Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 7C3961A02A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 04:44:41 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: optimise csum_partial() call when len is constant
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20160307174437.56E801A236B@localhost.localdomain>
Date: Mon,  7 Mar 2016 18:44:37 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

csum_partial is often called for small fixed length packets
for which it is suboptimal to use the generic csum_partial()
function.

For instance, in my configuration, I got:
* One place calling it with constant len 4
* Seven places calling it with constant len 8
* Three places calling it with constant len 14
* One place calling it with constant len 20
* One place calling it with constant len 24
* One place calling it with constant len 32

This patch renames csum_partial() to __csum_partial() and
implements csum_partial() as a wrapper inline function which
* uses csum_add() for small 16bits multiple constant length
* uses ip_fast_csum() for other 32bits multiple constant
* uses __csum_partial() in all other cases

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Taken into account Scott's comments
 applies on top of scottwood/linux next

 arch/powerpc/include/asm/checksum.h | 79 ++++++++++++++++++++++++++-----------
 arch/powerpc/lib/checksum_32.S      |  4 +-
 arch/powerpc/lib/checksum_64.S      |  4 +-
 arch/powerpc/lib/ppc_ksyms.c        |  2 +-
 4 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 74cd8d8..ee655ed 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -13,20 +13,6 @@
 #include <asm-generic/checksum.h>
 #else
 /*
- * computes the checksum of a memory block at buff, length len,
- * and adds in "sum" (32-bit)
- *
- * returns a 32-bit number suitable for feeding into itself
- * or csum_tcpudp_magic
- *
- * this function must be called with even lengths, except
- * for the last fragment, which may be odd
- *
- * it's best to have buff aligned on a 32-bit boundary
- */
-extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-
-/*
  * Computes the checksum of a memory block at src, length len,
  * and adds in "sum" (32-bit), while copying the block to dst.
  * If an access exception occurs on src or dst, it stores -EFAULT
@@ -67,15 +53,6 @@ static inline __sum16 csum_fold(__wsum sum)
 	return (__force __sum16)(~((__force u32)sum + tmp) >> 16);
 }
 
-/*
- * this routine is used for miscellaneous IP-like checksums, mainly
- * in icmp.c
- */
-static inline __sum16 ip_compute_csum(const void *buff, int len)
-{
-	return csum_fold(csum_partial(buff, len, 0));
-}
-
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
                                      unsigned short len,
                                      unsigned short proto,
@@ -174,6 +151,62 @@ static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 	return csum_fold(ip_fast_csum_nofold(iph, ihl));
 }
 
+/*
+ * computes the checksum of a memory block at buff, length len,
+ * and adds in "sum" (32-bit)
+ *
+ * returns a 32-bit number suitable for feeding into itself
+ * or csum_tcpudp_magic
+ *
+ * this function must be called with even lengths, except
+ * for the last fragment, which may be odd
+ *
+ * it's best to have buff aligned on a 32-bit boundary
+ */
+__wsum __csum_partial(const void *buff, int len, __wsum sum);
+
+static inline __wsum csum_partial(const void *buff, int len, __wsum sum)
+{
+	if (__builtin_constant_p(len) && len <= 16 && (len & 1) == 0) {
+		if (len == 2)
+			sum = csum_add(sum, (__force __wsum)*(const u16 *)buff);
+		if (len >= 4)
+			sum = csum_add(sum, (__force __wsum)*(const u32 *)buff);
+		if (len == 6)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u16 *)(buff + 4));
+		if (len >= 8)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u32 *)(buff + 4));
+		if (len == 10)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u16 *)(buff + 8));
+		if (len >= 12)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u32 *)(buff + 8));
+		if (len == 14)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u16 *)(buff + 12));
+		if (len >= 16)
+			sum = csum_add(sum, (__force __wsum)
+					    *(const u32 *)(buff + 12));
+	} else if (__builtin_constant_p(len) && (len & 3) == 0) {
+		sum = csum_add(sum, ip_fast_csum_nofold(buff, len >> 2));
+	} else {
+		sum = __csum_partial(buff, len, sum);
+	}
+	return sum;
+}
+
+/*
+ * this routine is used for miscellaneous IP-like checksums, mainly
+ * in icmp.c
+ */
+static inline __sum16 ip_compute_csum(const void *buff, int len)
+{
+	return csum_fold(csum_partial(buff, len, 0));
+}
+
 #endif
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index 0d34f47..d90870a 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -24,9 +24,9 @@
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
  *
- * csum_partial(buff, len, sum)
+ * __csum_partial(buff, len, sum)
  */
-_GLOBAL(csum_partial)
+_GLOBAL(__csum_partial)
 	subi	r3,r3,4
 	srawi.	r6,r4,2		/* Divide len by 4 and also clear carry */
 	beq	3f		/* if we're doing < 4 bytes */
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index f53f4ab..8e6e510 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -21,9 +21,9 @@
  * Computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit).
  *
- * csum_partial(r3=buff, r4=len, r5=sum)
+ * __csum_partial(r3=buff, r4=len, r5=sum)
  */
-_GLOBAL(csum_partial)
+_GLOBAL(__csum_partial)
 	addic	r0,r5,0			/* clear carry */
 
 	srdi.	r6,r4,3			/* less than 8 bytes? */
diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
index 8cd5c0b..c422812 100644
--- a/arch/powerpc/lib/ppc_ksyms.c
+++ b/arch/powerpc/lib/ppc_ksyms.c
@@ -17,7 +17,7 @@ EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 
 #ifndef CONFIG_GENERIC_CSUM
-EXPORT_SYMBOL(csum_partial);
+EXPORT_SYMBOL(__csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_generic);
 #endif
 
-- 
2.1.0
