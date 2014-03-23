Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E54822C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Mar 2014 10:17:25 +1100 (EST)
Message-ID: <1395616617.3460.109.camel@pasglop>
Subject: Re: Pull request: scottwood/linux.git next
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 24 Mar 2014 10:16:57 +1100
In-Reply-To: <20140320042527.GA23206@home.buserror.net>
References: <20140320042527.GA23206@home.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-19 at 23:25 -0500, Scott Wood wrote:
> The following changes since commit c7e64b9ce04aa2e3fad7396d92b5cb92056d16ac:
> 
>   powerpc/powernv Platform dump interface (2014-03-07 16:19:10 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
> 
> for you to fetch changes up to 48b16180d0d91324e5d2423c6d53d97bbe3dcc14:
> 
>   fsl/pci: The new pci suspend/resume implementation (2014-03-19 22:37:44 -0500)

Stephen just informed me that your tree wasn't in -next ... Kumar's
still is.

Can you guys fix that up ? I somewhat rely on the FSL stuff to simmer
in -next on its own.

Cheers,
Ben.


> ----------------------------------------------------------------
> Luis Henriques (1):
>       powerpc/kconfig: Remove TSI108_BRIDGE duplicates
> 
> Minghuan Lian (1):
>       powerpc/pci: Fix IMMRBAR address
> 
> Prabhakar Kushwaha (1):
>       powerpc/config: Remove unnecssary CONFIG_FSL_IFC
> 
> Scott Wood (8):
>       powerpc/booke64: Fix exception numbers
>       powerpc/e6500: Make TLB lock recursive
>       powerpc/booke64: Use SPRG7 for VDSO
>       powerpc/booke64: Use SPRG_TLB_EXFRAME on bolted handlers
>       powerpc/booke64: Remove ints from EXCEPTION_COMMON
>       powerpc/booke64: Add crit/mc/debug support to EXCEPTION_COMMON
>       powerpc/booke64: Critical and machine check exception support
>       Revert "powerpc/watchdog: Don't enable interrupt on PPC64 BookE"
> 
> Sebastian Siewior (1):
>       powerpc: 85xx rdb: move np pointer to avoid builderror
> 
> Tang Yuantian (2):
>       powerpc/mpc85xx: Update clock nodes in device tree
>       powerpc: T4240: Add ina220 node in dts
> 
> Tiejun Chen (2):
>       powerpc/book3e: initialize crit/mc/dbg kernel stack pointers
>       powerpc/book3e: store crit/mc/dbg exception thread info
> 
> Wang Dongsheng (2):
>       powerpc/fsl: add PVR definition for E500MC and E5500
>       fsl/pci: The new pci suspend/resume implementation
> 
> Zhao Qiang (2):
>       QE: split function mpc85xx_qe_init() into two functions.
>       Corenet: Add QE platform support for Corenet
> 
> harninder rai (1):
>       powerpc/fsl: Add/update miscellaneous missing binding
> 
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |  23 ++
>  .../devicetree/bindings/powerpc/fsl/mem-ctrlr.txt  |  27 ++
>  Documentation/devicetree/bindings/usb/fsl-usb.txt  |   4 +-
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi        |  36 ++
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi        |  36 ++
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  60 +++
>  arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  61 +++
>  arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        | 113 ++++++
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |   8 +
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi        |  43 ++
>  arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   2 +
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  61 +++
>  arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   4 +
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  86 ++++
>  arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  12 +
>  arch/powerpc/boot/dts/t4240qds.dts                 |  42 ++
>  arch/powerpc/configs/corenet64_smp_defconfig       |   1 -
>  arch/powerpc/configs/mpc85xx_defconfig             |   1 -
>  arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 -
>  arch/powerpc/include/asm/exception-64e.h           |  15 +-
>  arch/powerpc/include/asm/kvm_booke_hv_asm.h        |  17 +-
>  arch/powerpc/include/asm/mmu-book3e.h              |   9 +-
>  arch/powerpc/include/asm/paca.h                    |   9 +-
>  arch/powerpc/include/asm/reg.h                     |  15 +-
>  arch/powerpc/kernel/asm-offsets.c                  |   2 +-
>  arch/powerpc/kernel/exceptions-64e.S               | 435 ++++++++++++++++-----
>  arch/powerpc/kernel/setup_64.c                     |  20 +-
>  arch/powerpc/kernel/vdso.c                         |   8 +-
>  arch/powerpc/kernel/vdso32/getcpu.S                |   2 +-
>  arch/powerpc/kernel/vdso64/getcpu.S                |   2 +-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   4 +-
>  arch/powerpc/kvm/book3s_interrupts.S               |   4 +-
>  arch/powerpc/kvm/bookehv_interrupts.S              |  21 +-
>  arch/powerpc/mm/tlb_low_64e.S                      |  63 +--
>  arch/powerpc/mm/tlb_nohash.c                       |  11 +
>  arch/powerpc/platforms/85xx/c293pcie.c             |   1 +
>  arch/powerpc/platforms/85xx/common.c               |   6 +
>  arch/powerpc/platforms/85xx/corenet_generic.c      |  17 +
>  arch/powerpc/platforms/85xx/ge_imp3a.c             |   1 +
>  arch/powerpc/platforms/85xx/mpc8536_ds.c           |   1 +
>  arch/powerpc/platforms/85xx/mpc85xx.h              |   2 +
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   1 +
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c           |   3 +
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c          |   4 +
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  16 +-
>  arch/powerpc/platforms/85xx/p1010rdb.c             |   1 +
>  arch/powerpc/platforms/85xx/p1022_ds.c             |   1 +
>  arch/powerpc/platforms/85xx/p1022_rdk.c            |   1 +
>  arch/powerpc/platforms/85xx/p1023_rds.c            |   2 +
>  arch/powerpc/platforms/85xx/qemu_e500.c            |   1 +
>  arch/powerpc/platforms/85xx/sbc8548.c              |   1 +
>  arch/powerpc/platforms/85xx/twr_p102x.c            |   1 +
>  arch/powerpc/platforms/85xx/xes_mpc85xx.c          |   3 +
>  arch/powerpc/platforms/embedded6xx/Kconfig         |   2 -
>  arch/powerpc/sysdev/fsl_pci.c                      | 178 +++++++--
>  arch/powerpc/sysdev/fsl_pci.h                      |   8 +
>  drivers/watchdog/booke_wdt.c                       |   8 -
>  61 files changed, 1312 insertions(+), 219 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
