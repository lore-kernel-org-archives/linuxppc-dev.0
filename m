Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJqqq3TJlzDvqL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 03:45:11 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGGdUoP069646
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:45:09 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rnsehgs6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 11:45:09 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 11:45:08 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 Balbir Singh <bsingharora@gmail.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: allow memory hotplug into an offline node
Date: Wed, 16 Nov 2016 10:45:03 -0600
In-Reply-To: <20161116164057.mzlhfigsuwn53r72@arbab-laptop.austin.ibm.com>
References: <20161116164057.mzlhfigsuwn53r72@arbab-laptop.austin.ibm.com>
Message-Id: <1479314703-18989-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Relax the check preventing us from hotplugging into an offline node.

This limitation was added in commit 482ec7c403d2 ("[PATCH] powerpc numa:
Support sparse online node map") to prevent adding resources to an
uninitialized node.

These days, there is no harm in doing so. The addition will actually
cause the node to be initialized and onlined; add_memory_resource()
calls hotadd_new_pgdat() (if necessary) and node_set_online().

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
This applies on top of "powerpc/mm: allow memory hotplug into a
memoryless node", currently in the -mm tree:
http://lkml.kernel.org/r/1479160961-25840-2-git-send-email-arbab@linux.vnet.ibm.com

 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d69f6f6..07620c9 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1091,7 +1091,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 		nid = hot_add_node_scn_to_nid(scn_addr);
 	}
 
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
 	return nid;
-- 
1.8.3.1
