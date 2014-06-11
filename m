Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8465D1A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 18:24:07 +1000 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 11 Jun 2014 13:54:03 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F0E85E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:55:00 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5B8OABi60751982
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:54:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5B8Nvqx018013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 13:53:57 +0530
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] powerpc: implement vmemmap_remove_mapping() for BOOK3S
Date: Wed, 11 Jun 2014 16:23:37 +0800
Message-Id: <1402475019-19699-2-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1402475019-19699-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: paulus@samba.org, Li Zhong <zhong@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to be called in vmemmap_free(), leave the implementation on BOOK3E 
empty as before.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |    2 +-
 arch/powerpc/mm/init_64.c       |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 88fdd9d..25d9d66 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -243,7 +243,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static int htab_remove_mapping(unsigned long vstart, unsigned long vend,
+int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 		      int psize, int ssize)
 {
 	unsigned long vaddr;
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index fa5d28b..69203c8 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -212,6 +212,13 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 	for (i = 0; i < page_size; i += PAGE_SIZE)
 		BUG_ON(map_kernel_page(start + i, phys, flags));
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static void vmemmap_remove_mapping(unsigned long start,
+				   unsigned long page_size)
+{
+}
+#endif
 #else /* CONFIG_PPC_BOOK3E */
 static void __meminit vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
@@ -223,6 +230,21 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 					mmu_kernel_ssize);
 	BUG_ON(mapped < 0);
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern int htab_remove_mapping(unsigned long vstart, unsigned long vend,
+			int psize, int ssize);
+
+static void vmemmap_remove_mapping(unsigned long start,
+				   unsigned long page_size)
+{
+	int mapped = htab_remove_mapping(start, start + page_size,
+					 mmu_vmemmap_psize,
+					 mmu_kernel_ssize);
+	BUG_ON(mapped < 0);
+}
+#endif
+
 #endif /* CONFIG_PPC_BOOK3E */
 
 struct vmemmap_backing *vmemmap_list;
-- 
1.7.9.5
