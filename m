Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AB9D1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 14:50:38 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 10:20:34 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4F87DE005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:23:54 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A4oQkF52953148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:20:26 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A4oQ35022050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:20:26 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Cc: linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, anton@samba.org
Subject: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
Date: Wed, 10 Jun 2015 10:20:16 +0530
Message-Id: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Node distance will not get initialized in certain cases as
dynamic-reconfiguration path does not initialize the lookup table.

There is an assumption about the associativity list in
initialize_distance_lookup_table(). Associativity list has two forms:

a) [cpu,memory]@x/ibm,associativity has following
   format:

    <N> <N integers>

b) ibm,dynamic-reconfiguration-memory/ibm,associativity-lookup-arrays

   <M> <N> <M*N integers>
   M = the number of associativity lists
   N = the number of entries per associativity list

Fix initialize_distance_lookup_table() so that it does not assume
"case a". And update the caller to skip the length field before
sending the associativity list.

Call initialize_distance_lookup_table() from drconf path with
appropriate associativity list.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
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
1.8.3.1
