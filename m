Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0EDECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:25:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A9721470
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 04:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A9721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42btBL4LYbzF3Sx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 15:25:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bswn2N3lzF3T9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 15:13:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bswn0csnz9sCm; Fri, 19 Oct 2018 15:13:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42bswm6qyVz9sDJ; Fri, 19 Oct 2018 15:13:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/6] powerpc/mm/radix: Display if mappings are exec or not
Date: Fri, 19 Oct 2018 15:13:34 +1100
Message-Id: <20181019041334.4945-6-mpe@ellerman.id.au>
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

At boot we print the ranges we've mapped for the linear mapping and
what page size we've used. Also track whether the range is mapped
executable or not and display that as well.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/pgtable-radix.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 0e87733eed80..931156069a81 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -241,9 +241,8 @@ void radix__mark_initmem_nx(void)
 }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
-static inline void __meminit print_mapping(unsigned long start,
-					   unsigned long end,
-					   unsigned long size)
+static inline void __meminit
+print_mapping(unsigned long start, unsigned long end, unsigned long size, bool exec)
 {
 	char buf[10];
 
@@ -252,7 +251,8 @@ static inline void __meminit print_mapping(unsigned long start,
 
 	string_get_size(size, 1, STRING_UNITS_2, buf, sizeof(buf));
 
-	pr_info("Mapped 0x%016lx-0x%016lx with %s pages\n", start, end, buf);
+	pr_info("Mapped 0x%016lx-0x%016lx with %s pages%s\n", start, end, buf,
+		exec ? " (exec)" : "");
 }
 
 static unsigned long next_boundary(unsigned long addr, unsigned long end)
@@ -269,6 +269,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 					     int nid)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
+	bool prev_exec, exec = false;
 	pgprot_t prot;
 	int psize;
 
@@ -279,6 +280,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 
 		gap = next_boundary(addr, end) - addr;
 		previous_size = mapping_size;
+		prev_exec = exec;
 
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
 		    mmu_psize_defs[MMU_PAGE_1G].shift) {
@@ -293,18 +295,21 @@ static int __meminit create_physical_mapping(unsigned long start,
 			psize = mmu_virtual_psize;
 		}
 
-		if (mapping_size != previous_size) {
-			print_mapping(start, addr, previous_size);
-			start = addr;
-		}
-
 		vaddr = (unsigned long)__va(addr);
 
 		if (overlaps_kernel_text(vaddr, vaddr + mapping_size) ||
-		    overlaps_interrupt_vector_text(vaddr, vaddr + mapping_size))
+		    overlaps_interrupt_vector_text(vaddr, vaddr + mapping_size)) {
 			prot = PAGE_KERNEL_X;
-		else
+			exec = true;
+		} else {
 			prot = PAGE_KERNEL;
+			exec = false;
+		}
+
+		if (mapping_size != previous_size || exec != prev_exec) {
+			print_mapping(start, addr, previous_size, prev_exec);
+			start = addr;
+		}
 
 		rc = __map_kernel_page(vaddr, addr, prot, mapping_size, nid, start, end);
 		if (rc)
@@ -313,7 +318,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 		update_page_count(psize, 1);
 	}
 
-	print_mapping(start, addr, mapping_size);
+	print_mapping(start, addr, mapping_size, exec);
 	return 0;
 }
 
-- 
2.17.2

