Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqrb1xkgzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:26:39 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:26:37 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id A005B38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:33 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8QX8n31981686
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:26:33 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8QXXu006506
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:26:33 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 58/65] powerpc/mm/radix: Make sure swapper pgdir is properly
 aligned
Date: Sun, 27 Mar 2016 13:54:06 +0530
Message-Id: <1459067053-10835-58-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With 4k page size radix config our level 1 page table size 64K and it
should naturally aligned

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/head_64.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1b779560728f..e8870c9bbc11 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -875,13 +875,16 @@ start_here_common:
  * This stuff goes at the beginning of the bss, which is page-aligned.
  */
 	.section ".bss"
+/*
+ * pgd dir should be aligned to PGD_TABLE_SIZE which is 64K.
+ * We will need to find a better way to fix this
+ */
+	.align	16
 
-	.align	PAGE_SHIFT
+	.globl	swapper_pg_dir
+swapper_pg_dir:
+	.space	PGD_TABLE_SIZE
 
 	.globl	empty_zero_page
 empty_zero_page:
 	.space	PAGE_SIZE
-
-	.globl	swapper_pg_dir
-swapper_pg_dir:
-	.space	PGD_TABLE_SIZE
-- 
2.5.0
