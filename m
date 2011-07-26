Return-Path: <anton@samba.org>
Date: Tue, 26 Jul 2011 16:47:07 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix device tree claim code
Message-ID: <20110726164707.238bfec0@kryten>
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


I have a box that fails in OF during boot with:

DEFAULT CATCH!, exception-handler=fff00400 
at   %SRR0: 49424d2c4c6f6768   %SRR1: 800000004000b002 

ie "IBM,Logh". OF got corrupted with a device tree string.

Looking at make_room and alloc_up, we claim the first chunk (1 MB)
but we never claim any more. mem_end is always set to alloc_top
which is the top of our available address space, guaranteeing we will
never call alloc_up and claim more memory.

Also alloc_up wasn't setting alloc_bottom to the bottom of the
available address space.

This doesn't help the box to boot, but we at least fail with
an obvious error. We could relocate the device tree in a future
patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/prom_init.c	2011-07-26 12:37:56.142915032 +1000
+++ linux-powerpc/arch/powerpc/kernel/prom_init.c	2011-07-26 16:31:31.481793248 +1000
@@ -1020,7 +1020,7 @@ static unsigned long __init alloc_up(uns
 	}
 	if (addr == 0)
 		return 0;
-	RELOC(alloc_bottom) = addr;
+	RELOC(alloc_bottom) = addr + size;
 
 	prom_debug(" -> %x\n", addr);
 	prom_debug("  alloc_bottom : %x\n", RELOC(alloc_bottom));
@@ -1834,7 +1834,7 @@ static void __init *make_room(unsigned l
 		chunk = alloc_up(room, 0);
 		if (chunk == 0)
 			prom_panic("No memory for flatten_device_tree (claim failed)");
-		*mem_end = RELOC(alloc_top);
+		*mem_end = chunk + room;
 	}
 
 	ret = (void *)*mem_start;
@@ -2053,7 +2053,7 @@ static void __init flatten_device_tree(v
 	mem_start = (unsigned long)alloc_up(room, PAGE_SIZE);
 	if (mem_start == 0)
 		prom_panic("Can't allocate initial device-tree chunk\n");
-	mem_end = RELOC(alloc_top);
+	mem_end = mem_start + room;
 
 	/* Get root of tree */
 	root = call_prom("peer", 1, 1, (phandle)0);
