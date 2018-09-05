Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539k47lrzF1nv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:36:57 +1000 (AEST)
Message-Id: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside platform
 specific code
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:36:51 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today flags like for instance _PAGE_RW or _PAGE_USER are used through
common parts of code.
Using those directly in common parts of code have proven to lead to
mistakes or misbehaviour, because their use is not always as trivial
as one could think.

For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
that a page is a kernel page, because some targets are using
_PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be 
(flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
This has to (bad) consequences:

 - All targets must define every bit, even the unsupported ones,
   leading to a lot of useless #define _PAGE_XXX 0
 - If someone forgets to take into account all possible _PAGE_XXX bits
   for the case, we can get unexpected behaviour on some targets.

This becomes even more complex when we come to using _PAGE_RW.
Testing (flags & _PAGE_RW) is not enough to test whether a page
if writable or not, because:

 - Some targets have _PAGE_RO instead, which has to be unset to tell
   a page is writable
 - Some targets have _PAGE_R and _PAGE_W, in which case
   _PAGE_RW = _PAGE_R | _PAGE_W
 - Even knowing whether a page is readable is not always trivial because:
   - Some targets requires to check that _PAGE_R is set to ensure page
   is readable
   - Some targets requires to check that _PAGE_NA is not set
   - Some targets requires to check that _PAGE_RO or _PAGE_RW is set

Etc ....

In order to work around all those issues and minimise the risks of errors,
this serie aims at removing all use of _PAGE_XXX flags from powerpc code
and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
are then defined in target specific parts of the kernel code.

Christophe Leroy (17):
  powerpc/32: Add ioremap_wt()
  powerpc/mm: remove direct use of flags related to cache
  powerpc/mm: dont't use _PAGE_EXEC in book3s/32
  powerpc/mm: move some nohash pte helpers in nohash/[32:64]/pgtable.h
  powerpc/mm: add pte helpers to query and change pte flags
  powerpc/mm: use pte helpers in generic code
  powerpc/mm: Split dump_pagelinuxtables flag_array table
  powerpc/mm: drop unused page flags
  powerpc/mm: move __P and __S tables in the common pgtable.h
  powerpc/book3s/32: do not include pte-common.h
  powerpc/mm: Move pte_user() into nohash/pgtable.h
  powerpc/mm: Distribute platform specific PAGE and PMD flags and
    definitions
  powerpc/nohash/64: do not include pte-common.h
  powerpc/mm: Allow platforms to redefine some helpers
  powerpc/mm: Define platform default caches related flags
  powerpc/mm: Get rid of pte-common.h
  powerpc/8xx: change name of a few page flags to avoid confusion

 arch/powerpc/include/asm/book3s/32/pgtable.h       | 141 +++++++++++--
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  60 +++---
 arch/powerpc/include/asm/io.h                      |   6 +
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  65 +++++-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |  48 +++++
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |  35 ++++
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  92 ++++++++-
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  38 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  37 +++-
 arch/powerpc/include/asm/nohash/pgtable.h          |  96 ++++++---
 arch/powerpc/include/asm/nohash/pte-book3e.h       |  30 +++
 arch/powerpc/include/asm/pgtable.h                 |  19 ++
 arch/powerpc/include/asm/pte-common.h              | 219 ---------------------
 arch/powerpc/kernel/head_8xx.S                     |   6 +-
 arch/powerpc/mm/8xx_mmu.c                          |   2 +-
 arch/powerpc/mm/Makefile                           |   7 +
 arch/powerpc/mm/dump_linuxpagetables-8xx.c         |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c    | 115 +++++++++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c     |  82 ++++++++
 arch/powerpc/mm/dump_linuxpagetables.c             | 155 +--------------
 arch/powerpc/mm/dump_linuxpagetables.h             |  19 ++
 arch/powerpc/mm/mem.c                              |   2 +-
 arch/powerpc/mm/pgtable.c                          |  25 +--
 arch/powerpc/mm/pgtable_32.c                       |  45 +++--
 arch/powerpc/mm/pgtable_64.c                       |  21 +-
 arch/powerpc/xmon/xmon.c                           |  12 +-
 26 files changed, 960 insertions(+), 499 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/pte-common.h
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-8xx.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-book3s64.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-generic.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.h

-- 
2.13.3
