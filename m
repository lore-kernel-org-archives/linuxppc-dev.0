Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 0FBE2B7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 17:04:25 +1000 (EST)
Received: from neli.hopto.org (98-215.ftth.onsbrabantnet.nl [88.159.215.98])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTPSA id 79AFC3818D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 08:58:47 +0200 (CEST)
Received: from conroe.local ([90.0.0.126] ident=micha)
	by neli.hopto.org with esmtp (Exim 4.69)
	(envelope-from <micha@neli.hopto.org>) id 1OOmaE-00031B-57
	for linuxppc-dev@lists.ozlabs.org; Wed, 16 Jun 2010 08:58:46 +0200
Message-ID: <4C187616.4000303@neli.hopto.org>
Date: Wed, 16 Jun 2010 08:58:30 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
Content-Type: multipart/mixed; boundary="------------060509020102060705070908"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060509020102060705070908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch to fix large physical address support for the e500v2 
core. When >4GB addresses are used, the MAS7 register needs to be valid 
for tlbsx instruction usage.

Please review and apply.

Micha

--------------060509020102060705070908
Content-Type: text/plain;
 name="en-mas7-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="en-mas7-update.diff"

diff -u -ru linux-2.6.34/arch/powerpc/include/asm/reg.h linux-2.6.34-fix/arch/powerpc/include/asm/reg.h
--- linux-2.6.34/arch/powerpc/include/asm/reg.h	2010-05-16 23:17:36.000000000 +0200
+++ linux-2.6.34-fix/arch/powerpc/include/asm/reg.h	2010-06-16 08:43:28.000000000 +0200
@@ -272,6 +272,7 @@
 #define HID0_DAPUEN	(1<<8)		/* Debug APU enable */
 #define HID0_SGE	(1<<7)		/* Store Gathering Enable */
 #define HID0_SIED	(1<<7)		/* Serial Instr. Execution [Disable] */
+#define HID0_EN_MAS7_UPDATE (1<<7)      /* tlbre/tlbsx update MAS7 - e500v2 */
 #define HID0_DCFA	(1<<6)		/* Data Cache Flush Assist */
 #define HID0_LRSTK	(1<<4)		/* Link register stack - 745x */
 #define HID0_BTIC	(1<<5)		/* Branch Target Instr Cache Enable */
diff -u -ru linux-2.6.34/arch/powerpc/kernel/head_fsl_booke.S linux-2.6.34-fix/arch/powerpc/kernel/head_fsl_booke.S
--- linux-2.6.34/arch/powerpc/kernel/head_fsl_booke.S	2010-05-16 23:17:36.000000000 +0200
+++ linux-2.6.34-fix/arch/powerpc/kernel/head_fsl_booke.S	2010-06-16 08:45:10.000000000 +0200
@@ -328,6 +328,13 @@
 	oris	r2,r2,HID0_DOZE@h
 	mtspr	SPRN_HID0, r2
 #endif
+#ifdef CONFIG_PTE_64BIT
+BEGIN_MMU_FTR_SECTION
+	mfspr	r2,SPRN_HID0
+	ori	r2,r2,HID0_EN_MAS7_UPDATE@l
+	mtspr	SPRN_HID0, r2
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
+#endif
 
 #if !defined(CONFIG_BDI_SWITCH)
 	/*

--------------060509020102060705070908--
