Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40whTN1VMvzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 17:06:15 +1000 (AEST)
Message-Id: <cover.1527663626.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 0/2] powerpc/lib: Optimisation of memcmp() and
 __clear_user() for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 07:06:11 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This serie intends to optimise memcmp() and __clear_user() for PPC32
in the same spirit as already done on PPC64.

The first patch rewrites __clear_user() by using dcbz intruction
The second patch rewrites memcmp() to compare 32 bits words instead
of comparing byte per byte.

As shown in each individual commit log, second and third patches
provide significant improvment.

Changes in v6:
- Dropped first patch of the serie which was just moving memcmp() and __clear_user()
into new string_32.S file
- As suggested by Mathieu, to be consistant with PPC64:
  - __clear_user() is moved into new file string_32.S
  - memcmp() is moved into new file memcmp_32.S
- Removed unneccessary included header files.

Changes in v5:
- Removed the handling of Little Endian, as PPC32 kernel only support Big Endian
at the time being, and because unaligned accesses should be handled differently
in LE.

Changes in v4:
- In memcmp(), dropped the special handling for when length is 0. Handling it 
through the small length path.

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

Christophe Leroy (2):
  powerpc/lib: optimise 32 bits __clear_user()
  powerpc/lib: optimise PPC32 memcmp

 arch/powerpc/lib/Makefile    |  5 ++-
 arch/powerpc/lib/memcmp_32.S | 45 ++++++++++++++++++++++
 arch/powerpc/lib/string.S    | 63 -------------------------------
 arch/powerpc/lib/string_32.S | 90 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 65 deletions(-)
 create mode 100644 arch/powerpc/lib/memcmp_32.S
 create mode 100644 arch/powerpc/lib/string_32.S

-- 
2.13.3
