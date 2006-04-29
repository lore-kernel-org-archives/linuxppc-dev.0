Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 16:15:10 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get the following powerpc updates.  They are mostly bug-fixes;
there is also a defconfig update for Cell, plus a couple of commits
that will enable the kernel to run on forthcoming IBM machines.
These don't affect anything on the current machines, since the
firmware properties and methods they use aren't present.

Thanks,
Paul.

Alan Modra:
      powerpc64: Fix loading of modules without a .toc section

Andreas Schwab:
      sound/ppc: snd_pmac_toonie_init should be __init
      powerpc: Wire up *at syscalls

Anton Blanchard:
      powerpc: Add cputable entry for POWER6

Arnd Bergmann:
      spufs: Disable local interrupts for SPE hash_page calls.
      powerpc: update cell_defconfig

David Gibson:
      powerpc: Fix pagetable bloat for hugepages

David Woodhouse:
      powerpc: Use check_legacy_ioport() on ppc32 too.

Eugene Surovegin:
      ppc32: add 440GX erratum 440_43 workaround

Paul Mackerras:
      powerpc/pseries: Tell firmware our capabilities on new machines

Vitaly Bordug:
      ppc32: odd fixes and improvements in ppc_sys
      ppc32 CPM_UART: Convert to use platform devices
      ppc32: Update board-specific code of the CPM UART users
      ppc32 CPM_UART: Fixed odd address translations

 arch/powerpc/configs/cell_defconfig         |   40 ++--
 arch/powerpc/kernel/cputable.c              |   16 +
 arch/powerpc/kernel/module_64.c             |   16 +
 arch/powerpc/kernel/prom_init.c             |  112 ++++++++++
 arch/powerpc/kernel/setup-common.c          |    8 +
 arch/powerpc/kernel/setup_64.c              |    8 -
 arch/powerpc/kernel/systbl.S                |   13 +
 arch/powerpc/mm/hugetlbpage.c               |  295 ++++++++++++++++++++++++---
 arch/powerpc/mm/init_64.c                   |    7 +
 arch/powerpc/platforms/cell/spu_base.c      |   10 +
 arch/powerpc/platforms/cell/spu_callbacks.c |   13 +
 arch/ppc/platforms/4xx/ocotea.c             |    2 
 arch/ppc/platforms/mpc8272ads_setup.c       |  114 ++++++++++
 arch/ppc/platforms/mpc866ads_setup.c        |  140 +++++++++++++
 arch/ppc/platforms/mpc885ads_setup.c        |  131 ++++++++++++
 arch/ppc/platforms/pq2ads.c                 |   31 +++
 arch/ppc/syslib/ibm440gx_common.c           |   13 +
 arch/ppc/syslib/ibm440gx_common.h           |    4 
 arch/ppc/syslib/mpc8xx_devices.c            |   25 ++
 arch/ppc/syslib/ppc_sys.c                   |    4 
 arch/ppc/syslib/pq2_sys.c                   |    8 -
 drivers/block/floppy.c                      |    2 
 drivers/input/serio/i8042-io.h              |    4 
 drivers/serial/cpm_uart/cpm_uart.h          |   49 ++++
 drivers/serial/cpm_uart/cpm_uart_core.c     |  280 ++++++++++++++++++++------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c     |   54 -----
 drivers/serial/cpm_uart/cpm_uart_cpm2.c     |   14 -
 fs/stat.c                                   |    2 
 include/asm-powerpc/cputable.h              |   14 +
 include/asm-powerpc/io.h                    |    6 -
 include/asm-powerpc/page_64.h               |    1 
 include/asm-powerpc/pgalloc.h               |    2 
 include/asm-powerpc/unistd.h                |   20 ++
 include/asm-ppc/ppc_sys.h                   |    2 
 include/asm-ppc/reg_booke.h                 |    1 
 sound/ppc/toonie.c                          |    2 
 36 files changed, 1234 insertions(+), 229 deletions(-)
