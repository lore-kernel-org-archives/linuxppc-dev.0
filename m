Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8Y8Z5mjtzDvQM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:15:58 +1100 (AEDT)
Date: Thu, 3 Nov 2016 16:10:55 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/64: Fix checksum folding in csum_tcpudp_nofold
 and ip_fast_csum_nofold
Message-ID: <20161103051055.GA8368@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions compute an IP checksum by computing a 64-bit sum and
folding it to 32 bits (the "nofold" in their names refers to folding
down to 16 bits).  However, doing (u32) (s + (s >> 32)) is not
sufficient to fold a 64-bit sum to 32 bits correctly.  The addition
can produce a carry out from bit 31, which needs to be added in to
the sum to produce the correct result.

To fix this, we copy the from64to32() function from lib/checksum.c
and use that.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/checksum.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index ee655ed..c16c6f8 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -53,19 +53,27 @@ static inline __sum16 csum_fold(__wsum sum)
 	return (__force __sum16)(~((__force u32)sum + tmp) >> 16);
 }
 
+static inline u32 from64to32(u64 x)
+{
+	/* add up 32-bit and 32-bit for 32+c bit */
+	x = (x & 0xffffffff) + (x >> 32);
+	/* add up carry.. */
+	x = (x & 0xffffffff) + (x >> 32);
+	return (u32)x;
+}
+
 static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
                                      unsigned short len,
                                      unsigned short proto,
                                      __wsum sum)
 {
 #ifdef __powerpc64__
-	unsigned long s = (__force u32)sum;
+	u64 s = (__force u32)sum;
 
 	s += (__force u32)saddr;
 	s += (__force u32)daddr;
 	s += proto + len;
-	s += (s >> 32);
-	return (__force __wsum) s;
+	return (__force __wsum) from64to32(s);
 #else
     __asm__("\n\
 	addc %0,%0,%1 \n\
@@ -127,8 +135,7 @@ static inline __wsum ip_fast_csum_nofold(const void *iph, unsigned int ihl)
 
 	for (i = 0; i < ihl - 1; i++, ptr++)
 		s += *ptr;
-	s += (s >> 32);
-	return (__force __wsum)s;
+	return (__force __wsum)from64to32(s);
 #else
 	__wsum sum, tmp;
 
-- 
2.10.1
