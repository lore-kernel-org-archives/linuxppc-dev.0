Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADAB41A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:14:00 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 22:14:00 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64D7F3578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:55 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HCDkHH10027240
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:55 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HCDMui013502
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:22 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 1/4] powerpc/mm: Rename variable to reflect start address of a
 section
Date: Wed, 17 Feb 2016 17:42:56 +0530
Message-Id: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The commit (16a05bff1: powerpc: start loop at section start of
start in vmemmap_populated()) reused 'start' variable to compute
the starting address of the memory section where the given address
belongs. Then the same variable is used for iterating over starting
address of all memory sections before reaching the 'end' address.
Renaming it as 'section_start' makes the logic more clear.

Fixes: 16a05bff1 ("powerpc: start loop at section start of start in vmemmap_populated()")
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/init_64.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 379a6a9..d6b9b4d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -170,11 +170,15 @@ static unsigned long __meminit vmemmap_section_start(unsigned long page)
  */
 static int __meminit vmemmap_populated(unsigned long start, int page_size)
 {
-	unsigned long end = start + page_size;
-	start = (unsigned long)(pfn_to_page(vmemmap_section_start(start)));
+	unsigned long end, section_start;
 
-	for (; start < end; start += (PAGES_PER_SECTION * sizeof(struct page)))
-		if (pfn_valid(page_to_pfn((struct page *)start)))
+	end = start + page_size;
+	section_start = (unsigned long)(pfn_to_page
+					(vmemmap_section_start(start)));
+
+	for (; section_start < end; section_start
+				+= (PAGES_PER_SECTION * sizeof(struct page)))
+		if (pfn_valid(page_to_pfn((struct page *)section_start)))
 			return 1;
 
 	return 0;
-- 
2.1.0
