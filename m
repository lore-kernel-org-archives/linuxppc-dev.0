Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17697.988.150534.503958@cargo.ozlabs.ibm.com>
Date: Mon, 2 Oct 2006 22:19:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'master' branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get some more PowerPC updates.

There are a few more things I'd like to get in 2.6.19-rc1 if the
authors can get their patches ready in the next day or so - some
embedded stuff from Leo Li, some patches to allow us to build a single
64-bit kernel that boots on everything including legacy iSeries from
Stephen Rothwell, and a lazy IRQ disable patch from me.

Thanks,
Paul.

 arch/powerpc/Makefile                       |    6 
 arch/powerpc/boot/Makefile                  |  224 +++----
 arch/powerpc/boot/dts/mpc8560ads.dts        |  302 ++++++++++
 arch/powerpc/boot/wrapper                   |  204 ++++++
 arch/powerpc/boot/zImage.coff.lds.S         |    0 
 arch/powerpc/boot/zImage.lds.S              |    0 
 arch/powerpc/configs/chrp32_defconfig       |    2 
 arch/powerpc/configs/g5_defconfig           |   28 -
 arch/powerpc/configs/iseries_defconfig      |    2 
 arch/powerpc/configs/mpc7448_hpc2_defconfig |   28 -
 arch/powerpc/configs/mpc834x_itx_defconfig  |   53 +-
 arch/powerpc/configs/mpc8560_ads_defconfig  |  854 +++++++++++++++++++++++++++
 arch/powerpc/configs/pmac32_defconfig       |    4 
 arch/powerpc/configs/ppc64_defconfig        |   28 -
 arch/powerpc/configs/pseries_defconfig      |    2 
 arch/powerpc/kernel/irq.c                   |   19 -
 arch/powerpc/kernel/ptrace.c                |   13 
 arch/powerpc/kernel/sysfs.c                 |    4 
 arch/powerpc/kernel/time.c                  |   42 +
 arch/powerpc/lib/Makefile                   |    6 
 arch/powerpc/lib/rheap.c                    |   24 +
 arch/powerpc/math-emu/Makefile              |    3 
 arch/powerpc/oprofile/backtrace.c           |   11 
 arch/powerpc/platforms/83xx/mpc834x_itx.c   |    4 
 arch/powerpc/platforms/85xx/Kconfig         |   21 +
 arch/powerpc/platforms/85xx/Makefile        |    1 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c   |  120 ++++
 arch/powerpc/platforms/85xx/mpc85xx_ads.h   |   61 ++
 arch/powerpc/platforms/cell/spu_base.c      |    4 
 arch/powerpc/platforms/cell/spufs/file.c    |    2 
 arch/powerpc/platforms/cell/spufs/hw_ops.c  |    4 
 arch/powerpc/platforms/maple/pci.c          |   60 +-
 arch/powerpc/platforms/pseries/eeh.c        |    7 
 arch/powerpc/platforms/pseries/setup.c      |   24 -
 arch/powerpc/sysdev/Makefile                |    5 
 arch/powerpc/sysdev/cpm2_common.c           |  309 ++++++++++
 arch/powerpc/sysdev/cpm2_pic.c              |  256 ++++++++
 arch/powerpc/sysdev/cpm2_pic.h              |   10 
 arch/powerpc/sysdev/fsl_soc.c               |  281 +++++++++
 arch/powerpc/sysdev/fsl_soc.h               |    2 
 arch/ppc/boot/utils/mkbugboot.c             |  208 +++----
 arch/ppc/boot/utils/mkprep.c                |  416 ++++++-------
 arch/ppc/platforms/mpc8272ads_setup.c       |    8 
 arch/ppc/platforms/mpc866ads_setup.c        |    8 
 arch/ppc/platforms/mpc885ads_setup.c        |   10 
 drivers/char/hvc_iseries.c                  |    7 
 drivers/macintosh/via-pmu.c                 |    7 
 drivers/net/fs_enet/fs_enet-main.c          |    5 
 drivers/pnp/isapnp/core.c                   |    4 
 drivers/serial/8250.c                       |    4 
 drivers/serial/cpm_uart/cpm_uart_core.c     |   24 -
 drivers/serial/cpm_uart/cpm_uart_cpm2.c     |  143 +++--
 drivers/serial/cpm_uart/cpm_uart_cpm2.h     |    2 
 include/asm-powerpc/fs_pd.h                 |   45 +
 include/asm-powerpc/mpc85xx.h               |   53 ++
 include/asm-powerpc/time.h                  |    6 
 include/asm-ppc/cpm2.h                      |   63 ++
 include/asm-ppc/fs_pd.h                     |   36 +
 include/asm-ppc/rheap.h                     |    4 
 include/linux/fs_enet_pd.h                  |   47 +
 include/linux/fs_uart_pd.h                  |   14 
 61 files changed, 3395 insertions(+), 749 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8560ads.dts
 create mode 100755 arch/powerpc/boot/wrapper
 rename arch/powerpc/boot/{zImage.coff.lds => zImage.coff.lds.S} (100%)
 rename arch/powerpc/boot/{zImage.lds => zImage.lds.S} (100%)
 create mode 100644 arch/powerpc/configs/mpc8560_ads_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_ads.h
 create mode 100644 arch/powerpc/sysdev/cpm2_common.c
 create mode 100644 arch/powerpc/sysdev/cpm2_pic.c
 create mode 100644 arch/powerpc/sysdev/cpm2_pic.h
 create mode 100644 include/asm-powerpc/fs_pd.h
 create mode 100644 include/asm-powerpc/mpc85xx.h
 create mode 100644 include/asm-ppc/fs_pd.h

