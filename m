Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8YCF2qDkzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 21:18:49 +1000 (AEST)
Message-Id: <cover.1492772606.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 0/4] powerpc: Replace some bitops functions by builtin/generic
 ones
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 21 Apr 2017 13:18:44 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset replaces the following bitops by builtin/generic ones:
- ffs() / __ffs()
- fls() / __fls() / fls64()
- ffz()
- __ilog2() / __ilog2_u32() / __ilog2_u64()

The current functions are written as inline assembly which prevents
GCC to optimise them in case of constant parameters and obliges GCC
to group the related instructions all together.

With the builtin alternatives, GCC optimises better

Christophe Leroy (4):
  powerpc: Discard ffs()/__ffs() function and use builtin functions
    instead
  powerpc: Use builtin functions for fls()/__fls()/fls64()
  powerpc: Replace ffz() by equivalent generic function
  powerpc: remove __ilog2()s and use generic ones

 arch/powerpc/Kconfig              |  8 ----
 arch/powerpc/include/asm/bitops.h | 87 ++++-----------------------------------
 2 files changed, 7 insertions(+), 88 deletions(-)

-- 
2.12.0
