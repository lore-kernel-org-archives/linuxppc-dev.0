Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv3Fx0Yq8zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 23:04:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH v6 04/19] powerpc/mm: Remove checks that TASK_SIZE_USER64 is
 too small
Date: Thu, 30 Mar 2017 23:03:52 +1100
Message-Id: <1490875447-4016-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Remove the checks that TASK_SIZE_USER64 is smaller than H_PGTABLE_RANGE
and USER_VSID_RANGE.

In a following patch we will deliberately add support for a TASK_SIZE
smaller than both ranges, so this will no longer be an error condition.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[mpe: Keep the check in pgtable_64.c that we don't exceed USER_VSID_RANGE]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/init_64.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9be992083d2a..8f6f2a173e47 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -71,10 +71,6 @@
 #if H_PGTABLE_RANGE > USER_VSID_RANGE
 #warning Limited user VSID range means pagetable space is wasted
 #endif
-
-#if (TASK_SIZE_USER64 < H_PGTABLE_RANGE) && (TASK_SIZE_USER64 < USER_VSID_RANGE)
-#warning TASK_SIZE is smaller than it needs to be.
-#endif
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 phys_addr_t memstart_addr = ~0;
-- 
2.7.4
