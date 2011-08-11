Return-Path: <anton@samba.org>
Message-Id: <20110811064427.515781037@samba.org>
Date: Thu, 11 Aug 2011 16:44:21 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sfr@ozlabs.org,
	nfont@austin.ibm.com
Subject: [PATCH 1/4] [PATCH] powerpc: numa: Remove double of_node_put in
	hot_add_node_scn_to_nid
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During memory hotplug testing, I got the following warning:


ERROR: Bad of_node_put() on /memory@0

of_node_release
kref_put
of_node_put
of_find_node_by_type
hot_add_node_scn_to_nid
hot_add_scn_to_nid
memory_add_physaddr_to_nid
...


of_find_node_by_type() loop does the of_node_put for us so we only
need the handle the case where we terminate the loop early.

As suggested by Stephen Rothwell we can do the of_node_put
unconditionally outside of the loop since of_node_put handles a
NULL argument fine.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

Index: linux-powerpc/arch/powerpc/mm/numa.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-06-06 08:07:35.148708089 +1000
+++ linux-powerpc/arch/powerpc/mm/numa.c	2011-08-11 09:07:07.329584634 +1000
@@ -1214,11 +1214,12 @@ int hot_add_node_scn_to_nid(unsigned lon
 			break;
 		}
 
-		of_node_put(memory);
 		if (nid >= 0)
 			break;
 	}
 
+	of_node_put(memory);
+
 	return nid;
 }
 
