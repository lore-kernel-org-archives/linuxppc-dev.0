Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDpQr6QMFzDvfv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 14:28:04 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAA3Nesf072978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Nov 2016 22:28:01 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26mc6467ns-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 22:28:01 -0500
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 01:27:59 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 53EC61DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2016 22:27:56 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAA3RuBd5193932
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:27:56 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAA3RsS4019597
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:27:56 -0200
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
Subject: [PATCH v10 00/10] kexec_file_load implementation for PowerPC
Date: Thu, 10 Nov 2016 01:27:19 -0200
Message-Id: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

[ Andrew, you might want to wait until the kexec maintainers say whether
  they agree with patch 4 before picking up this version. ]

v10 addresses two requests from Michael Ellerman: build the
purgatory as a Position Independent Executable binary to reduce the
number of relocation types that we have to deal with, and remove code
that is not strictly necessary from the purgatory. 

The first objective is made possible by patch 4, which is new in this
version and adds the support in generic code that arch-specific code
needs if it wants to use a PIE purgatory. Now it's not necessary
anymore to refactor code in module_64.c to reuse its implementation
of the relocations.

I also added a script which checks purgatory.ro and warns if it has
a relocation type that is not supported.

The second objective is met by removing code for printing messages
to the console. Everything else that is in the purgatory is to implement
the checksum verification of the kexec image.

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

Changes for v10:
- Patch "kexec_file: Add support for purgatory built as PIE."
  - New patch.
- Patch "powerpc: Factor out relocation code in module_64.c"
  - Dropped patch from series.
- Patch "powerpc: Implement kexec_file_load."
  - Made CONFIG_KEXEC_FILE select HAVE_KEXEC_FILE_PIE_PURGATORY.
  - Removed elf_my_r2 and elf_toc_section functions, they aren't necessary
    anymore.
  - Adapted arch_kexec_apply_relocations_add to the absolute addresses found
    in PIE binaries. Apply the relocations in this function instead of
    calling elf64_apply_relocate_add_item (which doesn't exist anymore).
  - No need to change module_64.c anymore.
  - Implemented R_PPC64_RELATIVE relocation.
- Patch "powerpc: Add functions to read ELF files of any endianness."
  - Introduce <asm/elf_util.h> and elf_util.c in this patch.
- Patch "powerpc: Add support for loading ELF kernels with kexec_file_load."
  - Define PURGATORY_ELF_TYPE macro in <asm/kexec.h>.
  - Removed debug argument from the setup_purgatory function.
  - Don't call find_debug_console in elf64_load anymore.
  - Removed function find_debug_console.
  - Find the TOC address by looking for the .got section in setup_purgatory.
  - Don't set the "debug" purgatory symbol (which doesn't exist anymore) in
    setup_purgatory.
- Patch "powerpc: Add purgatory for kexec_file_load implementation."
  - Don't change boot/string.S.
  - Build purgatory as a PIE binary and suppress generation of the INTERP
    segment, which is not meaningful in this case.
  - Add check-purgatory-relocs.sh and call it after building purgatory.ro.
  - Removed console-ppc64.c, hvCall.S, ppc64_asm.h and printf.c.
  - Moved inclusion of <linux/compiler.h> from purgatory.h to
    purgatory-ppc64.c.
  - Removed "debug" global variable from purgatory-ppc64.c.
  - Removed inclusion of "../boot/string.h" from purgatory.c.
  - Removed printf calls from purgatory.c.
  - Included <linux/types.h>, added prototype for memcmp and removed
    prototypes for putchar, sprintf and printf in purgatory.h.
  - Added string.c with code copied from lib/string.c.
  - Removed inclusion of "ppc64_asm.h" and use of DOTSYM macro from v2wrap.S.
  
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

