Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A191AECDE43
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:23:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2CC121470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CC121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bt8B60c1zF3Vp
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:23:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bswm1MGpzF3V8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:13:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bswl6rDMz9sCm; Fri, 19 Oct 2018 15:13:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bswl6J5Qz9sDP; Fri, 19 Oct 2018 15:13:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] powerpc/mm/radix: Simplify split mapping logic
Date: Fri, 19 Oct 2018 15:13:33 +1100
Message-Id: <20181019041334.4945-5-mpe@ellerman.id.au>
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

If we look closely at the logic in create_physical_mapping(), when
we're doing STRICT_KERNEL_RWX, we do the following steps:
  - determine the gap from where we are to the end of the range
  - choose an appropriate mapping_size based on the gap
  - check if that mapping_size would overlap the __init_begin
    boundary, and if not choose an appropriate mapping_size

We can simplify the logic by taking the __init_begin boundary into
account when we calculate the initial gap.

So add a next_boundary() function which tells us what the next
boundary is, either the __init_begin boundary or end. In future we can
add more boundaries.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 030543451229..0e87733eed80 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -255,17 +255,21 @@ static inline void __meminit print_mapping(unsigned long start,
 	pr_info("Mapped 0x%016lx-0x%016lx with %s pages\n", start, end, buf);
 }
 
+static unsigned long next_boundary(unsigned long addr, unsigned long end)
+{
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	if (addr < __pa_symbol(__init_begin))
+		return __pa_symbol(__init_begin);
+#endif
+	return end;
+}
+
 static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end,
 					     int nid)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
-#ifdef CONFIG_STRICT_KERNEL_RWX
-	int split_text_mapping = 1;
-#else
-	int split_text_mapping = 0;
-#endif
 	int psize;
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
@@ -273,7 +277,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		unsigned long gap, previous_size;
 		int rc;
 
-		gap = end - addr;
+		gap = next_boundary(addr, end) - addr;
 		previous_size = mapping_size;
 
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
@@ -289,22 +293,6 @@ static int __meminit create_physical_mapping(unsigned long start,
 			psize = mmu_virtual_psize;
 		}
 
-		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
-			(addr < __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) > __pa_symbol(__init_begin)) {
-			if (mmu_psize_defs[MMU_PAGE_2M].shift)
-				mapping_size = PMD_SIZE;
-			else
-				mapping_size = PAGE_SIZE;
-		}
-
-		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
-		    (addr < __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) > __pa_symbol(__init_begin)) {
-			mapping_size = PAGE_SIZE;
-			psize = mmu_virtual_psize;
-		}
-
 		if (mapping_size != previous_size) {
 			print_mapping(start, addr, previous_size);
 			start = addr;
-- 
2.17.2

