Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2N6M3qfLzDqR3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 06:07:55 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0GJ4On2077113
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 14:07:53 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28126f47eg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 14:07:52 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 16 Jan 2017 14:07:51 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v5 2/4] powerpc/mm: add radix__create_section_mapping()
Date: Mon, 16 Jan 2017 13:07:44 -0600
In-Reply-To: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1484593666-8001-3-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wire up memory hotplug page mapping for radix. Share the mapping
function already used by radix_init_pgtable().

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h | 4 ++++
 arch/powerpc/mm/pgtable-book3s64.c         | 2 +-
 arch/powerpc/mm/pgtable-radix.c            | 7 +++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index b4d1302..43c2571 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -291,5 +291,9 @@ static inline unsigned long radix__get_tree_size(void)
 	}
 	return rts_field;
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int radix__create_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 653ff6c..2b13f6b 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -131,7 +131,7 @@ void mmu_cleanup_all(void)
 int create_section_mapping(unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
-		return -ENODEV;
+		return radix__create_section_mapping(start, end);
 
 	return hash__create_section_mapping(start, end);
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 2ce1354..075b4ec 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -475,6 +475,13 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	memblock_set_current_limit(first_memblock_base + first_memblock_size);
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
+{
+	return create_physical_mapping(start, end);
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 int __meminit radix__vmemmap_create_mapping(unsigned long start,
 				      unsigned long page_size,
-- 
1.8.3.1
