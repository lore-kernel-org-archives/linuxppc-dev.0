Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B0B971A033F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:14:02 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 22:14:01 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 29B062BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:56 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HCDmwj45547774
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:56 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HCDNF6013538
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:23 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 2/4] powerpc/mm: Add comments to the vmemmap layout
Date: Wed, 17 Feb 2016 17:42:57 +0530
Message-Id: <1455711179-20357-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add some explaination to the layout of vmemmap virtual address
space and how physical page mapping is only used for valid PFNs
present at any point on the system.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8d1c41d..9db4a86 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -26,6 +26,47 @@
 #define IOREMAP_BASE	(PHB_IO_END)
 #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
 
+/*
+ * Starting address of the virtual address space where all page structs
+ * for the system physical memory are stored under the vmemmap sparse
+ * memory model. All possible struct pages are logically stored in a
+ * sequence in this virtual address space irrespective of the fact
+ * whether any given PFN is valid or even the memory section is valid
+ * or not. During boot and memory hotplug add operation when new memory
+ * sections are added, real physical allocation and hash table bolting
+ * will be performed. This saves precious physical memory when the system
+ * really does not have valid PFNs in some address ranges.
+ *
+ *  vmemmap +--------------+
+ *     +    |  page struct +----------+  PFN is valid
+ *     |    +--------------+          |
+ *     |    |  page struct |          |  PFN is invalid
+ *     |    +--------------+          |
+ *     |    |  page struct +------+   |
+ *     |    +--------------+      |   |
+ *     |    |  page struct |      |   |
+ *     |    +--------------+      |   |
+ *     |    |  page struct |      |   |
+ *     |    +--------------+      |   |
+ *     |    |  page struct +--+   |   |
+ *     |    +--------------+  |   |   |
+ *     |    |  page struct |  |   |   |       +-------------+
+ *     |    +--------------+  |   |   +-----> |     PFN     |
+ *     |    |  page struct |  |   |           +-------------+
+ *     |    +--------------+  |   +---------> |     PFN     |
+ *     |    |  page struct |  |               +-------------+
+ *     |    +--------------+  +-------------> |     PFN     |
+ *     |    |  page struct |                  +-------------+
+ *     |    +--------------+           +----> |     PFN     |
+ *     |    |  page struct |           |      +-------------+
+ *     |    +--------------+           |    Bolted in hash table
+ *     |    |  page struct +-----------+
+ *     v    +--------------+
+ *
+ * VMEMMAP_BASE (0xf000000000000000) region has a total range of 64TB but
+ * then it uses NR_MEM_SECTIONS * PAGES_PER_SECTION * sizeof(page struct)
+ * amount of virtual memory from it.
+ */
 #define vmemmap			((struct page *)VMEMMAP_BASE)
 
 /* Advertise special mapping type for AGP */
-- 
2.1.0
