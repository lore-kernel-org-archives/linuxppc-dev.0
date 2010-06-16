Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-01.edutel.nl (edu-smtp-01.edutel.nl [88.159.1.175])
	by ozlabs.org (Postfix) with ESMTP id 35046B7D69
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Jun 2010 01:21:01 +1000 (EST)
Message-ID: <4C18EB4C.4060201@neli.hopto.org>
Date: Wed, 16 Jun 2010 17:18:36 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] e500v2 36 bit large physical HID0[EN_MAS7_UPDATE]
References: <4C187616.4000303@neli.hopto.org>	<A79B65D2-CDAF-4B16-8E97-E3522F154056@kernel.crashing.org>
	<4C18E9EA.2090903@neli.hopto.org>
In-Reply-To: <4C18E9EA.2090903@neli.hopto.org>
Content-Type: multipart/mixed; boundary="------------080403030108020403010605"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080403030108020403010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Micha Nelissen wrote:
> Do you mean like attached? I had to change the order of the '_GLOBAL' 
> definitions __setup_cpu_e500v1/__setup_cpu_e500v2 since this bit is 
> e500v2 only.

Hmm, maybe need to use r0 or r3 instead of r2?

Micha

--------------080403030108020403010605
Content-Type: text/plain;
 name="en-mas7-update-v2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="en-mas7-update-v2.diff"

Index: linux/arch/powerpc/kernel/cpu_setup_fsl_booke.S
===================================================================
--- linux/arch/powerpc/kernel/cpu_setup_fsl_booke.S	(revision 2871)
+++ linux/arch/powerpc/kernel/cpu_setup_fsl_booke.S	(working copy)
@@ -57,8 +57,14 @@
 	ori	r3,r3,HID0_DAPUEN@l
 	mtspr	SPRN_HID0,r3
 	b	__setup_e200_ivors
+_GLOBAL(__setup_cpu_e500v2)
+#ifdef CONFIG_PTE_64BIT
+	/* enable mas7 register for tlbre/tlbsx */
+	mfspr	r0,SPRN_HID0
+	ori 	r0,r0,HID0_EN_MAS7_UPDATE@l
+	mtspr	SPRN_HID0,r0
+#endif
 _GLOBAL(__setup_cpu_e500v1)
-_GLOBAL(__setup_cpu_e500v2)
 	mflr	r4
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
Index: linux/arch/powerpc/include/asm/reg.h
===================================================================
--- linux/arch/powerpc/include/asm/reg.h	(revision 2871)
+++ linux/arch/powerpc/include/asm/reg.h	(working copy)
@@ -276,6 +276,7 @@
 #define HID0_DAPUEN	(1<<8)		/* Debug APU enable */
 #define HID0_SGE	(1<<7)		/* Store Gathering Enable */
 #define HID0_SIED	(1<<7)		/* Serial Instr. Execution [Disable] */
+#define HID0_EN_MAS7_UPDATE (1<<7)	/* Enable MAS7 reg for tlbre/tlbsx */
 #define HID0_DCFA	(1<<6)		/* Data Cache Flush Assist */
 #define HID0_LRSTK	(1<<4)		/* Link register stack - 745x */
 #define HID0_BTIC	(1<<5)		/* Branch Target Instr Cache Enable */

--------------080403030108020403010605--
