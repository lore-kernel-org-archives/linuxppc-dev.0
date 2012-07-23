Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC6D92C0333
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2012 06:43:43 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: p1022ds: fix DIU/LBC switching with NAND enabled
Date: Mon, 23 Jul 2012 15:43:32 -0500
Message-ID: <1343076212-5236-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order for indirect mode on the PIXIS to work properly, both chip selects
need to be set to GPCM mode, otherwise writes to the chip select base
addresses will not actually post to the local bus -- they'll go to the
NAND controller instead.  Therefore, we need to set BR0 and BR1 to GPCM
mode before switching to indirect mode.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |   64 +++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 5ca2823a..3c732ac 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -208,6 +208,7 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 	u8 __iomem *lbc_lcs0_ba = NULL;
 	u8 __iomem *lbc_lcs1_ba = NULL;
 	phys_addr_t cs0_addr, cs1_addr;
+	u32 br0, or0, br1, or1;
 	const __be32 *iprop;
 	unsigned int num_laws;
 	u8 b;
@@ -256,11 +257,70 @@ static void p1022ds_set_monitor_port(enum fsl_diu_monitor_port port)
 	}
 	num_laws = be32_to_cpup(iprop);
 
-	cs0_addr = lbc_br_to_phys(ecm, num_laws, in_be32(&lbc->bank[0].br));
-	cs1_addr = lbc_br_to_phys(ecm, num_laws, in_be32(&lbc->bank[1].br));
+	/*
+	 * Indirect mode requires both BR0 and BR1 to be set to "GPCM",
+	 * otherwise writes to these addresses won't actually appear on the
+	 * local bus, and so the PIXIS won't see them.
+	 *
+	 * In FCM mode, writes go to the NAND controller, which does not pass
+	 * them to the localbus directly.  So we force BR0 and BR1 into GPCM
+	 * mode, since we don't care about what's behind the localbus any
+	 * more.
+	 */
+	br0 = in_be32(&lbc->bank[0].br);
+	br1 = in_be32(&lbc->bank[1].br);
+	or0 = in_be32(&lbc->bank[0].or);
+	or1 = in_be32(&lbc->bank[1].or);
+
+	/* Make sure CS0 and CS1 are programmed */
+	if (!(br0 & BR_V) || !(br1 & BR_V)) {
+		pr_err("p1022ds: CS0 and/or CS1 is not programmed\n");
+		goto exit;
+	}
+
+	/*
+	 * Use the existing BRx/ORx values if it's already GPCM. Otherwise,
+	 * force the values to simple 32KB GPCM windows with the most
+	 * conservative timing.
+	 */
+	if ((br0 & BR_MSEL) != BR_MS_GPCM) {
+		br0 = (br0 & BR_BA) | BR_V;
+		or0 = 0xFFFF8000 | 0xFF7;
+		out_be32(&lbc->bank[0].br, br0);
+		out_be32(&lbc->bank[0].or, or0);
+	}
+	if ((br1 & BR_MSEL) != BR_MS_GPCM) {
+		br1 = (br1 & BR_BA) | BR_V;
+		or1 = 0xFFFF8000 | 0xFF7;
+		out_be32(&lbc->bank[1].br, br1);
+		out_be32(&lbc->bank[1].or, or1);
+	}
+
+	cs0_addr = lbc_br_to_phys(ecm, num_laws, br0);
+	if (!cs0_addr) {
+		pr_err("p1022ds: could not determine physical address for CS0"
+		       " (BR0=%08x)\n", br0);
+		goto exit;
+	}
+	cs1_addr = lbc_br_to_phys(ecm, num_laws, br1);
+	if (!cs0_addr) {
+		pr_err("p1022ds: could not determine physical address for CS1"
+		       " (BR1=%08x)\n", br1);
+		goto exit;
+	}
 
 	lbc_lcs0_ba = ioremap(cs0_addr, 1);
+	if (!lbc_lcs0_ba) {
+		pr_err("p1022ds: could not ioremap CS0 address %llx\n",
+		       (unsigned long long)cs0_addr);
+		goto exit;
+	}
 	lbc_lcs1_ba = ioremap(cs1_addr, 1);
+	if (!lbc_lcs1_ba) {
+		pr_err("p1022ds: could not ioremap CS1 address %llx\n",
+		       (unsigned long long)cs1_addr);
+		goto exit;
+	}
 
 	/* Make sure we're in indirect mode first. */
 	if ((in_be32(&guts->pmuxcr) & PMUXCR_ELBCDIU_MASK) !=
-- 
1.7.3.4
