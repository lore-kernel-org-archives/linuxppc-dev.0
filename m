Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 5986567F6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 07:41:45 +1000 (EST)
Date: Tue, 16 Aug 2005 14:41:43 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: akpm@osdl.org
Message-ID: <20050816144143.C1053@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Fix PPC440SP SRAM controller DCRs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fixes the incorrect DCR base value for the 440SP SRAM controller.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -423,11 +423,7 @@
 #define MQ0_CONFIG_SIZE_2G		0x0000c000
 
 /* Internal SRAM Controller 440GX/440SP */
-#ifdef CONFIG_440SP
-#define DCRN_SRAM0_BASE		0x100
-#else /* 440GX */
 #define DCRN_SRAM0_BASE		0x000
-#endif
 
 #define DCRN_SRAM0_SB0CR	(DCRN_SRAM0_BASE + 0x020)
 #define DCRN_SRAM0_SB1CR	(DCRN_SRAM0_BASE + 0x021)
