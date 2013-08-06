Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/63] 64bit PowerPC little endian support
Date: Wed,  7 Aug 2013 02:01:17 +1000
Message-Id: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds support for building a 64bit PowerPC little
endian kernel.

binutils and gcc support (powerpcle/powerpc64le) is already
upstream. For gcc you can use gcc tip, or for the less adventurous
the gcc 4.8 branch works too.

QEMU patches to boot a little endian kernel will be posted over the
next day.

Anton
--

Alistair Popple (4):
  powerpc: More little endian fixes for prom.c
  powerpc: More little endian fixes for setup-common.c
  powerpc: Little endian fixes for legacy_serial.c
  powerpc: Make NUMA device node code endian safe

Anton Blanchard (53):
  powerpc: Align p_toc
  powerpc: handle unaligned ldbrx/stdbrx
  powerpc: Wrap MSR macros with parentheses
  powerpc: Remove SAVE_VSRU and REST_VSRU macros
  powerpc: Simplify logic in include/uapi/asm/elf.h
  powerpc/pseries: Simplify H_GET_TERM_CHAR
  powerpc: Fix a number of sparse warnings
  powerpc/pci: Don't use bitfield for force_32bit_msi
  powerpc: Stop using non-architected shared_proc field in lppaca
  powerpc: Make RTAS device tree accesses endian safe
  powerpc: Make cache info device tree accesses endian safe
  powerpc: Make RTAS calls endian safe
  powerpc: Make logical to real cpu mapping code endian safe
  powerpc: Add some endian annotations to time and xics code
  powerpc: Fix some endian issues in xics code
  powerpc: of_parse_dma_window should take a __be32 *dma_window
  powerpc: Make device tree accesses in cache info code endian safe
  powerpc: Make device tree accesses in HVC VIO console endian safe
  powerpc: Make device tree accesses in VIO subsystem endian safe
  powerpc: Make OF PCI device tree accesses endian safe
  powerpc: Make PCI device node device tree accesses endian safe
  powerpc: Add endian annotations to lppaca, slb_shadow and dtl_entry
  powerpc: Fix little endian lppaca, slb_shadow and dtl_entry
  powerpc: Emulate instructions in little endian mode
  powerpc: Little endian SMP IPI demux
  powerpc/pseries: Fix endian issues in H_GET_TERM_CHAR/H_PUT_TERM_CHAR
  powerpc: Fix little endian coredumps
  powerpc: Make rwlocks endian safe
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
  powerpc: Add endian safe trampoline to pseries secondary thread entry
  pseries: Add H_SET_MODE to change exception endianness
  powerpc/kvm/book3s_hv: Add little endian guest support
  powerpc: Remove open coded byte swap macro in alignment handler
  powerpc: Remove hard coded FP offsets in alignment handler
  powerpc: Alignment handler shouldn't access VSX registers with TS_FPR
  powerpc: Add little endian support to alignment handler
  powerpc: Handle VSX alignment faults in little endian mode
  ibmveth: Fix little endian issues
  ibmvscsi: Fix little endian issues
  [SCSI] lpfc: Don't force CONFIG_GENERIC_CSUM on
  powerpc: Use generic checksum code in little endian
  powerpc: Use generic memcpy code in little endian
  powerpc: uname should return ppc64le/ppcle on little endian builds
  powerpc: Don't set HAVE_EFFICIENT_UNALIGNED_ACCESS on little endian
    builds
  powerpc: Work around little endian gcc bug
  powerpc: Add pseries_le_defconfig

Benjamin Herrenschmidt (2):
  powerpc: Make prom_init.c endian safe
  powerpc: endian safe trampoline

