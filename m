Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0VKV5n4vzDvYt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 13:40:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9L2d5tw140443
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:40:44 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2675yh0qnv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:40:44 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 21 Oct 2016 00:40:41 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9B721352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 22:40:13 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9L2eeUn24969470
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:40:40 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9L2ecAC005415
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 00:40:39 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v9 00/10] kexec_file_load implementation for PowerPC
Date: Fri, 21 Oct 2016 00:40:07 -0200
Message-Id: <1477017617-8540-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This version has the following changes:

1. Rebased on v4.9-rc1. This should fix the conflicts in next and -mm
   that these patches were having with the s/CONFIG_WORD_SIZE/BITS/ change.

2. Changed patch "powerpc: Factor out relocation code in module_64.c" to
   make as little changes as possible to arch/powerpc/module_64.c and
   <asm/module.h>. This meant factoring out only the switch statement from
   apply_relocate_add into its own function, and keeping it in module_64.c.
   arch_kexec_apply_relocations_add and apply_relocate_add share a bit less
   code now. This addresses a concern expressed by Michael Ellerman that
   there were too many changes being made to the module loading code.

3. Reduced number of patches in the series by squashing one patch and
   redistributing the code in two other patches. They were smaller after
   the change above and didn't make that much sense on their own anymore.

4. Moved code implementing kexec_file_load to a new file instead of adding
   it to the existing arch/powerpc/machine_kexec_64.c.

5. Cleaned up the purgatory code a bit to fix checkpatch warnings: removed
   unused code related to crashdump support and added __section(".data")
   to global variables instead of initializing them to zero to avoid them
   going to .bss.

The changes in 3. and 4. made the patches somewhat different from v8 but
it's just code moving from one patch to another, or to a new file. Apart
from what is described in 2. and 5., there's very little actual code
changed. The patches are all bisectable, each one was tested with
several kernel configs.

The gory details are in the detailed changelog at the end of this email.

Original cover letter:

This patch series implements the kexec_file_load system call on PowerPC.

This system call moves the reading of the kernel, initrd and the device tree
from the userspace kexec tool to the kernel. This is needed if you want to
do one or both of the following:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel
   command line and other boot inputs for the Integrity Measurement
   Architecture subsystem.

The above are the functions kexec already has built into kexec_file_load.
Yesterday I posted a set of patches which allows a third feature:

3. have IMA pass-on its event log (where integrity measurements are
   registered) accross kexec to the second kernel, so that the event
   history is preserved.

Because OpenPower uses an intermediary Linux instance as a boot loader
(skiroot), feature 1 is needed to implement secure boot for the platform,
while features 2 and 3 are needed to implement trusted boot.

This patch series starts by removing an x86 assumption from kexec_file:
kexec_add_buffer uses iomem to find reserved memory ranges, but PowerPC
uses the memblock subsystem.  A hook is added so that each arch can
specify how memory ranges can be found.

Also, the memory-walking logic in kexec_add_buffer is useful in this
implementation to find a free area for the purgatory's stack, so the
next patch moves that logic to kexec_locate_mem_hole.

The kexec_file_load system call needs to apply relocations to the
purgatory but adding code for that would duplicate functionality with
the module loading mechanism, which also needs to apply relocations to
the kernel modules.  Therefore, this patch series factors out the module
relocation code so that it can be shared.

One thing that is still missing is crashkernel support, which I intend
to submit shortly. For now, arch_kexec_kernel_image_probe rejects crash
kernels.

This code is based on kexec-tools, but with many modifications to adapt
it to the kernel environment and facilities. Except the purgatory,
which only has minimal changes.

Changes for v9:
- Rebased on top of v4.9-rc1
- Patch "powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE instead."
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
- Patch "powerpc: Factor out relocation code from module_64.c to elf_util_64.c."
  - Retitled to "powerpc: Factor out relocation code in module_64.c"
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
  - Put relocation code in function elf64_apply_relocate_add_item in
    module_64.c itself instead of moving it to elf_util_64.c.
  - Only factored out the switch statement to apply the relocations
    instead of the whole logic to iterate through all of the relocations.
  - There's no elf_util_64.c anymore.
  - Doesn't change <asm/module.h> anymore.
  - Doesn't change arch/powerpc/kernel/Makefile anymore.
  - Moved creation of <asm/elf_util.h> to patch "Implement kexec_file_load."
