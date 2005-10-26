Return-Path: <galak@freescale.com>
Date: Tue, 25 Oct 2005 23:57:33 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510252356440.22448@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Some minor cleanups to setup_32.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Removed of_show_percpuinfo and just report CPU frequency in generic
  show_cpuinfo code.
* Killed OCP and PPC_SYS related code which doesn't belong in the
  merge tree

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit c77ae9103af0c3f77a298a7edd626da0675eddc5
tree 2e0286b5f502f31cc204fe2bf6c8bc4052bde123
parent 34feb902f76428e507b305dd511496aa8d35d57e
author Kumar K. Gala <kumar.gala@freescale.com> Tue, 25 Oct 2005 23:56:17 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Tue, 25 Oct 2005 23:56:17 -0500

 arch/powerpc/kernel/setup_32.c          |   45 ++++++-------------------------
 arch/powerpc/platforms/powermac/setup.c |    3 --
 2 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -39,15 +39,7 @@
 #include <asm/sections.h>
 #include <asm/nvram.h>
 #include <asm/xmon.h>
-#include <asm/ocp.h>
-
-#define USES_PPC_SYS (defined(CONFIG_85xx) || defined(CONFIG_83xx) || \
-		      defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
-		      defined(CONFIG_PPC_MPC52xx))
-
-#if USES_PPC_SYS
-#include <asm/ppc_sys.h>
-#endif
+#include <asm/time.h>
 
 #if defined CONFIG_KGDB
 #include <asm/kgdb.h>
@@ -234,18 +226,19 @@ int show_cpuinfo(struct seq_file *m, voi
 		}
 	}
 
+	/*
+	 * Assume here that all clock rates are the same in a
+	 * smp system.  -- Cort
+	 */
+	seq_printf(m, "clock\t\t: %lu.%06luMHz\n", ppc_proc_freq / 1000000,
+		   ppc_proc_freq % 1000000);
+
 	seq_printf(m, "revision\t: %hd.%hd (pvr %04x %04x)\n",
 		   maj, min, PVR_VER(pvr), PVR_REV(pvr));
 
 	seq_printf(m, "bogomips\t: %lu.%02lu\n",
 		   lpj / (500000/HZ), (lpj / (5000/HZ)) % 100);
 
-#if USES_PPC_SYS
-	if (cur_ppc_sys_spec->ppc_sys_name)
-		seq_printf(m, "chipset\t\t: %s\n",
-			cur_ppc_sys_spec->ppc_sys_name);
-#endif
-
 #ifdef CONFIG_SMP
 	seq_printf(m, "\n");
 #endif
@@ -305,28 +298,6 @@ unsigned long __init early_init(unsigned
 }
 
 #ifdef CONFIG_PPC_OF
-/*
- * Assume here that all clock rates are the same in a
- * smp system.  -- Cort
- */
-int
-of_show_percpuinfo(struct seq_file *m, int i)
-{
-	struct device_node *cpu_node;
-	u32 *fp;
-	int s;
-	
-	cpu_node = find_type_devices("cpu");
-	if (!cpu_node)
-		return 0;
-	for (s = 0; s < i && cpu_node->next; s++)
-		cpu_node = cpu_node->next;
-	fp = (u32 *)get_property(cpu_node, "clock-frequency", NULL);
-	if (fp)
-		seq_printf(m, "clock\t\t: %dMHz\n", *fp / 1000000);
-	return 0;
-}
-
 void __init
 intuit_machine_type(void)
 {
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -202,9 +202,6 @@ static void pmac_show_percpuinfo(struct 
 		return;
 	}
 #endif /* CONFIG_CPU_FREQ_PMAC */
-#ifdef CONFIG_PPC32
-	of_show_percpuinfo(m, i);
-#endif
 }
 
 #ifndef CONFIG_ADB_CUDA
