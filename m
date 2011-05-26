Return-Path: <matt@ozlabs.org>
Message-ID: <4DDDD268.70005@ozlabs.org>
Date: Thu, 26 May 2011 14:09:12 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Replace boot_cpu_count with spinning_secondaries,
	fix off-by-one cpu wait
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smp_release_cpus() waits for all cpus (including the bootcpu) due to an
off-by-one count on boot_cpu_count (which is all CPUs).  This patch replaces
that with spinning_secondaries (which is all secondary CPUs).

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 arch/powerpc/include/asm/smp.h |    2 +-
 arch/powerpc/kernel/head_64.S  |    2 +-
 arch/powerpc/kernel/prom.c     |    8 ++++++++
 arch/powerpc/kernel/setup_32.c |    1 -
 arch/powerpc/kernel/setup_64.c |    6 +++---
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 880b8c1..8f01c85 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -30,7 +30,7 @@
 #include <asm/percpu.h>
 
 extern int boot_cpuid;
-extern int boot_cpu_count;
+extern int spinning_secondaries;
 
 extern void cpu_die(void);
 
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index ba50409..3564c49 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -255,7 +255,7 @@ generic_secondary_common_init:
 	mtctr	r23
 	bctrl
 
-3:	LOAD_REG_ADDR(r3, boot_cpu_count) /* Decrement boot_cpu_count */
+3:	LOAD_REG_ADDR(r3, spinning_secondaries) /* Decrement spinning_secondaries */
 	lwarx	r4,0,r3
 	subi	r4,r4,1
 	stwcx.	r4,0,r3
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 48aeb55..540e0dc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -69,6 +69,7 @@ unsigned long tce_alloc_start, tce_alloc_end;
 u64 ppc64_rma_size;
 #endif
 static phys_addr_t first_memblock_size;
+static int __initdata boot_cpu_count;
 
 static int __init early_parse_mem(char *p)
 {
@@ -748,6 +749,13 @@ void __init early_init_devtree(void *params)
 	 */
 	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
 
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
+	/* We'll later wait for secondaries to check in; there are
+	 * NCPUS-1 non-boot CPUs  :-)
+	 */
+	spinning_secondaries = boot_cpu_count - 1;
+#endif
+
 	DBG(" <- early_init_devtree()\n");
 }
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 620d792..1d2fbc9 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -48,7 +48,6 @@ extern void bootx_init(unsigned long r4, unsigned long phys);
 
 int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
-int __initdata boot_cpu_count;
 int boot_cpuid_phys;
 
 int smp_hw_index[NR_CPUS];
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index a88bf27..0576919 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -73,7 +73,7 @@
 #endif
 
 int boot_cpuid = 0;
-int __initdata boot_cpu_count;
+int __initdata spinning_secondaries;
 u64 ppc64_pft_size;
 
 /* Pick defaults since we might want to patch instructions
@@ -253,11 +253,11 @@ void smp_release_cpus(void)
 	for (i = 0; i < 100000; i++) {
 		mb();
 		HMT_low();
-		if (boot_cpu_count == 0)
+		if (spinning_secondaries == 0)
 			break;
 		udelay(1);
 	}
-	DBG("boot_cpu_count = %d\n", boot_cpu_count);
+	DBG("spinning_secondaries = %d\n", spinning_secondaries);
 
 	DBG(" <- smp_release_cpus()\n");
 }
-- 
1.7.0.4

0
