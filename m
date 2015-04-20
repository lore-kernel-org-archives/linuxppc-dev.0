Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id DD50E1A1146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:54:38 +1000 (AEST)
Message-Id: <cover.1429287689.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH RESEND v5 0/5] powerpc8xx: Further optimisation of TLB handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Mon, 20 Apr 2015 07:54:36 +0200 (CEST)
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

Only the last patch of the set is changed compared to v4

Resending with proper From: this time.

Christophe Leroy (5):
  powerpc/8xx: macro for handling CPU15 errata
  powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
  powerpc/8xx: dont save CR in SCRATCH registers
  powerpc/8xx: Use SPRG2 instead of DAR for saving r3
  powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000

 arch/powerpc/kernel/head_8xx.S | 79 +++++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 28 deletions(-)

-- 
2.1.0
