Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtV6LsCzDrLH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 05/21] powerpc/64: Do feature patching before MMU init
Date: Thu, 28 Jul 2016 00:18:01 +1000
Message-Id: <1469629097-30859-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Up until now we needed to do the MMU init before feature patching,
because part of the MMU init was scanning the device tree and setting
and/or clearing some MMU feature bits.

Now that we have split that MMU feature modification out into routines
called from early_init_devtree() (called earlier) we can now do feature
patching before calling MMU init.

The advantage of this is it means the remainder of the MMU init runs
with the final set of features which will apply for the rest of the life
of the system. This means we don't have to special case anything called
from MMU init to deal with a changing set of feature bits.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

v3: Merged into this series.

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d8216aed22b7..984696136f96 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -298,12 +298,12 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	configure_exceptions();
 
-	/* Initialize the hash table or TLB handling */
-	early_init_mmu();
-
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
 
+	/* Initialize the hash table or TLB handling */
+	early_init_mmu();
+
 	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
-- 
2.7.4
