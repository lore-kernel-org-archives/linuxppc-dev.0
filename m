Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17707.12331.371766.892813@cargo.ozlabs.ibm.com>
Date: Tue, 10 Oct 2006 15:31:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some PowerPC bugfixes, including a pile of pt_regs fixes for
ARCH=ppc from Al Viro, and a fix for a crash on resume on powerbooks
from Ben.

Thanks,
Paul.

 arch/powerpc/boot/Makefile            |   16 +--
 arch/powerpc/configs/maple_defconfig  |   56 ++++++++--
 arch/powerpc/platforms/maple/pci.c    |  187 ++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powermac/smp.c |    7 +
 arch/powerpc/xmon/xmon.c              |    6 +
 arch/ppc/4xx_io/serial_sicc.c         |    8 +
 arch/ppc/8260_io/enet.c               |    4 -
 arch/ppc/8260_io/fcc_enet.c           |    6 +
 arch/ppc/8xx_io/commproc.c            |   19 ++-
 arch/ppc/8xx_io/cs4218_tdm.c          |    4 -
 arch/ppc/8xx_io/enet.c                |    4 -
 arch/ppc/8xx_io/fec.c                 |    7 +
 arch/ppc/kernel/smp.c                 |    4 -
 arch/ppc/platforms/apus_setup.c       |    2 
 arch/ppc/platforms/hdpu.c             |   22 ++--
 arch/ppc/platforms/radstone_ppc7d.c   |   10 +-
 arch/ppc/platforms/sbc82xx.c          |    4 -
 arch/ppc/syslib/cpc700.h              |    2 
 arch/ppc/syslib/cpc700_pic.c          |    2 
 arch/ppc/syslib/cpm2_pic.c            |    2 
 arch/ppc/syslib/cpm2_pic.h            |    2 
 arch/ppc/syslib/gt64260_pic.c         |    9 +-
 arch/ppc/syslib/ibm440gx_common.c     |    2 
 arch/ppc/syslib/ipic.c                |    2 
 arch/ppc/syslib/m82xx_pci.c           |    4 -
 arch/ppc/syslib/m8xx_setup.c          |    2 
 arch/ppc/syslib/m8xx_wdt.c            |    4 -
 arch/ppc/syslib/mpc52xx_pic.c         |    2 
 arch/ppc/syslib/mv64360_pic.c         |   18 +--
 arch/ppc/syslib/open_pic2.c           |    2 
 arch/ppc/syslib/ppc403_pic.c          |    2 
 arch/ppc/syslib/ppc4xx_pic.c          |    8 +
 arch/ppc/syslib/ppc85xx_rio.c         |    9 +-
 arch/ppc/syslib/ppc8xx_pic.c          |    4 -
 arch/ppc/syslib/xilinx_pic.c          |    2 
 drivers/i2c/busses/i2c-powermac.c     |   28 +++--
 drivers/macintosh/windfarm_pm112.c    |   18 ++-
 drivers/macintosh/windfarm_pm81.c     |   24 ++--
 drivers/macintosh/windfarm_pm91.c     |   24 ++--
 include/asm-ppc/commproc.h            |    3 -
 include/asm-ppc/gt64260.h             |    2 
 include/asm-ppc/mpc52xx.h             |    2 
 include/asm-ppc/mv64x60.h             |    4 -
 43 files changed, 370 insertions(+), 179 deletions(-)

Al Viro:
      [POWERPC] ARCH=ppc pt_regs fixes

Benjamin Herrenschmidt:
      [POWERPC] Make U4 PCIe work on maple
      [POWERPC] Fix Maple secondary IDE interrupt
      [POWERPC] Update maple defconfig
      [POWERPC] Fix i2c-powermac platform device usage
      [POWERPC] Fix windfarm platform device usage

Geoff Levand:
      [POWERPC] cell: fix default zImage build target

Michael Ellerman:
      [POWERPC] Fix boot wrapper invocation if CROSS_COMPILE contains spaces

Paul Mackerras:
      [POWERPC] Fix xmon IRQ handler for pt_regs removal
      [POWERPC] Fix secondary CPU startup on old "powersurge" SMP powermacs
