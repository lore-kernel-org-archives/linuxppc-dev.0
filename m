Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rS1Bk3LDKzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 13:10:53 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5C38iMW084608
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:50 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gcybfwk5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:50 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Sun, 12 Jun 2016 00:10:47 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id A6DD3352005C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 23:10:28 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5C3Aivn29032834
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:10:44 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5C3AiSP029563
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jun 2016 00:10:44 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/8] kexec_file_load implementation for PowerPC
Date: Sun, 12 Jun 2016 00:10:14 -0300
Message-Id: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This patch series implements the kexec_file_load system call on PowerPC.

It starts by removing an x86 assumption from kexec_file: kexec_add_buffer uses
iomem to find reserved memory ranges, but PowerPC uses the memblock subsystem.
Hooks are added so that each arch can specify how memory ranges can be found.

Also, the memory-walking logic in kexec_add_buffer is useful in this
implementation to find a free area for the purgatory's stack, so that same
patch moves that logic to kexec_locate_mem_hole.

The kexec_file_load system call needs to apply relocations to the purgatory
but adding code for that would duplicate functionality with the module loading
mechanism, which also needs to apply relocations to the kernel modules.
Therefore, this patch series factors out the module relocation code so that it
can be shared.

One thing that is still missing is crashkernel support, which I intend to
submit shortly.

This code is based on kexec-tools, but with many modifications to adapt it to
the kernel environment and facilities. Except the purgatory, which only has
minimal changes.

Thiago Jung Bauermann (8):
  kexec_file: Remove unused members from struct kexec_buf.
  kexec_file: Generalize kexec_add_buffer.
  powerpc: Factor out relocation code from module_64.c to elf_util_64.c.
  powerpc: Generalize elf64_apply_relocate_add.
  powerpc: Add functions to read ELF files of any endianness.
  powerpc: Implement kexec_file_load.
  powerpc: Add support for loading ELF kernels with kexec_file_load.
  powerpc: Add purgatory for kexec_file_load implementation.

 arch/powerpc/Kconfig                      |  13 +
 arch/powerpc/Makefile                     |   4 +
 arch/powerpc/include/asm/elf_util.h       |  92 +++++
 arch/powerpc/include/asm/kexec_elf_64.h   |  10 +
 arch/powerpc/include/asm/module.h         |  14 +-
 arch/powerpc/include/asm/systbl.h         |   1 +
 arch/powerpc/include/asm/unistd.h         |   2 +-
 arch/powerpc/include/uapi/asm/unistd.h    |   1 +
 arch/powerpc/kernel/Makefile              |   7 +
 arch/powerpc/kernel/elf_util.c            | 476 +++++++++++++++++++++++++
 arch/powerpc/kernel/elf_util_64.c         | 373 ++++++++++++++++++++
 arch/powerpc/kernel/kexec_elf_64.c        | 564 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c    | 142 ++++++++
 arch/powerpc/kernel/module_64.c           | 328 +++--------------
 arch/powerpc/purgatory/.gitignore         |   2 +
 arch/powerpc/purgatory/Makefile           |  36 ++
 arch/powerpc/purgatory/console-ppc64.c    |  43 +++
 arch/powerpc/purgatory/crashdump-ppc64.h  |  42 +++
 arch/powerpc/purgatory/crashdump_backup.c |  40 +++
 arch/powerpc/purgatory/crtsavres.S        |   5 +
 arch/powerpc/purgatory/hvCall.S           |  27 ++
 arch/powerpc/purgatory/hvCall.h           |   8 +
 arch/powerpc/purgatory/kexec-sha256.h     |  11 +
 arch/powerpc/purgatory/ppc64_asm.h        |  18 +
 arch/powerpc/purgatory/printf.c           | 171 +++++++++
 arch/powerpc/purgatory/purgatory-ppc64.c  |  46 +++
 arch/powerpc/purgatory/purgatory-ppc64.h  |   6 +
 arch/powerpc/purgatory/purgatory.c        |  66 ++++
 arch/powerpc/purgatory/purgatory.h        |  11 +
 arch/powerpc/purgatory/sha256.c           |   6 +
 arch/powerpc/purgatory/sha256.h           |   1 +
 arch/powerpc/purgatory/string.S           |   1 +
 arch/powerpc/purgatory/v2wrap.S           | 139 ++++++++
 include/linux/kexec.h                     |  10 +
 kernel/kexec_file.c                       | 102 ++++--
 kernel/kexec_internal.h                   |   2 -
 36 files changed, 2504 insertions(+), 316 deletions(-)
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
