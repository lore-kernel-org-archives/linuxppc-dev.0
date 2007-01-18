Return-Path: <livio@eecg.toronto.edu>
Received: from picton.eecg.toronto.edu (picton.eecg.toronto.edu
	[128.100.10.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "picton.eecg.toronto.edu",
	Issuer "picton.eecg.toronto.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EF6C0DDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 05:22:08 +1100 (EST)
Date: Thu, 18 Jan 2007 13:21:52 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH][PowerPC] Remove ineffective CONFIG_IRQ_ALL_CPUS option
Message-ID: <20070118182152.GA11204@eecg.toronto.edu>
References: <20070117230255.GA31478@eecg.toronto.edu>
	<1169079378.4965.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169079378.4965.3.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Hello Ben,

Benjamin Herrenschmidt writes:
> On Wed, 2007-01-17 at 18:02 -0500, Livio Soares wrote:

[...]

> 
> Please, provide as Signed-off-by: line. 

  I apologize; I was not very familiar with the procedures involved with sending
patches to Linux kernel. I will provide one in the future; thanks.

>                                         Note that the patch is incorrect
> too, CONFIG_IRQ_ALL_CPUS -is- used in arch/powerpc/sysdev/mpic.c though
> I agree it should probably be removed as a config option and made
> runtime instead (if at all, I think we can pretty much safely always
> enable it nowadays).

  Ok.  For  some  reason I  understood  that  mpic.c  was  being used  in  'ppc'
architecture as well, therefore I should not remove it. However, that assumption
was incorrect.  This new patch  completely removes the IRQ_ALL_CPUS  option from
powerpc  altogether.  To   do  so,  I  have  enabled   the  kernel  boot  option
"noirqdistrib"  for  both  PPC64 and  PPC32.  Both  mpic.c  and xics.c  use  the
"distribute_irqs"  variable, which is  1 (on)  by default,  and turned  off with
"noirqdistrib" bootup option.  Currently, there is no way  to dynamically change
the behaviour. 

  On  a side  note, I  probably need  to make  IRQ distribution  configurable at
run-time (for  my personal work).  I  was thinking of exporting  a bit-mask type
structure  through sysfs,  to enable  run-time configuration  of CPUs  which can
receive interrupts (and possibly priorities). Would people be interested in such
a patch?

  Below is the patch to remove CONFIG_IRQ_ALL_CPUS from powerpc. 

  Thanks,

		Livio

Signed-off-by: Livio Soares <livio@eecg.toronto.edu>

diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig	2007-01-17 17:50:43.000000000 -0500
@@ -204,7 +204,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
 CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig	2007-01-17 17:55:06.000000000 -0500
@@ -159,7 +159,6 @@ CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig	2007-01-17 17:57:50.000000000 -0500
@@ -166,7 +166,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig	2007-01-17 17:57:57.000000000 -0500
@@ -159,7 +159,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_LPARCFG=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig	2007-01-17 17:58:04.000000000 -0500
@@ -157,7 +157,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-17 17:58:19.000000000 -0500
@@ -138,7 +138,6 @@ CONFIG_PREEMPT_BKL=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
-# CONFIG_IRQ_ALL_CPUS is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig	2007-01-17 17:58:25.000000000 -0500
@@ -182,7 +182,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_EEH=y
 CONFIG_SCANLOG=m
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig	2007-01-17 17:58:32.000000000 -0500
@@ -177,7 +177,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-# CONFIG_IRQ_ALL_CPUS is not set
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig	2007-01-17 17:58:39.000000000 -0500
@@ -160,7 +160,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_EEH=y
 CONFIG_SCANLOG=m
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/Kconfig linux-2.6.20-rc4.pmu/arch/powerpc/Kconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/Kconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/Kconfig	2007-01-17 17:42:47.000000000 -0500
@@ -793,15 +793,6 @@ config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
 
-config IRQ_ALL_CPUS
-	bool "Distribute interrupts on all CPUs by default"
-	depends on SMP && !MV64360
-	help
-	  This option gives the kernel permission to distribute IRQs across
-	  multiple CPUs.  Saying N here will route all IRQs to the first
-	  CPU.  Generally saying Y is safe, although some problems have been
-	  reported with SMP Power Macintoshes with this option enabled.
-
 source "arch/powerpc/platforms/pseries/Kconfig"
 
 config NUMA
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/kernel/irq.c linux-2.6.20-rc4.pmu/arch/powerpc/kernel/irq.c
--- linux-2.6.20-rc4.vanilla/arch/powerpc/kernel/irq.c	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/kernel/irq.c	2007-01-17 19:47:42.000000000 -0500
@@ -92,11 +92,11 @@ extern atomic_t ipi_recv;
 extern atomic_t ipi_sent;
 #endif
 
+int distribute_irqs = 1;
+
 #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(irq_desc);
 
-int distribute_irqs = 1;
-
 static inline unsigned long get_hard_enabled(void)
 {
 	unsigned long enabled;
@@ -973,7 +973,6 @@ EXPORT_SYMBOL(pci_disable_msix);
 
 #endif
 
-#ifdef CONFIG_PPC64
 static int __init setup_noirqdistrib(char *str)
 {
 	distribute_irqs = 0;
@@ -981,4 +980,3 @@ static int __init setup_noirqdistrib(cha
 }
 
 __setup("noirqdistrib", setup_noirqdistrib);
-#endif /* CONFIG_PPC64 */
diff -pru -X linux-2.6.20-rc4/Documentation/dontdiff linux-2.6.20-rc4.vanilla/arch/powerpc/sysdev/mpic.c linux-2.6.20-rc4.pmu/arch/powerpc/sysdev/mpic.c
--- linux-2.6.20-rc4.vanilla/arch/powerpc/sysdev/mpic.c	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/sysdev/mpic.c	2007-01-17 19:46:41.000000000 -0500
@@ -46,14 +46,6 @@ static struct mpic *mpics;
 static struct mpic *mpic_primary;
 static DEFINE_SPINLOCK(mpic_lock);
 
-#ifdef CONFIG_PPC32	/* XXX for now */
-#ifdef CONFIG_IRQ_ALL_CPUS
-#define distribute_irqs	(1)
-#else
-#define distribute_irqs	(0)
-#endif
-#endif
-
 #ifdef CONFIG_MPIC_WEIRD
 static u32 mpic_infos[][MPIC_IDX_END] = {
 	[0] = {	/* Original OpenPIC compatible MPIC */
