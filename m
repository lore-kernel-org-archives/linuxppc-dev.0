Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id A16251A0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 00:34:37 +1000 (AEST)
Message-Id: <5549ecca2c921f34d076c47b5e2a91a3e78b20a7.1442876807.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442876807.git.christophe.leroy@c-s.fr>
References: <cover.1442876807.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 8/9] powerpc: simplify csum_add(a, b) in case a or b is
 constant 0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Date: Tue, 22 Sep 2015 16:34:34 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simplify csum_add(a, b) in case a or b is constant 0

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/checksum.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 56deea8..f8a9704 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -119,7 +119,13 @@ static inline __wsum csum_add(__wsum csum, __wsum addend)
 {
 #ifdef __powerpc64__
 	u64 res = (__force u64)csum;
+#endif
+	if (__builtin_constant_p(csum) && csum == 0)
+		return addend;
+	if (__builtin_constant_p(addend) && addend == 0)
+		return csum;
 
+#ifdef __powerpc64__
 	res += (__force u64)addend;
 	return (__force __wsum)((u32)res + (res >> 32));
 #else
-- 
2.1.0
