Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 483FBDDF1B
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 00:14:20 +1000 (EST)
Date: Fri, 1 Aug 2008 18:14:18 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] powerpc: remove default kexec/crash_kernel ops assignments
Message-ID: <20080801141418.GC1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080801141306.GA29127@polina.dev.rtsoft.ru>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Default ops are implicit now.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/cell/celleb_setup.c     |    9 ---------
 arch/powerpc/platforms/cell/setup.c            |    6 ------
 arch/powerpc/platforms/embedded6xx/c2k.c       |    6 ------
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    6 ------
 arch/powerpc/platforms/maple/setup.c           |    6 ------
 arch/powerpc/platforms/powermac/setup.c        |    6 ------
 arch/powerpc/platforms/ps3/setup.c             |    4 ----
 7 files changed, 0 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index b11cb30..07c234f 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -45,7 +45,6 @@
 #include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/io.h>
-#include <asm/kexec.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
@@ -226,9 +225,6 @@ define_machine(celleb_beat) {
 	.pci_setup_phb		= celleb_setup_phb,
 #ifdef CONFIG_KEXEC
 	.kexec_cpu_down		= beat_kexec_cpu_down,
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
 #endif
 };
 
@@ -248,9 +244,4 @@ define_machine(celleb_native) {
 	.pci_probe_mode 	= celleb_pci_probe_mode,
 	.pci_setup_phb		= celleb_setup_phb,
 	.init_IRQ		= celleb_init_IRQ_native,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index ab721b5..5930536 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -35,7 +35,6 @@
 #include <asm/mmu.h>
 #include <asm/processor.h>
 #include <asm/io.h>
-#include <asm/kexec.h>
 #include <asm/pgtable.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -289,9 +288,4 @@ define_machine(cell) {
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
 	.pci_setup_phb		= cell_setup_phb,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c b/arch/powerpc/platforms/embedded6xx/c2k.c
index d0b25b8..19d3bc4 100644
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ b/arch/powerpc/platforms/embedded6xx/c2k.c
@@ -20,7 +20,6 @@
 #include <linux/seq_file.h>
 #include <linux/time.h>
 #include <linux/of.h>
-#include <linux/kexec.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
@@ -150,9 +149,4 @@ define_machine(c2k) {
 	.get_irq		= mv64x60_get_irq,
 	.restart		= c2k_restart,
 	.calibrate_decr		= generic_calibrate_decr,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index 5a19b9a..e40b5a8 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -19,7 +19,6 @@
 #include <asm/prom.h>
 #include <asm/system.h>
 #include <asm/time.h>
-#include <asm/kexec.h>
 
 #include <mm/mmu_decl.h>
 
@@ -158,9 +157,4 @@ define_machine(prpmc2800){
 	.get_irq		= mv64x60_get_irq,
 	.restart		= prpmc2800_restart,
 	.calibrate_decr		= generic_calibrate_decr,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 3647147..1be9b7c 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -51,7 +51,6 @@
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/kexec.h>
 #include <asm/pci-bridge.h>
 #include <asm/iommu.h>
 #include <asm/machdep.h>
@@ -336,9 +335,4 @@ define_machine(maple) {
       	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= maple_progress,
 	.power_save		= power4_idle,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 };
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 88ccf3a..5e0999b 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -61,7 +61,6 @@
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
-#include <asm/kexec.h>
 #include <asm/pci-bridge.h>
 #include <asm/ohare.h>
 #include <asm/mediabay.h>
@@ -741,11 +740,6 @@ define_machine(powermac) {
 	.pci_probe_mode		= pmac_pci_probe_mode,
 	.power_save		= power4_idle,
 	.enable_pmcs		= power4_enable_pmcs,
-#ifdef CONFIG_KEXEC
-	.machine_kexec		= default_machine_kexec,
-	.machine_kexec_prepare	= default_machine_kexec_prepare,
-	.machine_crash_shutdown	= default_machine_crash_shutdown,
-#endif
 #endif /* CONFIG_PPC64 */
 #ifdef CONFIG_PPC32
 	.pcibios_enable_device_hook = pmac_pci_enable_device_hook,
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index a413abb..a8b99a6 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -23,7 +23,6 @@
 #include <linux/fs.h>
 #include <linux/root_dev.h>
 #include <linux/console.h>
-#include <linux/kexec.h>
 #include <linux/bootmem.h>
 
 #include <asm/machdep.h>
@@ -278,8 +277,5 @@ define_machine(ps3) {
 	.halt				= ps3_halt,
 #if defined(CONFIG_KEXEC)
 	.kexec_cpu_down			= ps3_kexec_cpu_down,
-	.machine_kexec			= default_machine_kexec,
-	.machine_kexec_prepare		= default_machine_kexec_prepare,
-	.machine_crash_shutdown		= default_machine_crash_shutdown,
 #endif
 };
-- 
1.5.5.4
