Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CEEBF67C42
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:02:34 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k58MNIVb028531
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:23:19 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M2XeP021111
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:02:33 -0500 (CDT)
Subject: [PATCH 4/10 v2] Guard L3CR references with CPU_FTR_L3CR.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1149803912.23938.282.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 16:58:33 -0500
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
