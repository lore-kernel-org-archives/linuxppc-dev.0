Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5NvV66xWzDqV1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 20:53:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds  <torvalds@linux-foundation.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 haokexin@gmail.com, khandual@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-2 tag
Date: Fri, 05 Aug 2016 20:53:25 +1000
Message-ID: <87twezcwre.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi Linus,

Please pull some more powerpc updates for 4.8.

These were delayed for various reasons, so I let them sit in next a bit
longer, rather than including them in my first pull request.

There's one conflict in kernel/jump_label.c, the resolution is simply to
take both sides changes.

The following changes since commit bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9:

  Merge tag 'powerpc-4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2016-07-30 21:01:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-2

for you to fetch changes up to eea8148c69f3aecbf297b12943a591467a1fb432:

  powerpc/mm: Move register_process_table() out of ppc_md (2016-08-04 20:22:34 +1000)

----------------------------------------------------------------
powerpc updates for 4.8 #2

Fixes:
 - Fix early access to cpu_spec relocation from Benjamin Herrenschmidt
 - Fix incorrect event codes in power9-event-list from Madhavan Srinivasan
 - Move register_process_table() out of ppc_md from Michael Ellerman

Use jump_label for [cpu|mmu]_has_feature() from Aneesh Kumar K.V, Kevin Hao and Michael Ellerman:
 - Add mmu_early_init_devtree() from Michael Ellerman
 - Move disable_radix handling into mmu_early_init_devtree() from Michael Ellerman
 - Do hash device tree scanning earlier from Michael Ellerman
 - Do radix device tree scanning earlier from Michael Ellerman
 - Do feature patching before MMU init from Michael Ellerman
 - Check features don't change after patching from Michael Ellerman
 - Make MMU_FTR_RADIX a MMU family feature from Aneesh Kumar K.V
 - Convert mmu_has_feature() to returning bool from Michael Ellerman
 - Convert cpu_has_feature() to returning bool from Michael Ellerman
 - Define radix_enabled() in one place & use static inline from Michael Ellerman
 - Add early_[cpu|mmu]_has_feature() from Michael Ellerman
 - Convert early cpu/mmu feature check to use the new helpers from Aneesh Kumar K.V
 - jump_label: Make it possible for arches to invoke jump_label_init() earlier from Kevin Hao
 - Call jump_label_init() in apply_feature_fixups() from Aneesh Kumar K.V
 - Remove mfvtb() from Kevin Hao
 - Move cpu_has_feature() to a separate file from Kevin Hao
 - Add kconfig option to use jump labels for cpu/mmu_has_feature() from Michael Ellerman
 - Add option to use jump label for cpu_has_feature() from Kevin Hao
 - Add option to use jump label for mmu_has_feature() from Kevin Hao
 - Catch usage of cpu/mmu_has_feature() before jump label init from Aneesh Kumar K.V
 - Annotate jump label assembly from Michael Ellerman

TLB flush enhancements from Aneesh Kumar K.V:
 - radix: Implement tlb mmu gather flush efficiently
 - Add helper for finding SLBE LLP encoding
 - Use hugetlb flush functions
 - Drop multiple definition of mm_is_core_local
 - radix: Add tlb flush of THP ptes
 - radix: Rename function and drop unused arg
 - radix/hugetlb: Add helper for finding page size
 - hugetlb: Add flush_hugetlb_tlb_range
 - remove flush_tlb_page_nohash

Add new ptrace regsets from Anshuman Khandual and Simon Guo:
 - elf: Add powerpc specific core note sections
 - Add the function flush_tmregs_to_thread
 - Enable in transaction NT_PRFPREG ptrace requests
 - Enable in transaction NT_PPC_VMX ptrace requests
 - Enable in transaction NT_PPC_VSX ptrace requests
 - Adapt gpr32_get, gpr32_set functions for transaction
 - Enable support for NT_PPC_CGPR
 - Enable support for NT_PPC_CFPR
 - Enable support for NT_PPC_CVMX
 - Enable support for NT_PPC_CVSX
 - Enable support for TM SPR state
 - Enable NT_PPC_TM_CTAR, NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
 - Enable support for NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR
 - Enable support for EBB registers
 - Enable support for Performance Monitor registers

