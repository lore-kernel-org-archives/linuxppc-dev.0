Return-Path: <srs0=xpzz=3n=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vydSC1sD1zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:55:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vydSC1C8qz8t15
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 17:55:39 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vydSB3R27z9s84
 for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2017 17:55:38 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 01/10] powerpc: Add more PPC bit conversion macros
Date: Wed,  5 Apr 2017 17:54:47 +1000
Message-Id: <20170405075456.13561-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add 32 and 8 bit variants

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/bitops.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index bc5fdfd..33a24fd 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -55,6 +55,14 @@
 #define PPC_BITEXTRACT(bits, ppc_bit, dst_bit)			\
 	((((bits) >> PPC_BITLSHIFT(ppc_bit)) & 1) << (dst_bit))
 
+#define PPC_BITLSHIFT32(be)	(32 - 1 - (be))
+#define PPC_BIT32(bit)		(1UL << PPC_BITLSHIFT32(bit))
+#define PPC_BITMASK32(bs, be)	((PPC_BIT32(bs) - PPC_BIT32(be))|PPC_BIT32(bs))
+
+#define PPC_BITLSHIFT8(be)	(8 - 1 - (be))
+#define PPC_BIT8(bit)		(1UL << PPC_BITLSHIFT8(bit))
+#define PPC_BITMASK8(bs, be)	((PPC_BIT8(bs) - PPC_BIT8(be))|PPC_BIT8(bs))
+
 #include <asm/barrier.h>
 
 /* Macro for generating the ***_bits() functions */
-- 
2.9.3
