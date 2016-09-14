Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZCHx5BZpzDscY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 06:07:09 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8EK2sPv087510
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 16:07:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25ewdfgv1d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 16:07:07 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 14:07:07 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/3] powerpc/mm: allow memory hotplug into a memoryless node
Date: Wed, 14 Sep 2016 15:06:57 -0500
In-Reply-To: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1473883618-14998-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1473883618-14998-3-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the check which prevents us from hotplugging into an empty node.

This limitation has been questioned before [1], and judging by the
response, there doesn't seem to be a reason we can't remove it. No issues
have been found in light testing.

[1] http://lkml.kernel.org/r/CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com
    http://lkml.kernel.org/r/20160511215051.GF22115@arbab-laptop.austin.ibm.com

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 75b9cd6..d7ac419 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1121,7 +1121,7 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 int hot_add_scn_to_nid(unsigned long scn_addr)
 {
 	struct device_node *memory = NULL;
-	int nid, found = 0;
+	int nid;
 
 	if (!numa_enabled || (min_common_depth < 0))
 		return first_online_node;
@@ -1137,17 +1137,6 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
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
