Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1540EDE1AB
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 04:45:47 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0SGxHYk020790
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 10:59:18 -0600
Date: Mon, 28 Jan 2008 10:56:50 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: convert sbc85* boards to use
	machine_device_initcall
Message-ID: <Pine.LNX.4.64.0801281056350.21097@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 arch/powerpc/platforms/85xx/sbc8548.c |    6 ++----
 arch/powerpc/platforms/85xx/sbc8560.c |    6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index de27b57..488facb 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -135,13 +135,11 @@ static struct of_device_id __initdata of_bus_ids[] = {

 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(sbc8548))
-		return 0;
-
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(sbc8548, declare_of_platform_devices);

 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index e2bc368..2c580cd 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -222,13 +222,11 @@ static struct of_device_id __initdata of_bus_ids[] = {

 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(sbc8560))
-		return 0;
-
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(sbc8560, declare_of_platform_devices);

 /*
  * Called very early, device-tree isn't unflattened
-- 
1.5.3.7
