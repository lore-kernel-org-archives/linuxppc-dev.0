Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 39BE367BA1
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:42:09 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k57N2pNM025011
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 16:02:51 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k57Mg7AL002807
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:42:07 -0500 (CDT)
Subject: [PATCH 4/10] Guard L3CR references with CPU_FTR_L3CR.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149719891.23938.193.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 07 Jun 2006 17:38:12 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/kernel/cpu_setup_6xx.S |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index 55ed771..365381f 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -210,9 +210,11 @@ setup_745x_specifics:
 	 * the firmware. If any, we disable NAP capability as
 	 * it's known to be bogus on rev 2.1 and earlier
 	 */
+BEGIN_FTR_SECTION
 	mfspr	r11,SPRN_L3CR
 	andis.	r11,r11,L3CR_L3E@h
 	beq	1f
+END_FTR_SECTION_IFSET(CPU_FTR_L3CR)
 	lwz	r6,CPU_SPEC_FEATURES(r5)
 	andi.	r0,r6,CPU_FTR_L3_DISABLE_NAP
 	beq	1f
