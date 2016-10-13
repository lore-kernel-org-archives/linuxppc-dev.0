Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw06k2jrtzDt1g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 05:45:50 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9DIi8i1047333
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:45:45 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 262bdtqxxk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 14:45:44 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 13 Oct 2016 12:45:43 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: simplify loop control in parse_numa_properties()
Date: Thu, 13 Oct 2016 13:45:30 -0500
Message-Id: <1476384330-22654-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The flow of the main loop in parse_numa_properties() is overly
complicated. Simplify it to be less confusing and easier to read.
No functional change.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index d7ac419..b30ced8 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -786,14 +786,9 @@ new_range:
 		fake_numa_create_new_node(((start + size) >> PAGE_SHIFT), &nid);
 		node_set_online(nid);
 
-		if (!(size = numa_enforce_memory_limit(start, size))) {
-			if (--ranges)
-				goto new_range;
-			else
-				continue;
-		}
-
-		memblock_set_node(start, size, &memblock.memory, nid);
+		size = numa_enforce_memory_limit(start, size);
+		if (size)
+			memblock_set_node(start, size, &memblock.memory, nid);
 
 		if (--ranges)
 			goto new_range;
-- 
1.8.3.1
