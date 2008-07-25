Return-Path: <wg@grandegger.com>
Message-ID: <48898470.80109@grandegger.com>
Date: Fri, 25 Jul 2008 09:44:48 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: 85xx: add proper OF bus ids for the TQM85xx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since recent modifications to the MPC I2C code, the MPC I2C buses are 
not found any more. This patch fixes the problem by adding proper OF
bus ids.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/platforms/85xx/tqm85xx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/platforms/85xx/tqm85xx.c
+++ linux-2.6-galak/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -156,15 +156,15 @@ static void tqm85xx_show_cpuinfo(struct 
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
 	{},
 };
 
 static int __init declare_of_platform_devices(void)
 {
-	of_platform_bus_probe(NULL, of_bus_ids, NULL);
-
-	return 0;
+	return of_platform_bus_probe(NULL, of_bus_ids, NULL);
 }
 machine_device_initcall(tqm85xx, declare_of_platform_devices);
 
