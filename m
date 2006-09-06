Return-Path: <minyard@acm.org>
Received: from sccrmhc13.comcast.net (sccrmhc13.comcast.net [204.127.200.83])
	by ozlabs.org (Postfix) with ESMTP id 22AD067B78
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2006 00:06:17 +1000 (EST)
Date: Wed, 6 Sep 2006 09:02:53 -0500
From: Corey Minyard <minyard@acm.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make function of pm_power_off consistent with x86
Message-ID: <20060906140253.GA7006@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jbarnett@motorola.com
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Allow the pm_power_off function variable in PPC to work as an override.
This makes the function consistent with the other architectures and it
allows generic poweroff operations (like those provided in IPMI
systems) to work properly on PPC.

Signed-off-by: Corey Minyard <minyard@acm.org>
Cc: Joseph Barnett <jbarnett@motorola.com>

Index: linux-2.6.17/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.6.17.orig/arch/ppc/kernel/setup.c
+++ linux-2.6.17/arch/ppc/kernel/setup.c
@@ -128,11 +128,8 @@ void machine_restart(char *cmd)
 	ppc_md.restart(cmd);
 }
 
-void machine_power_off(void)
+static void ppc_generic_power_off(void)
 {
-#ifdef CONFIG_NVRAM
-	nvram_sync();
-#endif
 	ppc_md.power_off();
 }
 
@@ -144,7 +141,17 @@ void machine_halt(void)
 	ppc_md.halt();
 }
 
-void (*pm_power_off)(void) = machine_power_off;
+void (*pm_power_off)(void) = ppc_generic_power_off;
+
+void machine_power_off(void)
+{
+#ifdef CONFIG_NVRAM
+	nvram_sync();
+#endif
+	if (pm_power_off)
+		pm_power_off();
+	ppc_generic_power_off();
+}
 
 #ifdef CONFIG_TAU
 extern u32 cpu_temp(unsigned long cpu);
