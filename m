Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB44FB6F62
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Sep 2011 01:37:48 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/e5500: Set r5 to point to cpu spec in
	setup_cpu_e5500()
Date: Fri, 16 Sep 2011 10:37:42 -0500
Message-Id: <1316187462-21074-1-git-send-email-galak@kernel.crashing.org>
Cc: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>

e500mc and e5500 share some eary setup code that need r5 to point to the
cpu spec structure.  setup_cpu_e500mc() sets it but setup_cpu_e5500()
didn't.

This caused a crash on 32 bit e5500 running under hypervisor, when
__setup_e500mc_ivors() tried to access the cpu features field.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 8053db0..f9f6a6f 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -1,7 +1,7 @@
 /*
  * This file contains low level CPU setup functions.
  * Kumar Gala <galak@kernel.crashing.org>
- * Copyright 2009 Freescale Semiconductor, Inc.
+ * Copyright 2009,2011 Freescale Semiconductor, Inc.
  *
  * Based on cpu_setup_6xx code by
  * Benjamin Herrenschmidt <benh@kernel.crashing.org>
@@ -83,6 +83,7 @@ _GLOBAL(__setup_cpu_e500mc)
 /* Right now, restore and setup are the same thing */
 _GLOBAL(__restore_cpu_e5500)
 _GLOBAL(__setup_cpu_e5500)
+	mr	r5, r4
 	mflr	r4
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
-- 
1.7.3.4
