Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DA8C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 12:58:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B7720854
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 12:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B7720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Kpff2sFpzDqM2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 23:58:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KpZs5h1CzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 23:55:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44KpZs0X9Lz9s5c; Thu, 14 Mar 2019 23:55:01 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44KpZr6X9Jz9s70; Thu, 14 Mar 2019 23:55:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm/64: Document the sizes of/sizes mapped by
 Pxx_INDEX_SIZE
Date: Thu, 14 Mar 2019 23:54:53 +1100
Message-Id: <20190314125453.4956-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add comments describing the size in bytes of the various levels of the
page table tree, and the size of the virtual address space mapped by
each level, to make it clear what the sizes are without having to also
look up other definitions.

The code that calculates the sizes actually uses sizeof(pgd_t) etc.,
so in theory these comments could skew vs the code, but the size of
pgd_t etc. is unlikely to change very often.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h   | 8 ++++----
 arch/powerpc/include/asm/book3s/64/hash-64k.h  | 9 +++++----
 arch/powerpc/include/asm/book3s/64/radix-4k.h  | 9 +++++----
 arch/powerpc/include/asm/book3s/64/radix-64k.h | 8 ++++----
 4 files changed, 18 insertions(+), 16 deletions(-)

Someone *please* check my math :)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index cf5ba5254299..54fab723a8c7 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_HASH_4K_H
 #define _ASM_POWERPC_BOOK3S_64_HASH_4K_H
 
-#define H_PTE_INDEX_SIZE  9
-#define H_PMD_INDEX_SIZE  7
-#define H_PUD_INDEX_SIZE  9
-#define H_PGD_INDEX_SIZE  9
+#define H_PTE_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x   4KB =   2MB
+#define H_PMD_INDEX_SIZE  7  // size: 8B << 7 = 1KB, maps: 2^7 x   2MB = 256MB
+#define H_PUD_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x 256MB = 128GB
+#define H_PGD_INDEX_SIZE  9  // size: 8B << 9 = 4KB, maps: 2^9 x 128GB =  64TB
 
 /*
  * Each context is 512TB. But on 4k we restrict our max TASK size to 64TB
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f82ee8a3b561..81f4eb6e7da4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -2,10 +2,11 @@
 #ifndef _ASM_POWERPC_BOOK3S_64_HASH_64K_H
 #define _ASM_POWERPC_BOOK3S_64_HASH_64K_H
 
-#define H_PTE_INDEX_SIZE  8
-#define H_PMD_INDEX_SIZE  10
-#define H_PUD_INDEX_SIZE  10
-#define H_PGD_INDEX_SIZE  8
+#define H_PTE_INDEX_SIZE   8  // size: 8B <<  8 = 2KB, maps 2^8  x 64KB = 16MB
+#define H_PMD_INDEX_SIZE  10  // size: 8B << 10 = 8KB, maps 2^10 x 16MB = 16GB
+#define H_PUD_INDEX_SIZE  10  // size: 8B << 10 = 8KB, maps 2^10 x 16GB = 16TB
+#define H_PGD_INDEX_SIZE   8  // size: 8B <<  8 = 2KB, maps 2^8  x 16TB =  4PB
+
 
 /*
  * Each context is 512TB size. SLB miss for first context/default context
diff --git a/arch/powerpc/include/asm/book3s/64/radix-4k.h b/arch/powerpc/include/asm/book3s/64/radix-4k.h
index 863c3e8286fb..d5f5ab73dc7f 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -5,10 +5,11 @@
 /*
  * For 4K page size supported index is 13/9/9/9
  */
-#define RADIX_PTE_INDEX_SIZE  9  /* 2MB huge page */
-#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
-#define RADIX_PUD_INDEX_SIZE	 9
-#define RADIX_PGD_INDEX_SIZE  13
+#define RADIX_PTE_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x    4K =   2MB
+#define RADIX_PMD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   2MB =   1GB
+#define RADIX_PUD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   1GB = 512GB
+#define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
+
 /*
  * One fragment per per page
  */
diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
index ccb78ca9d0c5..54e33828b0fb 100644
--- a/arch/powerpc/include/asm/book3s/64/radix-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
@@ -5,10 +5,10 @@
 /*
  * For 64K page size supported index is 13/9/9/5
  */
-#define RADIX_PTE_INDEX_SIZE  5  /* 2MB huge page */
-#define RADIX_PMD_INDEX_SIZE  9  /* 1G huge page */
-#define RADIX_PUD_INDEX_SIZE	 9
-#define RADIX_PGD_INDEX_SIZE  13
+#define RADIX_PTE_INDEX_SIZE   5  // size: 8B <<  5 = 256B, maps 2^5  x   64K =   2MB
+#define RADIX_PMD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   2MB =   1GB
+#define RADIX_PUD_INDEX_SIZE   9  // size: 8B <<  9 =  4KB, maps 2^9  x   1GB = 512GB
+#define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
 
 /*
  * We use a 256 byte PTE page fragment in radix
-- 
2.20.1

