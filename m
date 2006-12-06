Return-Path: <anton@ozlabs.org>
Date: Thu, 7 Dec 2006 07:58:18 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Add DSCR SPR to sysfs
Message-ID: <20061206205818.GA27857@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


POWER6 adds a new SPR, the data stream control register (DSCR). It can
be used to adjust how agressive the prefetch mechanisms are.

Its possible we may want to context switch this, but for now just export
it to userspace via sysfs so we can adjust it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index d45a168..505e0f4 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -181,6 +181,7 @@ SYSFS_PMCSETUP(pmc6, SPRN_PMC6);
 SYSFS_PMCSETUP(pmc7, SPRN_PMC7);
 SYSFS_PMCSETUP(pmc8, SPRN_PMC8);
 SYSFS_PMCSETUP(purr, SPRN_PURR);
+SYSFS_PMCSETUP(dscr, SPRN_DSCR);
 
 static SYSDEV_ATTR(mmcr0, 0600, show_mmcr0, store_mmcr0);
 static SYSDEV_ATTR(mmcr1, 0600, show_mmcr1, store_mmcr1);
@@ -194,6 +195,7 @@ static SYSDEV_ATTR(pmc6, 0600, show_pmc6, store_pmc6);
 static SYSDEV_ATTR(pmc7, 0600, show_pmc7, store_pmc7);
 static SYSDEV_ATTR(pmc8, 0600, show_pmc8, store_pmc8);
 static SYSDEV_ATTR(purr, 0600, show_purr, NULL);
+static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
 
 static void register_cpu_online(unsigned int cpu)
 {
@@ -232,6 +234,9 @@ static void register_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
+
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		sysdev_create_file(s, &attr_dscr);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -274,6 +279,9 @@ static void unregister_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
+
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		sysdev_remove_file(s, &attr_dscr);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index a9a4014..9548fee 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -148,6 +148,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
 #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
+#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0001000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -332,7 +333,8 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 6faae7b..cacdecc 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -143,6 +143,7 @@
 
 /* Special Purpose Registers (SPRNs)*/
 #define SPRN_CTR	0x009	/* Count Register */
+#define SPRN_DSCR	0x11
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
 #define   CTRL_CT	0xc0000000	/* current thread */
