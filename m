Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove unused postfix parameter to DEFINE_BITOP()
Date: Fri, 22 Feb 2013 14:25:41 +1100
Message-Id: <1361503541-1384-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

None of the users of DEFINE_BITOP pass a postfix, and as far as I can
tell none ever did, so drop it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/bitops.h |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index ef918a2..810c5fc 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -55,7 +55,7 @@
 #define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
 
 /* Macro for generating the ***_bits() functions */
-#define DEFINE_BITOP(fn, op, prefix, postfix)	\
+#define DEFINE_BITOP(fn, op, prefix)		\
 static __inline__ void fn(unsigned long mask,	\
 		volatile unsigned long *_p)	\
 {						\
@@ -68,16 +68,15 @@ static __inline__ void fn(unsigned long mask,	\
 	PPC405_ERR77(0,%3)			\
 	PPC_STLCX "%0,0,%3\n"			\
 	"bne- 1b\n"				\
-	postfix					\
 	: "=&r" (old), "+m" (*p)		\
 	: "r" (mask), "r" (p)			\
 	: "cc", "memory");			\
 }
 
-DEFINE_BITOP(set_bits, or, "", "")
-DEFINE_BITOP(clear_bits, andc, "", "")
-DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER, "")
-DEFINE_BITOP(change_bits, xor, "", "")
+DEFINE_BITOP(set_bits, or, "")
+DEFINE_BITOP(clear_bits, andc, "")
+DEFINE_BITOP(clear_bits_unlock, andc, PPC_RELEASE_BARRIER)
+DEFINE_BITOP(change_bits, xor, "")
 
 static __inline__ void set_bit(int nr, volatile unsigned long *addr)
 {
-- 
1.7.10.4
