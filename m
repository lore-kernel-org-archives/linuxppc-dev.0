Return-Path: <cody@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 536661400BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Apr 2014 03:11:18 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 15 Apr 2014 13:11:14 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3F51C38C801E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:13 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3FHBDI52032030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 17:11:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3FHBBvo022636
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 13:11:11 -0400
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH v2 4/6] powerpc/perf/hv-24x7: use (unsigned long) not (u32)
 values when calling plpar_hcall_norets()
Date: Tue, 15 Apr 2014 10:10:53 -0700
Message-Id: <1397581855-4585-5-git-send-email-cody@linux.vnet.ibm.com>
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

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index f5bca73..3e8f60a 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -155,16 +155,28 @@ static ssize_t read_offset_data(void *dest, size_t dest_len,
 	return copy_len;
 }
 
-static unsigned long h_get_24x7_catalog_page(char page[static 4096],
-					     u32 version, u32 index)
+static unsigned long h_get_24x7_catalog_page_(unsigned long phys_4096,
+					      unsigned long version,
+					      unsigned long index)
 {
-	WARN_ON(!IS_ALIGNED((unsigned long)page, 4096));
+	pr_devel("h_get_24x7_catalog_page(0x%lx, %lu, %lu)",
+			phys_4096,
+			version,
+			index);
+	WARN_ON(!IS_ALIGNED(phys_4096, 4096));
 	return plpar_hcall_norets(H_GET_24X7_CATALOG_PAGE,
-			virt_to_phys(page),
+			phys_4096,
 			version,
 			index);
 }
 
+static unsigned long h_get_24x7_catalog_page(char page[static 4096],
+					     u32 version, u32 index)
+{
+	return h_get_24x7_catalog_page_(virt_to_phys(page),
+					version, index);
+}
+
 static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
 			    struct bin_attribute *bin_attr, char *buf,
 			    loff_t offset, size_t count)
-- 
1.9.2