- Patch "powerpc: Generalize elf64_apply_relocate_add."
  - Dropped patch from series.
  - Moved changes adding address variable to patch "powerpc: Implement
    kexec_file_load."
- Patch "powerpc: Adapt elf64_apply_relocate_add for kexec_file_load."
  - Dropped patch from series.
  - Moved new relocs needed by the purgatory to patch "powerpc: Implement
    kexec_file_load."
- Patch "powerpc: Implement kexec_file_load."
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
  - Put code in a new file machine_kexec_file_64.c instead of adding it to
    machine_kexec_64.c.
  - arch_kexec_apply_relocations_add now has the for loop which was
    previously factored out in elf64_apply_relocate_add.
  - Moved definition of setup_purgatory to "powerpc: Add support for
    loading ELF kernels with kexec_file_load.".
  - Introduce <asm/elf_util.h> and elf_util.c in this patch.
  - Only build elf_util.c if CONFIG_KEXEC_FILE=y.
  - Renamed my_r2 to elf_my_r2 and changed it to receive a pointer to
    struct elf_shdr instead of struct elf_info.
  - Added toc_section function.
  - Removed elf_init_elf_info function.
- Patch "powerpc: Add functions to read ELF files of any endianness."
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
  - Introduce struct elf_info in this patch.
  - Removed stubs_section and toc_section from struct elf_info.
  - Doesn't change arch/powerpc/kernel/Makefile anymore.
- Patch "powerpc: Add code to work with device trees in kexec_file_load."
  - Squashed into "powerpc: Add support for loading ELF kernels with
    kexec_file_load.". The code is unchanged.
- Patch "powerpc: Add support for loading ELF kernels with kexec_file_load."
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
  - Fixed uninitialized variable warning when building with GCC 4.6.3.
  - Don't create <asm/kexec_elf_64.h> anymore, put declaration of
    kexec_el_64_ops in <asm/kexec.h> instead.
  - Removed unused extern declaration of kexec_purgatory_size.
  - Made elf64_load static.
  - Factor out delete_fdt_mem_rsv from setup_new_fdt. This change was in
    the patch series for preserving IMA measurements accross kexec.
- Patch "powerpc: Add purgatory for kexec_file_load implementation."
  - Fixed conflict with patch renaming CONFIG_WORD_SIZE to BITS.
  - Changed purgatory Makefile to use the kernel KBUILD_CFLAGS, filtering
    out the flags for ftrace. (Michael Ellerman)
  - Added extern declaration of the debug global variable to purgatory.h and
    included it in console-ppc64.c to fix checkpatch.pl warning.
  - Added __section attribute to global variables in purgatory-ppc64.c and
    don't initialize them to zero, to fix checkpatch.pl warning.
  - Fixed type of debug global variable to int instead of unsigned int.
  - Included <linux/compiler.h> in purgatory.h and use __printf macro to
    fix checkpatch.pl warning.
  - Removed crashdump-ppc64.h, crashdump_backup.c and purgatory-ppc64.h.

Changes for v8:
- Rebased on top of v4.8-rc5.
- Patch "powerpc: Add purgatory for kexec_file_load implementation."
  - Fix cross build from ppc64 LE to BE and vice-versa.
  - Don't build the purgatory during archprepare.

Changes for v7:
- Rebased on top of v4.8-rc4.
- Patch "powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE
  instead."
  - New patch. Fixes build when CONFIG_KEXEC=n and CONFIG_KEXEC_FILE=y.
- Patch "powerpc: Adapt elf64_apply_relocate_add for kexec_file_load."
  - Fixed checkpatch warning "else is not generally useful after a break
    or return".
  - Fixed checkpatch warnings about line length. (Andrew Morton)
- Patch "powerpc: Add code to work with device trees in kexec_file_load."
  - Remove space before tabs in doc comment for setup_new_fdt. (Andrew Morton)
  - Fixed checkpatch warnings about line length.
- Patch "powerpc: Add support for loading ELF kernels with kexec_file_load."
  - Removed duplicate #include <linux/kexec.h>.

