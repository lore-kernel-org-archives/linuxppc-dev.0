Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18440.12141.938002.331310@cargo.ozlabs.ibm.com>
Date: Fri, 18 Apr 2008 15:19:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [POWERPC] Optimize fls64() on 64-bit processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

64-bit powerpc processors can find the leftmost 1 bit in a 64-bit
doubleword in one instruction, so use that rather than using the
generic fls64(), which does two 32-bit fls() calls.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
This is on top of a patch from Alexander van Heukelum that was posted
to lkml (http://lkml.org/lkml/2008/4/16/107), which just uses
asm-generic/bitops/find.h in place of some declarations we had in
asm-powerpc/bitops.h.

diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index 36c8f3a..a99a749 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -312,7 +312,24 @@ static __inline__ int fls(unsigned int x)
 	asm ("cntlzw %0,%1" : "=r" (lz) : "r" (x));
 	return 32 - lz;
 }
+
+/*
+ * 64-bit can do this using one cntlzd (count leading zeroes doubleword)
+ * instruction; for 32-bit we use the generic version, which does two
+ * 32-bit fls calls.
+ */
+#ifdef __powerpc64__
+static __inline__ int fls64(__u64 x)
+{
+	int lz;
+
+	asm ("cntlzd %0,%1" : "=r" (lz) : "r" (x));
+	return 64 - lz;
+}
+#else
 #include <asm-generic/bitops/fls64.h>
+#endif /* __powerpc64__ */
+
 #include <asm-generic/bitops/hweight.h>
 #include <asm-generic/bitops/find.h>
 
