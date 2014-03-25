Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 00/33] Build ppc64le kernel using ABIv2
Date: Tue, 25 Mar 2014 22:44:06 +1100
Message-Id: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patches allow the kernel to be built using ABIv2 on a
compatible LE toolchain. Module support thanks to Rusty. Thanks also
to Uli for his help with some of assembly issues we tripped up on.

There are two known outstanding issues:

- If a kernel module calls into an exported assembly function
  which in turns calls out to C, r2 is going to be wrong. One example
  is __copy_tofrom_user_power7.

  The reason is _GLOBAL() doesn't have a global entry point setup
  with the associated addis/addi used to create r2. I tried adding
  it and quickly realised that _GLOBAL is used places that will not
  tolerate the addi/addis (eg __start()).

- arch/powerpc/platforms/pseries/hvCall.S assumes we always have a
  parameter save area, which is incorrect for ABIv2. I tried to be
  intelligent and use the toc save area to store some information
  but that failed as soon as we started using modules. It would be
  nice to avoid a stack frame in the common (tracepoints disabled)
  case, but we may end up having to allocate one.

Anton
--

Anton Blanchard (21):
  powerpc: No need to use dot symbols when branching to a function
  powerpc: Remove superflous function descriptors in assembly only code
  powerpc: Don't use a function descriptor for system call table
  powerpc: Remove some unnecessary uses of _GLOBAL() and _STATIC()
  powerpc: Remove _INIT_GLOBAL(), _STATIC() and _INIT_STATIC()
  powerpc: Remove dot symbol usage in exception macros
  powerpc: Create DOTSYM to wrap dot symbol usage
  powerpc: Remove function descriptors and dot symbols on new ABI
  powerpc: ABIv2 function calls must place target address in r12
  powerpc: Ignore TOC relocations
  powerpc: Add ABIv2 support to ppc_function_entry
  powerpc: Use ppc_function_entry instead of open coding it
  powerpc: Fix branch patching code for ABIv2
  powerpc: Fix kernel thread creation on ABIv2
  powerpc: Fix ABIv2 issues with stack offsets in assembly code
  powerpc/tm: Use STK_PARAM
  powerpc/tm: Fix GOT save offset for ABIv2
  powerpc/tracing: TRACE_WITH_FRAME_BUFFER creates invalid stack frames
  powerpc: Fix SMP issues with ppc64le ABIv2
  powerpc: Fix ABIv2 issue with dereference_function_descriptor
  powerpc: Build little endian ppc64 kernel with ABIv2

Rusty Russell (11):
  powerpc: make module stub code endian independent
  powerpc: modules implement R_PPC64_TOCSAVE relocation.
  powerpc: EXPORT_SYMBOL(.TOC.)
  powerpc: module: handle MODVERSION for .TOC.
  powerpc: Fix up TOC. for modules.
  powerpc: Handle new ELFv2 module relocations
  powerpc: modules: comment about de-dotifying symbols when using the
    ELFv2 ABI.
  powerpc: modules: change r2 save/restore offset for ELFv2 ABI.
  powerpc: modules: use r12 for stub jump address.
  powerpc: modules: skip r2 setup for ELFv2
  powerpc: modules: implement stubs for ELFv2 ABI.

Ulrich Weigand (1):
  powerpc: Fix unsafe accesses to parameter area in ELFv2

 arch/powerpc/Makefile                          |   8 +-
 arch/powerpc/boot/util.S                       |   4 +-
 arch/powerpc/include/asm/code-patching.h       |  40 ++++-
 arch/powerpc/include/asm/context_tracking.h    |   4 +-
 arch/powerpc/include/asm/exception-64e.h       |   6 +-
 arch/powerpc/include/asm/exception-64s.h       |   2 +-
 arch/powerpc/include/asm/ftrace.h              |   2 +
 arch/powerpc/include/asm/irqflags.h            |   8 +-
 arch/powerpc/include/asm/linkage.h             |   2 +
 arch/powerpc/include/asm/module.h              |   1 +
 arch/powerpc/include/asm/ppc_asm.h             |  64 ++++----
 arch/powerpc/include/asm/sections.h            |   2 +
 arch/powerpc/include/asm/systbl.h              |   6 +-
 arch/powerpc/include/uapi/asm/elf.h            |  10 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S      |  28 ++--
 arch/powerpc/kernel/entry_64.S                 | 110 ++++++-------
 arch/powerpc/kernel/exceptions-64e.S           | 140 ++++++++---------
 arch/powerpc/kernel/exceptions-64s.S           | 204 ++++++++++++-------------
 arch/powerpc/kernel/head_64.S                  | 117 +++++++-------
 arch/powerpc/kernel/idle_book3e.S              |   2 +-
 arch/powerpc/kernel/idle_power4.S              |   2 +-
 arch/powerpc/kernel/idle_power7.S              |   4 +-
 arch/powerpc/kernel/misc_64.S                  |  46 +++++-
 arch/powerpc/kernel/module_64.c                | 199 ++++++++++++++++++------
 arch/powerpc/kernel/process.c                  |  17 +--
 arch/powerpc/kernel/prom_init_check.sh         |   2 +-
 arch/powerpc/kernel/setup_64.c                 |   2 +-
 arch/powerpc/kernel/systbl.S                   |  18 ++-
 arch/powerpc/kernel/tm.S                       |  13 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S        |   2 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  32 ++--
 arch/powerpc/lib/copypage_64.S                 |   2 +-
 arch/powerpc/lib/copypage_power7.S             |  12 +-
 arch/powerpc/lib/copyuser_power7.S             |  32 ++--
 arch/powerpc/lib/hweight_64.S                  |   8 +-
 arch/powerpc/lib/mem_64.S                      |   4 +-
 arch/powerpc/lib/memcpy_64.S                   |   8 +-
 arch/powerpc/lib/memcpy_power7.S               |  26 ++--
 arch/powerpc/mm/hash_low_64.S                  |  44 ++++--
 arch/powerpc/mm/hash_utils_64.c                |  36 ++---
 arch/powerpc/mm/slb.c                          |  12 +-
 arch/powerpc/mm/slb_low.S                      |  12 +-
 arch/powerpc/platforms/85xx/smp.c              |   3 +-
 arch/powerpc/platforms/cell/smp.c              |   5 +-
 arch/powerpc/platforms/pasemi/powersave.S      |   2 +-
 arch/powerpc/platforms/powernv/opal-takeover.S |   2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |   4 +-
 arch/powerpc/platforms/powernv/smp.c           |   5 +-
 arch/powerpc/platforms/pseries/hvCall.S        |   4 +-
 arch/powerpc/platforms/pseries/smp.c           |   5 +-
 arch/powerpc/platforms/wsp/scom_smp.c          |   3 +-
 51 files changed, 760 insertions(+), 566 deletions(-)

-- 
1.8.3.2
