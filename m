Return-Path: <cody@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F38BE140093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:11:19 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 13:11:17 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 596696E801F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:07 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3FHBDqQ5636574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:11:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3FHBDfh022791
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:13 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v2 6/6] powerpc/perf/hv-24x7: catalog version number is be64,
 not be32
Date: Tue, 15 Apr 2014 10:10:55 -0700
Message-Id: <1397581855-4585-7-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1397581855-4585-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, David.Laight@aculab.com,
 Anton Blanchard <anton@samba.org>, Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The catalog version number was changed from a be32 (with proceeding
32bits of padding) to a be64, update the code to treat it as a be64

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 95a67f8..9d4badc 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -171,7 +171,7 @@ static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
 }
 
 static unsigned long h_get_24x7_catalog_page(char page[],
-					     u32 version, u32 index)
+					     u64 version, u32 index)
 {
 	return h_get_24x7_catalog_page_(virt_to_phys(page),
 					version, index);
@@ -185,7 +185,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 	ssize_t ret = 0;
 	size_t catalog_len = 0, catalog_page_len = 0, page_count = 0;
 	loff_t page_offset = 0;
-	uint32_t catalog_version_num = 0;
+	uint64_t catalog_version_num = 0;
 	void *page = kmem_cache_alloc(hv_page_cache, GFP_USER);
 	struct hv_24x7_catalog_page_0 *page_0 = page;
 	if (!page)
@@ -197,7 +197,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 		goto e_free;
 	}
 
-	catalog_version_num = be32_to_cpu(page_0->version);
+	catalog_version_num = be64_to_cpu(page_0->version);
 	catalog_page_len = be32_to_cpu(page_0->length);
 	catalog_len = catalog_page_len * 4096;
 
@@ -255,7 +255,7 @@ e_free:								\
 static DEVICE_ATTR_RO(_name)
 
 PAGE_0_ATTR(catalog_version, "%lld\n",
-		(unsigned long long)be32_to_cpu(page_0->version));
+		(unsigned long long)be64_to_cpu(page_0->version));
 PAGE_0_ATTR(catalog_len, "%lld\n",
 		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
 static BIN_ATTR_RO(catalog, 0/* real length varies */);
-- 
1.9.2
