Return-Path: <anton@ozlabs.org>
Date: Sat, 19 Aug 2006 04:48:22 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [PATCH] PURR should use correct cpu feature bit
Message-ID: <20060818184821.GC27947@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Now we have a PURR cpu feature bit, we should use it in sysfs code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index fec228c..a8172de 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -231,7 +231,7 @@ #endif
 	if (cur_cpu_spec->num_pmcs >= 8)
 		sysdev_create_file(s, &attr_pmc8);
 
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
 }
 
@@ -273,7 +273,7 @@ #endif
 	if (cur_cpu_spec->num_pmcs >= 8)
 		sysdev_remove_file(s, &attr_pmc8);
 
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