Al Viro:
      [POWERPC] ppc math-emu needs -fno-builtin-fabs for math.c and fabs.c
      [POWERPC] NULL noise removal: spufs
      [POWERPC] cell spufs iomem annotations
      [POWERPC] powerpc oprofile __user annotations
      [POWERPC] maple/pci iomem annotations
      [POWERPC] rewrite mkprep and mkbugboot in sane C
      [POWERPC] UPIO_TSI cleanup

Anton Blanchard:
      [POWERPC] Always call cede in pseries dedicated idle loop

David Woodhouse:
      [POWERPC] Fix audit syscall success/failure reporting on PowerPC
      [POWERPC] Fix PPC32 SECCOMP, unexport do_syscall_trace_{enter,leave}
      [POWERPC] Use check_legacy_ioport() for ISAPnP

Kim Phillips:
      [POWERPC] update mpc8349_itx_defconfig and remove some debug settings
      [POWERPC] Add powerpc get/set_rtc_time interface to new generic rtc class
      [POWERPC] Enable generic rtc hook for the MPC8349 mITX

Li Yang:
      [POWERPC] Fix rheap alignment problem

Linas Vepstas:
      [POWERPC] EEH failure to mark pci slot as frozen.

Michael Ellerman:
      [POWERPC] Fix loop logic in irq_alloc_virt()

Olaf Hering:
      [POWERPC] enable sysrq in pmac32_defconfig
      [POWERPC] update powerpc defconfig files after libata kconfig breakage
      [POWERPC] Avoid NULL pointer in gpio1_interrupt

Paul Mackerras:
      [POWERPC] Create a "wrapper" script and use it in arch/powerpc/boot

Stephen Rothwell:
      [POWERPC] fix spin lock nesting in hvc_iseries

Vitaly Bordug:
      POWERPC: Add cpm2 stuff support to the fsl_soc.c
      cpm_uart: make it possible to utilize from powerpc
      POWERPC: Move generic cpm2 stuff to powerpc
      POWERPC: Add support for the mpc8560 eval board
      POWERPC: Get rid of remapping the whole immr
      POWERPC: overhaul with cpm2_map mechanism
      POWERPC: Bring the fs_no calculation to the relevant SoC enumeration
