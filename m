Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [66.118.10.122])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3274367B28
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jun 2006 08:49:47 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.44)
	id 1Frjbq-0004Mk-DT
	for linuxppc-dev@ozlabs.org; Sat, 17 Jun 2006 17:49:43 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Guard L3CR references with CPU_FTR_L3CR.
Date: Sat, 17 Jun 2006 17:49:42 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Frjbq-0004Mk-DT@jdl.com>
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
