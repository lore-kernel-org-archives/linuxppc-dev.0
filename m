Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSkjP375SzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 08:21:44 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u85MHkR3004890
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 18:21:42 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 259d2r7us6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 18:21:42 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 5 Sep 2016 19:21:39 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id B7CA2352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 18:21:15 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u85MLc6n4927610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:38 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u85MLbDJ015290
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 19:21:38 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v8 00/13] kexec_file_load implementation for PowerPC
Date: Mon,  5 Sep 2016 19:20:01 -0300
Message-Id: <1473114014-20769-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When Stephen Rothwell added this patch series to the linux-next tree,
he found out that it fails to cross build a ppc64 LE kernel using a
ppc64 BE host. This version of the series fixes that problem with a
change in arch/powerpc/purgatory/Makefile.

While I was at it I noticed that it is not necessary to build the
purgatory during archprepare, so I was able to simplify the changes to
arch/powerpc/Makefile. Both changes are in patch 12. It is the only
patch that changed relative to v7, all others are exactly the same.

I tested building (and booting the resulting kernel) natively on ppc64 LE
and BE, cross-building from ppc64 BE to LE and vice-versa, and from x86 to
ppc64 LE and BE.

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

Changes for v4:
- Rebased series on today's powerpc/next.
- Patch "kexec_file: Remove unused members from struct kexec_buf.":
    - Dropped from the series.
- Patch "kexec_file: Allow arch-specific memory walking function for
  kexec_add_buffer":
    - Changed subject line to be more specific. Was: "kexec_file: Generalize
      kexec_add_buffer.".
    - Changed description to refer to x86 arch instead of Intel arch.
    - Moved documentation comments for struct kexec_buf to this patch.
- Patch "kexec_file: Change kexec_add_buffer to take kexec_buf as argument.":
    - New patch.
- Patch "kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.":
    - Changed kexec_locate_mem_hole to take kexec_buf as argument.
    - Improved description of kexec_locate_mem_hole in documentation comment.

Changes for v3:
- Rebased series on today's powerpc/next.
- Patch "kexec_file: Generalize kexec_add_buffer.":
    - Removed most arguments from arch_kexec_walk_mem and pass kbuf
      explicitly.
- Patch "powerpc: Add functions to read ELF files of any endianness.":
    - Fixed whitespace issues found by checkpatch.pl.
- Patch "powerpc: Factor out relocation code from module_64.c to
  elf_util_64.c.":
    - Changed to use the new PPC64_ELF_ABI_v2 macro.
- Patch "powerpc: Add support for loading ELF kernels with
  kexec_file_load.":
    - Adapted arch_kexec_walk_mem implementation to changes in its
      argument list.
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
- Patch "powerpc: Add purgatory for kexec_file_load implementation.":
    - Fixed whitespace and GPL header issues found by checkpatch.pl.
    - Changed to use the new PPC64_ELF_ABI_v2 macro.

Changes for v2:
- All patches: forgot to add Signed-off-by lines in v1, so added them now.
- Patch "kexec_file: Generalize kexec_add_buffer.": broke in two, one
  adding arch_kexec_walk_mem and the other adding kexec_locate_mem_hole.
- Patch "powerpc: Implement kexec_file_load.":
    - Moved relocation changes and the arch_kexec_walk_mem implementation
      to the next patch in the series.
    - Removed pr_fmt from machine_kexec_64.c, since the patch doesn't add
      any call to pr_debug in that file.
    - Changed arch_kexec_kernel_image_probe to reject crash kernels.


