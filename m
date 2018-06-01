Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80962gYzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:29 +1000 (AEST)
Message-Id: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 00/14] Remove unneccessary included headers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:25 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this serie is to limit the number of includes to
only the necessary ones in order to reduce the number of files
recompiled everytime a header file is modified.

This is the start of the work, please provide feedback if any so
that I don't go in the wrong direction.

Handled inclusion changes more carrefully after Michael feedback.

Started splitting some headers in order to reduce their coverage.

Christophe Leroy (14):
  powerpc: remove kdump.h from page.h
  powerpc: remove unneeded inclusions of cpu_has_feature.h
  powerpc/405: move PPC405_ERR77 in asm-405.h
  powerpc: move ASM_CONST and stringify_in_c() into asm-const.h
  powerpc: clean the inclusion of stringify.h
  powerpc: clean inclusions of asm/feature-fixups.h
  powerpc: remove superflous inclusions of asm/fixmap.h
  powerpc: declare set_breakpoint() static
  powerpc/book3s: Remove PPC_PIN_SIZE
  powerpc: fix includes in asm/processor.h
  powerpc/nohash: fix hash related comments in pgtable.h
  powerpc/44x: remove page.h from mmu-44x.h
  powerpc: split reg.h in two parts
  powerpc: Split synch.h in two parts

 arch/powerpc/crypto/md5-asm.S                     |  1 +
 arch/powerpc/crypto/sha1-powerpc-asm.S            |  1 +
 arch/powerpc/include/asm/asm-405.h                | 19 +++++++
 arch/powerpc/include/asm/asm-compat.h             | 26 +---------
 arch/powerpc/include/asm/asm-const.h              | 14 +++++
 arch/powerpc/include/asm/atomic.h                 |  2 +
 arch/powerpc/include/asm/barrier.h                |  3 ++
 arch/powerpc/include/asm/bitops.h                 |  2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h      |  7 ---
 arch/powerpc/include/asm/book3s/64/hash.h         |  2 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h     |  2 +-
 arch/powerpc/include/asm/book3s/64/radix.h        |  2 +
 arch/powerpc/include/asm/cacheflush.h             |  1 -
 arch/powerpc/include/asm/cmpxchg.h                |  3 +-
 arch/powerpc/include/asm/code-patching.h          |  1 +
 arch/powerpc/include/asm/cputable.h               |  3 +-
 arch/powerpc/include/asm/cputime.h                |  1 -
 arch/powerpc/include/asm/dbell.h                  |  2 +-
 arch/powerpc/include/asm/dcr-native.h             |  1 +
 arch/powerpc/include/asm/debug.h                  |  1 -
 arch/powerpc/include/asm/dt_cpu_ftrs.h            |  2 -
 arch/powerpc/include/asm/exception-64s.h          |  2 +
 arch/powerpc/include/asm/feature-fixups.h         |  2 +
 arch/powerpc/include/asm/firmware.h               |  3 +-
 arch/powerpc/include/asm/fixmap.h                 |  2 -
 arch/powerpc/include/asm/futex.h                  |  2 +-
 arch/powerpc/include/asm/hw_breakpoint.h          |  1 +
 arch/powerpc/include/asm/iommu.h                  |  1 +
 arch/powerpc/include/asm/jump_label.h             |  2 +-
 arch/powerpc/include/asm/kvm_booke_hv_asm.h       |  2 +
 arch/powerpc/include/asm/mmu-44x.h                | 11 ++--
 arch/powerpc/include/asm/mmu.h                    |  3 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h      |  7 +--
 arch/powerpc/include/asm/nohash/64/pgtable.h      | 19 ++-----
 arch/powerpc/include/asm/page.h                   |  3 +-
 arch/powerpc/include/asm/page_64.h                |  2 +
 arch/powerpc/include/asm/ppc-opcode.h             |  3 +-
 arch/powerpc/include/asm/ppc_asm.h                |  1 +
 arch/powerpc/include/asm/processor.h              |  5 +-
 arch/powerpc/include/asm/ptrace.h                 |  1 +
 arch/powerpc/include/asm/reg-ftr.h                | 63 +++++++++++++++++++++++
 arch/powerpc/include/asm/reg.h                    | 36 +------------
 arch/powerpc/include/asm/reg_a2.h                 |  2 +
 arch/powerpc/include/asm/reg_fsl_emb.h            |  2 +
 arch/powerpc/include/asm/spinlock.h               |  3 +-
 arch/powerpc/include/asm/{synch.h => synch-ftr.h} | 24 ++-------
 arch/powerpc/include/asm/synch.h                  | 30 -----------
 arch/powerpc/include/asm/thread_info.h            |  3 +-
 arch/powerpc/include/asm/uaccess.h                |  1 -
 arch/powerpc/kernel/cpu_setup_6xx.S               |  1 +
 arch/powerpc/kernel/crash.c                       |  1 -
 arch/powerpc/kernel/entry_32.S                    |  2 +
 arch/powerpc/kernel/entry_64.S                    |  3 ++
 arch/powerpc/kernel/exceptions-64e.S              |  1 +
 arch/powerpc/kernel/exceptions-64s.S              |  2 +
 arch/powerpc/kernel/fpu.S                         |  2 +
 arch/powerpc/kernel/head_32.S                     |  1 +
 arch/powerpc/kernel/head_40x.S                    |  1 +
 arch/powerpc/kernel/head_64.S                     |  2 +
 arch/powerpc/kernel/head_8xx.S                    |  1 -
 arch/powerpc/kernel/head_fsl_booke.S              |  1 +
 arch/powerpc/kernel/idle_6xx.S                    |  1 +
 arch/powerpc/kernel/idle_book3s.S                 |  3 ++
 arch/powerpc/kernel/idle_e500.S                   |  1 +
 arch/powerpc/kernel/idle_power4.S                 |  1 +
 arch/powerpc/kernel/kvm_emul.S                    |  1 +
 arch/powerpc/kernel/l2cr_6xx.S                    |  1 +
 arch/powerpc/kernel/machine_kexec.c               |  1 +
 arch/powerpc/kernel/misc_32.S                     |  1 +
 arch/powerpc/kernel/misc_64.S                     |  1 +
 arch/powerpc/kernel/paca.c                        |  1 +
 arch/powerpc/kernel/ppc_save_regs.S               |  1 +
 arch/powerpc/kernel/process.c                     | 14 ++---
 arch/powerpc/kernel/prom.c                        |  1 -
 arch/powerpc/kernel/prom_init.c                   |  1 -
 arch/powerpc/kernel/setup_32.c                    |  2 +
 arch/powerpc/kernel/setup_64.c                    |  1 +
 arch/powerpc/kernel/swsusp_32.S                   |  1 +
 arch/powerpc/kernel/swsusp_asm64.S                |  1 +
 arch/powerpc/kernel/tm.S                          |  2 +
 arch/powerpc/kernel/vdso.c                        |  1 -
 arch/powerpc/kernel/vector.S                      |  1 +
 arch/powerpc/kvm/book3s_64_slb.S                  |  3 ++
 arch/powerpc/kvm/book3s_64_vio_hv.c               |  1 +
 arch/powerpc/kvm/book3s_hv_interrupts.S           |  2 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S           |  3 ++
 arch/powerpc/kvm/book3s_interrupts.S              |  1 +
 arch/powerpc/kvm/book3s_rmhandlers.S              |  2 +
 arch/powerpc/kvm/book3s_segment.S                 |  4 ++
 arch/powerpc/lib/copypage_64.S                    |  1 +
 arch/powerpc/lib/copyuser_64.S                    |  2 +
 arch/powerpc/lib/feature-fixups-test.S            |  2 +
 arch/powerpc/lib/hweight_64.S                     |  1 +
 arch/powerpc/lib/ldstfp.S                         |  1 +
 arch/powerpc/lib/locks.c                          |  1 -
 arch/powerpc/lib/memcpy_64.S                      |  2 +
 arch/powerpc/lib/string.S                         |  1 +
 arch/powerpc/mm/dump_hashpagetable.c              |  1 -
 arch/powerpc/mm/hash_low_32.S                     |  1 +
 arch/powerpc/mm/hash_native_64.c                  |  1 +
 arch/powerpc/mm/slb_low.S                         |  1 +
 arch/powerpc/mm/tlb_low_64e.S                     |  1 +
 arch/powerpc/mm/tlb_nohash_low.S                  |  2 +
 arch/powerpc/net/bpf_jit32.h                      |  1 +
 arch/powerpc/net/bpf_jit_asm.S                    |  1 +
 arch/powerpc/net/bpf_jit_asm64.S                  |  1 +
 arch/powerpc/net/bpf_jit_comp.c                   |  1 +
 arch/powerpc/net/bpf_jit_comp64.c                 |  1 +
 arch/powerpc/perf/req-gen/_begin.h                |  2 +
 arch/powerpc/perf/req-gen/perf.h                  |  1 +
 arch/powerpc/platforms/cell/cbe_thermal.c         |  1 +
 arch/powerpc/platforms/cell/spufs/sputrace.h      |  1 +
 arch/powerpc/platforms/powermac/cache.S           |  1 +
 arch/powerpc/platforms/powermac/sleep.S           |  1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S    |  2 +
 arch/powerpc/platforms/powernv/vas.h              |  1 +
 arch/powerpc/platforms/pseries/hvCall.S           |  1 +
 arch/powerpc/platforms/pseries/mobility.c         |  1 +
 arch/powerpc/platforms/pseries/setup.c            |  1 +
 arch/powerpc/purgatory/trampoline.S               | 10 +---
 arch/powerpc/sysdev/cpm_common.c                  |  1 -
 arch/powerpc/xmon/spr_access.S                    |  1 +
 122 files changed, 259 insertions(+), 193 deletions(-)
 create mode 100644 arch/powerpc/include/asm/asm-405.h
 create mode 100644 arch/powerpc/include/asm/asm-const.h
 create mode 100644 arch/powerpc/include/asm/reg-ftr.h
 copy arch/powerpc/include/asm/{synch.h => synch-ftr.h} (63%)

-- 
2.13.3
