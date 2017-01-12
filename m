Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzg2D0b2BzDqgm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:09:55 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0C98P3A075362
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 04:09:54 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27x4hkd5aj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 04:09:53 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Thu, 12 Jan 2017 02:09:53 -0700
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Boqun Feng <boqun.feng@gmail.com>, jia he <hejianet@linux.vnet.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: fix a hardcode on memory boundary checking
Date: Thu, 12 Jan 2017 17:09:06 +0800
Message-Id: <20170112090906.17864-1-rui.teng@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The offset of hugepage block will not be 16G, if the expected
page is more than one. Calculate the totol size instead of the
hardcode value.

Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 8033493..b829f8e 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -506,7 +506,7 @@ static int __init htab_dt_scan_hugepage_blocks(unsigned long node,
 	printk(KERN_INFO "Huge page(16GB) memory: "
 			"addr = 0x%lX size = 0x%lX pages = %d\n",
 			phys_addr, block_size, expected_pages);
-	if (phys_addr + (16 * GB) <= memblock_end_of_DRAM()) {
+	if (phys_addr + block_size * expected_pages <= memblock_end_of_DRAM()) {
 		memblock_reserve(phys_addr, block_size * expected_pages);
 		add_gpage(phys_addr, block_size, expected_pages);
 	}
-- 
2.9.0
