Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <200704121501.34311.arnd@arndb.de>
References: <20070410111508.GA2969@localhost.localdomain>
	<1176240168.8061.51.camel@localhost.localdomain>
	<200704121501.34311.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <981B07C8-D35B-4581-8FC7-DCA58430A081@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC, PATCH] selection of CPU optimization
Date: Thu, 12 Apr 2007 11:45:29 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Akinobu Mita <mita@fixstars.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2007, at 8:01 AM, Arnd Bergmann wrote:

> On Tuesday 10 April 2007, Benjamin Herrenschmidt wrote:
>> On Tue, 2007-04-10 at 20:15 +0900, Akinobu Mita wrote:
>>> An Alignment interrupt occurs when the instruction is lmw, stmw,  
>>> lswi, lswx,
>>> stswi, or stswx, and the operand is in local store.
>>>
>>> GCC generated such instructions to handle memcpy() instead of kernel
>>> defined memcpy() without -mno-string option.
>>>
>>> Signed-off-by: Akinobu Mita <mita@fixstars.com>
>>
>> I would personally prefer building the entire kernel with -mno-string
>> when cell support is enabled...
>
> The -mno-string flag should be set when _optimizing_ for cell,  
> which it
> probably is, but not when enabling a platform that runs on cell.
>
> I recently experimented with cleaning up the CPU type selection in  
> powerpc
> in general, by splitting the selection into four groups:
>
> 1. CPU architecture (64 bit powerpc, 32 bit common, FSL book E,  
> 4xx, ...)
>   this is roughly what we have already and limits the other options
> 2. Minimum CPU level (power3, power4, 970, cell, ....)
>   this selects the instruction set with -mcpu=xxx, but assumes that  
> some
>   CPUs use are a superset of others.
> 3. Optimization for a CPU (same list as above)
>   compatible in both ways, but can optimize only for CPUs that were  
> not
>   excluded in step 2.
> 4. platform selection (mac, pseries, prep, 83xx, 86xx, ...)
>   unchanged from now, but depends on 1. and 2. Depending on 1, you may
>   choose multiple platforms simultaneously, or just one.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Index: linux-cg/arch/powerpc/Kconfig.cputype
> ===================================================================
> --- /dev/null
> +++ linux-cg/arch/powerpc/Kconfig.cputype
> @@ -0,0 +1,610 @@
> +menu "Processor support"
> +choice
> +	prompt "Processor Type"
> +	default 6xx
> +	help
> +	  There are four families of PowerPC chips supported.  The more  
> common
> +	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
> +	  versions (821, 823, 850, 855, 860, 52xx, 82xx, 83xx), the AMCC
> +	  embedded versions (403 and 405) and the high end 64 bit Power
> +	  processors (POWER 3, POWER4, and IBM PPC970 also known as G5).
> +
> +config PPC64
> +	bool "Any 64 bit processor"
> +	help
> +	  This option is the catch-all for all 64 bit processors, including
> +	  the IBM Power3/4/5/6, PowerPC 970 (G5), Cell Broadband Engine,
> +	  and the PA Semi PA6T.
> +
> +config PPC_6xx
> +	bool "52xx/6xx/7xx/74xx/82xx/83xx/86xx"
> +	select PPC_FPU
> +	select 6xx
> +	help
> +	  This option is the catch-all for 6xx types, including some of the
> +	  embedded versions.  Unless there is see an option for the specific
> +	  chip family you are using, you want this option.
> +
> +	  If unsure, select this option.
> +
> +config PPC_85xx
> +	bool "Freescale 85xx"
> +	select E500
> +	select FSL_SOC
> +	select 85xx
> +
> +config PPC_8xx
> +	bool "Freescale 8xx"
> +	select FSL_SOC
> +	select 8xx
> +
> +config 40x
> +	bool "AMCC 40x"
> +	select PPC_DCR_NATIVE
> +
> +config 44x
> +	bool "AMCC 44x"
> +	select PPC_DCR_NATIVE
> +
> +config E200
> +	bool "Freescale e200"
> +
> +endchoice
> +
> +#choice
> +#	prompt "Type of 6xx package"
> +#	default CLASSIC32
> +#	depends on PPC_6xx
> +#
> +config CLASSIC32
> +	bool "Classic 52xx/6xx/7xx/74xx"
> +	select 6xx
> +	select PPC_FPU
> +
> +config PPC_82xx
> +	bool "Embedded Freescale 82xx"
> +	select 6xx
> +	select PPC_FPU
> +
> +config PPC_83xx
> +	bool "Embedded Freescale 83xx"
> +	select 6xx
> +	select FSL_SOC
> +	select 83xx
> +	select PPC_FPU
> +
> +config PPC_86xx
> +	bool "Embedded Freescale 86xx"
> +	select 6xx
> +	select FSL_SOC
> +	select PPC_FPU
> +	select ALTIVEC
> +	help
> +	  The Freescale E600 SoCs have 74xx cores.
> +# endchoice
> +
> +choice
> +	prompt "Processor level"
> +	default PPC_CPU_POWER3 if PPC64
> +
> +config PPC_CPU_UNSPECIFIED
> +	bool "Use compiler default"
> +
> +config PPC_CPU_ANY64
> +	bool "Generic 64 bit PowerPC"
> +	depends on PPC64
> +	select PPC_ENABLE_ANY64
> +
> +config PPC_CPU_RS64
> +	bool "RS64 (Northstar/Pulsar/Icestar/Sstar)"
> +	depends on PPC64
> +	select PPC_ENABLE_RS64
> +
> +config PPC_CPU_POWER3
> +	bool "Power3"
> +	depends on PPC64
> +	select PPC_ENABLE_POWER3
> +
> +config PPC_CPU_POWER4
> +	bool "Power4"
> +	depends on PPC64
> +	select PPC_ENABLE_POWER4
> +
> +config PPC_CPU_POWER5
> +	bool "Power5"
> +	depends on PPC64
> +	select PPC_ENABLE_POWER5
> +	select ALTIVEC
> +
> +config PPC_CPU_POWER5PLUS
> +	bool "Power5+"
> +	depends on PPC64
> +	select PPC_ENABLE_POWER5PLUS
> +	select ALTIVEC
> +
> +config PPC_CPU_POWER6
> +	bool "Power6"
> +	depends on PPC64
> +	select PPC_ENABLE_PA6T
> +	select PPC_ENABLE_POWER6
> +	select ALTIVEC
> +
> +config PPC_CPU_970
> +	bool "PowerPC 970 (G5)"
> +	depends on PPC64
> +	select PPC_ENABLE_970
> +	select ALTIVEC
> +
> +config PPC_CPU_CELLBE
> +	bool "Cell Broadband Engine"
> +	depends on PPC64
> +	select PPC_ENABLE_CELLBE
> +	select PPC_ENABLE_PA6T
> +	select PPC_ENABLE_POWER6
> +	select ALTIVEC
> +
> +config PPC_CPU_PA6T
> +	bool "PA Semi PA6T"
> +	depends on PPC64
> +	select PPC_ENABLE_PA6T
> +	select PPC_ENABLE_POWER6
> +	select ALTIVEC
> +
> +config PPC_CPU_ANY32
> +	bool "Generic 32 bit PowerPC"
> +	depends on PPC_6xx || PPC_8xx || 4xx || E200 || E500
> +	select PPC_ENABLE_ALTIVEC

