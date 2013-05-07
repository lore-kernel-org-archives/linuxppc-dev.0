Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: stable@vger.kernel.org
Subject: [PATCH] powerpc: fix numa distance for form0 device tree
Date: Tue,  7 May 2013 13:49:34 +1000
Message-Id: <1367898574-20594-1-git-send-email-michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

Commit 7122beeee7bc1757682049780179d7c216dd1c83 upstream.

The following commit breaks numa distance setup for old powerpc
systems that use form0 encoding in device tree.

commit 41eab6f88f24124df89e38067b3766b7bef06ddb
powerpc/numa: Use form 1 affinity to setup node distance

Device tree node /rtas/ibm,associativity-reference-points would
index into /cpus/PowerPCxxxx/ibm,associativity based on form0 or
form1 encoding detected by ibm,architecture-vec-5 property.

All modern systems use form1 and current kernel code is correct.
However, on older systems with form0 encoding, the numa distance
will get hard coded as LOCAL_DISTANCE for all nodes.  This causes
task scheduling anomaly since scheduler will skip building numa
level domain (topmost domain with all cpus) if all numa distances
are same.  (value of 'level' in sched_init_numa() will remain 0)

Prior to the above commit:
((from) == (to) ? LOCAL_DISTANCE : REMOTE_DISTANCE)

Restoring compatible behavior with this patch for old powerpc systems
with device tree where numa distance are encoded as form0.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/numa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index bba87ca..6a252c4 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -201,7 +201,7 @@ int __node_distance(int a, int b)
 	int distance = LOCAL_DISTANCE;
 
 	if (!form1_affinity)
-		return distance;
+		return ((a == b) ? LOCAL_DISTANCE : REMOTE_DISTANCE);
 
 	for (i = 0; i < distance_ref_points_depth; i++) {
 		if (distance_lookup_table[a][i] == distance_lookup_table[b][i])
-- 
1.7.10.4
