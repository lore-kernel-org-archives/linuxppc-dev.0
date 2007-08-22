Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
Date: Wed, 22 Aug 2007 19:47:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git for-2.6.24 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer (10):
      [POWERPC] Rename 4xx paths to 40x
      [POWERPC] 4xx Kconfig cleanup
      [POWERPC] Rename 44x bootwrapper
      [POWERPC] 4xx bootwrapper reworks
      [POWERPC] 40x MMU
      [POWERPC] 40x decrementer fixes
      [POWERPC] Fix 40x build
      [POWERPC] Bamboo DTS
      [POWERPC] Bamboo board support
      [POWERPC] Bamboo zImage wrapper

Olaf Hering (1):
      [POWERPC] Advertise correct IDE mode on Pegasos2

Olof Johansson (1):
      [POWERPC] Rework SMP timebase handoff for pasemi

Scott Wood (15):
      [POWERPC] Whitespace cleanup in arch/powerpc
      [POWERPC] Add clrbits8 and setbits8
      [POWERPC] Use strcasecmp() rather than strncasecmp() when determining device node compatibility
      [POWERPC] bootwrapper: Update .gitignore
      [POWERPC] bootwrapper: Set timebase_period_ns from dt_fixup_cpu_clocks
      [POWERPC] bootwrapper: dt_xlate_range() bugfixes
      [POWERPC] bootwrapper: Add dt_is_compatible()
      [POWERPC] bootwrapper: Add 16-bit I/O, sync(), eieio(), and barrier()
      [POWERPC] bootwrapper: Add TARGET_HAS_ETHn tests to ppcboot.h
      [POWERPC] bootwrapper: serial_console_init() fixes
      [POWERPC] bootwrapper: Declare udelay() in ops.h
      [POWERPC] bootwrapper: Add CPM serial driver
      [POWERPC] bootwrapper: Move linker symbols into ops.h
      [POWERPC] bootwrapper: Add 8xx cuboot support
      [POWERPC] bootwrapper: Add PowerQUICC II (82xx with CPM) cuboot support

