Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 240231A013C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Feb 2015 01:49:12 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Subject: [PATCH v4 0/5] powerpc8xx: Further optimisation of TLB handling
Message-Id: <20150204144908.361E71A5F24@localhost.localdomain>
Date: Wed,  4 Feb 2015 15:49:08 +0100 (CET)
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
Changes are:
- Not saving registers like CR when not needed
- Adding support to any TASK_SIZE

Patchset:
01 - powerpc/8xx: macro for handling CPU15 errata
02 - powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
03 - powerpc/8xx: dont save CR in SCRATCH registers
04 - powerpc/8xx: Use SPRG2 instead of DAR for saving r3
05 - powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000

All changes have been successfully tested on MPC885

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
v3: 01-06 no change ; 07-11 changed
v4: 01-06 removed (already in scootwood.git next) ; 07-11 renamed 01-05 and respined against scootwood.git next

 arch/powerpc/kernel/head_8xx.S | 79 +++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 28 deletions(-)
