Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ADC19DDF72
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 09:48:56 +1000 (EST)
From: Trent Piepho <tpiepho@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] [POWERPC] Improve (in|out)_[bl]eXX() asm code
Date: Tue, 27 May 2008 16:48:32 -0700
Message-Id: <1211932112-15239-1-git-send-email-tpiepho@freescale.com>
In-Reply-To: <je3aocdqxh.fsf@sykes.suse.de>
References: <je3aocdqxh.fsf@sykes.suse.de>
Cc: Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since commit 4cb3cee03d558fd457cb58f56c80a2a09a66110c the code generated
for the in_beXX() and out_beXX() mmio functions has been sub-optimal.

The out_leXX() family of functions are created with the macro
DEF_MMIO_OUT_LE() while the out_beXX() family are created with
DEF_MMIO_OUT_BE().  In what was perhaps a bit too much macro use, both of
these macros are in turn created via the macro DEF_MMIO_OUT().

For the LE versions, eventually they boil down to an asm that will look
something like this:
asm("sync; stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));

The issue is that the "stwbrx" instruction only comes in an indexed, or
'x', version, in which the address is represented by the sum of two
registers (the "0,%2").  Unfortunately, gcc doesn't have a constraint for
an indexed memory reference.  The "m" constraint allows both indexed and
offset, i.e. register plus constant, memory references and there is no
"stwbr" version for offset references.  "m" also allows updating addresses
and there is no 'u' version of "stwbrx" like there is with "stwux".

The unused first operand to the asm is just to tell gcc that *addr is an
output of the asm.  The address used is passed in a single register via the
third asm operand, and the index register is just hard coded as 0.  This
means gcc is forced to put the address in a single register and can't use
index addressing, e.g. if one has the data in register 9, a base address in
register 3 and an index in register 4, gcc must emit code like "add 11,4,3;
stwbrx 9,0,11" instead of just "stwbrx 9,4,3".  This costs an extra add
instruction and another register.

For gcc 4.0 and older, there doesn't appear to be anything that can be
done.  But for 4.1 and newer, there is a 'Z' constraint.  It does not allow
"updating" addresses, but does allow both indexed and offset addresses.
However, the only allowed constant offset is 0.  We can then use the
undocumented 'y' operand modifier, which causes gcc to convert "0(reg)"
into the equivilient "0,reg" format that can be used with stwbrx.

This brings us the to problem with the BE version.  In this case, the "stw"
instruction does have both indexed and non-indexed versions.  The final asm
ends up looking like this:
asm("sync; stw%U0%X0 %1,%0" : "=m" (*addr) : "r" (val), "r" (addr));

The undocumented codes "%U0" and "%0X" will generate a 'u' if the memory
reference should be an auto-updating one, and an 'x' if the memory
reference is indexed, respectively.  The third operand is unused, it's just
there because asm the code is reused from the LE version.  However, gcc
does not know this, and generates unnecessary code to stick addr in a
register!  To use the example from the LE version, gcc will generate "add
11,4,3; stwx 9,4,3".  It is able to use the indexed address "4,3" for the
"stwx", but still thinks it needs to put 4+3 into register 11, which will
never be used.

This also ends up happening a lot for the offset addressing mode, where
common code like this:  out_be32(&device_registers->some_register, data);
uses an instruction like "stw 9, 42(3)", where register 3 has the pointer
device_registers and 42 is the offset of some_register in that structure.
gcc will be forced to generate the unnecessary instruction "addi 11, 3, 42"
to put the address into a single (unused) register.

The in_* versions end up having these exact same problems as well.

Signed-off-by: Trent Piepho <tpiepho@freescale.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Andreas Schwab <schwab@suse.de>
---

This version uses the Andreas's suggestions about how to use the "Z"
constraint and "y" modifier to improve the LE version as well.

 include/asm-powerpc/io.h |   63 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 45 insertions(+), 18 deletions(-)

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index e0062d7..a2547ac 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -95,33 +95,60 @@ extern resource_size_t isa_mem_base;
 #define IO_SET_SYNC_FLAG()
 #endif
 
-#define DEF_MMIO_IN(name, type, insn)					\
-static inline type name(const volatile type __iomem *addr)		\
+/* gcc 4.0 and older doesn't have 'Z' constraint */
+#if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ == 0)
+#define DEF_MMIO_IN_LE(name, size, insn)				\
+static inline u##size name(const volatile u##size __iomem *addr)	\
 {									\
-	type ret;							\
-	__asm__ __volatile__("sync;" insn ";twi 0,%0,0;isync"		\
- 		: "=r" (ret) : "r" (addr), "m" (*addr));		\
+	u##size ret;							\
+	__asm__ __volatile__("sync;"#insn" %0,0,%1;twi 0,%0,0;isync"	\
+		: "=r" (ret) : "r" (addr), "m" (*addr));		\
 	return ret;							\
 }
 
-#define DEF_MMIO_OUT(name, type, insn)					\
-static inline void name(volatile type __iomem *addr, type val)		\
+#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+static inline void name(volatile u##size __iomem *addr, u##size val)	\
 {									\
-	__asm__ __volatile__("sync;" insn				\
- 		: "=m" (*addr) : "r" (val), "r" (addr));		\
-	IO_SET_SYNC_FLAG();					\
+	__asm__ __volatile__("sync;"#insn" %1,0,%2"			\
+		: "=m" (*addr) : "r" (val), "r" (addr));		\
+	IO_SET_SYNC_FLAG();						\
 }
+#else /* newer gcc */
+#define DEF_MMIO_IN_LE(name, size, insn)				\
+static inline u##size name(const volatile u##size __iomem *addr)	\
+{									\
+	u##size ret;							\
+	__asm__ __volatile__("sync;"#insn" %0,%y1;twi 0,%0,0;isync"	\
+		: "=r" (ret) : "Z" (*addr));				\
+	return ret;							\
+}
+
+#define DEF_MMIO_OUT_LE(name, size, insn) 				\
+static inline void name(volatile u##size __iomem *addr, u##size val)	\
+{									\
+	__asm__ __volatile__("sync;"#insn" %1,%y0"			\
+		: "=Z" (*addr) : "r" (val));				\
+	IO_SET_SYNC_FLAG();						\
+}
+#endif
 
+#define DEF_MMIO_IN_BE(name, size, insn)				\
+static inline u##size name(const volatile u##size __iomem *addr)	\
+{									\
+	u##size ret;							\
+	__asm__ __volatile__("sync;"#insn"%U1%X1 %0,%1;twi 0,%0,0;isync"\
+		: "=r" (ret) : "m" (*addr));				\
+	return ret;							\
+}
 
-#define DEF_MMIO_IN_BE(name, size, insn) \
-	DEF_MMIO_IN(name, u##size, __stringify(insn)"%U2%X2 %0,%2")
-#define DEF_MMIO_IN_LE(name, size, insn) \
-	DEF_MMIO_IN(name, u##size, __stringify(insn)" %0,0,%1")
+#define DEF_MMIO_OUT_BE(name, size, insn)				\
+static inline void name(volatile u##size __iomem *addr, u##size val)	\
+{									\
+	__asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"			\
+		: "=m" (*addr) : "r" (val));				\
+	IO_SET_SYNC_FLAG();						\
+}
 
-#define DEF_MMIO_OUT_BE(name, size, insn) \
-	DEF_MMIO_OUT(name, u##size, __stringify(insn)"%U0%X0 %1,%0")
-#define DEF_MMIO_OUT_LE(name, size, insn) \
-	DEF_MMIO_OUT(name, u##size, __stringify(insn)" %1,0,%2")
 
 DEF_MMIO_IN_BE(in_8,     8, lbz);
 DEF_MMIO_IN_BE(in_be16, 16, lhz);
-- 
1.5.4.1
