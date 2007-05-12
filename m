Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17989.11576.260025.36853@cargo.ozlabs.ibm.com>
Date: Sat, 12 May 2007 12:58:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git master branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

to get a powerpc update.  This includes a set of patches from Mark
Greer and Dale Farnsworth to port the PrPMC2800 support over to
arch/powerpc plus a few other small fixes for various bugs and
warnings.

Thanks,
Paul.

 arch/powerpc/Kconfig                           |    5 
 arch/powerpc/Makefile                          |    2 
 arch/powerpc/boot/Makefile                     |   30 
 arch/powerpc/boot/cuboot-83xx.c                |    2 
 arch/powerpc/boot/cuboot-85xx.c                |    2 
 arch/powerpc/boot/dts/prpmc2800.dts            |  315 +++++
 arch/powerpc/boot/mpsc.c                       |  170 +++
 arch/powerpc/boot/mv64x60.c                    |  581 ++++++++++
 arch/powerpc/boot/mv64x60.h                    |   70 +
 arch/powerpc/boot/mv64x60_i2c.c                |  206 +++
 arch/powerpc/boot/ops.h                        |    1 
 arch/powerpc/boot/prpmc2800.c                  |  577 ++++++++++
 arch/powerpc/boot/serial.c                     |    2 
 arch/powerpc/configs/prpmc2800_defconfig       | 1442 ++++++++++++++++++++++++
 arch/powerpc/configs/ps3_defconfig             |  167 +--
 arch/powerpc/kernel/prom_parse.c               |    2 
 arch/powerpc/kernel/setup-common.c             |   41 +
 arch/powerpc/kernel/time.c                     |   19 
 arch/powerpc/mm/hash_native_64.c               |    4 
 arch/powerpc/platforms/embedded6xx/Kconfig     |   13 
 arch/powerpc/platforms/embedded6xx/Makefile    |    1 
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |  171 +++
 arch/powerpc/platforms/pasemi/idle.c           |    1 
 arch/powerpc/platforms/ps3/setup.c             |    2 
 arch/powerpc/platforms/ps3/smp.c               |    6 
 arch/powerpc/platforms/ps3/system-bus.c        |    6 
 arch/powerpc/sysdev/Makefile                   |    2 
 arch/powerpc/sysdev/mv64x60.h                  |   11 
 arch/powerpc/sysdev/mv64x60_dev.c              |  422 +++++++
 arch/powerpc/sysdev/mv64x60_pci.c              |  172 +++
 arch/powerpc/sysdev/mv64x60_pic.c              |  305 +++++
 arch/ppc/4xx_io/serial_sicc.c                  |   10 
 arch/ppc/8xx_io/commproc.c                     |    2 
 arch/ppc/8xx_io/fec.c                          |    2 
 arch/ppc/boot/lib/vreset.c                     |    2 
 arch/ppc/boot/simple/m8xx_tty.c                |    2 
 arch/ppc/boot/simple/misc-embedded.c           |    2 
 arch/ppc/boot/simple/mpc52xx_tty.c             |    2 
 arch/ppc/boot/simple/mv64x60_tty.c             |    2 
 arch/ppc/boot/simple/rw4/stb.h                 |    2 
 arch/ppc/kernel/traps.c                        |    4 
 arch/ppc/mm/init.c                             |    2 
 arch/ppc/platforms/4xx/bubinga.c               |    2 
 arch/ppc/platforms/4xx/ep405.c                 |    2 
 arch/ppc/platforms/4xx/ibmnp405h.h             |    2 
 arch/ppc/platforms/4xx/sycamore.c              |    2 
 arch/ppc/platforms/4xx/walnut.c                |    2 
 arch/ppc/platforms/ev64360.c                   |    2 
 arch/ppc/platforms/hdpu.c                      |    2 
 arch/ppc/platforms/katana.c                    |    2 
 arch/ppc/platforms/mbx.h                       |    2 
 arch/ppc/platforms/mvme5100.h                  |    2 
 arch/ppc/platforms/pplus.h                     |    2 
 arch/ppc/platforms/prep_pci.c                  |   22 
 arch/ppc/platforms/prep_setup.c                |    6 
 arch/ppc/platforms/prpmc750.h                  |    2 
 arch/ppc/platforms/radstone_ppc7d.c            |    2 
 arch/ppc/platforms/sandpoint.c                 |    8 
 arch/ppc/syslib/harrier.c                      |    2 
 arch/ppc/syslib/hawk_common.c                  |    4 
 arch/ppc/syslib/m82xx_pci.c                    |    2 
 arch/ppc/syslib/mpc10x_common.c                |    4 
 arch/ppc/syslib/mpc52xx_setup.c                |    2 
 arch/ppc/syslib/mpc8xx_devices.c               |    2 
 arch/ppc/syslib/mv64x60.c                      |   10 
 arch/ppc/syslib/ocp.c                          |    2 
 arch/ppc/syslib/ppc403_pic.c                   |    2 
 arch/ppc/syslib/ppc405_pci.c                   |    2 
 arch/ppc/syslib/ppc4xx_dma.c                   |    2 
 arch/ppc/syslib/ppc85xx_rio.c                  |    4 
 arch/ppc/syslib/xilinx_pic.c                   |    2 
 drivers/net/Kconfig                            |    2 
 72 files changed, 4682 insertions(+), 204 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/prpmc2800.dts
 create mode 100644 arch/powerpc/boot/mpsc.c
 create mode 100644 arch/powerpc/boot/mv64x60.c
 create mode 100644 arch/powerpc/boot/mv64x60.h
 create mode 100644 arch/powerpc/boot/mv64x60_i2c.c
 create mode 100644 arch/powerpc/boot/prpmc2800.c
 create mode 100644 arch/powerpc/configs/prpmc2800_defconfig
 create mode 100644 arch/powerpc/platforms/embedded6xx/prpmc2800.c
 create mode 100644 arch/powerpc/sysdev/mv64x60.h
 create mode 100644 arch/powerpc/sysdev/mv64x60_dev.c
 create mode 100644 arch/powerpc/sysdev/mv64x60_pci.c
 create mode 100644 arch/powerpc/sysdev/mv64x60_pic.c

