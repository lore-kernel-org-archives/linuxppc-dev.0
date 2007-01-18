Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3667ADDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:16:02 +1100 (EST)
Subject: Re: [PATCH][PowerPC] Remove ineffective CONFIG_IRQ_ALL_CPUS option
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Livio Soares <livio@eecg.toronto.edu>
In-Reply-To: <20070117230255.GA31478@eecg.toronto.edu>
References: <20070117230255.GA31478@eecg.toronto.edu>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:16:18 +1100
Message-Id: <1169079378.4965.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-17 at 18:02 -0500, Livio Soares wrote:
>   Hi all,
> 
>   Anton Blanchard a couple of years  ago made a patch to enable IRQ distribution
> as   a  boot   option,  as   opposed  to   static  kernel   compile   option  on
> PPC64. [http://ozlabs.org/pipermail/linuxppc64-dev/2005-January/003045.html]. 
> 
>   Apparently, when  'ppc64' was  renamed to 'powerpc',  the Kconfig  option came
> back  (just the  option, not  the code).  Well, the  option confused  me,  as it
> currently has no effect (grep shows no users on PowerPC code, except for mpic.c,
> but that one is guarded with #ifdef CONFIG_PPC32). 
> 
>   So, I think it would be best to remove it, no? 
> 
>   Patch below. 
> 
> PS: I am not a member of this list. 
> 
>   regards,

Please, provide as Signed-off-by: line. Note that the patch is incorrect
too, CONFIG_IRQ_ALL_CPUS -is- used in arch/powerpc/sysdev/mpic.c though
I agree it should probably be removed as a config option and made
runtime instead (if at all, I think we can pretty much safely always
enable it nowadays).

Ben.
 
> 			Livio
> 
> 
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/cell_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/cell_defconfig	2007-01-17 17:50:43.375814695 -0500
> @@ -204,7 +204,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  # CONFIG_KEXEC is not set
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_NUMA=y
>  CONFIG_NODES_SHIFT=4
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/chrp32_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/chrp32_defconfig	2007-01-17 17:55:06.877092205 -0500
> @@ -159,7 +159,6 @@ CONFIG_BINFMT_ELF=y
>  CONFIG_BINFMT_MISC=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  # CONFIG_KEXEC is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_ARCH_FLATMEM_ENABLE=y
>  CONFIG_SELECT_MEMORY_MODEL=y
>  CONFIG_FLATMEM_MANUAL=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/g5_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/g5_defconfig	2007-01-17 17:57:50.693841420 -0500
> @@ -166,7 +166,6 @@ CONFIG_IOMMU_VMERGE=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  CONFIG_KEXEC=y
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  # CONFIG_NUMA is not set
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>  CONFIG_ARCH_FLATMEM_ENABLE=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/iseries_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/iseries_defconfig	2007-01-17 17:57:57.350140227 -0500
> @@ -159,7 +159,6 @@ CONFIG_IOMMU_VMERGE=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  # CONFIG_KEXEC is not set
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_LPARCFG=y
>  # CONFIG_NUMA is not set
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/maple_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/maple_defconfig	2007-01-17 17:58:04.111427956 -0500
> @@ -157,7 +157,6 @@ CONFIG_IOMMU_VMERGE=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  CONFIG_KEXEC=y
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  # CONFIG_NUMA is not set
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>  CONFIG_ARCH_FLATMEM_ENABLE=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/mpc8641_hpcn_defconfig	2007-01-17 17:58:19.534803095 -0500
> @@ -138,7 +138,6 @@ CONFIG_PREEMPT_BKL=y
>  CONFIG_BINFMT_ELF=y
>  # CONFIG_BINFMT_MISC is not set
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> -# CONFIG_IRQ_ALL_CPUS is not set
>  CONFIG_ARCH_FLATMEM_ENABLE=y
>  CONFIG_SELECT_MEMORY_MODEL=y
>  CONFIG_FLATMEM_MANUAL=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ppc64_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ppc64_defconfig	2007-01-17 17:58:25.804142587 -0500
> @@ -182,7 +182,6 @@ CONFIG_HOTPLUG_CPU=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  CONFIG_KEXEC=y
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_PPC_SPLPAR=y
>  CONFIG_EEH=y
>  CONFIG_SCANLOG=m
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/ps3_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/ps3_defconfig	2007-01-17 17:58:32.825402840 -0500
> @@ -177,7 +177,6 @@ CONFIG_FORCE_MAX_ZONEORDER=9
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  # CONFIG_KEXEC is not set
>  # CONFIG_CRASH_DUMP is not set
> -# CONFIG_IRQ_ALL_CPUS is not set
>  # CONFIG_NUMA is not set
>  CONFIG_ARCH_SELECT_MEMORY_MODEL=y
>  CONFIG_ARCH_FLATMEM_ENABLE=y
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/configs/pseries_defconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/configs/pseries_defconfig	2007-01-17 17:58:39.077744089 -0500
> @@ -160,7 +160,6 @@ CONFIG_HOTPLUG_CPU=y
>  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
>  CONFIG_KEXEC=y
>  # CONFIG_CRASH_DUMP is not set
> -CONFIG_IRQ_ALL_CPUS=y
>  CONFIG_PPC_SPLPAR=y
>  CONFIG_EEH=y
>  CONFIG_SCANLOG=m
> diff -pru linux-2.6.20-rc4.vanilla/arch/powerpc/Kconfig linux-2.6.20-rc4.pmu/arch/powerpc/Kconfig
> --- linux-2.6.20-rc4.vanilla/arch/powerpc/Kconfig	2007-01-07 00:45:51.000000000 -0500
> +++ linux-2.6.20-rc4.pmu/arch/powerpc/Kconfig	2007-01-17 17:42:47.000000000 -0500
> @@ -793,15 +793,6 @@ config PPCBUG_NVRAM
>  	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
>  	default y if PPC_PREP
>  
> -config IRQ_ALL_CPUS
> -	bool "Distribute interrupts on all CPUs by default"
> -	depends on SMP && !MV64360
> -	help
> -	  This option gives the kernel permission to distribute IRQs across
> -	  multiple CPUs.  Saying N here will route all IRQs to the first
> -	  CPU.  Generally saying Y is safe, although some problems have been
> -	  reported with SMP Power Macintoshes with this option enabled.
> -
>  source "arch/powerpc/platforms/pseries/Kconfig"
>  
>  config NUMA
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
