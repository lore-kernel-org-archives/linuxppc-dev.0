Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013825.075157000@samba.org>
References: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:14 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 04/10] Fix backwards ? : when printing machine type
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Looks like someone got this backwards, highlighting the perils of the
? : !!! :)

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/traps.c	2007-03-11 11:03:11.000000000 -0500
+++ linux-2.6/arch/powerpc/kernel/traps.c	2007-03-11 11:03:20.000000000 -0500
@@ -153,7 +153,7 @@
 #ifdef CONFIG_NUMA
 		printk("NUMA ");
 #endif
-		printk("%s\n", ppc_md.name ? "" : ppc_md.name);
+		printk("%s\n", ppc_md.name ? ppc_md.name : "");
 
 		print_modules();
 		show_regs(regs);

--
