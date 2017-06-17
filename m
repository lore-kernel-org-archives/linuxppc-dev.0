Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqNcb1KblzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 13:53:03 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id d14so893779qkb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 20:53:03 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC v2 00/12] powerpc: Memory Protection Keys
Date: Fri, 16 Jun 2017 20:52:32 -0700
Message-Id: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
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
	tests available in  the selftests directory.
	The tests are updated to work on both x86 and powerpc.


version v2:
	(1) documentation and selftest added
 	(2) fixed a bug in 4k hpte backed 64k pte where page
	    invalidation was not done correctly, and 
	    initialization of second-part-of-the-pte was not
	    done correctly if the pte was not yet Hashed
	    with a hpte.  Reported by Aneesh.
	(3) Fixed ABI breakage caused in siginfo structure.
		Reported by Anshuman.
	
	Outstanding known issue:
	  Calls to sys_swapcontext with a made-up context will end 
	  up with a crap AMR if done by code who didn't know about
	  that register. -- Reported by Ben.

version v1: Initial version

Thanks-to: Dave Hansen, Aneesh, Paul Mackerras,
	   Michael Ellermen


Ram Pai (12):
  Free up four 64K PTE bits in 4K backed hpte pages.
  Free up four 64K PTE bits in 64K backed hpte pages.
  Implement sys_pkey_alloc and sys_pkey_free system call.
  store and restore the pkey state across context switches.
  Implementation for sys_mprotect_pkey() system call.
  Program HPTE key protection bits.
  Macro the mask used for checking DSI exception
  Handle exceptions caused by violation of pkey protection.
  Deliver SEGV signal on pkey violation.
  Read AMR only if pkey-violation caused the exception.
  Documentation updates.
  Updated protection key selftest

 Documentation/vm/protection-keys.txt          |  110 ++
 Documentation/x86/protection-keys.txt         |   85 --
 arch/powerpc/Kconfig                          |   15 +
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   20 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   48 +-
 arch/powerpc/include/asm/book3s/64/hash.h     |   15 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   10 +
 arch/powerpc/include/asm/book3s/64/mmu.h      |   10 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   84 +-
 arch/powerpc/include/asm/mman.h               |   29 +-
 arch/powerpc/include/asm/mmu_context.h        |   12 +
 arch/powerpc/include/asm/paca.h               |    1 +
 arch/powerpc/include/asm/pkeys.h              |  159 +++
 arch/powerpc/include/asm/processor.h          |    5 +
 arch/powerpc/include/asm/reg.h                |   10 +-
 arch/powerpc/include/asm/systbl.h             |    3 +
 arch/powerpc/include/asm/unistd.h             |    6 +-
 arch/powerpc/include/uapi/asm/ptrace.h        |    3 +-
 arch/powerpc/include/uapi/asm/unistd.h        |    3 +
 arch/powerpc/kernel/asm-offsets.c             |    5 +
 arch/powerpc/kernel/exceptions-64s.S          |   18 +-
 arch/powerpc/kernel/process.c                 |   18 +
 arch/powerpc/kernel/signal_32.c               |   14 +
 arch/powerpc/kernel/signal_64.c               |   14 +
 arch/powerpc/kernel/traps.c                   |   49 +
 arch/powerpc/mm/Makefile                      |    1 +
 arch/powerpc/mm/dump_linuxpagetables.c        |    3 +-
 arch/powerpc/mm/fault.c                       |   25 +-
 arch/powerpc/mm/hash64_4k.c                   |   14 +-
 arch/powerpc/mm/hash64_64k.c                  |   93 +-
 arch/powerpc/mm/hash_utils_64.c               |   35 +-
 arch/powerpc/mm/hugetlbpage-hash64.c          |   16 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |    5 +
 arch/powerpc/mm/pkeys.c                       |  267 +++++
 include/linux/mm.h                            |   32 +-
 include/uapi/asm-generic/mman-common.h        |    2 +-
 tools/testing/selftests/vm/Makefile           |    1 +
 tools/testing/selftests/vm/pkey-helpers.h     |  365 +++++++
 tools/testing/selftests/vm/protection_keys.c  | 1451 +++++++++++++++++++++++++
 tools/testing/selftests/x86/Makefile          |    2 +-
 tools/testing/selftests/x86/pkey-helpers.h    |  219 ----
 tools/testing/selftests/x86/protection_keys.c | 1395 ------------------------
 42 files changed, 2828 insertions(+), 1844 deletions(-)
 create mode 100644 Documentation/vm/protection-keys.txt
 delete mode 100644 Documentation/x86/protection-keys.txt
 create mode 100644 arch/powerpc/include/asm/pkeys.h
 create mode 100644 arch/powerpc/mm/pkeys.c
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/protection_keys.c
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h
 delete mode 100644 tools/testing/selftests/x86/protection_keys.c

-- 
1.8.3.1
