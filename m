Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Please pull for-2.6.23 branch of cell-2.6.git
Date: Fri, 20 Jul 2007 21:55:43 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200707202155.45002.arnd.bergmann@de.ibm.com>
Cc: Philippe Elie <phil.el@wanadoo.fr>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, Jeremy Kerr <jk@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus,

Please pull from

	master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.23

This is a number of changes that fell through the cracks because
it wasn't clear how we were going to merge it in the absence of paulus.
Mostly bug fixes, except a few features that should we should have
submitted all along:

* oprofile on Cell SPU
* SPU affinity
* Kdump saves SPU state
* drivers for I/O buffer memory and MSI on the Axon south bridge

	Arnd <><

shortlog

    [CELL] spufs: rework list management and associated locking
    [CELL] oprofile: add support to OProfile for profiling CELL BE SPUs
    [CELL] oprofile: enable SPU switch notification to detect currently active SPU tasks
    [CELL] spu_base: locking cleanup
    [CELL] cell: indexing of SPUs based on firmware vicinity properties
    [CELL] spufs: integration of SPE affinity with the scheduller
    [CELL] cell: add placement computation for scheduling of affinity contexts
    [CELL] spufs: extension of spu_create to support affinity definition
    [CELL] cell: add hardcoded spu vicinity information for QS20
    [CELL] cell: add vicinity information on spus
    [CELL] cell: add per BE structure with info about its SPUs
    [CELL] spufs: use find_first_bit() instead of sched_find_first_bit()
    [CELL] spufs: remove unused file argument from spufs_run_spu()
    [CELL] spufs: change decrementer restore timing
    [CELL] spufs: dont halt decrementer at restore step 47
    [CELL] spufs: limit saving MFC_CNTL bits
    [CELL] spufs: fix read and write for decr_status file
    [CELL] spufs: fix decr_status meanings
    [CELL] spufs: remove needless context save/restore code
    [CELL] spufs: fix array size of channel index
    [CELL] spufs: make sure context are scheduled again after spu_acquire_saved
    [CELL] spufs: add spu stats in sysfs and ctx stat file in spufs
    [CELL] spufs: Remove spurious WARN_ON for spu_deactivate for NOSCHED contexts
    [CELL] spufs: Make signal-notification files readonly for NOSCHED contexts
    [CELL] spufs: Avoid unexpectedly restaring MFC during context save
    [CELL] spufs: remove section mismatch warning
    [CELL] add support for MSI on Axon-based Cell systems
    [CELL] saving spus information for kexec crash
    [CELL] driver for DDR2 memory on AXON
    [CELL] allow linux to map Cell regs on legacy SLOF tree.
    [CELL] fix cbe_thermal for legacy SLOF tree.
    [CELL] fix cbe_cpufreq for legacy SLOF tree.
    [CELL] cbe_cpufreq: reorganize code
    [CELL] cbe_cpufreq: fix minor issues
    [CELL] cbe_cpufreq: fix initialization
    [CELL] cbe_cpufreq: fix latency measurement
    [CELL] pmi: remove support for mutiple devices.

diffstat

 arch/powerpc/configs/cell_defconfig                          |    3
 arch/powerpc/kernel/crash.c                                  |   67 +
 arch/powerpc/kernel/time.c                                   |    1
 arch/powerpc/oprofile/Kconfig                                |    7
 arch/powerpc/oprofile/Makefile                               |    4
 arch/powerpc/oprofile/cell/pr_util.h                         |   97 +
 arch/powerpc/oprofile/cell/spu_profiler.c                    |  221 ++++
 arch/powerpc/oprofile/cell/spu_task_sync.c                   |  484 ++++++++
 arch/powerpc/oprofile/cell/vma_map.c                         |  287 +++++
 arch/powerpc/oprofile/common.c                               |   51
 arch/powerpc/oprofile/op_model_7450.c                        |   14
 arch/powerpc/oprofile/op_model_cell.c                        |  607 +++++++++--
 arch/powerpc/oprofile/op_model_fsl_booke.c                   |   11
 arch/powerpc/oprofile/op_model_pa6t.c                        |   12
 arch/powerpc/oprofile/op_model_power4.c                      |   11
 arch/powerpc/oprofile/op_model_rs64.c                        |   10
 arch/powerpc/platforms/Kconfig                               |   10
 arch/powerpc/platforms/cell/Kconfig                          |   10
 arch/powerpc/platforms/cell/Makefile                         |    6
 arch/powerpc/platforms/cell/axon_msi.c                       |  445 ++++++++
 arch/powerpc/platforms/cell/cbe_cpufreq.c                    |  217 ---
 arch/powerpc/platforms/cell/cbe_cpufreq.h                    |   24
 arch/powerpc/platforms/cell/cbe_cpufreq_pervasive.c          |  115 ++
 arch/powerpc/platforms/cell/cbe_cpufreq_pmi.c                |  148 ++
 arch/powerpc/platforms/cell/cbe_regs.c                       |    7
 arch/powerpc/platforms/cell/cbe_thermal.c                    |   25
 arch/powerpc/platforms/cell/spu_base.c                       |  295 +++--
 arch/powerpc/platforms/cell/spu_syscalls.c                   |   17
 arch/powerpc/platforms/cell/spufs/context.c                  |   42
 arch/powerpc/platforms/cell/spufs/coredump.c                 |    2
 arch/powerpc/platforms/cell/spufs/fault.c                    |    8
 arch/powerpc/platforms/cell/spufs/file.c                     |  104 +
 arch/powerpc/platforms/cell/spufs/gang.c                     |    6
 arch/powerpc/platforms/cell/spufs/inode.c                    |  132 ++
 arch/powerpc/platforms/cell/spufs/run.c                      |   36
 arch/powerpc/platforms/cell/spufs/sched.c                    |  377 ++++--
 arch/powerpc/platforms/cell/spufs/spu_restore.c              |    6
 arch/powerpc/platforms/cell/spufs/spu_restore_dump.h_shipped |  480 ++++----
 arch/powerpc/platforms/cell/spufs/spufs.h                    |   99 +
 arch/powerpc/platforms/cell/spufs/switch.c                   |   72 -
 arch/powerpc/platforms/cell/spufs/syscalls.c                 |   34
 arch/powerpc/sysdev/Makefile                                 |    1
 arch/powerpc/sysdev/axonram.c                                |  381 ++++++
 arch/powerpc/sysdev/pmi.c                                    |   51
 drivers/oprofile/buffer_sync.c                               |    3
 drivers/oprofile/event_buffer.h                              |   20
 drivers/oprofile/oprof.c                                     |   28
 include/asm-powerpc/oprofile_impl.h                          |   10
 include/asm-powerpc/pmi.h                                    |    8
 include/asm-powerpc/spu.h                                    |   62 -
 include/asm-powerpc/spu_csa.h                                |    8
 include/linux/dcookies.h                                     |    1
 include/linux/elf-em.h                                       |    3
 include/linux/oprofile.h                                     |   35
 include/linux/syscalls.h                                     |    2