What is PPC_ENABLE_ALTIVEC used for?

> +
> +config PPC_CPU_601
> +	bool "601 (G1)"
> +	depends on CLASSIC32
> +
> +config PPC_CPU_603
> +	bool "603/603e/82xx/83xx/e300 (G2)"
> +	depends on CLASSIC32 || PPC_82xx || PPC_83xx
> +
> +config PPC_CPU_604
> +	bool "604/604e/604r/604ev"
> +	depends on CLASSIC32
> +
> +config PPC_CPU_750
> +	bool "750/750CX/750CXe/750FX/750GX (G3)"
> +	depends on CLASSIC32
> +
> +config PPC_CPU_7400
> +	bool "7400/7410"
> +	depends on CLASSIC32
> +	select ALTIVEC
> +
> +config PPC_CPU_7450
> +	bool "7450/7447/7457/7448/7450/86xx (G4)"
> +	depends on CLASSIC32 || PPC_86xx
> +	select ALTIVEC
> +
> +config PPC_CPU_801
> +	bool "801"
> +	depends on PPC_8xx
> +
> +config PPC_CPU_821
> +	bool "821"
> +	depends on PPC_8xx
> +
> +config PPC_CPU_823
> +	bool "823"
> +	depends on PPC_8xx
> +
> +config PPC_CPU_860
> +	bool "860"
> +	depends on PPC_8xx
> +
> +config PPC_CPU_403
> +	bool "403"
> +	depends on 40x
> +
> +config PPC_CPU_405
> +	bool "405"
> +	depends on 40x
> +
> +config PPC_CPU_440
> +	bool "440"
> +	depends on 44x
> +
> +config PPC_CPU_E200
> +	bool "e200/5554"
> +	depends on E200
> +
> +config PPC_CPU_E500
> +	bool "e500/8540/8548"
> +	depends on E500
> +endchoice
> +
> +config PPC_ENABLE_ANY64
> +	bool
> +	select PPC_ENABLE_RS64
> +
> +config PPC_ENABLE_POWER3
> +	bool
> +	select PPC_ENABLE_POWER4
> +
> +config PPC_ENABLE_POWER4
> +	bool
> +	select PPC_ENABLE_POWER5
> +	select PPC_ENABLE_970
> +
> +config PPC_ENABLE_POWER5
> +	bool
> +	select PPC_ENABLE_POWER5PLUS
> +	select PPC_ENABLE_CELLBE
> +
> +config PPC_ENABLE_POWER5PLUS
> +	bool
> +	select PPC_ENABLE_POWER6
> +
> +config PPC_ENABLE_POWER6
> +	bool
> +	select PPC_ENABLE_ALTIVEC
> +
> +config PPC_ENABLE_RS64
> +	bool
> +	select PPC_ENABLE_POWER3
> +
> +config PPC_ENABLE_970
> +	bool
> +	select PPC_ENABLE_POWER5
> +
> +config PPC_ENABLE_CELLBE
> +	bool
> +
> +config PPC_ENABLE_PA6T
> +	bool
> +
> +choice
> +	prompt "Tune for processor"
> +
> +config PPC_TUNE_UNSPECIFIED
> +	bool "Use compiler default"
> +
> +config PPC_TUNE_ANY64
> +	bool "Generic 64 bit PowerPC"
> +	depends on PPC64
> +
> +config PPC_TUNE_RS64
> +	bool "RS64 (Northstar/Pulsar/Icestar/Sstar)"
> +	depends on PPC_ENABLE_RS64
> +
> +config PPC_TUNE_POWER3
> +	bool "Power3"
> +	depends on PPC_ENABLE_POWER3
> +
> +config PPC_TUNE_POWER4
> +	bool "Power4"
> +	depends on PPC_ENABLE_POWER4
> +
> +config PPC_TUNE_POWER5
> +	bool "Power5"
> +	depends on PPC_ENABLE_POWER5
> +
> +config PPC_TUNE_POWER5PLUS
> +	bool "Power5+"
> +	depends on PPC_ENABLE_POWER5PLUS
> +
> +config PPC_TUNE_POWER6
> +	bool "Power6"
> +	depends on PPC_ENABLE_POWER6
> +
> +config PPC_TUNE_970
> +	bool "PowerPC 970 (G5)"
> +	depends on PPC_ENABLE_970
> +
> +config PPC_TUNE_CELLBE
> +	bool "Cell Broadband Engine"
> +	depends on PPC_ENABLE_CELLBE
> +
> +config PPC_TUNE_PA6T
> +	bool "PA Semi PA6T"
> +	depends on PPC_ENABLE_PA6T
> +
> +config PPC_TUNE_ANY32
> +	bool "Generic 32 bit PowerPC"
> +	depends on PPC32
> +	select PPC_ENABLE_ALTIVEC
> +
> +config PPC_TUNE_601
> +	bool "601 (G1)"
> +	depends on CLASSIC32
> +
> +config PPC_TUNE_603
> +	bool "603/603e/82xx/83xx/e300 (G2)"
> +	depends on CLASSIC32 || PPC_82xx || PPC_83xx
> +
> +config PPC_TUNE_604
> +	bool "604/604e/604r/604ev"
> +	depends on CLASSIC32
> +
> +config PPC_TUNE_750
> +	bool "750/750CX/750CXe/750FX/750GX (G3)"
> +	depends on CLASSIC32
> +
> +config PPC_TUNE_7400
> +	bool "7400/7410"
> +	depends on CLASSIC32
> +
> +config PPC_TUNE_7450
> +	bool "7450/7447/7457/7448/7450/86xx (G4)"
> +	depends on CLASSIC32 || PPC_86xx
> +
> +config PPC_TUNE_801
> +	bool "801"
> +	depends on PPC_8xx
> +
> +config PPC_TUNE_821
> +	bool "821"
> +	depends on PPC_8xx
> +
> +config PPC_TUNE_823
> +	bool "823"
> +	depends on PPC_8xx
> +
> +config PPC_TUNE_860
> +	bool "860"
> +	depends on PPC_8xx
> +
> +config PPC_TUNE_403
> +	bool "403"
> +	depends on 40x
> +
> +config PPC_TUNE_405
> +	bool "405"
> +	depends on 40x
> +
> +config PPC_TUNE_440
> +	bool "440"
> +	depends on 44x
> +
> +config PPC_TUNE_E200
> +	bool "e200/5554"
> +	depends on E200
> +
> +config PPC_TUNE_E500
> +	bool "e500/8540/8548"
> +	depends on E500
> +
> +endchoice
> +
> +config PPC_ENABLE_ALTIVEC
> +	bool
> +
> +config PPC_CPU_FLAG
> +	string
> +	default "" if PPC_CPU_UNSPECIFIED
> +	default "-mcpu=powerpc64" if PPC_CPU_ANY64
> +	default "-mcpu=rs64" if PPC_CPU_RS64
> +	default "-mcpu=power3" if PPC_CPU_POWER3
> +	default "-mcpu=power4" if PPC_CPU_POWER4
> +	default "-mcpu=power5" if PPC_CPU_POWER5
> +	default "-mcpu=power5+" if PPC_CPU_POWER5PLUS
> +	default "-mcpu=power6" if PPC_CPU_POWER6
> +	default "-mcpu=970" if PPC_CPU_970
> +	default "" if PPC_CPU_CELLBE
> +	default "" if PPC_CPU_PA6T
> +	default "-mcpu=powerpc" if PPC_CPU_ANY32
> +	default "-mcpu=601" if PPC_CPU_601
> +	default "-mcpu=603" if PPC_CPU_603
> +	default "-mcpu=604" if PPC_CPU_604
> +	default "-mcpu=750" if PPC_CPU_750
> +	default "-mcpu=7400" if PPC_CPU_7400
> +	default "-mcpu=7450" if PPC_CPU_7450
> +	default "-mcpu=801" if PPC_CPU_801
> +	default "-mcpu=821" if PPC_CPU_821
> +	default "-mcpu=823" if PPC_CPU_823
> +	default "-mcpu=860" if PPC_CPU_860
> +	default "-mcpu=403" if PPC_CPU_403
> +	default "-mcpu=405" if PPC_CPU_405
> +	default "-mcpu=440" if PPC_CPU_440
> +	default "" if PPC_CPU_E200
> +	default "" if PPC_CPU_E500

