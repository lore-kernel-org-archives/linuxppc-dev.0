Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C3E081A0C53
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 20:57:37 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v2 00/11] powerpc8xx: Further optimisation of TLB handling
Message-Id: <20150120095733.9F3281A5E86@localhost.localdomain>
Date: Tue, 20 Jan 2015 10:57:33 +0100 (CET)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset provides a further optimisation of TLB handling in the 8xx.
Main changes are based on:
- Using processor handling of PGD/PTE Validity bits instead of testing ourselves
the entries validity
- Aligning PGD address to allow direct bit manipulation
- Not saving registers like CR when not needed

It also adds support to any TASK_SIZE

Patchset:
01 - powerpc/8xx: remove remaining unnecessary code in FixupDAR
02 - powerpc/8xx: remove tests on PGDIR entry validity
03 - powerpc32: Use kmem_cache memory for PGDIR
04 - powerpc/8xx: Take benefit of aligned PGDIR
05 - powerpc/8xx: Optimise access to swapper_pg_dir
06 - powerpc/8xx: Remove duplicated code in set_context()
07 - powerpc/8xx: macro for handling CPU15 errata
08 - powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
09 - powerpc/8xx: dont save CR in SCRATCH registers
10 - powerpc/8xx: Use SPRG2 instead of DAR for saving r3
11 - powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000

All changes have been successfully tested on MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 arch/powerpc/include/asm/pgtable-ppc32.h |   4 +
 arch/powerpc/kernel/head_8xx.S           | 197 +++++++++++++++----------------
 arch/powerpc/mm/pgtable_32.c             |  16 ++-
 3 files changed, 111 insertions(+), 106 deletions(-)
