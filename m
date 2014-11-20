Return-Path: <mgorman@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59B991A0979
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 21:19:59 +1100 (AEDT)
From: Mel Gorman <mgorman@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/10] mm: Add p[te|md] protnone helpers for use by NUMA
 balancing
Date: Thu, 20 Nov 2014 10:19:42 +0000
Message-Id: <1416478790-27522-3-git-send-email-mgorman@suse.de>
In-Reply-To: <1416478790-27522-1-git-send-email-mgorman@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
Cc: Rik van Riel <riel@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Mel Gorman <mgorman@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a preparatory patch that introduces protnone helpers for automatic
NUMA balancing.

Signed-off-by: Mel Gorman <mgorman@suse.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h | 11 +++++++++++
 arch/x86/include/asm/pgtable.h     | 16 ++++++++++++++++
 include/asm-generic/pgtable.h      | 19 +++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 316f9a5..452c3b4 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -39,6 +39,17 @@ static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK)
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_NUMA_BALANCING
+static inline int pte_protnone_numa(pte_t pte)
+{
+	return (pte_val(pte) &
+		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+}
+
+static inline int pmd_protnone_numa(pmd_t pmd)
+{
+	return pte_protnone_numa(pmd_pte(pmd));
+}
+
 static inline int pte_present(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NUMA_MASK;
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index aa97a07..613cd00 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -497,6 +497,22 @@ static inline int pmd_present(pmd_t pmd)
 				 _PAGE_NUMA);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * These work without NUMA balancing but the kernel does not care. See the
+ * comment in include/asm-generic/pgtable.h
+ */
+static inline int pte_protnone_numa(pte_t pte)
+{
+	return pte_flags(pte) & _PAGE_PROTNONE;
+}
+
+static inline int pmd_protnone_numa(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_PROTNONE;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static inline int pmd_none(pmd_t pmd)
 {
 	/* Only check low word on 32-bit platforms, since it might be
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 752e30d..7e74122 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -677,6 +677,25 @@ static inline int pmd_trans_unstable(pmd_t *pmd)
 #endif
 }
 
+#ifndef CONFIG_NUMA_BALANCING
+/*
+ * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
+ * the only case the kernel cares is for NUMA balancing. By default,
+ * implement the helper as "always no". Note that this does not check VMA
+ * protection bits meaning that it is up to the caller to distinguish between
+ * PROT_NONE protections and NUMA hinting fault protections.
+ */
+static inline int pte_protnone_numa(pte_t pte)
+{
+	return 0;
+}
+
+static inline int pmd_protnone_numa(pmd_t pmd)
+{
+	return 0;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * _PAGE_NUMA distinguishes between an unmapped page table entry, an entry that
-- 
2.1.2
