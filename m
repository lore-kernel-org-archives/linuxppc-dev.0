Return-Path: <anton@ozlabs.org>
Date: Sat, 25 Mar 2006 17:27:09 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Consistent printing of node id
Message-ID: <20060325062709.GT30422@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We were printing node ids in hex in one spot. Lets be consistent and
always print them in decimal.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/mm/mem.c
===================================================================
--- build.orig/arch/powerpc/mm/mem.c	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/mm/mem.c	2006-03-24 16:13:26.000000000 +1100
@@ -342,7 +342,7 @@ void __init mem_init(void)
 #ifdef CONFIG_NEED_MULTIPLE_NODES
         for_each_online_node(nid) {
 		if (NODE_DATA(nid)->node_spanned_pages != 0) {
-			printk("freeing bootmem node %x\n", nid);
+			printk("freeing bootmem node %d\n", nid);
 			totalram_pages +=
 				free_all_bootmem_node(NODE_DATA(nid));
 		}