Thiago Jung Bauermann (13):
  kexec_file: Allow arch-specific memory walking for kexec_add_buffer
  kexec_file: Change kexec_add_buffer to take kexec_buf as argument.
  kexec_file: Factor out kexec_locate_mem_hole from kexec_add_buffer.
  powerpc: Change places using CONFIG_KEXEC to use CONFIG_KEXEC_CORE
    instead.
  powerpc: Factor out relocation code from module_64.c to elf_util_64.c.
  powerpc: Generalize elf64_apply_relocate_add.
  powerpc: Adapt elf64_apply_relocate_add for kexec_file_load.
  powerpc: Add functions to read ELF files of any endianness.
  powerpc: Implement kexec_file_load.
  powerpc: Add code to work with device trees in kexec_file_load.
  powerpc: Add support for loading ELF kernels with kexec_file_load.
  powerpc: Add purgatory for kexec_file_load implementation.
  powerpc: Enable CONFIG_KEXEC_FILE in powerpc server defconfigs.

 arch/powerpc/Kconfig                          |  15 +-
 arch/powerpc/Makefile                         |   1 +
 arch/powerpc/boot/string.S                    |  67 ++--
 arch/powerpc/configs/powernv_defconfig        |   2 +
 arch/powerpc/configs/ppc64_defconfig          |   2 +
 arch/powerpc/configs/pseries_defconfig        |   2 +
 arch/powerpc/include/asm/debug.h              |   2 +-
 arch/powerpc/include/asm/elf_util.h           |  92 +++++
 arch/powerpc/include/asm/kexec.h              |  16 +-
 arch/powerpc/include/asm/kexec_elf_64.h       |  10 +
 arch/powerpc/include/asm/machdep.h            |   4 +-
 arch/powerpc/include/asm/module.h             |  14 +-
 arch/powerpc/include/asm/smp.h                |   2 +-
 arch/powerpc/include/asm/systbl.h             |   1 +
 arch/powerpc/include/asm/unistd.h             |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h        |   1 +
 arch/powerpc/kernel/Makefile                  |  11 +-
 arch/powerpc/kernel/elf_util.c                | 476 ++++++++++++++++++++++++++
 arch/powerpc/kernel/elf_util_64.c             | 376 ++++++++++++++++++++
 arch/powerpc/kernel/head_64.S                 |   2 +-
 arch/powerpc/kernel/kexec_elf_64.c            | 282 +++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c        | 476 ++++++++++++++++++++++++++
 arch/powerpc/kernel/misc_32.S                 |   2 +-
 arch/powerpc/kernel/misc_64.S                 |   6 +-
 arch/powerpc/kernel/module_64.c               | 329 +++---------------
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
 arch/powerpc/purgatory/Makefile               |  48 +++
 arch/powerpc/purgatory/console-ppc64.c        |  38 ++
 arch/powerpc/purgatory/crashdump-ppc64.h      |  42 +++
 arch/powerpc/purgatory/crashdump_backup.c     |  36 ++
 arch/powerpc/purgatory/crtsavres.S            |   5 +
 arch/powerpc/purgatory/hvCall.S               |  27 ++
 arch/powerpc/purgatory/hvCall.h               |   8 +
 arch/powerpc/purgatory/kexec-sha256.h         |  11 +
 arch/powerpc/purgatory/ppc64_asm.h            |  20 ++
 arch/powerpc/purgatory/printf.c               | 164 +++++++++
 arch/powerpc/purgatory/purgatory-ppc64.c      |  41 +++
 arch/powerpc/purgatory/purgatory-ppc64.h      |   6 +
 arch/powerpc/purgatory/purgatory.c            |  62 ++++
 arch/powerpc/purgatory/purgatory.h            |  11 +
 arch/powerpc/purgatory/sha256.c               |   6 +
 arch/powerpc/purgatory/sha256.h               |   1 +
 arch/powerpc/purgatory/string.S               |   2 +
 arch/powerpc/purgatory/v2wrap.S               | 134 ++++++++
 arch/x86/kernel/crash.c                       |  37 +-
 arch/x86/kernel/kexec-bzimage64.c             |  48 +--
 include/linux/kexec.h                         |  36 +-
 kernel/kexec_file.c                           | 141 ++++----
 kernel/kexec_internal.h                       |  16 -
 60 files changed, 2705 insertions(+), 472 deletions(-)
 create mode 100644 arch/powerpc/include/asm/elf_util.h
 create mode 100644 arch/powerpc/include/asm/kexec_elf_64.h
 create mode 100644 arch/powerpc/kernel/elf_util.c
 create mode 100644 arch/powerpc/kernel/elf_util_64.c
 create mode 100644 arch/powerpc/kernel/kexec_elf_64.c
 create mode 100644 arch/powerpc/purgatory/.gitignore
 create mode 100644 arch/powerpc/purgatory/Makefile
 create mode 100644 arch/powerpc/purgatory/console-ppc64.c
 create mode 100644 arch/powerpc/purgatory/crashdump-ppc64.h
 create mode 100644 arch/powerpc/purgatory/crashdump_backup.c
 create mode 100644 arch/powerpc/purgatory/crtsavres.S
 create mode 100644 arch/powerpc/purgatory/hvCall.S
 create mode 100644 arch/powerpc/purgatory/hvCall.h
 create mode 100644 arch/powerpc/purgatory/kexec-sha256.h
 create mode 100644 arch/powerpc/purgatory/ppc64_asm.h
 create mode 100644 arch/powerpc/purgatory/printf.c
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.c
 create mode 100644 arch/powerpc/purgatory/purgatory-ppc64.h
 create mode 100644 arch/powerpc/purgatory/purgatory.c
 create mode 100644 arch/powerpc/purgatory/purgatory.h
 create mode 100644 arch/powerpc/purgatory/sha256.c
 create mode 100644 arch/powerpc/purgatory/sha256.h
 create mode 100644 arch/powerpc/purgatory/string.S
 create mode 100644 arch/powerpc/purgatory/v2wrap.S

-- 
1.9.1
