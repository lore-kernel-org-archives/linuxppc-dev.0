Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: print physical_start for the relocatable kernel 
In-reply-to: <31488.1224733437@neuling.org> 
References: <31488.1224733437@neuling.org>
Date: Thu, 23 Oct 2008 16:39:49 +1100
Message-ID: <20047.1224740389@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Print physical start address for the relocatable kernel.  

Also fixes this warning:
 arch/powerpc/kernel/setup_64.c:447:5: warning: "kernstart_addr" is not defin

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/setup_64.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

This fixes a small whitespace issue noticed by sfr.  

Index: linux-2.6-ozlabs/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/setup_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/setup_64.c
@@ -444,9 +444,9 @@ void __init setup_system(void)
 	if (htab_address)
 		printk("htab_address                  = 0x%p\n", htab_address);
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
-#if PHYSICAL_START > 0
-	printk("physical_start                = 0x%lx\n", PHYSICAL_START);
-#endif
+	if (PHYSICAL_START > 0)
+		printk("physical_start                = 0x%lx\n",
+		       PHYSICAL_START);
 	printk("-----------------------------------------------------\n");
 
 	DBG(" <- setup_system()\n");
