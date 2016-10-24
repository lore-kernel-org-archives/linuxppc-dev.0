Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2nCL57HrzDvkk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 06:58:22 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9OJrpvG120237
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:58:21 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 269ksj1t8a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:58:21 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 13:58:20 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: [PATCH v5 1/3] powerpc/mm: allow memory hotplug into a memoryless node
Date: Mon, 24 Oct 2016 14:58:07 -0500
In-Reply-To: <1477339089-5455-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1477339089-5455-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1477339089-5455-2-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the check which prevents us from hotplugging into an empty node.

The original commit b226e4621245 ("[PATCH] powerpc: don't add memory to
empty node/zone"), states that this was intended to be a temporary measure.
It is a workaround for an oops which no longer occurs.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index a51c188..0cb6bd8 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1085,7 +1085,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 int hot_add_scn_to_nid(unsigned long scn_addr)
 {
 	struct device_node *memory = NULL;
-	int nid, found = 0;
+	int nid;
 
 	if (!numa_enabled || (min_common_depth < 0))
 		return first_online_node;
@@ -1101,17 +1101,6 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 	if (nid < 0 || !node_online(nid))
 		nid = first_online_node;
 
-	if (NODE_DATA(nid)->node_spanned_pages)
-		return nid;
-
-	for_each_online_node(nid) {
-		if (NODE_DATA(nid)->node_spanned_pages) {
-			found = 1;
-			break;
-		}
-	}
-
-	BUG_ON(!found);
 	return nid;
 }
 
-- 
1.8.3.1
