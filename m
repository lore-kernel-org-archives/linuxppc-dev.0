Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gqqr2btgzF3Q8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 20:40:22 +1000 (AEST)
From: YueHaibing <yuehaibing@huawei.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <nfont@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc/pseries/memory-hotplug: Fix return value type
 of find_aa_index
Date: Fri, 21 Sep 2018 18:37:59 +0800
Message-ID: <20180921103759.24976-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

find_aa_index will return -1 when dlpar_clone_property fails,
its return value type should be int. Also the caller
update_lmb_associativity_index should use a int variable to
get it,then compared with 0.

Fixes: c05a5a40969e ("powerpc/pseries: Dynamic add entires to associativity lookup array")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9a15d39..6aad17c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -101,13 +101,12 @@ static struct property *dlpar_clone_property(struct property *prop,
 	return new_prop;
 }
 
-static u32 find_aa_index(struct device_node *dr_node,
+static int find_aa_index(struct device_node *dr_node,
 			 struct property *ala_prop, const u32 *lmb_assoc)
 {
 	u32 *assoc_arrays;
-	u32 aa_index;
 	int aa_arrays, aa_array_entries, aa_array_sz;
-	int i, index;
+	int i, index, aa_index;
 
 	/*
 	 * The ibm,associativity-lookup-arrays property is defined to be
@@ -168,7 +167,7 @@ static int update_lmb_associativity_index(struct drmem_lmb *lmb)
 	struct device_node *parent, *lmb_node, *dr_node;
 	struct property *ala_prop;
 	const u32 *lmb_assoc;
-	u32 aa_index;
+	int aa_index;
 
 	parent = of_find_node_by_path("/");
 	if (!parent)
-- 
2.7.0