Ian Munsie (4):
  powerpc: Make prom.c device tree accesses endian safe
  powerpc: Support endian agnostic MMIO
  powerpc: Include the appropriate endianness header
  powerpc: Add ability to build little endian kernels

 arch/powerpc/Kconfig                            |   5 +-
 arch/powerpc/Makefile                           |  37 ++-
 arch/powerpc/boot/Makefile                      |   3 +-
 arch/powerpc/configs/pseries_le_defconfig       | 347 ++++++++++++++++++++++++
 arch/powerpc/include/asm/asm-compat.h           |   9 +
 arch/powerpc/include/asm/checksum.h             |   5 +
 arch/powerpc/include/asm/hvcall.h               |   2 +
 arch/powerpc/include/asm/io.h                   |  67 +++--
 arch/powerpc/include/asm/kvm_host.h             |   1 +
 arch/powerpc/include/asm/lppaca.h               |  68 +++--
 arch/powerpc/include/asm/mmu-hash64.h           |   4 +-
 arch/powerpc/include/asm/paca.h                 |   5 +
 arch/powerpc/include/asm/pci-bridge.h           |   2 +-
 arch/powerpc/include/asm/ppc-opcode.h           |   3 +
 arch/powerpc/include/asm/ppc_asm.h              |  68 +++--
 arch/powerpc/include/asm/processor.h            |  12 +-
 arch/powerpc/include/asm/prom.h                 |   5 +-
 arch/powerpc/include/asm/reg.h                  |  13 +-
 arch/powerpc/include/asm/reg_booke.h            |   8 +-
 arch/powerpc/include/asm/rtas.h                 |   8 +-
 arch/powerpc/include/asm/spinlock.h             |   6 +-
 arch/powerpc/include/asm/string.h               |   4 +
 arch/powerpc/include/asm/word-at-a-time.h       |  71 +++++
 arch/powerpc/include/uapi/asm/byteorder.h       |   4 +
 arch/powerpc/include/uapi/asm/elf.h             |  21 +-
 arch/powerpc/kernel/align.c                     | 172 ++++++++----
 arch/powerpc/kernel/asm-offsets.c               |   1 +
 arch/powerpc/kernel/cacheinfo.c                 |  12 +-
 arch/powerpc/kernel/entry_64.S                  |  47 ++--
 arch/powerpc/kernel/head_64.S                   |   4 +
 arch/powerpc/kernel/legacy_serial.c             |   8 +-
 arch/powerpc/kernel/lparcfg.c                   |  14 +-
 arch/powerpc/kernel/paca.c                      |  10 +-
 arch/powerpc/kernel/pci-common.c                |  10 +-
 arch/powerpc/kernel/pci_64.c                    |   4 +-
 arch/powerpc/kernel/pci_dn.c                    |  20 +-
 arch/powerpc/kernel/pci_of_scan.c               |  23 +-
 arch/powerpc/kernel/ppc_ksyms.c                 |   4 +
 arch/powerpc/kernel/prom.c                      |  64 ++---
 arch/powerpc/kernel/prom_init.c                 | 253 +++++++++--------
 arch/powerpc/kernel/prom_parse.c                |  17 +-
 arch/powerpc/kernel/ptrace.c                    |   8 +-
 arch/powerpc/kernel/rtas.c                      |  66 ++---
 arch/powerpc/kernel/setup-common.c              |  13 +-
 arch/powerpc/kernel/setup_64.c                  |  14 +-
 arch/powerpc/kernel/signal_32.c                 |   3 +-
 arch/powerpc/kernel/signal_64.c                 |  11 +-
 arch/powerpc/kernel/smp.c                       |  21 +-
 arch/powerpc/kernel/time.c                      |  18 +-
 arch/powerpc/kernel/traps.c                     |   2 +-
 arch/powerpc/kernel/vdso32/vdso32.lds.S         |   4 +
 arch/powerpc/kernel/vdso64/vdso64.lds.S         |   4 +
 arch/powerpc/kernel/vio.c                       |  33 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c             |   2 +-
 arch/powerpc/kvm/book3s_64_slb.S                |   4 +
 arch/powerpc/kvm/book3s_hv.c                    |  46 +++-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c             |   4 +
 arch/powerpc/kvm/book3s_hv_rmhandlers.S         |  27 +-
 arch/powerpc/lib/Makefile                       |  18 +-
 arch/powerpc/lib/copyuser_power7.S              |  54 ++--
 arch/powerpc/lib/locks.c                        |   4 +-
 arch/powerpc/lib/memcpy_power7.S                |  55 ++--
 arch/powerpc/mm/fault.c                         |   6 +-
 arch/powerpc/mm/hash_native_64.c                |  46 ++--
 arch/powerpc/mm/hash_utils_64.c                 |  40 ++-
 arch/powerpc/mm/numa.c                          | 102 +++----
 arch/powerpc/mm/slb.c                           |   9 +-
 arch/powerpc/mm/subpage-prot.c                  |   4 +-
 arch/powerpc/perf/core-book3s.c                 |   2 +-
 arch/powerpc/platforms/Kconfig.cputype          |  11 +
 arch/powerpc/platforms/cell/iommu.c             |   2 +-
 arch/powerpc/platforms/powernv/opal.c           |   2 +-
 arch/powerpc/platforms/pseries/dtl.c            |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    |   4 +-
 arch/powerpc/platforms/pseries/hvconsole.c      |  17 +-
 arch/powerpc/platforms/pseries/iommu.c          |   8 +-
 arch/powerpc/platforms/pseries/lpar.c           |  21 +-
 arch/powerpc/platforms/pseries/plpar_wrappers.h |  50 ++--
 arch/powerpc/platforms/pseries/processor_idle.c |   8 +-
 arch/powerpc/platforms/pseries/pseries_energy.c |   4 +-
 arch/powerpc/platforms/pseries/setup.c          |  46 +++-
 arch/powerpc/sysdev/xics/icp-native.c           |   2 +-
 arch/powerpc/sysdev/xics/xics-common.c          |  10 +-
 drivers/net/ethernet/ibm/ibmveth.c              |   4 +-
 drivers/net/ethernet/ibm/ibmveth.h              |  19 +-
 drivers/scsi/Kconfig                            |   1 -
 drivers/scsi/ibmvscsi/ibmvscsi.c                | 153 ++++++-----
 drivers/scsi/ibmvscsi/viosrp.h                  |  46 ++--
 drivers/tty/hvc/hvc_vio.c                       |   4 +-
 89 files changed, 1697 insertions(+), 778 deletions(-)
 create mode 100644 arch/powerpc/configs/pseries_le_defconfig

-- 
1.8.1.2
