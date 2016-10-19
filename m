Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szLhn2zLszDt2W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 16:53:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/hash64: Be more careful when generating tlbiel
Date: Wed, 19 Oct 2016 16:53:25 +1100
Message-Id: <1476856405-4811-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

In ISA v2.05, the tlbiel instruction takes two arguments, RB and L:

tlbiel RB,L

+---------+---------+----+---------+---------+---------+----+
|    31   |    /    | L  |    /    |    RB   |   274   | /  |
| 31 - 26 | 25 - 22 | 21 | 20 - 16 | 15 - 11 |  10 - 1 | 0  |
+---------+---------+----+---------+---------+---------+----+

In ISA v2.06 tlbiel takes only one argument, RB:

tlbiel RB

+---------+---------+---------+---------+---------+----+
|    31   |    /    |    /    |    RB   |   274   | /  |
| 31 - 26 | 25 - 21 | 20 - 16 | 15 - 11 |  10 - 1 | 0  |
+---------+---------+---------+---------+---------+----+

And in ISA v3.00 tlbiel takes five arguments:

tlbiel RB,RS,RIC,PRS,R

+---------+---------+----+---------+----+----+---------+---------+----+
|    31   |    RS   | /  |   RIC   |PRS | R  |    RB   |   274   | /  |
| 31 - 26 | 25 - 21 | 20 | 19 - 18 | 17 | 16 | 15 - 11 |  10 - 1 | 0  |
+---------+---------+----+---------+----+----+---------+---------+----+

However the assembler also accepts "tlbiel RB", and generates
"tlbiel RB,r0,0,0,0".

As you can see above the L field from the v2.05 encoding overlaps with the
reserved field of the v2.06 encoding, and the low bit of the RS field of the
v3.00 encoding.

Currently in __tlbiel() we generate two tlbiel instructions manually using hex
constants. In the first case, for MMU_PAGE_4K, we generate "tlbiel RB,0", which
is safe in all cases, because the L bit is zero.

However in the default case we generate "tlbiel RB,1", therefore setting bit 21
to 1.

This is not an actual bug on v2.06 processors, because the CPU ignores the value
of the reserved field. However software is supposed to encode the reserved
fields as zero to enable forward compatibility.

On v3.00 processors setting bit 21 to 1 and no other bits of RS, means we are
using r1 for the value of RS.

Although it's not obvious, the code sets the IS field (bits 10-11) to 0 (by
omission), and L=1, in the va value, which is passed as RB. We also pass R=0 in
the instruction.

The combination of IS=0, L=1 and R=0 means the value of RS is not used, so even
on ISA v3.00 there is no actual bug.

We should still fix it, as setting a reserved bit on v2.06 is naughty, and we
are only avoiding a bug on v3.00 by accident rather than design. Use
ASM_FTR_IFSET() to generate the single argument form on ISA v2.06 and later, and
the two argument form on pre v2.06.

Although there may be very old toolchains which don't understand tlbiel, we have
other code in the tree which has been using tlbiel for over five years, and no
one has reported any build failures, so just let the assembler generate the
instructions.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
[mpe: Rewrite change log, use IFSET instead of IFCLR]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/hash_native_64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

v2: Rewrite change log, use IFSET instead of IFCLR.

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 83ddc0e171b0..9d9b3eff123e 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -123,8 +123,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		va |= ssize << 8;
 		sllp = get_sllp_encoding(apsize);
 		va |= sllp << 5;
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (0 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFSET("tlbiel %0", "tlbiel %0,0", %1)
+			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	default:
 		/* We need 14 to 14 + i bits of va */
@@ -141,8 +142,9 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 		 */
 		va |= (vpn & 0xfe);
 		va |= 1; /* L */
-		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
-			     : : "r"(va) : "memory");
+		asm volatile(ASM_FTR_IFSET("tlbiel %0", "tlbiel %0,1", %1)
+			     : : "r" (va), "i" (CPU_FTR_ARCH_206)
+			     : "memory");
 		break;
 	}
 
-- 
2.7.4
