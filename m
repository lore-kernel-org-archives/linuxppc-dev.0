Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyf6v2vzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 63/70] powerpc/mm/radix: Make sure swapper pgdir is
 properly aligned
Date: Fri, 29 Apr 2016 23:26:26 +1000
Message-Id: <1461936393-10131-63-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

With 4K page size radix config our level 1 page table size is 64K and it
should be naturally aligned.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
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