I think -mcpu=8540 will work for e500 (same for tune)

> +
> +config PPC_TUNE_FLAG
> +	string
> +	default "" if PPC_TUNE_UNSPECIFIED
> +	default "-mtune=powerpc64" if PPC_TUNE_ANY64
> +	default "-mtune=rs64" if PPC_TUNE_RS64
> +	default "-mtune=power3" if PPC_TUNE_POWER3
> +	default "-mtune=power4" if PPC_TUNE_POWER4
> +	default "-mtune=power5" if PPC_TUNE_POWER5
> +	default "-mtune=power5+" if PPC_TUNE_POWER5PLUS
> +	default "-mtune=power6" if PPC_TUNE_POWER6
> +	default "-mtune=970" if PPC_TUNE_970
> +	default "" if PPC_TUNE_CELLBE
> +	default "" if PPC_TUNE_PA6T
> +	default "-mtune=powerpc" if PPC_TUNE_ANY32
> +	default "-mtune=601" if PPC_TUNE_601
> +	default "-mtune=603" if PPC_TUNE_603
> +	default "-mtune=604" if PPC_TUNE_604
> +	default "-mtune=750" if PPC_TUNE_750
> +	default "-mtune=7400" if PPC_TUNE_7400
> +	default "-mtune=7450" if PPC_TUNE_7450
> +	default "-mtune=801" if PPC_TUNE_801
> +	default "-mtune=821" if PPC_TUNE_821
> +	default "-mtune=823" if PPC_TUNE_823
> +	default "-mtune=860" if PPC_TUNE_860
> +	default "-mtune=403" if PPC_TUNE_403
> +	default "-mtune=405" if PPC_TUNE_405
> +	default "-mtune=440" if PPC_TUNE_440
> +	default "" if PPC_TUNE_E200
> +	default "" if PPC_TUNE_E500
> +
> +# these are temp to transition to new cpu selection
> +config POWER3
> +	bool
> +	depends on PPC_ENABLE_POWER3 || PPC_ENABLE_RS64
> +	default y
> +
> +config POWER4
> +	depends on PPC64
> +	def_bool y
> +
> +config POWER4_ONLY
> +	bool
> +	default y if !PPC_POWER3
> +
> +config 6xx
> +	bool
> +
> +# this is temp to handle compat with arch=ppc
> +config 8xx
> +	bool
> +
> +# this is temp to handle compat with arch=ppc
> +config 83xx
> +	bool
> +
> +# this is temp to handle compat with arch=ppc
> +config 85xx
> +	bool
> +
> +config E500
> +	bool
> +
> +config PPC_FPU
> +	bool
> +	default y if PPC64
> +
> +config PPC_DCR_NATIVE
> +	bool
> +	default n
> +
> +config PPC_DCR_MMIO
> +	bool
> +	default n
> +
> +config PPC_DCR
> +	bool
> +	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
> +	default y
> +
> +config PPC_OF_PLATFORM_PCI
> +	bool
> +	depends on PPC64 # not supported on 32 bits yet
> +	default n

