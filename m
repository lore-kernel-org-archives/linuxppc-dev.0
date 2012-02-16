Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1046B6EE6
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 04:21:19 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/8xxx: remove 85xx/86xx restrictions from
 fsl_guts.h
Date: Thu, 16 Feb 2012 11:21:09 -0600
Message-ID: <1329412870-16716-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the check for CONFIG_PPC_85xx and CONFIG_PPC_86xx from fsl_guts.h.
The check was originally intended to allow the same header file to
be used on 85xx and 86xx systems, even though the Global Utilities
register could be different.  It turns out that they're not actually
different, and so the check is not necessary.  In addition, neither
macro is defined for 64-bit e5500 kernels, so that causes a build
break.

To maintain backwards compatibility, we also define macros for
ccsr_guts_85xx and ccsr_guts_86xx.  This eliminates the need to
change all the files that #include fsl_guts.h.  Those files will
be updated at a later time, and then the macros can be deleted.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/include/asm/fsl_guts.h |   26 +++++++-------------------
 1 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/fsl_guts.h b/arch/powerpc/include/asm/fsl_guts.h
index bebd124..a880377 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/arch/powerpc/include/asm/fsl_guts.h
@@ -16,15 +16,6 @@
 #define __ASM_POWERPC_FSL_GUTS_H__
 #ifdef __KERNEL__
 
-/*
- * These #ifdefs are safe because it's not possible to build a kernel that
- * runs on e500 and e600 cores.
- */
-
-#if !defined(CONFIG_PPC_85xx) && !defined(CONFIG_PPC_86xx)
-#error Only 85xx and 86xx SOCs are supported
-#endif
-
 /**
  * Global Utility Registers.
  *
@@ -36,11 +27,7 @@
  * different names.  In these cases, one name is chosen to avoid extraneous
  * #ifdefs.
  */
-#ifdef CONFIG_PPC_85xx
-struct ccsr_guts_85xx {
-#else
-struct ccsr_guts_86xx {
-#endif
+struct ccsr_guts {
 	__be32	porpllsr;	/* 0x.0000 - POR PLL Ratio Status Register */
 	__be32	porbmsr;	/* 0x.0004 - POR Boot Mode Status Register */
 	__be32	porimpscr;	/* 0x.0008 - POR I/O Impedance Status and Control Register */
@@ -77,11 +64,8 @@ struct ccsr_guts_86xx {
 	u8	res0a8[0xb0 - 0xa8];
 	__be32	rstcr;		/* 0x.00b0 - Reset Control Register */
 	u8	res0b4[0xc0 - 0xb4];
-#ifdef CONFIG_PPC_85xx
-	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register */
-#else
-	__be32	elbcvselcr;	/* 0x.00c0 - eLBC Voltage Select Ctrl Reg */
-#endif
+	__be32  iovselsr;	/* 0x.00c0 - I/O voltage select status register
+				             Called 'elbcvselcr' on 86xx SOCs */
 	u8	res0c4[0x224 - 0xc4];
 	__be32  iodelay1;	/* 0x.0224 - IO delay control register 1 */
 	__be32  iodelay2;	/* 0x.0228 - IO delay control register 2 */
@@ -114,6 +98,10 @@ struct ccsr_guts_86xx {
 	__be32	srds2cr1;	/* 0x.0f44 - SerDes2 Control Register 0 */
 } __attribute__ ((packed));
 
+/* For backwards-compatibility */
+#define ccsr_guts_85xx ccsr_guts
+#define ccsr_guts_86xx ccsr_guts
+
 #ifdef CONFIG_PPC_86xx
 
 #define CCSR_GUTS_DMACR_DEV_SSI	0	/* DMA controller/channel set to SSI */
-- 
1.7.3.4
