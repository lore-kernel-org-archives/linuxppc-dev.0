Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whYQg0fJBzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 11:05:47 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id w1so20236572qtg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 18:05:46 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC PATCH 0/7 v1] powerpc: Memory Protection Keys
Date: Mon,  5 Jun 2017 18:05:02 -0700
Message-Id: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory protection keys enable applications to protect its
address space from inadvertent access or corruption from
itself.

The overall idea:

 A process allocates a   key  and associates it with
 a  address  range  within    its   address   space.
 The process  than  can  dynamically  set read/write 
 permissions on  the   key   without  involving  the 
 kernel. Any  code that  violates   the  permissions
 off the address space; as defined by its associated
 key, will receive a segmentation fault.

This patch series enables the feature on PPC64.
It is enabled on HPTE 64K-page platform.

ISA3.0 section 5.7.13 describes the detailed specifications.

Testing:
	This patch series has passed all the protection key
	tests available in  the selftests directory. Though
	the test are written  for x86, I  have updated  the
	tests to  cater  to  powerpc. Will  send  the patch
	separately, along with documentation updates.

Thanks-to: Dave Hansen, Aneesh, Paul Mackerras,
	   Michael Ellermen  :)

Ram Pai (7):
  Free up four PTE bits to accommadate memory keys
  Implement sys_pkey_alloc and sys_pkey_free system call.
  store and restore the key state across context switches.
  Implementation for sys_mprotect_pkey() system call.
  Program HPTE key protection bits.
  Handle exceptions caused by violation of key protection.
  Deliver SEGV signal on protection key violation.

 arch/powerpc/Kconfig                          |  15 ++
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  12 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  38 ++--
 arch/powerpc/include/asm/book3s/64/hash.h     |   8 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  10 +
 arch/powerpc/include/asm/book3s/64/mmu.h      |  10 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  84 +++++++-
 arch/powerpc/include/asm/mman.h               |  29 +--
 arch/powerpc/include/asm/mmu_context.h        |  12 ++
 arch/powerpc/include/asm/pkeys.h              | 159 +++++++++++++++
 arch/powerpc/include/asm/processor.h          |   5 +
 arch/powerpc/include/asm/reg.h                |  10 +-
 arch/powerpc/include/asm/systbl.h             |   3 +
 arch/powerpc/include/asm/unistd.h             |   6 +-
 arch/powerpc/include/uapi/asm/ptrace.h        |   5 +-
 arch/powerpc/include/uapi/asm/unistd.h        |   3 +
 arch/powerpc/kernel/asm-offsets.c             |   1 +
 arch/powerpc/kernel/exceptions-64s.S          |  10 +-
 arch/powerpc/kernel/process.c                 |  18 ++
 arch/powerpc/kernel/signal_32.c               |  18 +-
 arch/powerpc/kernel/signal_64.c               |  11 ++
 arch/powerpc/kernel/traps.c                   |  49 +++++
 arch/powerpc/mm/Makefile                      |   1 +
 arch/powerpc/mm/dump_linuxpagetables.c        |   3 +-
 arch/powerpc/mm/fault.c                       |  21 +-
 arch/powerpc/mm/hash64_4k.c                   |  12 +-
 arch/powerpc/mm/hash64_64k.c                  |  73 +++----
 arch/powerpc/mm/hash_utils_64.c               |  43 ++++-
 arch/powerpc/mm/hugetlbpage-hash64.c          |  16 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |   5 +
 arch/powerpc/mm/pkeys.c                       | 267 ++++++++++++++++++++++++++
 include/linux/mm.h                            |  32 +--
 include/uapi/asm-generic/mman-common.h        |   2 +-
 33 files changed, 856 insertions(+), 135 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pkeys.h
 create mode 100644 arch/powerpc/mm/pkeys.c

-- 
1.8.3.1
