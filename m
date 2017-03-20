Return-Path: <srs0=i+vg=25=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmmm05SGpzDqZW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:08 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vmmm03tvTz8xW3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 17:50:08 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vmmlz2SSKz9s7Z
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Mar 2017 17:50:07 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 03/12] powerpc: Add more PPC bit conversion macros
Date: Mon, 20 Mar 2017 17:49:05 +1100
Message-Id: <20170320064914.4437-3-benh@kernel.crashing.org>
In-Reply-To: <20170320064914.4437-1-benh@kernel.crashing.org>
References: <20170320064914.4437-1-benh@kernel.crashing.org>
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
