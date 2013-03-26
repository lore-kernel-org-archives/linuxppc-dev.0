Return-Path: <cody@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E8762C016F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 04:49:18 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 26 Mar 2013 11:49:13 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D772019D8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 11:46:48 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2QHkpQW109926
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 11:46:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2QHknGC019843
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2013 11:46:51 -0600
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-mm@kvack.org
Subject: [PATCH 3/3] powerpc/mm/numa: use setup_nr_node_ids() instead of
 opencoding.
Date: Tue, 26 Mar 2013 10:46:02 -0700
Message-Id: <1364319962-30967-4-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1364319962-30967-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index bba87ca..7574ae3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -62,14 +62,11 @@ static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
  */
 static void __init setup_node_to_cpumask_map(void)
 {
-	unsigned int node, num = 0;
+	unsigned int node;
 
 	/* setup nr_node_ids if not done yet */
-	if (nr_node_ids == MAX_NUMNODES) {
-		for_each_node_mask(node, node_possible_map)
-			num = node;
-		nr_node_ids = num + 1;
-	}
+	if (nr_node_ids == MAX_NUMNODES)
+		setup_nr_node_ids()
 
 	/* allocate the map */
 	for (node = 0; node < nr_node_ids; node++)
-- 
1.8.2
