Return-Path: <clg@kaod.org>
Received: from 6.mo68.mail-out.ovh.net (6.mo68.mail-out.ovh.net
 [46.105.63.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjGTp20wnzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:56:14 +1000 (AEST)
Received: from player776.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 028C07B7E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:47:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 8/8] powerpc/xive: improve debugging macros
Date: Wed, 30 Aug 2017 21:46:17 +0200
Message-Id: <20170830194617.26621-9-clg@kaod.org>
In-Reply-To: <20170830194617.26621-1-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
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

Having the CPU identifier in the debug logs is helpful when tracking
issues. Also add some more logging and fix a compile issue in
xive_do_source_eoi().

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/sysdev/xive/common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 8fd58773c241..1c087ed7427f 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -40,7 +40,8 @@
 #undef DEBUG_ALL
 
 #ifdef DEBUG_ALL
-#define DBG_VERBOSE(fmt...)	pr_devel(fmt)
+#define DBG_VERBOSE(fmt, ...)	pr_devel("cpu %d - " fmt, \
+					 smp_processor_id(), ## __VA_ARGS__)
 #else
 #define DBG_VERBOSE(fmt...)	do { } while(0)
 #endif
@@ -344,7 +345,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
 			xive_esb_read(xd, XIVE_ESB_LOAD_EOI);
 		else {
 			eoi_val = xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
-			DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
+			DBG_VERBOSE("eoi_val=%x\n", eoi_val);
 
 			/* Re-trigger if needed */
 			if ((eoi_val & XIVE_ESB_VAL_Q) && xd->trig_mmio)
@@ -1004,6 +1005,9 @@ static void xive_ipi_eoi(struct irq_data *d)
 {
 	struct xive_cpu *xc = __this_cpu_read(xive_cpu);
 
+	DBG_VERBOSE("IPI eoi: irq=%d [0x%lx] (HW IRQ 0x%x) pending=%02x\n",
+		    d->irq, irqd_to_hwirq(d), xc->hw_ipi, xc->pending_prio);
+
 	/* Handle possible race with unplug and drop stale IPIs */
 	if (!xc)
 		return;
-- 
2.13.5
