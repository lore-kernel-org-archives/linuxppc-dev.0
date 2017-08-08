Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXcB69ZKzDqjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:44:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Fix section mismatch warning in early_check_vec5()
Date: Tue,  8 Aug 2017 21:44:08 +1000
Message-Id: <1502192648-912-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

early_check_vec5() is called from and calls __init routines, so should
also be __init.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/init_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b1c83a6bfd54..588a521966ec 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -381,7 +381,7 @@ early_param("disable_radix", parse_disable_radix);
  * /chosen/ibm,architecture-vec-5 to see if the hypervisor is willing to do
  * radix.  If not, we clear the radix feature bit so we fall back to hash.
  */
-static void early_check_vec5(void)
+static void __init early_check_vec5(void)
 {
 	unsigned long root, chosen;
 	int size;
-- 
2.7.4
