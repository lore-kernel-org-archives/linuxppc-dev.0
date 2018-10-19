Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A98ECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:21:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 444822145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444822145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bt671SLWzF3VG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:21:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bswl1fCXzF3Tj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:13:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bswl0gm3z9sCm; Fri, 19 Oct 2018 15:13:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bswk6Wzbz9sDK; Fri, 19 Oct 2018 15:13:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/6] powerpc/mm/radix: Remove the retry in the split mapping
 logic
Date: Fri, 19 Oct 2018 15:13:32 +1100
Message-Id: <20181019041334.4945-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181019041334.4945-1-mpe@ellerman.id.au>
References: <20181019041334.4945-1-mpe@ellerman.id.au>
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

When we have CONFIG_STRICT_KERNEL_RWX enabled, we want to split the
linear mapping at the text/data boundary so we can map the kernel
text read only.

The current logic uses a goto inside the for loop, which works, but is
hard to reason about.

When we hit the goto retry case we set max_mapping_size to PMD_SIZE
and go back to the start.

Setting max_mapping_size means we skip the PUD case and go to the PMD
case.

We know we will pass the alignment and gap checks because the only
reason we are there is we hit the goto retry, and that is guarded by
mapping_size == PUD_SIZE, which means addr is PUD aligned and gap is
greater or equal to PUD_SIZE.

So the only part of the check that can fail is the mmu_psize_defs
check for the 2M page size.

If we just duplicate that check we can avoid the goto, and we get the
same result.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 7a44ec276290..030543451229 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -261,7 +261,6 @@ static int __meminit create_physical_mapping(unsigned long start,
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
-	unsigned long max_mapping_size;
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	int split_text_mapping = 1;
 #else
@@ -276,12 +275,9 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		gap = end - addr;
 		previous_size = mapping_size;
-		max_mapping_size = PUD_SIZE;
 
-retry:
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
-		    mmu_psize_defs[MMU_PAGE_1G].shift &&
-		    PUD_SIZE <= max_mapping_size) {
+		    mmu_psize_defs[MMU_PAGE_1G].shift) {
 			mapping_size = PUD_SIZE;
 			psize = MMU_PAGE_1G;
 		} else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
@@ -296,8 +292,10 @@ static int __meminit create_physical_mapping(unsigned long start,
 		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
 			(addr < __pa_symbol(__init_begin)) &&
 			(addr + mapping_size) > __pa_symbol(__init_begin)) {
-			max_mapping_size = PMD_SIZE;
-			goto retry;
+			if (mmu_psize_defs[MMU_PAGE_2M].shift)
+				mapping_size = PMD_SIZE;
+			else
+				mapping_size = PAGE_SIZE;
 		}
 
 		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
-- 
2.17.2

