Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 539382C0080
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 12:57:00 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/e500/qemu-e500: enable coreint
Date: Mon, 21 Jan 2013 19:56:43 -0600
Message-ID: <1358819804-28665-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
References: <1358819804-28665-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MPIC code will disable coreint if it detects an insufficient
MPIC version.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/qemu_e500.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index f6ea561..5cefc5a 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -29,9 +29,10 @@
 void __init qemu_e500_pic_init(void)
 {
 	struct mpic *mpic;
+	unsigned int flags = MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU |
+		MPIC_ENABLE_COREINT;
 
-	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN | MPIC_SINGLE_DEST_CPU,
-			0, 256, " OpenPIC  ");
+	mpic = mpic_alloc(NULL, 0, flags, 0, 256, " OpenPIC  ");
 
 	BUG_ON(mpic == NULL);
 	mpic_init(mpic);
@@ -66,7 +67,7 @@ define_machine(qemu_e500) {
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-	.get_irq		= mpic_get_irq,
+	.get_irq		= mpic_get_coreint_irq,
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
1.7.9.5
