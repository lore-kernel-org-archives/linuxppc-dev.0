Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id CE61CDE57A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 23:13:04 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Fix 460GT support to (re-)enable the FPU
Date: Fri, 23 May 2008 15:04:56 +0200
Message-Id: <1211547896-4263-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since AMCC now reports that the 460GT *has* an FPU, we should enable it
(again). This patch basically reverts my patch
acb0142bf01c0ebe18f09e37814451ee6a873e27 ([POWERPC] 4xx: Fix 460GT support
to not enable FPU), which disabled the FPU upon AMCC request.

Sorry about the confusion here.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/kernel/cpu_setup_44x.S |    1 +
 arch/powerpc/kernel/cputable.c      |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
index e3623e3..5465e8d 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -33,6 +33,7 @@ _GLOBAL(__setup_cpu_440grx)
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_460ex)
+_GLOBAL(__setup_cpu_460gt)
 	b	__init_fpu_44x
 _GLOBAL(__setup_cpu_440gx)
 _GLOBAL(__setup_cpu_440spe)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 36080d4..26ffb44 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -37,6 +37,7 @@ extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1415,9 +1416,10 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_value		= 0x13020000,
 		.cpu_name		= "460GT",
 		.cpu_features		= CPU_FTRS_44X,
-		.cpu_user_features	= COMMON_USER_BOOKE,
+		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_460gt,
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
-- 
1.5.5.1