Should this really be in here? I don't see how OF PCI has anything to  
do with CPU/core.

> +
> +config BOOKE
> +	bool
> +	depends on E200 || E500
> +	default y
> +
> +config FSL_BOOKE
> +	bool
> +	depends on E200 || E500
> +	default y
> +
> +config PTE_64BIT
> +	bool
> +	depends on 44x || E500
> +	default y if 44x
> +	default y if E500 && PHYS_64BIT
> +
> +config PHYS_64BIT
> +	bool 'Large physical address support' if E500
> +	depends on 44x || E500
> +	select RESOURCES_64BIT
> +	default y if 44x
> +	---help---
> +	  This option enables kernel support for larger than 32-bit physical
> +	  addresses.  This features is not be available on all e500 cores.
> +
> +	  If in doubt, say N here.
> +
> +config ALTIVEC
> +	bool "AltiVec Support"
> +	depends on PPC64 || PPC_CPU_ANY32 || CLASSIC32
> +	---help---
> +	  This option enables kernel support for the Altivec extensions  
> to the
> +	  PowerPC processor. The kernel currently supports saving and  
> restoring
> +	  altivec registers, and turning on the 'altivec enable' bit so user
> +	  processes can execute altivec instructions.
> +
> +	  This option is only usefully if you have a processor that supports
> +	  altivec (G4, otherwise known as 74xx series), but does not have
> +	  any affect on a non-altivec cpu (it does, however add code to the
> +	  kernel).
> +
> +	  If in doubt, say Y here.
> +
> +config SPE
> +	bool "SPE Support"
> +	depends on E200 || E500
> +	default y
> +	---help---
> +	  This option enables kernel support for the Signal Processing
> +	  Extensions (SPE) to the PowerPC processor. The kernel currently
> +	  supports saving and restoring SPE registers, and turning on the
> +	  'spe enable' bit so user processes can execute SPE instructions.
> +
> +	  This option is only useful if you have a processor that supports
> +	  SPE (e500, otherwise known as 85xx series), but does not have any
> +	  effect on a non-spe cpu (it does, however add code to the kernel).
> +
> +	  If in doubt, say Y here.
> +
> +config PPC_STD_MMU
> +	bool
> +	depends on 6xx || POWER3 || POWER4 || PPC64
> +	default y
> +
> +config PPC_STD_MMU_32
> +	def_bool y
> +	depends on PPC_STD_MMU && PPC32
> +
> +config PPC_MM_SLICES
> +	bool
> +	default y if HUGETLB_PAGE
> +	default n
> +
> +config VIRT_CPU_ACCOUNTING
> +	bool "Deterministic task and CPU time accounting"
> +	depends on PPC64
> +	default y
> +	help
> +	  Select this option to enable more accurate task and CPU time
> +	  accounting.  This is done by reading a CPU counter on each
> +	  kernel entry and exit and on transitions within the kernel
> +	  between system, softirq and hardirq state, so there is a
> +	  small performance impact.  This also enables accounting of
> +	  stolen time on logically-partitioned systems running on
> +	  IBM POWER5-based machines.
> +
> +	  If in doubt, say Y here.
> +
> +config SMP
> +	depends on PPC_STD_MMU
> +	bool "Symmetric multi-processing support"
> +	---help---
> +	  This enables support for systems with more than one CPU. If you  
> have
> +	  a system with only one CPU, say N. If you have a system with more
> +	  than one CPU, say Y.  Note that the kernel does not currently
> +	  support SMP machines with 603/603e/603ev or PPC750 ("G3")  
> processors
> +	  since they have inadequate hardware support for multiprocessor
> +	  operation.
> +
> +	  If you say N here, the kernel will run on single and  
> multiprocessor
> +	  machines, but will use only one CPU of a multiprocessor  
> machine. If
> +	  you say Y here, the kernel will run on single-processor machines.
> +	  On a single-processor machine, the kernel will run faster if  
> you say
> +	  N here.
> +
> +	  If you don't know what to do here, say N.
> +
> +config NR_CPUS
> +	int "Maximum number of CPUs (2-128)"
> +	range 2 128
> +	depends on SMP
> +	default "32" if PPC64
> +	default "4"
> +
> +config NOT_COHERENT_CACHE
> +	bool
> +	depends on 4xx || 8xx || E200
> +	default y
> +
> +endmenu

[snip]

  - k
