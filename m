Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmM94vKYzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:17:09 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:17:07 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 473C23E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:17:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396H5nd37748870
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2016 23:17:05 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396H4nS000361
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 00:17:04 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 60/68] powerpc/mm/radix: Make sure swapper pgdir is
 properly aligned
Date: Sat,  9 Apr 2016 11:43:56 +0530
Message-Id: <1460182444-2468-61-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 4286775cbde9..2d14774af6b4 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -973,13 +973,16 @@ start_here_common:
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
