Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KKzg3nQPzF3Js
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 22:25:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8PCKCdK043746
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 08:25:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mqmbxsv53-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 08:25:48 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 25 Sep 2018 13:25:46 +0100
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@au1.ibm.com>
Cc: Michael Bringmann <mbringm@us.ibm.com>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Harish <harisrir@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/numa: Use associativity if VPHN hcall is successful
Date: Tue, 25 Sep 2018 17:55:15 +0530
Message-Id: <1537878315-10783-1-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently associativity is used to lookup node-id even if the preceding
VPHN hcall failed. However this can cause CPU to be made part of the
wrong node, (most likely to be node 0). This is because VPHN is not
enabled on kvm guests.

With 2ea6263 ("powerpc/topology: Get topology for shared processors at
boot"), associativity is used to set to the wrong node. Hence KVM guest
topology is broken.

For example : A 4 node KVM guest before would have reported.

[root@localhost ~]#  numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3
node 0 size: 1746 MB
node 0 free: 1604 MB
node 1 cpus: 4 5 6 7
node 1 size: 2044 MB
node 1 free: 1765 MB
node 2 cpus: 8 9 10 11
node 2 size: 2044 MB
node 2 free: 1837 MB
node 3 cpus: 12 13 14 15
node 3 size: 2044 MB
node 3 free: 1903 MB
node distances:
node   0   1   2   3
  0:  10  40  40  40
  1:  40  10  40  40
  2:  40  40  10  40
  3:  40  40  40  10

would now report

[root@localhost ~]# numactl -H
available: 4 nodes (0-3)
node 0 cpus: 0 2 3 4 5 6 7 8 9 10 11 12 13 14 15
node 0 size: 1746 MB
node 0 free: 1244 MB
node 1 cpus:
node 1 size: 2044 MB
node 1 free: 2032 MB
node 2 cpus: 1
node 2 size: 2044 MB
node 2 free: 2028 MB
node 3 cpus:
node 3 size: 2044 MB
node 3 free: 2032 MB
node distances:
node   0   1   2   3
  0:  10  40  40  40
  1:  40  10  40  40
  2:  40  40  10  40
  3:  40  40  40  10

Fix this by skipping associativity lookup if the VPHN hcall failed.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 35ac5422903a..e94148a1d7e4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1204,7 +1204,9 @@ int find_and_online_cpu_nid(int cpu)
 	int new_nid;
 
 	/* Use associativity from first thread for all siblings */
-	vphn_get_associativity(cpu, associativity);
+	if (vphn_get_associativity(cpu, associativity))
+		return cpu_to_node(cpu);
+
 	new_nid = associativity_to_nid(associativity);
 	if (new_nid < 0 || !node_possible(new_nid))
 		new_nid = first_online_node;
-- 
2.12.3
