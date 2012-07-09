Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 099A02C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 22:59:51 +1000 (EST)
Received: from mail94-ch1 (localhost [127.0.0.1])	by mail94-ch1-R.bigfish.com
 (Postfix) with ESMTP id 7591C2E02C8	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 12:57:30 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail94-ch1.bigfish.com (Postfix) with ESMTP id
 4FBC32C0042
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 12:57:19 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q69CxT9a011593	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 05:59:30 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH 2/4] powerpc/booke: Merge the 32 bit e5500/e500mc cpu setup
 code.
Date: Mon, 9 Jul 2012 18:28:21 +0530
Message-ID: <1341838701-17089-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Merge the 32 bit cpu setup code for e500mc/e5500 and define the "cpu_restore"
routine (for e5500/e6500) only for the 64 bit case. The cpu_restore routine
is used in the 64 bit case for setting up the secondary cores.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    1 +
 arch/powerpc/kernel/cputable.c            |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index a55d028..5e87737 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -75,6 +75,7 @@ _GLOBAL(__setup_cpu_e500v2)
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_e500mc)
+_GLOBAL(__setup_cpu_e5500)
 	mflr	r5
 	bl	__e500_icache_setup
 	bl	__e500_dcache_setup
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 455faa3..0514c21 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2016,7 +2016,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc/e500mc",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.cpu_setup		= __setup_cpu_e5500,
+#ifndef CONFIG_PPC32
 		.cpu_restore		= __restore_cpu_e5500,
+#endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
 	},
@@ -2034,7 +2036,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.oprofile_cpu_type	= "ppc/e6500",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.cpu_setup		= __setup_cpu_e5500,
+#ifndef CONFIG_PPC32
 		.cpu_restore		= __restore_cpu_e5500,
+#endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
 	},
-- 
1.7.4.1
