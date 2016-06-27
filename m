Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZW1jc2zDqpN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:42 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/38] powerpc/mm/hash64: Don't test for machine type to
 detect HEA special case
Date: Mon, 27 Jun 2016 21:29:18 +1000
Message-Id: <1467026976-7974-21-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead, check for FW_FEATURE_SPLPAR. This should be roughtly equivalent
as all pseries machiens that can have an HEA also support SPLPAR and
no other machine type does.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/hash_utils_64.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index a70d0a3..164c2da 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -508,7 +508,8 @@ static bool might_have_hea(void)
 	 * we will never see an HEA ethernet device.
 	 */
 #ifdef CONFIG_IBMEBUS
-	return !cpu_has_feature(CPU_FTR_ARCH_207S);
+	return !cpu_has_feature(CPU_FTR_ARCH_207S) &&
+		!firmware_has_feature(FW_FEATURE_SPLPAR);
 #else
 	return false;
 #endif
@@ -574,7 +575,7 @@ found:
 			 * would stop us accessing the HEA ethernet. So if we
 			 * have the chance of ever seeing one, stay at 4k.
 			 */
-			if (!might_have_hea() || !machine_is(pseries))
+			if (!might_have_hea())
 				mmu_io_psize = MMU_PAGE_64K;
 		} else
 			mmu_ci_restrictions = 1;
-- 
2.7.4
