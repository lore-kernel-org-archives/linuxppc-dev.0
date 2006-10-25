Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17727.901.368752.68802@cargo.ozlabs.ibm.com>
Date: Wed, 25 Oct 2006 16:26:13 +1000
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

to get some more PowerPC bugfixes, as listed below.  There is also a
defconfig update and the addition of a new processor type (970GX) to
the cpu table.  The first 4 listed under Ben H.'s name aren't strictly
bugfixes in themselves, but are needed for the Cell timebase hardware
bug workaround (the bug is that reads from the timebase may
occasionally not return monotonically increasing values, as they
implemented the timebase as two 32-bit counters).

Thanks,
Paul.

 arch/powerpc/boot/Makefile                 |    2 
 arch/powerpc/configs/cell_defconfig        |   19 +++-
 arch/powerpc/kernel/cputable.c             |   86 +++++++++++++++++++
 arch/powerpc/kernel/head_64.S              |   19 ----
 arch/powerpc/kernel/misc_32.S              |   74 -----------------
 arch/powerpc/kernel/misc_64.S              |  124 ----------------------------
 arch/powerpc/kernel/module_32.c            |   39 +++++++--
 arch/powerpc/kernel/module_64.c            |   49 +++++++++--
 arch/powerpc/kernel/prom.c                 |    8 +-
 arch/powerpc/kernel/setup_32.c             |    8 +-
 arch/powerpc/kernel/setup_64.c             |   11 ++
 arch/powerpc/kernel/time.c                 |   63 ++++----------
 arch/powerpc/kernel/vdso.c                 |   43 ++++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S    |   12 +++
 arch/powerpc/kernel/vdso64/gettimeofday.S  |    6 +
 arch/powerpc/kernel/vdso64/vdso64.lds.S    |   10 ++
 arch/powerpc/oprofile/op_model_power4.c    |    2 
 arch/powerpc/platforms/cell/spufs/file.c   |    2 
 arch/powerpc/platforms/cell/spufs/hw_ops.c |    2 
 arch/powerpc/platforms/chrp/setup.c        |    4 +
 arch/powerpc/platforms/iseries/setup.c     |    5 +
 arch/powerpc/platforms/powermac/sleep.S    |    3 -
 arch/powerpc/sysdev/i8259.c                |    5 +
 arch/powerpc/sysdev/ipic.c                 |    4 -
 arch/powerpc/sysdev/qe_lib/ucc.c           |    2 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c      |    2 
 arch/powerpc/sysdev/qe_lib/ucc_slow.c      |    2 
 arch/powerpc/sysdev/tsi108_dev.c           |    4 -
 arch/ppc/boot/simple/relocate.S            |    6 +
 arch/ppc/kernel/misc.S                     |   74 -----------------
 arch/ppc/kernel/setup.c                    |   10 +-
 include/asm-powerpc/asm-compat.h           |   52 ++++++++++++
 include/asm-powerpc/cputable.h             |   37 +++-----
 include/asm-powerpc/firmware.h             |   17 ++--
 include/asm-powerpc/i8259.h                |    1 
 include/asm-powerpc/ppc_asm.h              |   18 +++-
 include/asm-powerpc/prom.h                 |   10 +-
 include/asm-powerpc/reg.h                  |   26 ++++++
 include/asm-powerpc/time.h                 |   27 ++++--
 include/asm-powerpc/timex.h                |   20 ++---
 scripts/mod/modpost.c                      |    2 
 41 files changed, 456 insertions(+), 454 deletions(-)

Arnd Bergmann:
      [POWERPC] spufs: fix another off-by-one bug in spufs_mbox_read
      [POWERPC] cell: update defconfig

Benjamin Herrenschmidt:
      [POWERPC] Consolidate feature fixup code
      [POWERPC] Support nested cpu feature sections
      [POWERPC] Support feature fixups in vdso's
      [POWERPC] Support feature fixups in modules
      [POWERPC] Cell timebase bug workaround
      [POWERPC] Fix device_is_compatible() const warning
      [POWERPC] Fix CHRP platforms with only 8259

Dwayne Grant Mcconnell:
      [POWERPC] spufs: fix signal2 file to report signal2

Jake Moilanen:
      [POWERPC] Add 970GX cputable entry

Liu Dave-r63238:
      [POWERPC] Fix the UCC rx/tx clock of QE

Mark A. Greer:
      [POWERPC] Don't require execute perms on wrapper when building zImage.initrd

Olaf Hering:
      [POWERPC] Fix hang in start_ldr if _end or _edata is unaligned

Scott Wood:
      [POWERPC] IPIC: Fix spinlock recursion in set_irq_handler

Srinivasa Ds:
      [POWERPC] Fix build breakage with CONFIG_PPC32

Stephen Rothwell:
      [POWERPC] Simplify stolen time calculation

Timur Tabi:
      [POWERPC] Fix spelling errors in ucc_fast.c and ucc_slow.c

Zang Roy-r61911:
      [POWERPC] Fix compiler warning message on get_property call
