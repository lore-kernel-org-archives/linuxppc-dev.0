Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88D05DDFA2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 10:14:15 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] Add oprofile support for e300
Date: Mon,  4 Feb 2008 17:14:06 -0600
Message-Id: <12021668462559-git-send-email-afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The e300 c3 and c4 variants support hardware performance monitor counters which
are identical to those found in the e500.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/kernel/cputable.c |    4 ++--
 arch/powerpc/platforms/Kconfig |    1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c8af497..2a8f5cc 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -961,7 +961,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_603,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e300",
-		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.platform		= "ppc603",
 	},
 	{	/* e300c4 (e300c1, plus one IU) */
@@ -976,7 +976,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.num_pmcs		= 4,
 		.oprofile_cpu_type	= "ppc/e300",
-		.oprofile_type		= PPC_OPROFILE_BOOKE,
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.platform		= "ppc603",
 	},
 	{	/* default match, we assume split I/D cache & TB (non-601)... */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index fdce10c..045b8c8 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -24,6 +24,7 @@ config PPC_83xx
 	select MPC83xx
 	select IPIC
 	select WANT_DEVICE_TREE
+	select FSL_EMB_PERFMON
 
 config PPC_86xx
 	bool "Freescale 86xx"
-- 
1.5.0.2.230.gfbe3d-dirty
