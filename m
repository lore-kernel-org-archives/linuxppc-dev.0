Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/39] Second round of 64bit PowerPC little endian patches
Date: Mon, 23 Sep 2013 12:04:34 +1000
Message-Id: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset fixes little endian issues found in various places
including the alignment handler, PCI, and ptrace code.

It also adds little endian support for KVM guests and PowerNV.

Alistair Popple (4):
  powerpc: Little endian fixes for platforms/powernv/opal.c
  powerpc: Little endian fix for arch/powerpc/platforms/powernv/pci.c
  powerpc: Little endian fix for
    arch/powerpc/platforms/powernv/pci-p5ioc2.c
  powerpc: Little endian sparse clean up for
    arch/powerpc/platforms/powernv/pci-ioda.c

Anton Blanchard (22):
  powerpc: Fix endian issues in VMX copy loops
  powerpc: Book 3S MMU little endian support
  powerpc: Fix offset of FPRs in VSX registers in little endian builds
  powerpc: PTRACE_PEEKUSR/PTRACE_POKEUSER of FPR registers in little
    endian builds
  powerpc: Little endian builds double word swap VSX state during
    context save/restore
  powerpc: Add little endian support for word-at-a-time functions
  powerpc: Set MSR_LE bit on little endian builds
  powerpc: Reset MSR_LE on signal entry
  powerpc: Remove open coded byte swap macro in alignment handler
  powerpc: Remove hard coded FP offsets in alignment handler
  powerpc: Alignment handler shouldn't access VSX registers with TS_FPR
  powerpc: Add little endian support to alignment handler
  powerpc: Handle VSX alignment faults in little endian mode
  powerpc: Use generic checksum code in little endian
  powerpc: Use generic memcpy code in little endian
  powerpc: uname should return ppc64le/ppcle on little endian builds
  powerpc/powernv: More little endian issues in OPAL RTC driver
  powerpc/powernv: Fix some PCI sparse errors and one LE bug
  KVM: PPC: Disable KVM on little endian builds
  powerpc/kvm/book3s_hv: Add little endian guest support
  powerpc: Don't set HAVE_EFFICIENT_UNALIGNED_ACCESS on little endian
    builds
  powerpc: Work around little endian gcc bug

Benjamin Herrenschmidt (10):
  powerpc: endian safe trampoline
  powerpc/powernv: Fix endian issues in OPAL RTC driver
  powerpc/powernv: Fix endian issues in OPAL ICS backend
  powerpc/powernv: Make OPAL NVRAM device tree accesses endian safe
  powerpc/powernv: Fix endian issues in powernv PCI code
  powerpc/powernv: Fix endian issues in OPAL console and udbg backend
  powerpc/powernv: Fix OPAL entry and exit in little endian mode
  powerpc/powernv: Don't register exception handlers in little endian
    mode
  powerpc/hvsi: Fix endian issues in HVSI driver
  tty/hvc_opal: powerpc: Make OPAL HVC device tree accesses endian safe

Ian Munsie (3):
  powerpc: Support endian agnostic MMIO
  powerpc: Include the appropriate endianness header
  powerpc: Add ability to build little endian kernels

 arch/powerpc/Kconfig                           |   5 +-
 arch/powerpc/Makefile                          |  37 +++++-
 arch/powerpc/boot/Makefile                     |   3 +-
 arch/powerpc/include/asm/checksum.h            |   5 +
 arch/powerpc/include/asm/hvsi.h                |  16 +--
 arch/powerpc/include/asm/io.h                  |  67 +++++++---
 arch/powerpc/include/asm/kvm_host.h            |   1 +
 arch/powerpc/include/asm/mmu-hash64.h          |   4 +-
 arch/powerpc/include/asm/opal.h                |  34 +++---
 arch/powerpc/include/asm/ppc-opcode.h          |   3 +
 arch/powerpc/include/asm/ppc_asm.h             |  52 +++++++-
 arch/powerpc/include/asm/processor.h           |  12 +-
 arch/powerpc/include/asm/reg.h                 |   7 +-
 arch/powerpc/include/asm/string.h              |   4 +
 arch/powerpc/include/asm/word-at-a-time.h      |  71 +++++++++++
 arch/powerpc/include/uapi/asm/byteorder.h      |   4 +
 arch/powerpc/kernel/align.c                    | 162 ++++++++++++++++---------
 arch/powerpc/kernel/asm-offsets.c              |   1 +
 arch/powerpc/kernel/entry_64.S                 |  36 +++---
 arch/powerpc/kernel/head_64.S                  |   3 +
 arch/powerpc/kernel/ppc_ksyms.c                |   4 +
 arch/powerpc/kernel/ptrace.c                   |   8 +-
 arch/powerpc/kernel/signal_32.c                |   3 +-
 arch/powerpc/kernel/signal_64.c                |   3 +-
 arch/powerpc/kernel/vdso32/vdso32.lds.S        |   4 +
 arch/powerpc/kernel/vdso64/vdso64.lds.S        |   4 +
 arch/powerpc/kvm/Kconfig                       |   1 +
 arch/powerpc/kvm/book3s_64_mmu_hv.c            |   2 +-
 arch/powerpc/kvm/book3s_hv.c                   |  44 +++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |  15 +--
 arch/powerpc/lib/Makefile                      |  18 ++-
 arch/powerpc/lib/copyuser_power7.S             |  54 +++++----
 arch/powerpc/lib/memcpy_power7.S               |  55 +++++----
 arch/powerpc/mm/hash_native_64.c               |  46 ++++---
 arch/powerpc/mm/hash_utils_64.c                |  38 +++---
 arch/powerpc/platforms/powernv/opal-nvram.c    |   4 +-
 arch/powerpc/platforms/powernv/opal-rtc.c      |  12 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S |   9 +-
 arch/powerpc/platforms/powernv/opal.c          |  34 +++---
 arch/powerpc/platforms/powernv/pci-ioda.c      |  41 ++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c    |   4 +-
 arch/powerpc/platforms/powernv/pci.c           |  26 ++--
 arch/powerpc/platforms/powernv/pci.h           |   2 +-
 arch/powerpc/sysdev/xics/ics-opal.c            |  17 +--
 drivers/tty/hvc/hvc_opal.c                     |   4 +-
 drivers/tty/hvc/hvsi_lib.c                     |  25 ++--
 46 files changed, 685 insertions(+), 319 deletions(-)

-- 
1.8.1.2
