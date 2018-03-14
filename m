Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401dG15LnLzF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:58:17 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2EGw11c090668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 12:58:14 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gq44635rv-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 12:58:14 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 14 Mar 2018 16:58:12 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, clg@kaod.org
Cc: andrew.donnellan@au1.ibm.com, vaibhav@linux.vnet.ibm.com
Subject: [RFC] powerpc/xive: Remove irq from queue when it is shutdown
Date: Wed, 14 Mar 2018 17:58:08 +0100
Message-Id: <20180314165808.26628-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a driver has called free_irq() but an irq is waiting in a queue, an
error is logged when a cpu processes it:

    irq 232, desc: 0000000044e5941a, depth: 1, count: 9823, unhandled: 0
    ->handle_irq():  0000000023f2e352,
    handle_bad_irq+0x0/0x2e0
    ->irq_data.chip(): 000000007fd7bf50,
    no_irq_chip+0x0/0x110
    ->action():           (null)
    IRQ_NOREQUEST set
    unexpected IRQ trap at vector e8

In most cases, it's due to a driver bug or a misbehaving device, but
it can be observed with opencapi with no involvment of a device. AFU
interrupts are triggered by writing a special page of a process, but
it's possible for a thread of that process to write to that page as
well. If that process exits abruptly, the driver will free the AFU
interrupts resources, but there's no possible quiescing of the
process, so we may have interrupts in the queue.

This patch adds a scan of the queue when an interrupt is shutdown to
replace any pending irq with XIVE_BAD_IRQ, since those are ignored.
Also move when XIVE_BAD_IRQs are ignored closer to reading the queue,
so that we can reset the CPPR if it's the last interrupt in the queue.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/sysdev/xive/common.c | 69 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 3459015092fa..91047bc7c731 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -148,8 +148,16 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
 		prio = ffs(xc->pending_prio) - 1;
 		DBG_VERBOSE("scan_irq: trying prio %d\n", prio);
 
-		/* Try to fetch */
-		irq = xive_read_eq(&xc->queue[prio], just_peek);
+		/*
+		 * Try to fetch.
+		 * When not peeking, drop any BAD_IRQ on the floor
+		 * now. If we let it reach get_irq() and it's the last
+		 * one, then we'd need to rescan again to reset the
+		 * CPPR
+		 */
+		do {
+			irq = xive_read_eq(&xc->queue[prio], just_peek);
+		} while (irq == XIVE_BAD_IRQ && !just_peek);
 
 		/* Found something ? That's it */
 		if (irq)
@@ -282,8 +290,6 @@ static unsigned int xive_get_irq(void)
 	    irq, xc->pending_prio);
 
 	/* Return pending interrupt if any */
-	if (irq == XIVE_BAD_IRQ)
-		return 0;
 	return irq;
 }
 
@@ -592,6 +598,58 @@ static unsigned int xive_irq_startup(struct irq_data *d)
 	return 0;
 }
 
+static void xive_remove_from_queue(unsigned int hw_irq, int cpu)
+{
+	struct xive_cpu *xc;
+	struct xive_q *q;
+	u32 irq = 0, cur, idx, toggle, prev;
+	u8 prio;
+	int count;
+
+	xc = per_cpu(xive_cpu, cpu);
+
+	/*
+	 * Only one queue is really in use, but let's try stay generic, and
+	 * check all of them
+	 */
+	for (prio = 0; prio < XIVE_MAX_QUEUES; prio++) {
+		q = &xc->queue[prio];
+		if (!q->qpage)
+			continue;
+
+		/*
+		 * We can't read a reliable index and toggle without
+		 * locking, as another cpu can process an interrupt
+		 * and read the queue at any given time. So use the
+		 * toggle from the previous index, which should be ok
+		 * as long as the queue doesn't overflow.
+		 */
+		idx = q->idx;
+		prev = (idx - 1) & q->msk;
+		cur = be32_to_cpup(q->qpage + prev);
+		toggle = (cur >> 31) ^ 1;
+		count = 0;
+		do {
+			count++;
+			cur = be32_to_cpup(q->qpage + idx);
+			if ((cur >> 31) == toggle)
+				irq = 0;
+			else
+				irq = cur & 0x7fffffff;
+
+			if (irq == hw_irq) {
+				cur &= 1 << 31;
+				cur |= XIVE_BAD_IRQ;
+				*(q->qpage + idx) = cpu_to_be32(cur);
+			}
+
+			idx = (idx + 1) & q->msk;
+			if (idx == 0)
+				toggle ^= 1;
+		} while (irq && (count < q->msk));
+	}
+}
+
 static void xive_irq_shutdown(struct irq_data *d)
 {
 	struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
@@ -624,6 +682,9 @@ static void xive_irq_shutdown(struct irq_data *d)
 				get_hard_smp_processor_id(xd->target),
 				0xff, XIVE_BAD_IRQ);
 
+	/* configure_irq() syncs the queue */
+	xive_remove_from_queue(hw_irq, xd->target);
+
 	xive_dec_target_count(xd->target);
 	xd->target = XIVE_INVALID_TARGET;
 }
-- 
2.14.1
