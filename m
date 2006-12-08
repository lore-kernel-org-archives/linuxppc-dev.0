Return-Path: <anton@ozlabs.org>
Date: Fri, 8 Dec 2006 17:46:58 +1100
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Add DSCR SPR to sysfs
Message-ID: <20061208064658.GA29167@krispykreme>
References: <20061206205818.GA27857@krispykreme>
	<17784.62591.729512.791358@cargo.ozlabs.ibm.com>
	<20061208054106.GB9391@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061208054106.GB9391@krispykreme>
Cc: linuxppc-dev@ozlabs.org
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
index 63ed265..22daba5 100644
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
@@ -231,6 +233,9 @@ static void register_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_create_file(s, &attr_purr);
+
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		sysdev_create_file(s, &attr_dscr);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -272,6 +277,9 @@ static void unregister_cpu_online(unsigned int cpu)
 
 	if (cpu_has_feature(CPU_FTR_PURR))
 		sysdev_remove_file(s, &attr_purr);
+
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		sysdev_remove_file(s, &attr_dscr);
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 6fe5c9d..782adbf 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -152,6 +152,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
 #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
 #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
+#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -330,13 +331,14 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR)
 #define CPU_FTRS_POWER6X (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_SPURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_SPURR | CPU_FTR_REAL_LE | CPU_FTR_DSCR)
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
