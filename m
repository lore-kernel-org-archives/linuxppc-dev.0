Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id 7CE8B67C2D
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Oct 2006 08:22:22 +1000 (EST)
Date: Fri, 13 Oct 2006 15:22:20 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <1160773040.11239.28.camel@farscape>
Message-ID: <Pine.LNX.4.64.0610131515200.28279@schroedinger.engr.sgi.com>
References: <1160764895.11239.14.camel@farscape>
	<Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com>
	<1160769226.11239.22.camel@farscape>
	<1160773040.11239.28.camel@farscape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is another fall back fix checking if the slab has already been setup 
for this node. MPOL_INTERLEAVE could redirect the allocation.

Index: linux-2.6.19-rc1-mm1/mm/slab.c
===================================================================
--- linux-2.6.19-rc1-mm1.orig/mm/slab.c	2006-10-10 21:47:12.949563383 -0500
+++ linux-2.6.19-rc1-mm1/mm/slab.c	2006-10-13 17:21:31.937863714 -0500
@@ -3158,12 +3158,15 @@ void *fallback_alloc(struct kmem_cache *
 	struct zone **z;
 	void *obj = NULL;
 
-	for (z = zonelist->zones; *z && !obj; z++)
+	for (z = zonelist->zones; *z && !obj; z++) {
+		int nid = zone_to_nid(*z);
+
 		if (zone_idx(*z) <= ZONE_NORMAL &&
-				cpuset_zone_allowed(*z, flags))
+				cpuset_zone_allowed(*z, flags) &&
+				cache->nodelists[nid])
 			obj = __cache_alloc_node(cache,
-					flags | __GFP_THISNODE,
-					zone_to_nid(*z));
+					flags | __GFP_THISNODE, nid);
+	}
 	return obj;
 }
 
