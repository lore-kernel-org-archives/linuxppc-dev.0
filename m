Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 80B52DE055
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:25:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6RIP0AN021320
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:25:00 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6RIOxcX017065
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:25:00 -0500 (CDT)
Subject: [PATCH 4/5] 8xx: Remove unnecessary loops_per_jiffy initialization
	code.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185560699.8055.177.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Jul 2007 13:24:59 -0500
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
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |   14 --------------
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |   14 --------------
 2 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/mpc86xads_setup.c b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
index cf0e7bc..d881647 100644
--- a/arch/powerpc/platforms/8xx/mpc86xads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc86xads_setup.c
@@ -254,20 +254,6 @@ int platform_device_skip(const char *model, int id)
 
 static void __init mpc86xads_setup_arch(void)
 {
-	struct device_node *cpu;
-
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
-
 	cpm_reset();
 
 	mpc86xads_board_setup();
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 5a808d6..bd5ff7a 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -406,20 +406,6 @@ int platform_device_skip(const char *model, int id)
 
 static void __init mpc885ads_setup_arch(void)
 {
-	struct device_node *cpu;
-
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
-
 	cpm_reset();
 
 	mpc885ads_board_setup();
-- 
1.5.0.3
