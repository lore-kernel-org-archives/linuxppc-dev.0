Return-Path: <clg@kaod.org>
Received: from 7.mo179.mail-out.ovh.net (7.mo179.mail-out.ovh.net
 [46.105.61.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgcZV0dwhzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 20:25:04 +1100 (AEDT)
Received: from player755.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 16593A24CB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:47:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] powerpc/xive: use hw CPU ids when configuring the CPU queues
Date: Tue, 13 Feb 2018 09:47:12 +0100
Message-Id: <20180213084712.18351-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU event notification queues on sPAPR should be configured using
a hardware CPU identifier.

The problem did not show up on the Power Hypervisor because pHyp
supports 8 threads per core which keeps CPU number contiguous. This is
not the case on all sPAPR virtual machines, some use SMT=1.

Also improve error logging by adding the CPU number.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 I think we should send this one to stable also.

 arch/powerpc/sysdev/xive/spapr.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index d9c4c9366049..091f1d0d0af1 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -356,7 +356,8 @@ static int xive_spapr_configure_queue(u32 target, struct xive_q *q, u8 prio,
 
 	rc = plpar_int_get_queue_info(0, target, prio, &esn_page, &esn_size);
 	if (rc) {
-		pr_err("Error %lld getting queue info prio %d\n", rc, prio);
+		pr_err("Error %lld getting queue info CPU %d prio %d\n", rc,
+		       target, prio);
 		rc = -EIO;
 		goto fail;
 	}
@@ -370,7 +371,8 @@ static int xive_spapr_configure_queue(u32 target, struct xive_q *q, u8 prio,
 	/* Configure and enable the queue in HW */
 	rc = plpar_int_set_queue_config(flags, target, prio, qpage_phys, order);
 	if (rc) {
-		pr_err("Error %lld setting queue for prio %d\n", rc, prio);
+		pr_err("Error %lld setting queue for CPU %d prio %d\n", rc,
+		       target, prio);
 		rc = -EIO;
 	} else {
 		q->qpage = qpage;
@@ -389,8 +391,8 @@ static int xive_spapr_setup_queue(unsigned int cpu, struct xive_cpu *xc,
 	if (IS_ERR(qpage))
 		return PTR_ERR(qpage);
 
-	return xive_spapr_configure_queue(cpu, q, prio, qpage,
-					  xive_queue_shift);
+	return xive_spapr_configure_queue(get_hard_smp_processor_id(cpu),
+					  q, prio, qpage, xive_queue_shift);
 }
 
 static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
@@ -399,10 +401,12 @@ static void xive_spapr_cleanup_queue(unsigned int cpu, struct xive_cpu *xc,
 	struct xive_q *q = &xc->queue[prio];
 	unsigned int alloc_order;
 	long rc;
+	int hw_cpu = get_hard_smp_processor_id(cpu);
 
-	rc = plpar_int_set_queue_config(0, cpu, prio, 0, 0);
+	rc = plpar_int_set_queue_config(0, hw_cpu, prio, 0, 0);
 	if (rc)
-		pr_err("Error %ld setting queue for prio %d\n", rc, prio);
+		pr_err("Error %ld setting queue for CPU %d prio %d\n", rc,
+		       hw_cpu, prio);
 
 	alloc_order = xive_alloc_order(xive_queue_shift);
 	free_pages((unsigned long)q->qpage, alloc_order);
-- 
2.13.6
