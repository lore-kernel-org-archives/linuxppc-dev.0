Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 245871A2ABB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:19:00 +1000 (AEST)
Message-Id: <1d1362c8aa696e316d3ba97dce2342df6f6ee6cf.1432047904.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1432047904.git.christophe.leroy@c-s.fr>
References: <cover.1432047904.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 2/2] powerpc: add support for csum_add()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Date: Tue, 19 May 2015 17:18:57 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The C version of csum_add() as defined in include/net/checksum.h gives the
following assembly in ppc32:
       0:       7c 04 1a 14     add     r0,r4,r3
       4:       7c 64 00 10     subfc   r3,r4,r0
       8:       7c 63 19 10     subfe   r3,r3,r3
       c:       7c 63 00 50     subf    r3,r3,r0
and the following in ppc64:
   0xc000000000001af8 <+0>:	add     r3,r3,r4
   0xc000000000001afc <+4>:	cmplw   cr7,r3,r4
   0xc000000000001b00 <+8>:	mfcr    r4
   0xc000000000001b04 <+12>:	rlwinm  r4,r4,29,31,31
   0xc000000000001b08 <+16>:	add     r3,r4,r3
   0xc000000000001b0c <+20>:	clrldi  r3,r3,32
   0xc000000000001b10 <+24>:	blr

include/net/checksum.h also offers the possibility to define an arch specific
function.
This patch provides a specific csum_add() inline function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 5e43d2d..e8d9ef4 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -130,6 +130,22 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
 	return csum_fold(csum_tcpudp_nofold(saddr, daddr, len, proto, sum));
 }
 
+#define HAVE_ARCH_CSUM_ADD
+static inline __wsum csum_add(__wsum csum, __wsum addend)
+{
+#ifdef __powerpc64__
+	u64 res = (__force u64)csum;
+
+	res += (__force u64)addend;
+	return (__force __wsum)((u32)res + (res >> 32));
+#else
+	asm("addc %0,%0,%1;"
+	    "addze %0,%0;"
+	    : "+r" (csum) : "r" (addend));
+	return csum;
+#endif
+}
+
 #endif
 #endif /* __KERNEL__ */
 #endif
-- 
2.1.0
