Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 148C81A0633
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 11:16:29 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 2/3] powerpc: Use defines for __init_tlb_power[78]
Date: Fri, 19 Feb 2016 11:16:23 +1100
Message-Id: <1455840984-24068-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1455840984-24068-1-git-send-email-mikey@neuling.org>
References: <1455840984-24068-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use defines for literals __init_tlb_power[78] rather than hand coding
them.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/cpu_setup_power.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 9c9b741..cb3e272 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -15,6 +15,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
+#include <asm/mmu-hash64.h>
 
 /* Entry: r3 = crap, r4 = ptr to cputable entry
  *
@@ -139,7 +140,7 @@ __init_HFSCR:
  * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
  */
 __init_tlb_power7:
-	li	r6,128
+	li	r6,POWER7_TLB_SETS
 	mtctr	r6
 	li	r7,0xc00	/* IS field = 0b11 */
 	ptesync
@@ -150,7 +151,7 @@ __init_tlb_power7:
 1:	blr
 
 __init_tlb_power8:
-	li	r6,512
+	li	r6,POWER8_TLB_SETS
 	mtctr	r6
 	li	r7,0xc00	/* IS field = 0b11 */
 	ptesync
-- 
2.5.0
