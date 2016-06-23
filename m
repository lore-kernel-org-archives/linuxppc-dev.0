Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rb6ch3GDlzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 02:39:31 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5NGYQhZ020718
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:39:29 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23ra2mebm3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 12:39:29 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 12:39:29 -0400
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Vasant Hegde <hegdevasant@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/mm: update arch_{add,remove}_memory() for radix
Date: Thu, 23 Jun 2016 11:39:22 -0500
Message-Id: <1466699962-22412-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These functions are making direct calls to the hash table APIs,
leading to a BUG() on systems using radix.

Switch them to the vmemmap_{create,remove}_mapping() wrappers, and
move to the __meminit section.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 2fd57fa..80c6ee7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -116,7 +116,7 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 #endif
 
-int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
+int __meminit arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 {
 	struct pglist_data *pgdata;
 	struct zone *zone;
@@ -127,7 +127,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	pgdata = NODE_DATA(nid);
 
 	start = (unsigned long)__va(start);
-	rc = create_section_mapping(start, start + size);
+	rc = vmemmap_create_mapping(start, size, __pa(start));
 	if (rc) {
 		pr_warning(
 			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
@@ -143,7 +143,7 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size)
+int __meminit arch_remove_memory(u64 start, u64 size)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
@@ -157,7 +157,7 @@ int arch_remove_memory(u64 start, u64 size)
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
-	ret = remove_section_mapping(start, start + size);
+	vmemmap_remove_mapping(start, size);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
 	 * hit that section of memory
-- 
1.8.3.1