Stephen Rothwell (6):
      [POWERPC] iSeries: Clean up lparmap mess
      [POWERPC] Move iSeries startup code out of head_64.S
      [POWERPC] Move the exception macros into a header file
      [POWERPC] Move the iSeries exception vectors
      [POWERPC] Split out iSeries specific exception macros
      [POWERPC] Exception numbers are not relevant to iSeries

 arch/powerpc/Makefile                      |    2 
 arch/powerpc/boot/.gitignore               |    8 
 arch/powerpc/boot/44x.c                    |   85 ---
 arch/powerpc/boot/44x.h                    |    5 
 arch/powerpc/boot/4xx.c                    |  192 +++++++
 arch/powerpc/boot/4xx.h                    |   21 +
 arch/powerpc/boot/Makefile                 |   10 
 arch/powerpc/boot/bamboo.c                 |   45 ++
 arch/powerpc/boot/cpm-serial.c             |  249 +++++++++
 arch/powerpc/boot/cuboot-83xx.c            |    1 
 arch/powerpc/boot/cuboot-85xx.c            |    1 
 arch/powerpc/boot/cuboot-8xx.c             |   45 ++
 arch/powerpc/boot/cuboot-pq2.c             |  283 ++++++++++
 arch/powerpc/boot/cuboot.c                 |    3 
 arch/powerpc/boot/dcr.h                    |   13 
 arch/powerpc/boot/devtree.c                |   70 ++-
 arch/powerpc/boot/dts/bamboo.dts           |  244 +++++++++
 arch/powerpc/boot/dts/mpc8272ads.dts       |  376 +++++++-------
 arch/powerpc/boot/ebony.c                  |    6 
 arch/powerpc/boot/holly.c                  |    5 
 arch/powerpc/boot/io.h                     |   49 ++
 arch/powerpc/boot/main.c                   |   10 
 arch/powerpc/boot/mpsc.c                   |    1 
 arch/powerpc/boot/mv64x60_i2c.c            |    2 
 arch/powerpc/boot/of.c                     |    2 
 arch/powerpc/boot/ops.h                    |   24 +
 arch/powerpc/boot/ppcboot.h                |    7 
 arch/powerpc/boot/prpmc2800.c              |    6 
 arch/powerpc/boot/ps3.c                    |    4 
 arch/powerpc/boot/serial.c                 |   19 -
 arch/powerpc/boot/treeboot-bamboo.c        |   27 +
 arch/powerpc/boot/treeboot-ebony.c         |    2 
 arch/powerpc/configs/bamboo_defconfig      |  775 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile               |    9 
 arch/powerpc/kernel/asm-offsets.c          |    8 
 arch/powerpc/kernel/head_40x.S             |    3 
 arch/powerpc/kernel/head_64.S              |  585 +--------------------
 arch/powerpc/kernel/irq.c                  |    4 
 arch/powerpc/kernel/lparmap.c              |   32 -
 arch/powerpc/kernel/ppc_ksyms.c            |    2 
 arch/powerpc/kernel/prom_init.c            |   11 
 arch/powerpc/kernel/time.c                 |    2 
 arch/powerpc/mm/40x_mmu.c                  |    4 
 arch/powerpc/mm/Makefile                   |    2 
 arch/powerpc/platforms/40x/Kconfig         |   77 ---
 arch/powerpc/platforms/40x/Makefile        |    0 
 arch/powerpc/platforms/44x/Kconfig         |   15 -
 arch/powerpc/platforms/44x/Makefile        |    1 
 arch/powerpc/platforms/44x/bamboo.c        |   66 ++
 arch/powerpc/platforms/8xx/m8xx_setup.c    |   72 +--
 arch/powerpc/platforms/Kconfig             |    1 
 arch/powerpc/platforms/Kconfig.cputype     |    2 
 arch/powerpc/platforms/chrp/pci.c          |   29 +
 arch/powerpc/platforms/iseries/Makefile    |    1 
 arch/powerpc/platforms/iseries/exception.S |  251 +++++++++
 arch/powerpc/platforms/iseries/exception.h |   58 ++
 arch/powerpc/platforms/pasemi/setup.c      |   24 +
 arch/powerpc/sysdev/commproc.c             |   20 -
 arch/powerpc/sysdev/cpm2_common.c          |    2 
 include/asm-powerpc/exception.h            |  309 +++++++++++
 include/asm-powerpc/io.h                   |    3 
 include/asm-powerpc/iseries/lpar_map.h     |    3 
 include/asm-powerpc/mmu-40x.h              |   65 ++
 include/asm-powerpc/mmu.h                  |    3 
 include/asm-powerpc/page_64.h              |    2 
 include/asm-powerpc/ppc_asm.h              |   14 +
 include/asm-powerpc/prom.h                 |    2 
 include/asm-powerpc/time.h                 |    2 
 68 files changed, 3158 insertions(+), 1118 deletions(-)
 delete mode 100644 arch/powerpc/boot/44x.c
 create mode 100644 arch/powerpc/boot/4xx.c
 create mode 100644 arch/powerpc/boot/4xx.h
 create mode 100644 arch/powerpc/boot/bamboo.c
 create mode 100644 arch/powerpc/boot/cpm-serial.c
 create mode 100644 arch/powerpc/boot/cuboot-8xx.c
 create mode 100644 arch/powerpc/boot/cuboot-pq2.c
 create mode 100644 arch/powerpc/boot/dts/bamboo.dts
 create mode 100644 arch/powerpc/boot/treeboot-bamboo.c
 create mode 100644 arch/powerpc/configs/bamboo_defconfig
 rename arch/powerpc/kernel/{head_4xx.S => head_40x.S} (99%)
 delete mode 100644 arch/powerpc/kernel/lparmap.c
 rename arch/powerpc/mm/{4xx_mmu.c => 40x_mmu.c} (96%)
 rename arch/powerpc/platforms/{4xx/Kconfig => 40x/Kconfig} (68%)
 rename arch/powerpc/platforms/{4xx/Makefile => 40x/Makefile} (100%)
 create mode 100644 arch/powerpc/platforms/44x/bamboo.c
 create mode 100644 arch/powerpc/platforms/iseries/exception.S
 create mode 100644 arch/powerpc/platforms/iseries/exception.h
 create mode 100644 include/asm-powerpc/exception.h
 create mode 100644 include/asm-powerpc/mmu-40x.h
