Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKf851CKzF13y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:10:39 +1000 (AEST)
Message-Id: <cover.1537877134.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 12:10:35 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
moves the thread_info into task_struct.

Moving thread_info into task_struct has the following advantages:
- It protects thread_info from corruption in the case of stack
overflows.
- Its address is harder to determine if stack addresses are
leaked, making a number of attacks more difficult.

Changes since v1:
 - Removed the first patch which was modifying header inclusion order in timer
 - Modified some names in asm-offsets to avoid conflicts when including asm-offsets in C files
 - Modified asm/smp.h to avoid having to include linux/sched.h (using asm-offsets instead)
 - Moved some changes from the activation patch to the preparation patch.

Christophe Leroy (9):
  book3s/64: avoid circular header inclusion in mmu-hash.h
  powerpc: change name THREAD_INFO to TASK_STACK
  powerpc: clear redundancies in asm-offset.c
  powerpc: Prepare for moving thread_info into task_struct
  powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
  powerpc: regain entire stack space
  powerpc: 'current_set' is now a table of task_struct pointers
  powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
  powerpc/64: Modify CURRENT_THREAD_INFO()

 arch/powerpc/Kconfig                           |  1 +
 arch/powerpc/include/asm/asm-prototypes.h      |  4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |  2 +-
 arch/powerpc/include/asm/exception-64s.h       |  4 +-
 arch/powerpc/include/asm/irq.h                 | 14 ++--
 arch/powerpc/include/asm/livepatch.h           |  2 +-
 arch/powerpc/include/asm/mmu-44x.h             |  8 +--
 arch/powerpc/include/asm/processor.h           | 39 +-----------
 arch/powerpc/include/asm/ptrace.h              |  2 +-
 arch/powerpc/include/asm/reg.h                 |  2 +-
 arch/powerpc/include/asm/smp.h                 | 14 +++-
 arch/powerpc/include/asm/task_size.h           | 42 ++++++++++++
 arch/powerpc/include/asm/thread_info.h         | 17 +----
 arch/powerpc/kernel/asm-offsets.c              | 37 ++++++-----
 arch/powerpc/kernel/entry_32.S                 | 88 ++++++++++----------------
 arch/powerpc/kernel/entry_64.S                 | 12 ++--
 arch/powerpc/kernel/epapr_hcalls.S             |  5 +-
 arch/powerpc/kernel/exceptions-64e.S           | 13 +---
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/head_32.S                  | 16 ++---
 arch/powerpc/kernel/head_40x.S                 |  6 +-
 arch/powerpc/kernel/head_44x.S                 | 10 +--
 arch/powerpc/kernel/head_64.S                  |  3 +-
 arch/powerpc/kernel/head_8xx.S                 |  4 +-
 arch/powerpc/kernel/head_booke.h               | 12 +---
 arch/powerpc/kernel/head_fsl_booke.S           | 18 +++---
 arch/powerpc/kernel/idle_6xx.S                 |  8 +--
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_e500.S                |  8 +--
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/irq.c                      | 66 +++----------------
 arch/powerpc/kernel/kgdb.c                     | 28 --------
 arch/powerpc/kernel/machine_kexec_64.c         |  6 +-
 arch/powerpc/kernel/misc_32.S                  | 17 ++---
 arch/powerpc/kernel/process.c                  | 15 ++---
 arch/powerpc/kernel/setup-common.c             |  2 +-
 arch/powerpc/kernel/setup_32.c                 | 15 ++---
 arch/powerpc/kernel/setup_64.c                 | 29 ++-------
 arch/powerpc/kernel/smp.c                      | 16 ++---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S      |  4 +-
 arch/powerpc/kvm/book3s_hv_hmi.c               |  1 +
 arch/powerpc/mm/hash_low_32.S                  | 14 ++--
 arch/powerpc/sysdev/6xx-suspend.S              |  5 +-
 arch/powerpc/xmon/xmon.c                       |  2 +-
 45 files changed, 243 insertions(+), 380 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size.h

-- 
2.13.3
