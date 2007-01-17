Return-Path: <livio@eecg.toronto.edu>
Received: from picton.eecg.toronto.edu (picton.eecg.toronto.edu
	[128.100.10.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "picton.eecg.toronto.edu",
	Issuer "picton.eecg.toronto.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 10D41DDE49
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 10:03:01 +1100 (EST)
Received: from ouch.eecg.toronto.edu (ouch.eecg.toronto.edu [128.100.24.67])
	by picton.eecg.toronto.edu (8.13.6/8.13.6) with ESMTP id l0HN2tft009861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 18:02:56 -0500 (EST)
Received: (from livio@localhost)
	by ouch.eecg.toronto.edu (8.13.6/8.13.6/Submit) id l0HN2teC031981
	for linuxppc-dev@ozlabs.org; Wed, 17 Jan 2007 18:02:55 -0500
Date: Wed, 17 Jan 2007 18:02:55 -0500
From: Livio Soares <livio@eecg.toronto.edu>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][PowerPC] Remove ineffective CONFIG_IRQ_ALL_CPUS option
Message-ID: <20070117230255.GA31478@eecg.toronto.edu>
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

  Hi all,

  Anton Blanchard a couple of years  ago made a patch to enable IRQ distribution
as   a  boot   option,  as   opposed  to   static  kernel   compile   option  on
PPC64. [http://ozlabs.org/pipermail/linuxppc64-dev/2005-January/003045.html]. 

  Apparently, when  'ppc64' was  renamed to 'powerpc',  the Kconfig  option came
back  (just the  option, not  the code).  Well, the  option confused  me,  as it
currently has no effect (grep shows no users on PowerPC code, except for mpic.c,
but that one is guarded with #ifdef CONFIG_PPC32). 

  So, I think it would be best to remove it, no? 

  Patch below. 

PS: I am not a member of this list. 

  regards,

			Livio


diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig	2007-01-17 17:50:43.375814695 -0500
@@ -204,7 +204,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_NUMA=y
 CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig	2007-01-17 17:55:06.877092205 -0500
@@ -159,7 +159,6 @@ CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig	2007-01-17 17:57:50.693841420 -0500
@@ -166,7 +166,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig	2007-01-17 17:57:57.350140227 -0500
@@ -159,7 +159,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_LPARCFG=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig	2007-01-17 17:58:04.111427956 -0500
@@ -157,7 +157,6 @@ CONFIG_IOMMU_VMERGE=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-17 17:58:19.534803095 -0500
@@ -138,7 +138,6 @@ CONFIG_PREEMPT_BKL=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
-# CONFIG_IRQ_ALL_CPUS is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig	2007-01-17 17:58:25.804142587 -0500
@@ -182,7 +182,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_EEH=y
 CONFIG_SCANLOG=m
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig	2007-01-17 17:58:32.825402840 -0500
@@ -177,7 +177,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 # CONFIG_KEXEC is not set
 # CONFIG_CRASH_DUMP is not set
-# CONFIG_IRQ_ALL_CPUS is not set
 # CONFIG_NUMA is not set
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig
--- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig	2007-01-07 00:45:51.000000000 -0500
+++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig	2007-01-17 17:58:39.077744089 -0500
@@ -160,7 +160,6 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
-CONFIG_IRQ_ALL_CPUS=y
 CONFIG_PPC_SPLPAR=y
 CONFIG_EEH=y
 CONFIG_SCANLOG=m
diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/Kconfig linux-2.6.20-rc4.pmu/arch/powerpc/Kconfig
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
