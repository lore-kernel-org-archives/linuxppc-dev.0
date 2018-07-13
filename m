Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Rym64QW2zDr55
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 02:23:34 +1000 (AEST)
Message-Id: <cover.1531498345.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 0/4] KASAN for nohash PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Date: Fri, 13 Jul 2018 16:23:29 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie adds support to nohash PPC32

Tested on MPC8xx

Christophe Leroy (4):
  powerpc/mm: prepare kernel for KAsan on PPC32
  powerpc: add missing header in pgtable-types.h
  powerpc/32: Move early_init() in a separate file
  powerpc/nohash32: Add KASAN support

 arch/powerpc/Kconfig                         |  1 +
 arch/powerpc/include/asm/kasan.h             | 21 ++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +
 arch/powerpc/include/asm/pgtable-types.h     |  2 +
 arch/powerpc/include/asm/ppc_asm.h           |  5 ++
 arch/powerpc/include/asm/setup.h             |  5 ++
 arch/powerpc/include/asm/string.h            | 14 ++++++
 arch/powerpc/kernel/Makefile                 |  5 +-
 arch/powerpc/kernel/cputable.c               |  4 +-
 arch/powerpc/kernel/early_32.c               | 35 +++++++++++++
 arch/powerpc/kernel/setup-common.c           |  2 +
 arch/powerpc/kernel/setup_32.c               | 33 ++-----------
 arch/powerpc/lib/Makefile                    |  2 +
 arch/powerpc/lib/copy_32.S                   |  9 ++--
 arch/powerpc/mm/Makefile                     |  3 ++
 arch/powerpc/mm/dump_linuxpagetables.c       |  8 +++
 arch/powerpc/mm/kasan_init.c                 | 73 ++++++++++++++++++++++++++++
 arch/powerpc/mm/mem.c                        |  4 ++
 18 files changed, 193 insertions(+), 35 deletions(-)
 create mode 100644 arch/powerpc/include/asm/kasan.h
 create mode 100644 arch/powerpc/kernel/early_32.c
 create mode 100644 arch/powerpc/mm/kasan_init.c

-- 
2.13.3
