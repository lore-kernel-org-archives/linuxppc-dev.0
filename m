Return-Path: <ppc@mindchasers.com>
Received: from resqmta-po-11v.sys.comcast.net (resqmta-po-11v.sys.comcast.net
 [IPv6:2001:558:fe16:19:96:114:154:170])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9EBBE1A012D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 14:01:22 +1000 (EST)
Message-ID: <5420EE93.7080006@mindchasers.com>
Date: Mon, 22 Sep 2014 23:52:51 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, benh@kernel.crashing.org
Subject: Re: Pull request: scottwood/linux.git next
References: <20140922222142.GA8525@home.buserror.net>
In-Reply-To: <20140922222142.GA8525@home.buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/22/2014 06:21 PM, Scott Wood wrote:
> Highlights include DMA32 zone support (SATA, USB, etc now works on 64-bit
> FSL kernels), MSI changes, 8xx optimizations and cleanup, t104x board
> support, and PrPMC PCI enumeration.
>
> The following changes since commit 78eb9094ca08a40b8f9d3e113a2b88e0b7dbad1d:
>
>    powerpc/t2080rdb: Add T2080RDB board support (2014-07-31 00:11:10 -0500)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>
> for you to fetch changes up to cb0446c1b625326682ec4f9d1dd10779433646bc:
>
>    Revert "powerpc/fsl_msi: spread msi ints across different MSIRs" (2014-09-19 15:20:42 -0500)
>
> ----------------------------------------------------------------
> Aaron Sierra (2):
>        fsl_ifc: Fix csor_ext position in fsl_ifc_regs
>        powerpc: fsl_pci: Add forced PCI Agent enumeration
>
> LEROY Christophe (7):
>        powerpc/8xx: Declare SPRG2 as a SCRATCH register
>        powerpc/8xx: Use SCRATCH0 and SCRATCH1 also for TLB handlers
>        powerpc/8xx: Remove loading of r10 at end of FixupDAR
>        powerpc/8xx: Fix comment about DIRTY update
>        powerpc/8xx: No need to save r10 and r3 when not calling FixupDAR
>        powerpc/8xx: Optimize verification in FixupDAR
>        powerpc/8xx: Duplicate two insns instead of branching
>
> Nikhil Badola (3):
>        powerpc: configs: Add VFAT file-system configs
>        powerpc: dts: t4240: Change T4240 USB controller version
>        powerpc: dts: t208x: Change T208x USB controller version
>
> Priyanka Jain (2):
>        powerpc/fsl-booke: Add initial T1040/T1042 RDB board support


Hi Scott,

I would like to try your next branch with my t1040rdb along with DPAA 
support / drivers.  I don't see DPAA support in your repo.  Can you 
point me to a DPAA patch set somewhere, or am I on my own to merge what 
I need from sdk or yocto?


Thanks,

Bob





>        powerpc/fsl-booke: Add initial T1042RDB_PI board support
>
> Scott Wood (7):
>        powerpc: Dynamic DMA zone limits
>        powerpc/64: Honor swiotlb limit in coherent allocations
>        powerpc/64: Limit ZONE_DMA32 to 4GiB in swiotlb_detect_4g()
>        powerpc/fsl-pci: Limit ZONE_DMA32 to 2GiB on 64-bit platforms
>        powerpc/85xx/defconfig: Remove duplicate CONFIG_RTC_DRV_DS1307
>        powerpc/mm: Use common paging_init() for NUMA
>        Revert "powerpc/fsl_msi: spread msi ints across different MSIRs"
>
> Tudor Laurentiu (6):
>        powerpc/fsl_msi: support vmpic msi with mpic 4.3
>        powerpc/fsl_msi: reorganize structs to improve clarity and flexibility
>        powerpc/fsl_msi: change the irq handler from chained to normal
>        powerpc/fsl_msi: show more meaningful names in /proc/interrupts
>        powerpc/fsl_msi: spread msi ints across different MSIRs
>        powerpc/fsl-booke64: add missing virtualization options in defconfig
>
>   Documentation/devicetree/bindings/pci/fsl,pci.txt |  27 ++++
>   arch/powerpc/Kconfig                              |   4 +
>   arch/powerpc/boot/dts/fsl/t2081si-post.dtsi       |   4 +-
>   arch/powerpc/boot/dts/fsl/t4240si-post.dtsi       |   4 +-
>   arch/powerpc/boot/dts/t1040rdb.dts                |  48 +++++++
>   arch/powerpc/boot/dts/t1042rdb.dts                |  48 +++++++
>   arch/powerpc/boot/dts/t1042rdb_pi.dts             |  57 ++++++++
>   arch/powerpc/boot/dts/t104xrdb.dtsi               | 156 ++++++++++++++++++++++
>   arch/powerpc/configs/corenet32_smp_defconfig      |   2 +
>   arch/powerpc/configs/corenet64_smp_defconfig      |  46 ++-----
>   arch/powerpc/configs/mpc85xx_defconfig            |   4 +-
>   arch/powerpc/configs/mpc85xx_smp_defconfig        |   4 +-
>   arch/powerpc/configs/mpc86xx_defconfig            |   3 +
>   arch/powerpc/include/asm/pgtable.h                |   3 +
>   arch/powerpc/include/asm/reg.h                    |   3 +-
>   arch/powerpc/kernel/dma-swiotlb.c                 |   8 +-
>   arch/powerpc/kernel/dma.c                         |  33 +++++
>   arch/powerpc/kernel/head_8xx.S                    | 150 ++++++++-------------
>   arch/powerpc/mm/mem.c                             |  68 +++++++++-
>   arch/powerpc/mm/numa.c                            |   8 --
>   arch/powerpc/platforms/85xx/Kconfig               |   2 +-
>   arch/powerpc/platforms/85xx/corenet_generic.c     |  14 ++
>   arch/powerpc/platforms/85xx/qemu_e500.c           |  10 ++
>   arch/powerpc/sysdev/fsl_msi.c                     |  95 ++++++-------
>   arch/powerpc/sysdev/fsl_msi.h                     |   4 +-
>   arch/powerpc/sysdev/fsl_pci.c                     |   3 +-
>   include/linux/fsl_ifc.h                           |   6 +-
>   27 files changed, 610 insertions(+), 204 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/fsl,pci.txt
>   create mode 100644 arch/powerpc/boot/dts/t1040rdb.dts
>   create mode 100644 arch/powerpc/boot/dts/t1042rdb.dts
>   create mode 100644 arch/powerpc/boot/dts/t1042rdb_pi.dts
>   create mode 100644 arch/powerpc/boot/dts/t104xrdb.dtsi
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