Changes for v6:
- Based directly on top of v4.8-rc1.
- Patch "powerpc: Adapt elf64_apply_relocate_add for kexec_file_load."
  - Allow undefined symbols if they are relocations for the TOC in the
    big endian ABI.
  - Fixed build error in this patch by adding the ehdr member to elf_info
    here instead of in the next patch.
  - Initialize elf_info.ehdr in module_64.c:module_frob_arch_sections.
- Patch "powerpc: Add code to work with device trees in kexec_file_load."
  - Changed find_debug_console to look for /chosen instead of receiving
    its offset as an argument.
  - setup_new_fdt: no need to find /chosen again after deleting the memory
    reservation for initrd.
- Patch "powerpc: Add support for loading ELF kernels with kexec_file_load."
  - Don't pass the offset to /chosen to find_debug_console.
- Patch "powerpc: Allow userspace to set device tree properties in kexec_file_load"
  - Dropped patch.
- Patch "powerpc: Add purgatory for kexec_file_load implementation."
  - Make boot/string.S use the DOTSYM macro so that it can be
    used by the ppc64 big endian purgatory.
  - Use -mcall-aixdesc to compile the purgatory on big endian ppc64.

Changes for v5:
- Rebased series on v4.8-rc1 + the extend kexec_file_load series.
- Patch "powerpc: Adapt elf64_apply_relocate_add for kexec_file_load."
  - New patch. These changes were previously in patch 10.
    The code itself is unchanged from v4.
- Patch "powerpc: Implement kexec_file_load."
  - Moved arch_kexec_walk_mem, arch_kexec_apply_relocations_add and
    setup_purgatory from patch 10 to this patch.
  - arch_kexec_apply_relocations_add is unchanged from v4.
  - Fixed off-by-one error in arch_kexec_walk_mem when passing range
    to func.
  - Moved setup_purgatory from kexec_elf_64.c to machine_kexec_64.c,
    and changed it to receive a pointer to the slave code directly
    rather than a struct elf_info and getting the pointer from there.
- Patch "powerpc: Add code to work with device trees in kexec_file_load."
  - New patch. These changes were previously in patch 10.
  - find_debug_console moved from kexec_elf_64.c to machine_kexec_64.c.
    The code is unchanged from v4.
  - setup_new_fdt is a new function factored out of elf64_load. The only
    code change from v4 is to create /chosen if it doesn't exist yet.
- Patch "powerpc: Add support for loading ELF kernels with kexec_file_load."
  - This patch was too big, so moved some of its changes to other patches
    to facilitate review.
  - Allow loading ELF file type ET_DYN, which is what the BE kernel uses.
  - The code adapting the device tree for booting the new kernel was moved
    out of elf64_load to setup_new_fdt.
- Patch "powerpc: Allow userspace to set device tree properties in kexec_file_load"
  - New patch.
  - The code in this patch didn't exist in v4.
  - This is the only patch that depends on the extend kexec_file_load series.
- Patch "powerpc: Enable CONFIG_KEXEC_FILE in powerpc server defconfigs."
  - New patch.