Thiago Jung Bauermann (10):
  kexec_file: Allow arch-specific memory walking for kexec_add_buffer
  kexec_file: Change kexec_add_buffer to take kexec_buf as argument.
  kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.
  kexec_file: Add support for purgatory built as PIE.
  powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE
    instead.
  powerpc: Implement kexec_file_load.
  powerpc: Add functions to read ELF files of any endianness.
  powerpc: Add support for loading ELF kernels with kexec_file_load.
  powerpc: Add purgatory for kexec_file_load implementation.
  powerpc: Enable CONFIG_KEXEC_FILE in powerpc server defconfigs.

 arch/Kconfig                                   |  11 +
 arch/powerpc/Kconfig                           |  16 +-
 arch/powerpc/Makefile                          |   1 +
 arch/powerpc/configs/powernv_defconfig         |   2 +
 arch/powerpc/configs/ppc64_defconfig           |   2 +
 arch/powerpc/configs/pseries_defconfig         |   2 +
 arch/powerpc/include/asm/debug.h               |   2 +-
 arch/powerpc/include/asm/elf_util.h            |  43 ++
 arch/powerpc/include/asm/kexec.h               |  18 +-
 arch/powerpc/include/asm/machdep.h             |   4 +-
 arch/powerpc/include/asm/smp.h                 |   2 +-
 arch/powerpc/include/asm/systbl.h              |   1 +
 arch/powerpc/include/asm/unistd.h              |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h         |   1 +
 arch/powerpc/kernel/Makefile                   |   6 +-
 arch/powerpc/kernel/elf_util.c                 | 437 +++++++++++++++++++
 arch/powerpc/kernel/head_64.S                  |   2 +-
 arch/powerpc/kernel/kexec_elf_64.c             | 279 ++++++++++++
 arch/powerpc/kernel/machine_kexec_file_64.c    | 578 +++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S                  |   2 +-
 arch/powerpc/kernel/misc_64.S                  |   6 +-
 arch/powerpc/kernel/prom.c                     |   2 +-
 arch/powerpc/kernel/setup_64.c                 |   4 +-
 arch/powerpc/kernel/smp.c                      |   6 +-
 arch/powerpc/kernel/traps.c                    |   2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c  |   2 +-
 arch/powerpc/platforms/85xx/smp.c              |   8 +-
 arch/powerpc/platforms/cell/spu_base.c         |   2 +-
 arch/powerpc/platforms/powernv/setup.c         |   6 +-
 arch/powerpc/platforms/ps3/setup.c             |   4 +-
 arch/powerpc/platforms/pseries/Makefile        |   2 +-
 arch/powerpc/platforms/pseries/setup.c         |   4 +-
 arch/powerpc/purgatory/.gitignore              |   2 +
 arch/powerpc/purgatory/Makefile                |  40 ++
 arch/powerpc/purgatory/crtsavres.S             |   5 +
 arch/powerpc/purgatory/kexec-sha256.h          |  11 +
 arch/powerpc/purgatory/purgatory-ppc64.c       |  36 ++
 arch/powerpc/purgatory/purgatory.c             |  48 ++
 arch/powerpc/purgatory/purgatory.h             |  10 +
 arch/powerpc/purgatory/sha256.c                |   6 +
 arch/powerpc/purgatory/sha256.h                |   1 +
 arch/powerpc/purgatory/string.c                |  60 +++
 arch/powerpc/purgatory/v2wrap.S                | 132 ++++++
 arch/powerpc/scripts/check-purgatory-relocs.sh |  47 ++
 arch/x86/kernel/crash.c                        |  37 +-
 arch/x86/kernel/kexec-bzimage64.c              |  48 +-
 include/linux/kexec.h                          |  40 +-
 kernel/kexec_file.c                            | 413 +++++++++++++-----
 kernel/kexec_internal.h                        |  16 -
 49 files changed, 2197 insertions(+), 214 deletions(-)
 create mode 100644 arch/powerpc/include/asm/elf_util.h
 create mode 100644 arch/powerpc/kernel/elf_util.c
 create mode 100644 arch/powerpc/kernel/kexec_elf_64.c
 create mode 100644 arch/powerpc/kernel/machine_kexec_file_64.c
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/crtsavres.S
 create mode 100644 arch/powerpc/purgatory/kexec-sha256.h
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.c
 create mode 100644 arch/powerpc/purgatory/purgatory.c
 create mode 100644 arch/powerpc/purgatory/purgatory.h
 create mode 100644 arch/powerpc/purgatory/sha256.c
 create mode 100644 arch/powerpc/purgatory/sha256.h
 create mode 100644 arch/powerpc/purgatory/string.c
 create mode 100644 arch/powerpc/purgatory/v2wrap.S
 create mode 100755 arch/powerpc/scripts/check-purgatory-relocs.sh

-- 
2.7.4
