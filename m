Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B927D1A0616
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 15:40:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Thu, 2 Jul 2015 15:40:00 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5F0E62CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2015 15:40:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t625dnLa47841378
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 15:39:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t625dREJ003477
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Jul 2015 15:39:27 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, anton@samba.org
Subject: [PATCH RESEND] powerpc/numa: initialize distance lookup table from
 drconf path
Date: Thu,  2 Jul 2015 11:09:01 +0530
Message-Id: <1435815541-11860-1-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In some situations, a NUMA guest that supports
ibm,dynamic-memory-reconfiguration node will end up having flat NUMA
distances between nodes. This is because of two problems in the
current code.

1) Different representations of associativity lists.

   There is an assumption about the associativity list in
   initialize_distance_lookup_table(). Associativity list has two forms:

   a) [cpu,memory]@x/ibm,associativity has following
      format:
           <N> <N integers>

   b) ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays

           <M> <N> <M associativity lists each having N integers>
           M = the number of associativity lists
           N = the number of entries per associativity list

   Fix initialize_distance_lookup_table() so that it does not assume
   "case a". And update the caller to skip the length field before
   sending the associativity list.

2) Distance table not getting updated from drconf path.

   Node distance table will not get initialized in certain cases as
   ibm,dynamic-reconfiguration-memory path does not initialize the
   lookup table.

   Call initialize_distance_lookup_table() from drconf path with
   appropriate associativity list.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Acked-by: Anton Blanchard <anton@samba.org>
---

* Rebased to mpe/next
* Dropped RFC tag
* Updated commit log

 arch/powerpc/mm/numa.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 5e80621..8b9502a 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -225,7 +225,7 @@ static void initialize_distance_lookup_table(int nid,
 	for (i = 0; i < distance_ref_points_depth; i++) {
 		const __be32 *entry;
 
-		entry = &associativity[be32_to_cpu(distance_ref_points[i])];
+		entry = &associativity[be32_to_cpu(distance_ref_points[i]) - 1];
 		distance_lookup_table[nid][i] = of_read_number(entry, 1);
 	}
 }
@@ -248,8 +248,12 @@ static int associativity_to_nid(const __be32 *associativity)
 		nid = -1;
 
 	if (nid > 0 &&
-	    of_read_number(associativity, 1) >= distance_ref_points_depth)
-		initialize_distance_lookup_table(nid, associativity);
+		of_read_number(associativity, 1) >= distance_ref_points_depth) {
+		/*
+		 * Skip the length field and send start of associativity array
+		 */
+		initialize_distance_lookup_table(nid, associativity + 1);
+	}
 
 out:
 	return nid;
@@ -507,6 +511,12 @@ static int of_drconf_to_nid_single(struct of_drconf_cell *drmem,
 
 		if (nid == 0xffff || nid >= MAX_NUMNODES)
 			nid = default_nid;
+
+		if (nid > 0) {
+			index = drmem->aa_index * aa->array_sz;
+			initialize_distance_lookup_table(nid,
+							&aa->arrays[index]);
+		}
 	}
 
 	return nid;
-- 
2.4.3
