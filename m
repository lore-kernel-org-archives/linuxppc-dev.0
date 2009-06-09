Return-Path: <ncase@xes-inc.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 781DDB70D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 04:54:12 +1000 (EST)
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11FE6DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 04:54:10 +1000 (EST)
Subject: Re: [PATCH -next] powerpc/85xx: Add support for X-ES MPC85xx boards
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2AF4BA69-D05A-4D2E-BD32-5E1C93ACF445@kernel.crashing.org>
References: <1244499228-18602-1-git-send-email-ncase@xes-inc.com>
	<2AF4BA69-D05A-4D2E-BD32-5E1C93ACF445@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 09 Jun 2009 13:53:59 -0500
Message-Id: <1244573639.29684.1536.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-06-08 at 17:52 -0500, Kumar Gala wrote:
> > +static void xes_mpc85xx_configure_l1(void)
> > +{
[snip]
> 
> I'd prefer we move this into __setup_cpu_e500v1/__setup_cpu_e500v2 so  
> its done for all processors regardless of platform.

How does something like this look?  Let me know and I can test and
submit it separately.

- Nate

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index eb4b9ad..546804f 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -17,6 +17,34 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
 
+_GLOBAL(__e500_icache_enable)
+	mfspr	r3, SPRN_L1CSR1
+	oris	r3, r3, L1CSR1_CPE@h
+	ori	r3, r3, (L1CSR1_ICFI | L1CSR1_ICE)
+	mtspr	SPRN_L1CSR1, r3		/* Enable I-Cache */
+	isync
+	blr
+
+_GLOBAL(__e500_dcache_enable)
+	msync
+	isync
+	li	r3, 0
+	mtspr	SPRN_L1CSR0, r3		/* Disable */
+	msync
+	isync
+	li	r3, L1CSR0_DCFI
+	mtspr	SPRN_L1CSR0, r3		/* Invalidate */
+	msync
+	isync
+	mfspr	r3, SPRN_L1CSR0
+	oris	r3, r3, L1CSR0_CPE@h
+	ori	r3, r3, (L1CSR0_DCFI | L1CSR0_DCE)
+	msync
+	isync
+	mtspr	SPRN_L1CSR0, r3		/* Enable */
+	isync
+	blr
+
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r3,SPRN_HID0
@@ -25,7 +53,16 @@ _GLOBAL(__setup_cpu_e200)
 	b	__setup_e200_ivors
 _GLOBAL(__setup_cpu_e500v1)
 _GLOBAL(__setup_cpu_e500v2)
-	b	__setup_e500_ivors
+	mflr	r4
+	bl	__e500_icache_enable
+	bl	__e500_dcache_enable
+	bl	__setup_e500_ivors
+	mtlr	r4
+	blr
 _GLOBAL(__setup_cpu_e500mc)
-	b	__setup_e500mc_ivors
-
+	mflr	r4
+	bl	__e500_icache_enable
+	bl	__e500_dcache_enable
+	bl	__setup_e500mc_ivors
+	mtlr	r4
+	blr
