Return-Path: <SRS0=Blre=XF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FAAC3A5A2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6C220863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 08:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6C220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46SJpR5BsZzDr41
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Sep 2019 18:58:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.49; helo=2.mo173.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo173.mail-out.ovh.net (2.mo173.mail-out.ovh.net
 [178.33.251.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46SJkq4mcvzDqmY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2019 18:54:58 +1000 (AEST)
Received: from player694.ha.ovh.net (unknown [10.108.57.183])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id CCED9118ED0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2019 10:19:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player694.ha.ovh.net (Postfix) with ESMTPSA id 5CF3098EF5A5;
 Tue, 10 Sep 2019 08:19:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/xmon: Fix output of XIVE IPI
Date: Tue, 10 Sep 2019 10:18:50 +0200
Message-Id: <20190910081850.26038-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910081850.26038-1-clg@kaod.org>
References: <20190910081850.26038-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6667016301829917617
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudekkedgtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenuc
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When dumping the XIVE state of an CPU IPI, xmon does not check if the
CPU is started or not which can cause an error. Add a check for that
and change the output to be on one line just as the XIVE interrupts of
the machine.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 85a27ec49d34..20f45b8a52ab 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -237,25 +237,30 @@ static notrace void xive_dump_eq(const char *name, struct xive_q *q)
 	i0 = be32_to_cpup(q->qpage + idx);
 	idx = (idx + 1) & q->msk;
 	i1 = be32_to_cpup(q->qpage + idx);
-	xmon_printf("  %s Q T=%d %08x %08x ...\n", name,
-		    q->toggle, i0, i1);
+	xmon_printf("%s idx=%d T=%d %08x %08x ...", name,
+		     q->idx, q->toggle, i0, i1);
 }
 
 notrace void xmon_xive_do_dump(int cpu)
 {
 	struct xive_cpu *xc = per_cpu(xive_cpu, cpu);
 
-	xmon_printf("XIVE state for CPU %d:\n", cpu);
-	xmon_printf("  pp=%02x cppr=%02x\n", xc->pending_prio, xc->cppr);
-	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
+	xmon_printf("CPU %d:", cpu);
+	if (xc) {
+		xmon_printf("pp=%02x CPPR=%02x ", xc->pending_prio, xc->cppr);
+
 #ifdef CONFIG_SMP
-	{
-		u64 val = xive_esb_read(&xc->ipi_data, XIVE_ESB_GET);
-		xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
-			val & XIVE_ESB_VAL_P ? 'P' : 'p',
-			val & XIVE_ESB_VAL_Q ? 'Q' : 'q');
-	}
+		{
+			u64 val = xive_esb_read(&xc->ipi_data, XIVE_ESB_GET);
+
+			xmon_printf("IPI=0x%08x PQ=%c%c ", xc->hw_ipi,
+				    val & XIVE_ESB_VAL_P ? 'P' : '-',
+				    val & XIVE_ESB_VAL_Q ? 'Q' : '-');
+		}
 #endif
+		xive_dump_eq("EQ", &xc->queue[xive_irq_priority]);
+	}
+	xmon_printf("\n");
 }
 
 int xmon_xive_get_irq_config(u32 hw_irq, struct irq_data *d)
-- 
2.21.0

