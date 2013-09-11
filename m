Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2BF62C0239
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 09:37:02 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/b4qds: enable coreint
Date: Wed, 11 Sep 2013 18:36:52 -0500
Message-ID: <1378942612-29439-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9837b43c5f3514e5d28f65f1513f4dc6759d2810 ("powerpc/85xx: enable
coreint for all the 64bit boards") removed the ifdef that avoided
coreint on 64-bit, but it missed b4_qds.c.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Kevin Hao <haokexin@gmail.com>
Cc: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/platforms/85xx/b4_qds.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/b4_qds.c b/arch/powerpc/platforms/85xx/b4_qds.c
index 0c6702f..0f18663 100644
--- a/arch/powerpc/platforms/85xx/b4_qds.c
+++ b/arch/powerpc/platforms/85xx/b4_qds.c
@@ -79,12 +79,7 @@ define_machine(b4_qds) {
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
-#ifdef CONFIG_PPC64
-	.get_irq		= mpic_get_irq,
-#else
 	.get_irq		= mpic_get_coreint_irq,
-#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
1.8.1.2
