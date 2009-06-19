Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D16B2B7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 14:30:10 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F09DDDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 14:30:09 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n5J4U5Bj012027
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 23:30:06 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Stop using ppc_md.init on socrates
Date: Thu, 18 Jun 2009 23:30:05 -0500
Message-Id: <1245385805-32234-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Match what other 85xx platforms do for of_platform_bus_probe and use
machine_device_initcall.  This is one small step in killing of
ppc_md.init.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/socrates.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index d0e8443..747d8fb 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -102,10 +102,11 @@ static struct of_device_id __initdata socrates_of_bus_ids[] = {
 	{},
 };
 
-static void __init socrates_init(void)
+static int __init socrates_publish_devices(void)
 {
-	of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
+	return of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
 }
+machine_device_initcall(socrates, socrates_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -124,7 +125,6 @@ define_machine(socrates) {
 	.name			= "Socrates",
 	.probe			= socrates_probe,
 	.setup_arch		= socrates_setup_arch,
-	.init			= socrates_init,
 	.init_IRQ		= socrates_pic_init,
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
-- 
1.6.0.6
