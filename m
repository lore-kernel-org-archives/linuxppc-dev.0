Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmd546pbczDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 00:05:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: mwb@linux.vnet.ibm.com,
	nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/pseries: Fix duplicate firmware feature for DRC_INFO
Date: Thu, 22 Feb 2018 00:05:23 +1100
Message-Id: <20180221130523.27836-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We had a mid-air collision between two new firmware features, DRMEM_V2
and DRC_INFO, and they ended up with the same value.

No one's actually reported any problems, presumably because the new
firmware that supports both properties is not widely available, and
the two properties tend to be enabled together.

Still if we ever had one enabled but not the other, the bugs that
could result are many and varied. So fix it.

Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/firmware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/firmware.h b/arch/powerpc/include/asm/firmware.h
index 511acfd7ab0d..535add3f7791 100644
--- a/arch/powerpc/include/asm/firmware.h
+++ b/arch/powerpc/include/asm/firmware.h
@@ -52,7 +52,7 @@
 #define FW_FEATURE_TYPE1_AFFINITY ASM_CONST(0x0000000100000000)
 #define FW_FEATURE_PRRN		ASM_CONST(0x0000000200000000)
 #define FW_FEATURE_DRMEM_V2	ASM_CONST(0x0000000400000000)
-#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000400000000)
+#define FW_FEATURE_DRC_INFO	ASM_CONST(0x0000000800000000)
 
 #ifndef __ASSEMBLY__
 
-- 
2.14.1
