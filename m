Return-Path: <anton@samba.org>
Message-Id: <20110810064937.424887717@samba.org>
Date: Wed, 10 Aug 2011 16:49:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/3] powerpc: numa: Remove double of_node_put in
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


of_find_node_by_type() loop does of_node_put for us so remove the
duplicate one inside the loop.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: stable@kernel.org
---

Index: linux-powerpc/arch/powerpc/mm/numa.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-06-06 08:07:35.148708089 +1000
+++ linux-powerpc/arch/powerpc/mm/numa.c	2011-08-10 11:31:59.723379868 +1000
@@ -1214,7 +1214,6 @@ int hot_add_node_scn_to_nid(unsigned lon
 			break;
 		}
 
-		of_node_put(memory);
 		if (nid >= 0)
 			break;
 	}
