Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyTg91wwczDr4Z
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 03:04:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so9771669pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 10:04:53 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v5 6/7] mm/radix: Fix permissions correctly for
 interrupt_vectors
Date: Thu, 29 Jun 2017 03:04:10 +1000
Message-Id: <20170628170411.28864-7-bsingharora@gmail.com>
In-Reply-To: <20170628170411.28864-1-bsingharora@gmail.com>
References: <20170628170411.28864-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9abcc98 introduced marking kernel text as executable,
but missed some bits of the changes from hash_utils_64.c, where
under CONFIG_RELOCATABLE with CONFIG_RELOCATABLE_TEST or a kdump
kernel, if the size of the mapping was less than 1G, we end up
marking the first page (address range 0->mapping_size) as non
executable. As a side-effect none of the exception handlers
work

fixes - Commit 9abcc981de97
("powerpc/mm/radix: Only add X for pages overlapping kernel text")

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 6dc9923..ec21f97 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -230,6 +230,14 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			prot = PAGE_KERNEL;
 
+		/*
+		 * See the comment in hash_utils_64.c
+		 */
+		if ((PHYSICAL_START > MEMORY_START) &&
+			overlaps_interrupt_vector_text(vaddr,
+							vaddr + mapping_size))
+			prot = PAGE_KERNEL_X;
+
 		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
 		if (rc)
 			return rc;
-- 
2.9.4
