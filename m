Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: please pull the cell-merge branch of cell-2.6.git
Date: Wed, 22 Nov 2006 23:49:07 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611222349.08057.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've taken the patches left over from the previous series, as well as
those from Geoff and Michael and pushed them to cell-2.6.git.

The changes relative to the submission are:
- fix build problem in SPU core dump patch
- use the version from benh for the power_save fix,
  this was verified to work in systemsim by Hubertus Franke
- include a fix from benh in 'abstract spu management routines',
  as already commented.

*shortlog

Arnd Bergmann <arnd@arndb.de>
  cell: update defconfig for ps3 support

Geoff Levand <geoffrey.levand@am.sony.com>
  powerpc: add ps3 platform defconfig
  powerpc: add ps3 platform system bus support
  powerpc: add ps3 platform spu support
  powerpc: add ps3 platform OS params support
  powerpc: add ps3 platform lpar addressing
  powerpc: add ps3 platform interrupt support
  powerpc: add ps3 platform repository support
  powerpc: add ps3 platform htab routines
  powerpc: add ps3 platform feature bits
  powerpc: add ps3 platform hvcalls
  powerpc: add support for ps3 platform
  powerpc: abstract spu management routines
  powerpc: add virq_to_hw accessor routine

Michael Ellerman <michael@ellerman.id.au>
  cell: spu management xmon routines
  Import updated version of ppc disassembly code for xmon
  Make 64-bit cpu features defined on 32-bit
  Make xmon disassembly optional
  Add spu disassembly to xmon
  Import spu disassembly code into xmon
  Prepare for spu disassembly in xmon
  Add a sd command (spu dump) to xmon to dump spu local
  Show state of spus as theyre stopped in Cell xmon helper
  Fix sparse warning in xmon Cell code

Benjamin Herrenschmidt <benh@kernel.crashing.org>
  cell: hard disable interrupts in power_save()

Dwayne Grant McConnell <decimal@us.ibm.com>
  coredump: Add SPU elf notes to coredump.

* diffstat
 MAINTAINERS                                  |    7
 arch/powerpc/Kconfig                         |   11
 arch/powerpc/Kconfig.debug                   |    9
 arch/powerpc/configs/cell_defconfig          |   31
 arch/powerpc/configs/ps3_defconfig           |  837 ++++++++++++++++++++++++++
 arch/powerpc/platforms/Makefile              |    1
 arch/powerpc/platforms/cell/Makefile         |    1
 arch/powerpc/platforms/cell/cbe_thermal.c    |    5
 arch/powerpc/platforms/cell/pervasive.c      |    9
 arch/powerpc/platforms/cell/setup.c          |    3
 arch/powerpc/platforms/cell/spu_base.c       |  309 ---------
 arch/powerpc/platforms/cell/spu_coredump.c   |   81 ++
 arch/powerpc/platforms/cell/spu_priv1_mmio.c |  424 ++++++++++++-
 arch/powerpc/platforms/cell/spu_priv1_mmio.h |   26
 arch/powerpc/platforms/cell/spufs/Makefile   |    2
 arch/powerpc/platforms/cell/spufs/coredump.c |  238 +++++++
 arch/powerpc/platforms/cell/spufs/file.c     |  327 +++++++---
 arch/powerpc/platforms/cell/spufs/inode.c    |    7
 arch/powerpc/platforms/cell/spufs/spufs.h    |   11
 arch/powerpc/platforms/ps3/Kconfig           |   43 +
 arch/powerpc/platforms/ps3/Makefile          |    4
 arch/powerpc/platforms/ps3/exports.c         |   27
 arch/powerpc/platforms/ps3/htab.c            |  277 ++++++++
 arch/powerpc/platforms/ps3/hvcall.S          |  804 +++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/interrupt.c       |  575 ++++++++++++++++++
 arch/powerpc/platforms/ps3/mm.c              |  827 ++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/os-area.c         |  259 ++++++++
 arch/powerpc/platforms/ps3/platform.h        |   68 ++
 arch/powerpc/platforms/ps3/repository.c      |  840 +++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/setup.c           |  173 +++++
 arch/powerpc/platforms/ps3/smp.c             |  158 +++++
 arch/powerpc/platforms/ps3/spu.c             |  613 +++++++++++++++++++
 arch/powerpc/platforms/ps3/time.c            |  104 +++
 arch/powerpc/xmon/Makefile                   |    9
 arch/powerpc/xmon/dis-asm.h                  |   31
 arch/powerpc/xmon/ppc-dis.c                  |   29
 arch/powerpc/xmon/ppc-opc.c                  |  778 ++++++++++++++++++-------
 arch/powerpc/xmon/ppc.h                      |   39 -
 arch/powerpc/xmon/spu-dis.c                  |  248 +++++++
 arch/powerpc/xmon/spu-insns.h                |  410 +++++++++++++
 arch/powerpc/xmon/spu-opc.c                  |   44 +
 arch/powerpc/xmon/spu.h                      |  126 ++++
 arch/powerpc/xmon/xmon.c                     |  124 +++
 drivers/Makefile                             |    1
 drivers/ps3/Makefile                         |    1
 drivers/ps3/system-bus.c                     |  358 +++++++++++
 fs/binfmt_elf.c                              |    8
 include/asm-powerpc/cputable.h               |    4
 include/asm-powerpc/elf.h                    |   13
 include/asm-powerpc/firmware.h               |    8
 include/asm-powerpc/irq.h                    |    4
 include/asm-powerpc/lv1call.h                |  345 +++++++++++
 include/asm-powerpc/ps3.h                    |  462 ++++++++++++++
 include/asm-powerpc/sparsemem.h              |    6
 include/asm-powerpc/spu.h                    |   15
 include/asm-powerpc/spu_priv1.h              |   40 +
 include/linux/elf.h                          |    7
 57 files changed, 9552 insertions(+), 669 deletions(-)
