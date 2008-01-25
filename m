Return-Path: <grant.likely@secretlab.ca>
Received: from pd4mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id BA89BDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:24:34 +1100 (EST)
Received: from pd3mr5so.prod.shaw.ca (pd3mr5so-qfe3.prod.shaw.ca [10.0.141.12])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JV600D6PPNZEOC0@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 24 Jan 2008 22:23:59 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd3mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JV600D7OPNZ8Y60@pd3mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Thu, 24 Jan 2008 22:24:00 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JV600HL0PNXVI10@l-daemon> for linuxppc-dev@ozlabs.org;
	Thu, 24 Jan 2008 22:23:58 -0700 (MST)
Date: Thu, 24 Jan 2008 22:23:24 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] 82xx and embedded6xx: Use machine_*_initcall()	hooks
	in platform code
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Message-id: <20080125052324.8405.99760.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
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

 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5 +----
 arch/powerpc/platforms/82xx/pq2fads.c        |    5 +----
 arch/powerpc/platforms/embedded6xx/ls_uart.c |    5 +----
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index fd83440..3fce6b3 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -165,14 +165,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(mpc8272_ads))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(mpc8272_ads, declare_of_platform_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
index 1be5005..68196e3 100644
--- a/arch/powerpc/platforms/82xx/pq2fads.c
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -176,14 +176,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
-	if (!machine_is(pq2fads))
-		return 0;
-
 	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(pq2fads, declare_of_platform_devices);
 
 define_machine(pq2fads)
 {
diff --git a/arch/powerpc/platforms/embedded6xx/ls_uart.c b/arch/powerpc/platforms/embedded6xx/ls_uart.c
index c99264c..9d891bd 100644
--- a/arch/powerpc/platforms/embedded6xx/ls_uart.c
+++ b/arch/powerpc/platforms/embedded6xx/ls_uart.c
@@ -117,9 +117,6 @@ static int __init ls_uarts_init(void)
 	phys_addr_t phys_addr;
 	int len;
 
-	if (!machine_is(linkstation))
-		return 0;
-
 	avr = of_find_node_by_path("/soc10x/serial@80004500");
 	if (!avr)
 		return -EINVAL;
@@ -142,4 +139,4 @@ static int __init ls_uarts_init(void)
 	return 0;
 }
 
-late_initcall(ls_uarts_init);
+machine_late_initcall(linkstation, ls_uarts_init);