----------------------------------------------------------------
Aneesh Kumar K.V (13):
      powerpc/mm: Make MMU_FTR_RADIX a MMU family feature
      powerpc/mm: Convert early cpu/mmu feature check to use the new helpers
      powerpc: Call jump_label_init() in apply_feature_fixups()
      powerpc/mm: Catch usage of cpu/mmu_has_feature() before jump label init
      powerpc/mm/radix: Implement tlb mmu gather flush efficiently
      powerpc/mm/hash: Add helper for finding SLBE LLP encoding
      powerpc/mm: Use hugetlb flush functions
      powerpc/mm: Drop multiple definition of mm_is_core_local
      powerpc/mm/radix: Add tlb flush of THP ptes
      powerpc/mm/radix: Rename function and drop unused arg
      powerpc/mm/radix/hugetlb: Add helper for finding page size from hstate
      powerpc/mm/hugetlb: Add flush_hugetlb_tlb_range
      powerpc/mm: remove flush_tlb_page_nohash

Anshuman Khandual (15):
      elf: Add powerpc specific core note sections
      powerpc/process: Add the function flush_tmregs_to_thread
      powerpc/ptrace: Enable in transaction NT_PRFPREG ptrace requests
      powerpc/ptrace: Enable in transaction NT_PPC_VMX ptrace requests
      powerpc/ptrace: Enable in transaction NT_PPC_VSX ptrace requests
      powerpc/ptrace: Adapt gpr32_get, gpr32_set functions for transaction
      powerpc/ptrace: Enable support for NT_PPC_CGPR
      powerpc/ptrace: Enable support for NT_PPC_CFPR
      powerpc/ptrace: Enable support for NT_PPC_CVMX
      powerpc/ptrace: Enable support for NT_PPC_CVSX
      powerpc/ptrace: Enable support for TM SPR state
      powerpc/ptrace: Enable NT_PPC_TM_CTAR, NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
      powerpc/ptrace: Enable support for NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR
      powerpc/ptrace: Enable support for EBB registers
      powerpc/ptrace: Enable support for Performance Monitor registers

Benjamin Herrenschmidt (1):
      powerpc/32: Fix early access to cpu_spec relocation

Kevin Hao (5):
      jump_label: Make it possible for arches to invoke jump_label_init() earlier
      powerpc: Remove mfvtb()
      powerpc: Move cpu_has_feature() to a separate file
      powerpc: Add option to use jump label for cpu_has_feature()
      powerpc: Add option to use jump label for mmu_has_feature()

Madhavan Srinivasan (1):
      powerpc/perf: Fix incorrect event codes in power9-event-list

