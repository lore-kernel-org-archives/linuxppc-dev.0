Return-Path: <anton@samba.org>
Date: Tue, 26 Jul 2011 16:47:51 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Clean up some panic messages in prom_init
Message-ID: <20110726164751.7a836474@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Add a newline to the panic messages in make_room. Also fix a
comment that suggested our chunk size is 4Mb. It's 1MB.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/prom_init.c	2011-07-26 16:32:14.692650932 +1000
+++ linux-powerpc/arch/powerpc/kernel/prom_init.c	2011-07-26 16:32:47.323298072 +1000
@@ -1830,10 +1830,12 @@ static void __init *make_room(unsigned l
 		if (room > DEVTREE_CHUNK_SIZE)
 			room = DEVTREE_CHUNK_SIZE;
 		if (room < PAGE_SIZE)
-			prom_panic("No memory for flatten_device_tree (no room)");
+			prom_panic("No memory for flatten_device_tree "
+				   "(no room)\n");
 		chunk = alloc_up(room, 0);
 		if (chunk == 0)
-			prom_panic("No memory for flatten_device_tree (claim failed)");
+			prom_panic("No memory for flatten_device_tree "
+				   "(claim failed)\n");
 		*mem_end = chunk + room;
 	}
 
@@ -2042,7 +2044,7 @@ static void __init flatten_device_tree(v
 
 	/*
 	 * Check how much room we have between alloc top & bottom (+/- a
-	 * few pages), crop to 4Mb, as this is our "chuck" size
+	 * few pages), crop to 1MB, as this is our "chunk" size
 	 */
 	room = RELOC(alloc_top) - RELOC(alloc_bottom) - 0x4000;
 	if (room > DEVTREE_CHUNK_SIZE)