Thiago Jung Bauermann (10):
  kexec_file: Allow arch-specific memory walking for kexec_add_buffer
  kexec_file: Change kexec_add_buffer to take kexec_buf as argument.
  kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.
  powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE
    instead.
  powerpc: Factor out relocation code in module_64.c
  powerpc: Implement kexec_file_load.
  powerpc: Add functions to read ELF files of any endianness.
  powerpc: Add support for loading ELF kernels with kexec_file_load.
  powerpc: Add purgatory for kexec_file_load implementation.
  powerpc: Enable CONFIG_KEXEC_FILE in powerpc server defconfigs.

 arch/powerpc/Kconfig                          |  15 +-
 arch/powerpc/Makefile                         |   1 +
 arch/powerpc/boot/string.S                    |  67 +--
 arch/powerpc/configs/powernv_defconfig        |   2 +
 arch/powerpc/configs/ppc64_defconfig          |   2 +
 arch/powerpc/configs/pseries_defconfig        |   2 +
 arch/powerpc/include/asm/debug.h              |   2 +-
 arch/powerpc/include/asm/elf_util.h           |  64 +++
 arch/powerpc/include/asm/kexec.h              |  18 +-
 arch/powerpc/include/asm/machdep.h            |   4 +-
 arch/powerpc/include/asm/smp.h                |   2 +-
 arch/powerpc/include/asm/systbl.h             |   1 +
 arch/powerpc/include/asm/unistd.h             |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h        |   1 +
 arch/powerpc/kernel/Makefile                  |   6 +-
 arch/powerpc/kernel/elf_util.c                | 464 +++++++++++++++++++++
 arch/powerpc/kernel/head_64.S                 |   2 +-
 arch/powerpc/kernel/kexec_elf_64.c            | 280 +++++++++++++
 arch/powerpc/kernel/machine_kexec_file_64.c   | 579 ++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S                 |   2 +-
 arch/powerpc/kernel/misc_64.S                 |   6 +-
 arch/powerpc/kernel/module_64.c               | 383 ++++++++++-------
 arch/powerpc/kernel/prom.c                    |   2 +-
 arch/powerpc/kernel/setup_64.c                |   4 +-
 arch/powerpc/kernel/smp.c                     |   6 +-
 arch/powerpc/kernel/traps.c                   |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c |   2 +-
 arch/powerpc/platforms/85xx/smp.c             |   8 +-
 arch/powerpc/platforms/cell/spu_base.c        |   2 +-
 arch/powerpc/platforms/powernv/setup.c        |   6 +-
 arch/powerpc/platforms/ps3/setup.c            |   4 +-
 arch/powerpc/platforms/pseries/Makefile       |   2 +-
 arch/powerpc/platforms/pseries/setup.c        |   4 +-
 arch/powerpc/purgatory/.gitignore             |   2 +
 arch/powerpc/purgatory/Makefile               |  33 ++
 arch/powerpc/purgatory/console-ppc64.c        |  37 ++
 arch/powerpc/purgatory/crtsavres.S            |   5 +
 arch/powerpc/purgatory/hvCall.S               |  27 ++
 arch/powerpc/purgatory/hvCall.h               |   8 +
 arch/powerpc/purgatory/kexec-sha256.h         |  11 +
 arch/powerpc/purgatory/ppc64_asm.h            |  20 +
 arch/powerpc/purgatory/printf.c               | 164 ++++++++
 arch/powerpc/purgatory/purgatory-ppc64.c      |  36 ++
 arch/powerpc/purgatory/purgatory.c            |  62 +++
 arch/powerpc/purgatory/purgatory.h            |  14 +
 arch/powerpc/purgatory/sha256.c               |   6 +
 arch/powerpc/purgatory/sha256.h               |   1 +
 arch/powerpc/purgatory/string.S               |   2 +
 arch/powerpc/purgatory/v2wrap.S               | 134 ++++++
 arch/x86/kernel/crash.c                       |  37 +-
 arch/x86/kernel/kexec-bzimage64.c             |  48 ++-
 include/linux/kexec.h                         |  36 +-
 kernel/kexec_file.c                           | 141 ++++---
 kernel/kexec_internal.h                       |  16 -
 54 files changed, 2437 insertions(+), 350 deletions(-)
 create mode 100644 arch/powerpc/include/asm/elf_util.h
 create mode 100644 arch/powerpc/kernel/elf_util.c
 create mode 100644 arch/powerpc/kernel/kexec_elf_64.c
 create mode 100644 arch/powerpc/kernel/machine_kexec_file_64.c
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/console-ppc64.c
 create mode 100644 arch/powerpc/purgatory/crtsavres.S
 create mode 100644 arch/powerpc/purgatory/hvCall.S
 create mode 100644 arch/powerpc/purgatory/hvCall.h
 create mode 100644 arch/powerpc/purgatory/kexec-sha256.h
 create mode 100644 arch/powerpc/purgatory/ppc64_asm.h
 create mode 100644 arch/powerpc/purgatory/printf.c
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.c
 create mode 100644 arch/powerpc/purgatory/purgatory.c
 create mode 100644 arch/powerpc/purgatory/purgatory.h
 create mode 100644 arch/powerpc/purgatory/sha256.c
 create mode 100644 arch/powerpc/purgatory/sha256.h
 create mode 100644 arch/powerpc/purgatory/string.S
 create mode 100644 arch/powerpc/purgatory/v2wrap.S

-- 
2.7.4
