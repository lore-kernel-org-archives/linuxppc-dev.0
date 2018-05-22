Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r0rv3L4fzDqL4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:06:55 +1000 (AEST)
Message-Id: <cover.1527004752.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 0/3] powerpc/lib: Optimisation of string functions for
 PPC32 - part 1
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 18:06:49 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie intends to optimise string functions for PPC32 in the
same spirit as already done on PPC64.

The first patch moves PPC32 specific functions from string.S into
a dedicated file named string_32.S
The second patch rewrites __clear_user() by using dcbz intruction
The third patch rewrites memcmp() to compare 32 bits words instead
of comparing byte per byte.

As shown in each individual commit log, second and third patches provide
significant improvment.

Changes in v3:
- Fixed the sign of the result returned by memcmp() by using a logical
comparison of u32 words and returning -1, 0 or 1 instead of doing a substract.
- In first patch, replaced PPC_LCMPI by cmpwi
- Fixed licence in string_32.S
- Removed the two last patches from the serie. They will be handled later as
they require further tests and analysis to properly identify their real benefit
in all possible cases.

Changes in v2:
- Moved out the patch removing the hot loop alignment on PPC32
- Squashed the changes related to NUL size verification in a single patch
- Reordered the patches in a more logical order
- Modified the inlining patch to avoid warning about impossibility to version symbols.

Christophe Leroy (3):
  powerpc/lib: move PPC32 specific functions out of string.S
  powerpc/lib: optimise 32 bits __clear_user()
  powerpc/lib: optimise PPC32 memcmp

 arch/powerpc/lib/Makefile    |   5 +-
 arch/powerpc/lib/string.S    |  61 -------------------
 arch/powerpc/lib/string_32.S | 140 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+), 63 deletions(-)
 create mode 100644 arch/powerpc/lib/string_32.S

-- 
2.13.3
