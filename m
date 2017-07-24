Return-Path: <victora@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGdTB0Ty6zDrBS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 09:52:13 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6ONmePp094277
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:52:10 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bwpb8jupd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 19:52:10 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <victora@linux.vnet.ibm.com>;
 Mon, 24 Jul 2017 20:52:08 -0300
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6ONq5le26214508
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:52:05 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6ONq6EF031941
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 20:52:06 -0300
From: Victor Aoqui <victora@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com
Cc: victora@br.ibm.com, victora@linux.vnet.ibm.com, mauricfo@linux.vnet.ibm.com
Subject: [PATCH v3] powerpc/mm: Implemented default_hugepagesz verification
 for powerpc
Date: Mon, 24 Jul 2017 20:52:02 -0300
Message-Id: <20170724235202.5675-1-victora@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implemented default hugepage size verification (default_hugepagesz=)
in order to allow allocation of defined number of pages (hugepages=)
only for supported hugepage sizes.

Signed-off-by: Victor Aoqui <victora@linux.vnet.ibm.com>
---
v2:

- Renamed default_hugepage_setup_sz function to hugetlb_default_size_setup;
- Added powerpc string to error message.

v3:

- Renamed hugetlb_default_size_setup() to hugepage_default_setup_sz();
- Implemented hugetlb_bad_default_size();
- Reimplemented hugepage_setup_sz() to just parse default_hugepagesz= and
check if it's a supported size;
- Added verification of default_hugepagesz= value on hugetlb_nrpages_setup()
before allocating hugepages.

 arch/powerpc/mm/hugetlbpage.c | 15 +++++++++++++++
 include/linux/hugetlb.h       |  1 +
 mm/hugetlb.c                  | 17 +++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index e1bf5ca..5990381 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -780,6 +780,21 @@ static int __init hugepage_setup_sz(char *str)
 }
 __setup("hugepagesz=", hugepage_setup_sz);
 
+static int __init hugepage_default_setup_sz(char *str)
+{
+	unsigned long long size;
+
+	size = memparse(str, &str);
+
+	if (add_huge_page_size(size) != 0) {
+		hugetlb_bad_default_size();
+		pr_err("Invalid ppc default huge page size specified(%llu)\n", size);
+	}
+
+	return 1;
+}
+__setup("default_hugepagesz=", hugepage_default_setup_sz);
+
 struct kmem_cache *hugepte_cache;
 static int __init hugetlbpage_init(void)
 {
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 0ed8e41..2927200 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -361,6 +361,7 @@ int huge_add_to_page_cache(struct page *page, struct address_space *mapping,
 int __init alloc_bootmem_huge_page(struct hstate *h);
 
 void __init hugetlb_bad_size(void);
+void __init hugetlb_bad_default_size(void);
 void __init hugetlb_add_hstate(unsigned order);
 struct hstate *size_to_hstate(unsigned long size);
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bc48ee7..3c24266 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,6 +54,7 @@
 static unsigned long __initdata default_hstate_max_huge_pages;
 static unsigned long __initdata default_hstate_size;
 static bool __initdata parsed_valid_hugepagesz = true;
+static bool __initdata parsed_valid_default_hugepagesz = true;
 
 /*
  * Protects updates to hugepage_freelists, hugepage_activelist, nr_huge_pages,
@@ -2804,6 +2805,12 @@ void __init hugetlb_bad_size(void)
 	parsed_valid_hugepagesz = false;
 }
 
+/* Should be called on processing a default_hugepagesz=... option */
+void __init hugetlb_bad_default_size(void)
+{
+	parsed_valid_default_hugepagesz = false;
+}
+
 void __init hugetlb_add_hstate(unsigned int order)
 {
 	struct hstate *h;
@@ -2846,8 +2853,14 @@ static int __init hugetlb_nrpages_setup(char *s)
 	 * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter yet,
 	 * so this hugepages= parameter goes to the "default hstate".
 	 */
-	else if (!hugetlb_max_hstate)
-		mhp = &default_hstate_max_huge_pages;
+	else if (!hugetlb_max_hstate) {
+		if (!parsed_valid_default_hugepagesz) {
+			pr_warn("hugepages = %s cannot be allocated for "
+				"unsupported default_hugepagesz, ignoring\n", s);
+			parsed_valid_default_hugepagesz = true;
+		} else
+			mhp = &default_hstate_max_huge_pages;
+	}
 	else
 		mhp = &parsed_hstate->max_huge_pages;
 
-- 
1.8.3.1
