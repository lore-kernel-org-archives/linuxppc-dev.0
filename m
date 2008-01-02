Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 05DB6DDF07
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:34:03 +1100 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU1009MV7OL1WJ0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:33:57 -0700 (MST)
Received: from pn2ml9so.prod.shaw.ca ([10.0.121.7])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU100IWZ7MDX690@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 12:32:38 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU100E5H7MCJ550@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:32:37 -0700 (MST)
Date: Wed, 02 Jan 2008 12:32:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/5] [POWERPC] pasemi: Use machine_*_initcall() hooks in
	platform code
In-reply-to: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net
Message-id: <20080102191441.24178.42988.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/pasemi/idle.c  |    5 +----
 arch/powerpc/platforms/pasemi/setup.c |   10 ++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/idle.c b/arch/powerpc/platforms/pasemi/idle.c
index d8e1fcc..43911d8 100644
--- a/arch/powerpc/platforms/pasemi/idle.c
+++ b/arch/powerpc/platforms/pasemi/idle.c
@@ -74,9 +74,6 @@ static int pasemi_system_reset_exception(struct pt_regs *regs)
 
 static int __init pasemi_idle_init(void)
 {
-	if (!machine_is(pasemi))
-		return -ENODEV;
-
 #ifndef CONFIG_PPC_PASEMI_CPUFREQ
 	printk(KERN_WARNING "No cpufreq driver, powersavings modes disabled\n");
 	current_mode = 0;
@@ -88,7 +85,7 @@ static int __init pasemi_idle_init(void)
 
 	return 0;
 }
-late_initcall(pasemi_idle_init);
+machine_late_initcall(pasemi, pasemi_idle_init);
 
 static int __init idle_param(char *p)
 {
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 1940e67..98c7f3b 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -135,9 +135,6 @@ static int __init pas_setup_mce_regs(void)
 	struct pci_dev *dev;
 	int reg;
 
-	if (!machine_is(pasemi))
-		return -ENODEV;
-
 	/* Remap various SoC status registers for use by the MCE handler */
 
 	reg = 0;
@@ -181,7 +178,7 @@ static int __init pas_setup_mce_regs(void)
 
 	return 0;
 }
-device_initcall(pas_setup_mce_regs);
+machine_device_initcall(pasemi, pas_setup_mce_regs);
 
 static __init void pas_init_IRQ(void)
 {
@@ -405,9 +402,6 @@ static struct of_device_id pasemi_bus_ids[] = {
 
 static int __init pasemi_publish_devices(void)
 {
-	if (!machine_is(pasemi))
-		return 0;
-
 	pasemi_pcmcia_init();
 
 	/* Publish OF platform devices for SDC and other non-PCI devices */
@@ -415,7 +409,7 @@ static int __init pasemi_publish_devices(void)
 
 	return 0;
 }
-device_initcall(pasemi_publish_devices);
+machine_device_initcall(pasemi, pasemi_publish_devices);
 
 
 /*
