Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 708181A0E41
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 15:08:43 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 10:38:41 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E1ADC125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:41:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A58bjk9306442
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:38:37 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A58bPc009043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 10:38:37 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
Cc: linux-kernel@vger.kernel.org, bharata@linux.vnet.ibm.com, anton@samba.org
Subject: Re: [RFC PATCH] powerpc/numa: initialize distance lookup table from
 drconf path
In-Reply-To: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1433911816-854-1-git-send-email-nikunj@linux.vnet.ibm.com>
Date: Wed, 10 Jun 2015 10:38:35 +0530
Message-ID: <87lhfs5ewc.fsf@linux.vnet.ibm.com>
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


Reworded commit log:

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

powerpc/numa: initialize distance lookup table from drconf path

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
