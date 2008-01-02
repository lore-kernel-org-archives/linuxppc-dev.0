Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id C63EBDDF0C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:34:42 +1100 (EST)
Received: from pd4mr3so.prod.shaw.ca
	(pd4mr3so-qfe3.prod.shaw.ca [10.0.141.214]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JU1009VE7PQ1WJ0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:34:38 -0700 (MST)
Received: from pn2ml2so.prod.shaw.ca ([10.0.121.146])
	by pd4mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU1003FS7NDAB40@pd4mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 12:33:13 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JU100ECV7N84U10@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:33:12 -0700 (MST)
Date: Wed, 02 Jan 2008 12:32:51 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/5] [POWERPC] 8xx: Use machine_*_initcall() hooks in platform
	code
In-reply-to: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net
Message-id: <20080102193233.24178.74501.stgit@trillian.secretlab.ca>
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

 arch/powerpc/platforms/8xx/ep88xc.c          |    5 ++---
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
index c518b6c..88afa35 100644
--- a/arch/powerpc/platforms/8xx/ep88xc.c
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -155,12 +155,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 static int __init declare_of_platform_devices(void)
 {
 	/* Publish the QE devices */
-	if (machine_is(ep88xc))
-		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(ep88xc, declare_of_platform_devices);
 
 define_machine(ep88xc) {
 	.name = "Embedded Planet EP88xC",
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
index 2cf1b6a..6ef8e9e 100644
--- a/arch/powerpc/platforms/8xx/mpc885ads_setup.c
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -264,12 +264,11 @@ static struct of_device_id __initdata of_bus_ids[] = {
 static int __init declare_of_platform_devices(void)
 {
 	/* Publish the QE devices */
-	if (machine_is(mpc885_ads))
-		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
 	return 0;
 }
-device_initcall(declare_of_platform_devices);
+machine_device_initcall(mpc885_ads, declare_of_platform_devices);
 
 define_machine(mpc885_ads) {
 	.name			= "Freescale MPC885 ADS",
