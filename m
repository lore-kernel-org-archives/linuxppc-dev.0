Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 322501A2AC5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:18:58 +1000 (AEST)
Message-Id: <c89a9224825d1e14b885ac573126b88d6b456894.1432047904.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432047904.git.christophe.leroy@c-s.fr>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/2] powerpc: put csum_tcpudp_magic inline
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 17:18:55 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

csum_tcpudp_magic() is only a few instructions, and does modify
really few registers. So it is not worth having it as a separate
function and suffer function branching and saving of volatile
registers.

This patch makes it inline by use of the already existing
csum_tcpudp_nofold() function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h | 21 ++++++++++++---------
 arch/powerpc/lib/checksum_32.S      | 16 ----------------
 arch/powerpc/lib/checksum_64.S      | 21 ---------------------
 3 files changed, 12 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 8251a3b..5e43d2d 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -20,15 +20,6 @@
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 
 /*
- * computes the checksum of the TCP/UDP pseudo-header
- * returns a 16-bit checksum, already complemented
- */
-extern __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
-					unsigned short len,
-					unsigned short proto,
-					__wsum sum);
-
-/*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
  *
@@ -127,6 +118,18 @@ static inline __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
 #endif
 }
 
+/*
+ * computes the checksum of the TCP/UDP pseudo-header
+ * returns a 16-bit checksum, already complemented
+ */
+static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
+					unsigned short len,
+					unsigned short proto,
+					__wsum sum)
+{
+	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
+}
+
 #endif
 #endif /* __KERNEL__ */
 #endif
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index e23a436..d6fab08 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -41,22 +41,6 @@ _GLOBAL(ip_fast_csum)
 	blr
 
 /*
- * Compute checksum of TCP or UDP pseudo-header:
- *   csum_tcpudp_magic(saddr, daddr, len, proto, sum)
- */	
-_GLOBAL(csum_tcpudp_magic)
-	rlwimi	r5,r6,16,0,15	/* put proto in upper half of len */
-	addc	r0,r3,r4	/* add 4 32-bit words together */
-	adde	r0,r0,r5
-	adde	r0,r0,r7
-	addze	r0,r0		/* add in final carry */
-	rlwinm	r3,r0,16,0,31	/* fold two halves together */
-	add	r3,r0,r3
-	not	r3,r3
-	srwi	r3,r3,16
-	blr
-
-/*
  * computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit)
  *
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 57a0720..f3ef354 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -45,27 +45,6 @@ _GLOBAL(ip_fast_csum)
 	blr
 
 /*
- * Compute checksum of TCP or UDP pseudo-header:
- *   csum_tcpudp_magic(r3=saddr, r4=daddr, r5=len, r6=proto, r7=sum)
- * No real gain trying to do this specially for 64 bit, but
- * the 32 bit addition may spill into the upper bits of
- * the doubleword so we still must fold it down from 64.
- */	
-_GLOBAL(csum_tcpudp_magic)
-	rlwimi	r5,r6,16,0,15	/* put proto in upper half of len */
-	addc	r0,r3,r4	/* add 4 32-bit words together */
-	adde	r0,r0,r5
-	adde	r0,r0,r7
-        rldicl  r4,r0,32,0      /* fold 64 bit value */
-        add     r0,r4,r0
-        srdi    r0,r0,32
-	rlwinm	r3,r0,16,0,31	/* fold two halves together */
-	add	r3,r0,r3
-	not	r3,r3
-	srwi	r3,r3,16
-	blr
-
-/*
  * Computes the checksum of a memory block at buff, length len,
  * and adds in "sum" (32-bit).
  *
-- 
2.1.0