Dale Farnsworth (7):
      [POWERPC] Add interrupt support for Marvell mv64x60 chips
      [POWERPC] Create Marvell mv64x60 MPSC (serial) platform_data
      [POWERPC] Create Marvell mv64x60 ethernet platform_data
      [POWERPC] Create Marvell mv64x60 I2C platform_data
      [POWERPC] Add Marvell mv64x60 PCI bridge support
      [POWERPC] Check cache coherency of kernel vs firmware
      [POWERPC] Add arch/powerpc support for the Motorola PrPMC2800

Geoff Levand (2):
      [POWERPC] PS3: Fix request_irq warning
      [POWERPC] PS3: Update ps3_defconfig

Kim Phillips (1):
      [POWERPC] Don't complain if size-cells == 0 in prom_parse()

Mark A. Greer (6):
      [POWERPC] Add Makefile rules to wrap dts file in zImage
      [POWERPC] Add bootwrapper support for Marvell/mv64x60 hostbridge
      [POWERPC] Add bootwrapper support for Marvell MPSC
      [POWERPC] Add bootwrapper support for Marvell/mv64x60 I2C
      [POWERPC] Add DTS file for the Motorola PrPMC2800 platform
      [POWERPC] Add bootwrapper support for Motorola PrPMC2800 platform

Scott Wood (1):
      [POWERPC] U-boot passes the initrd as start/end, not start/size.

Simon Arlott (1):
      [POWERPC] Spelling fixes: arch/ppc/

Stephen Rothwell (4):
      [POWERPC] Assign correct variable in hpte_decode()
      [POWERPC] Remove unused variable in hpte_decode()
      [POWERPC] Add missed include
      [POWERPC] Trivial ps3 warning fixes

will schmidt (1):
      [POWERPC] Simplify smp_space_timers