Michael Ellerman (13):
      powerpc/mm: Add mmu_early_init_devtree()
      powerpc/mm: Move disable_radix handling into mmu_early_init_devtree()
      powerpc/mm: Do hash device tree scanning earlier
      powerpc/mm: Do radix device tree scanning earlier
      powerpc/64: Do feature patching before MMU init
      powerpc/kernel: Check features don't change after patching
      powerpc/kernel: Convert mmu_has_feature() to returning bool
      powerpc/kernel: Convert cpu_has_feature() to returning bool
      powerpc/mm: Define radix_enabled() in one place & use static inline
      powerpc/mm: Add early_[cpu|mmu]_has_feature()
      powerpc: Add kconfig option to use jump labels for cpu/mmu_has_feature()
      powerpc/jump_label: Annotate jump label assembly
      powerpc/mm: Move register_process_table() out of ppc_md

 arch/powerpc/Kconfig.debug                         |   19 +
 arch/powerpc/include/asm/book3s/64/hugetlb-radix.h |   15 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |   10 +
 arch/powerpc/include/asm/book3s/64/mmu.h           |   16 +-
 arch/powerpc/include/asm/book3s/64/tlbflush-hash.h |    5 -
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |   16 +-
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |   27 +-
 arch/powerpc/include/asm/cacheflush.h              |    1 +
 arch/powerpc/include/asm/cpu_has_feature.h         |   53 +
 arch/powerpc/include/asm/cputable.h                |   15 +-
 arch/powerpc/include/asm/cputime.h                 |    1 +
 arch/powerpc/include/asm/dbell.h                   |    1 +
 arch/powerpc/include/asm/dcr-native.h              |    1 +
 arch/powerpc/include/asm/hugetlb.h                 |    2 +-
 arch/powerpc/include/asm/jump_label.h              |    4 +-
 arch/powerpc/include/asm/kvm_book3s_64.h           |    3 +-
 arch/powerpc/include/asm/machdep.h                 |    2 -
 arch/powerpc/include/asm/mman.h                    |    1 +
 arch/powerpc/include/asm/mmu.h                     |   98 +-
 arch/powerpc/include/asm/reg.h                     |    9 -
 arch/powerpc/include/asm/switch_to.h               |    8 +
 arch/powerpc/include/asm/time.h                    |    3 +-
 arch/powerpc/include/asm/tlb.h                     |   13 +
 arch/powerpc/include/asm/tlbflush.h                |    1 -
 arch/powerpc/include/asm/xor.h                     |    1 +
 arch/powerpc/include/uapi/asm/elf.h                |    5 +
 arch/powerpc/kernel/align.c                        |    1 +
 arch/powerpc/kernel/cputable.c                     |   37 +
 arch/powerpc/kernel/entry_64.S                     |    2 +-
 arch/powerpc/kernel/exceptions-64s.S               |    8 +-
 arch/powerpc/kernel/idle_book3s.S                  |    2 +-
 arch/powerpc/kernel/irq.c                          |    1 +
 arch/powerpc/kernel/paca.c                         |    2 +-
 arch/powerpc/kernel/process.c                      |   21 +
 arch/powerpc/kernel/prom.c                         |   17 +-
 arch/powerpc/kernel/ptrace.c                       | 1740 ++++++++++++++++++--
 arch/powerpc/kernel/setup-common.c                 |    1 +
 arch/powerpc/kernel/setup_32.c                     |    1 +
 arch/powerpc/kernel/setup_64.c                     |   10 +-
 arch/powerpc/kernel/smp.c                          |    1 +
 arch/powerpc/lib/feature-fixups.c                  |   39 +-
 arch/powerpc/mm/hash_native_64.c                   |    8 +-
 arch/powerpc/mm/hash_utils_64.c                    |   53 +-
 arch/powerpc/mm/hugetlbpage-radix.c                |   39 +-
 arch/powerpc/mm/init_64.c                          |   22 +
 arch/powerpc/mm/pgtable-book3s64.c                 |    7 +-
 arch/powerpc/mm/pgtable-radix.c                    |    7 +-
 arch/powerpc/mm/pgtable.c                          |    2 +-
 arch/powerpc/mm/tlb-radix.c                        |   90 +-
 arch/powerpc/mm/tlb_hash32.c                       |   11 -
 arch/powerpc/mm/tlb_nohash.c                       |    6 -
 arch/powerpc/perf/power9-events-list.h             |    6 +-
 arch/powerpc/platforms/cell/pervasive.c            |    1 +
 arch/powerpc/xmon/ppc-dis.c                        |    1 +
 include/uapi/linux/elf.h                           |   13 +
 kernel/jump_label.c                                |    3 +
 mm/hugetlb.c                                       |   10 +-
 57 files changed, 2178 insertions(+), 314 deletions(-)
 create mode 100644 arch/powerpc/include/asm/cpu_has_feature.h

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXpHAlAAoJEFHr6jzI4aWAn6IP+wcYn0+Q9kixxvHtiJDUhIlP
ifw1qLgcEbjaKMCLGPVGJ4qE6jRloPoRy3RwHquGIbeIgFKrRRzRzRwC6pNOCTSI
ElV1CJhvWI4tr9CHqb4dbVK2zAgzIqcosRApLaeSyVg4jhbJyFCdHjh/JEI9ktwZ
7UOpAxdGAftfm9aC0JDZh4ItOK2f5bCgppb2owgYFvvik463ILAUvU5Td3ONQ7Vb
TWoL46XMPSArK5zxnU8oaIsSCOrUb/t+kI1O1taHaFjEdb7qYQ3dFOV0027yEbnK
slRe8Xxs1lg1C4cr3/E57MgyaahgbNYpxFuxd9Yt7F1S0kAKarNDJMJjGWIBOMju
lTJ/yUFjMSqrhjit1nmVqrl/yz7G09RcQzZw+SLQKssG7AwkelNv/tjIjrJiHF/L
jMargReRvg6fJTp+LB0KCT82/mtIZjGkTlbki/nEb5M5XjbxyRSvooBpgA+irEbu
fSDuLGe5QVTh7bzq9m4qDmlnDC9v9V7pgRKPfA1+G+k7wgb6mze58n4BKiVybWil
1OxltH3kiWIsgW9EIqCtMPFM8CKV8Jhvw5BxZ+/AMFAGZM4O+EKHIVSuBpsozd6X
Aoa/y6zSzC2DdtMkRD6kYwnUixY6ZwECrF9RPeTznxD2f3tTi7OetSUy3Tm8D2En
QZ8AYG3cyHFCedCkQ54x
=qbtG
-----END PGP SIGNATURE-----
--=-=-=--
