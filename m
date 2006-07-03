Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17577.2014.880854.217553@cargo.ozlabs.ibm.com>
Date: Mon, 3 Jul 2006 22:04:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'master' branch
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

Please do a pull from the "master" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get Ben's patches moving powerpc over to genirq, and three other
minor changes.  The kernel/irq/chip.c change has been acked by Ingo
Molnar and Thomas Gleixner.

Thanks,
Paul.

Benjamin Herrenschmidt:
      [POWERPC] Fix various offb and BootX-related issues
      [POWERPC] Fix booting on Momentum "Apache" board (a Maple derivative)
      [POWERPC] Fix error handling in detecting legacy serial ports
      [POWERPC] Update the SWIM3 (powermac) floppy driver
      genirq: Allow fasteoi handler to retrigger disabled interrupts
      [POWERPC] Use the genirq framework
      [POWERPC] New device-tree interrupt parsing code
      [POWERPC] Copy i8259 code back to arch/ppc
      [POWERPC] Add new interrupt mapping core and change platforms to use it

Dave Jones:
      [POWERPC] fix implicit declaration on cell.

Jeremy Kerr:
      [POWERPC] change get_property to return void *

Paul Mackerras:
      [POWERPC] Add a default config for 32-bit CHRP machines

 arch/powerpc/configs/chrp32_defconfig        | 1378 ++++++++++++++++++++++++++
 arch/powerpc/kernel/btext.c                  |   20 
 arch/powerpc/kernel/ibmebus.c                |    9 
 arch/powerpc/kernel/irq.c                    |  659 ++++++++++--
 arch/powerpc/kernel/legacy_serial.c          |   57 +
 arch/powerpc/kernel/misc_64.S                |   10 
 arch/powerpc/kernel/pci_32.c                 |   37 +
 arch/powerpc/kernel/pci_64.c                 |   33 -
 arch/powerpc/kernel/prom.c                   |  454 ---------
 arch/powerpc/kernel/prom_init.c              |   20 
 arch/powerpc/kernel/prom_parse.c             |  443 ++++++++
 arch/powerpc/kernel/rtas_pci.c               |   17 
 arch/powerpc/kernel/setup_32.c               |    2 
 arch/powerpc/kernel/setup_64.c               |   17 
 arch/powerpc/kernel/vio.c                    |   12 
 arch/powerpc/platforms/cell/interrupt.c      |  419 ++++----
 arch/powerpc/platforms/cell/interrupt.h      |   19 
 arch/powerpc/platforms/cell/setup.c          |   22 
 arch/powerpc/platforms/cell/spider-pic.c     |  394 +++++--
 arch/powerpc/platforms/cell/spu_base.c       |  119 +-
 arch/powerpc/platforms/chrp/pci.c            |   11 
 arch/powerpc/platforms/chrp/setup.c          |  101 +-
 arch/powerpc/platforms/chrp/smp.c            |    1 
 arch/powerpc/platforms/iseries/irq.c         |  105 +-
 arch/powerpc/platforms/iseries/irq.h         |    2 
 arch/powerpc/platforms/iseries/setup.c       |    8 
 arch/powerpc/platforms/maple/pci.c           |   17 
 arch/powerpc/platforms/maple/setup.c         |   94 +-
 arch/powerpc/platforms/powermac/bootx_init.c |   33 +
 arch/powerpc/platforms/powermac/low_i2c.c    |    9 
 arch/powerpc/platforms/powermac/nvram.c      |    5 
 arch/powerpc/platforms/powermac/pci.c        |   68 +
 arch/powerpc/platforms/powermac/pfunc_base.c |   13 
 arch/powerpc/platforms/powermac/pic.c        |  422 ++++----
 arch/powerpc/platforms/powermac/pmac.h       |    2 
 arch/powerpc/platforms/powermac/setup.c      |    3 
 arch/powerpc/platforms/pseries/ras.c         |   82 +-
 arch/powerpc/platforms/pseries/setup.c       |  244 +++--
 arch/powerpc/platforms/pseries/smp.c         |   32 -
 arch/powerpc/platforms/pseries/xics.c        |  718 ++++++++------
 arch/powerpc/platforms/pseries/xics.h        |   17 
 arch/powerpc/sysdev/Makefile                 |    5 
 arch/powerpc/sysdev/i8259.c                  |  163 ++-
 arch/powerpc/sysdev/mpic.c                   |  482 ++++++---
 arch/ppc/syslib/Makefile                     |    2 
 drivers/block/swim3.c                        |  230 ++--
 drivers/char/hvsi.c                          |    7 
 drivers/macintosh/macio-adb.c                |   19 
 drivers/macintosh/macio_asic.c               |  152 ++-
 drivers/macintosh/smu.c                      |    6 
 drivers/macintosh/via-cuda.c                 |   24 
 drivers/macintosh/via-pmu.c                  |   33 -
 drivers/net/mace.c                           |    4 
 drivers/serial/pmac_zilog.c                  |    6 
 drivers/video/offb.c                         |  284 ++---
 include/asm-powerpc/i8259.h                  |    8 
 include/asm-powerpc/irq.h                    |  358 ++++++-
 include/asm-powerpc/machdep.h                |    2 
 include/asm-powerpc/mpic.h                   |   67 +
 include/asm-powerpc/prom.h                   |   98 ++
 include/asm-powerpc/spu.h                    |    1 
 kernel/irq/chip.c                            |    5 
 sound/aoa/core/snd-aoa-gpio-feature.c        |    7 
 sound/aoa/soundbus/i2sbus/i2sbus-core.c      |    7 
 sound/oss/dmasound/dmasound_awacs.c          |   16 
 sound/ppc/pmac.c                             |   33 -
 sound/ppc/tumbler.c                          |    8 
 67 files changed, 5412 insertions(+), 2743 deletions(-)
 create mode 100644 arch/powerpc/configs/chrp32_defconfig
