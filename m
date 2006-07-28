Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: [PATCH] Enable PURR sysfs entry correctly
Date: Fri, 28 Jul 2006 13:58:37 +1000
Sender: mikey@ozlabs.org
Message-Id: <20060728035837.CC11367A3A@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have CPU_FTR_PURR now, so let's use it.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/sysfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/sysfs.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/sysfs.c
@@ -231,7 +231,7 @@ static void register_cpu_online(unsigned
 	if (cur_cpu_spec->num_pmcs >= 8)
 		sysdev_create_file(s, &attr_pmc8);
 
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
 }
 
@@ -273,7 +273,7 @@ static void unregister_cpu_online(unsign
 	if (cur_cpu_spec->num_pmcs >= 8)
 		sysdev_remove_file(s, &attr_pmc8);
 
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
