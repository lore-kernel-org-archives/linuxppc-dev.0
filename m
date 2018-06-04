Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zq0r6jT3zF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 19:10:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: copy/paste - Mask SO bit in CR
Date: Mon,  4 Jun 2018 18:33:38 +1000
Message-Id: <20180604083338.2661-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NX can set the 3rd bit in CR register for XER[SO] (Summary overflow)
which is not related to paste request. The current paste function
returns failure for a successful request when this bit is set. So mask
this bit and check the proper return status.

Fixes: 2392c8c8c045 ("powerpc/powernv/vas: Define copy/paste interfaces")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Haren Myneni <haren@us.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/copy-paste.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/copy-paste.h b/arch/powerpc/platforms/powernv/copy-paste.h
index 3fa62de96d9c..cb36f9fbcef3 100644
--- a/arch/powerpc/platforms/powernv/copy-paste.h
+++ b/arch/powerpc/platforms/powernv/copy-paste.h
@@ -41,5 +41,6 @@ static inline int vas_paste(void *paste_address, int offset)
 		: "b" (offset), "b" (paste_address)
 		: "memory", "cr0");
 
-	return (cr >> CR0_SHIFT) & CR0_MASK;
+	/* We mask with 0xE to ignore SO */
+	return (cr >> CR0_SHIFT) & 0xE;
 }
-- 
2.14.1
