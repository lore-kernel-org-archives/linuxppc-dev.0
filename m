Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 Ulrich.Weigand@de.ibm.com, alistair@popple.id.au
Subject: [PATCH 0/9] ppc64 little endian updates
Date: Wed, 20 Nov 2013 22:14:57 +1100
Message-Id: <1384946106-18200-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series adds support for the new ABI, LPAR support
for H_SET_MODE and finally adds a kconfig option and defconfig.

ABIv2 support was recently committed to binutils and gcc, and
should be merged into glibc soon. There are a number of
very nice improvements including the removal of function
descriptors. Rusty's kernel patches allow binaries of either
ABI to work, easing the transition.

Alistair Popple (1):
  powerpc: Don't use ELFv2 ABI to build the kernel

Anton Blanchard (4):
  powerpc/pseries: Fix endian issues in pseries EEH code
  pseries: Add H_SET_MODE to change exception endianness
  powerpc: Add CONFIG_CPU_LITTLE_ENDIAN kernel config option.
  powerpc: Add pseries_le_defconfig

Rusty Russell (4):
  powerpc: Add TIF_ELF2ABI flag.
  powerpc: Set eflags correctly for ELF ABIv2 core dumps.
  powerpc: ELF2 binaries launched directly.
  powerpc: ELF2 binaries signal handling

 arch/powerpc/Makefile                        |   1 +
 arch/powerpc/configs/pseries_le_defconfig    | 352 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/elf.h               |   4 +
 arch/powerpc/include/asm/hvcall.h            |   2 +
 arch/powerpc/include/asm/plpar_wrappers.h    |  26 ++
 arch/powerpc/include/asm/thread_info.h       |   9 +
 arch/powerpc/kernel/process.c                |  50 ++--
 arch/powerpc/kernel/signal_64.c              |  25 +-
 arch/powerpc/platforms/Kconfig.cputype       |  11 +
 arch/powerpc/platforms/pseries/eeh_pseries.c |  21 +-
 arch/powerpc/platforms/pseries/lpar.c        |  17 ++
 arch/powerpc/platforms/pseries/setup.c       |  42 ++++
 12 files changed, 527 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/configs/pseries_le_defconfig

-- 
1.8.3.2
