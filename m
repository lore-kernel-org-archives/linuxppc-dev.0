Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA7901A1785
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 19:35:30 +1000 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 27 Aug 2014 10:35:26 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5025417D804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 10:37:20 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7R9ZOiO20840448
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 09:35:24 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7R4Y7bq006099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Aug 2014 00:34:07 -0400
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 3/3] powerpc: some changes in numa_setup_cpu()
Date: Wed, 27 Aug 2014 17:34:01 +0800
Message-Id: <1409132041-11890-3-git-send-email-zhong@linux.vnet.ibm.com>
In-Reply-To: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>,
 Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, paulus@samba.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

this patches changes some error handling logics in numa_setup_cpu(),
when cpu node is not found, so:

if the cpu is possible, but not present, -1 is kept in numa_cpu_lookup_table,
so later, if the cpu is added, we could set correct numa information for it.

if the cpu is present, then we set the first online node to
numa_cpu_lookup_table instead of 0 ( in case 0 might not be an online node? )

Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3a9061e..ec32d46 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -538,7 +538,7 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
  */
 static int numa_setup_cpu(unsigned long lcpu)
 {
-	int nid;
+	int nid = -1;
 	struct device_node *cpu;
 
 	/*
@@ -555,19 +555,21 @@ static int numa_setup_cpu(unsigned long lcpu)
 
 	if (!cpu) {
 		WARN_ON(1);
-		nid = 0;
-		goto out;
+		if (cpu_present(lcpu))
+			goto out_present;
+		else
+			goto out;
 	}
 
 	nid = of_node_to_nid_single(cpu);
 
+out_present:
 	if (nid < 0 || !node_online(nid))
 		nid = first_online_node;
-out:
-	map_cpu_to_node(lcpu, nid);
 
+	map_cpu_to_node(lcpu, nid);
 	of_node_put(cpu);
-
+out:
 	return nid;
 }
 
-- 
1.9.1
