Return-Path: <bsingharora@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2Ckx4mYSzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:51:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8R9nAMp080455
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:51:18 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d87tvee0x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 05:51:17 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bsingharora@gmail.com>;
 Wed, 27 Sep 2017 19:51:15 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8R9pCfI39387228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:51:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8R9p54l021851
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 19:51:05 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] powerpc/strict_rwx: fixup region splitting
Date: Wed, 27 Sep 2017 19:51:11 +1000
In-Reply-To: <20170927095111.10626-1-bsingharora@gmail.com>
References: <20170927095111.10626-1-bsingharora@gmail.com>
Message-Id: <20170927095111.10626-2-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We were aggressive with splitting regions and missed the case
when _stext and __init_begin completely overlap addr and addr+mapping.

This patch fixes that case and allows us to keep the largest possible
mapping through the overlap. The patch also simplies the check
into a function

Fixes: 7614ff3 ("powerpc/mm/radix: Implement STRICT_RWX/mark_rodata_ro() for Radix")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c2a2b46..ea0da3b 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -210,17 +210,36 @@ static inline void __meminit print_mapping(unsigned long start,
 	pr_info("Mapped 0x%016lx-0x%016lx with %s pages\n", start, end, buf);
 }
 
+static inline int __meminit
+should_split_mapping_size(unsigned long addr, unsigned long mapping_size)
+{
+#ifdef CONFIG_STRICT_KERNEL_RWX
+	/*
+	 * If addr, addr+mapping overlap the text region and
+	 * _stext and __init_begin end up lying between
+	 * addr, addr+mapping split the mapping size down
+	 * further
+	 */
+	if ((addr < __pa_symbol(__init_begin)) &&
+		(addr + mapping_size) > __pa_symbol(_stext)) {
+
+		if (((addr + mapping_size) <= __pa_symbol(__init_begin)) &&
+			(addr >= __pa_symbol(_stext)))
+			return 0;
+
+		return 1;
+	}
+#endif
+	return 0;
+}
+
+
 static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	pgprot_t prot;
 	unsigned long max_mapping_size;
-#ifdef CONFIG_STRICT_KERNEL_RWX
-	int split_text_mapping = 1;
-#else
-	int split_text_mapping = 0;
-#endif
 
 	start = _ALIGN_UP(start, PAGE_SIZE);
 	for (addr = start; addr < end; addr += mapping_size) {
@@ -242,16 +261,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			mapping_size = PAGE_SIZE;
 
-		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
-			(addr <= __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(_stext)) {
+		if ((mapping_size == PUD_SIZE) &&
+			should_split_mapping_size(addr, mapping_size)) {
 			max_mapping_size = PMD_SIZE;
 			goto retry;
 		}
 
-		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
-		    (addr <= __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(_stext))
+		if ((mapping_size == PMD_SIZE) &&
+			should_split_mapping_size(addr, mapping_size))
 			mapping_size = PAGE_SIZE;
 
 		if (mapping_size != previous_size) {
-- 
2.9.5
