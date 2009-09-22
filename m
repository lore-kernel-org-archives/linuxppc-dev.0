Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 16:47:39 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix ibm,client-architecture-support printout
Message-ID: <20090922064739.GB19453@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On machines without the ibm,client-architecture-support call we were missing a
newline. We may as well print the full name in all its glory too - its
ibm,client-architecture-support, not ibm,client-architecture as I mistakenly
wrote (a name only an IBM architect could love).

For my penance I will write out ibm,client-architecture-support 100 times.

Before:

Calling ibm,client-architecture...command line: root=/dev/sda6 console=hvc0  quiet

After:

Calling ibm,client-architecture-support... not implemented
command line: root=/dev/sda6 console=hvc0  

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/prom_init.c	2009-09-22 16:18:12.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/prom_init.c	2009-09-22 16:37:59.000000000 +1000
@@ -800,7 +800,7 @@ static void __init prom_send_capabilitie
 	root = call_prom("open", 1, 1, ADDR("/"));
 	if (root != 0) {
 		/* try calling the ibm,client-architecture-support method */
-		prom_printf("Calling ibm,client-architecture...");
+		prom_printf("Calling ibm,client-architecture-support...");
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
 				  root,
@@ -814,6 +814,7 @@ static void __init prom_send_capabilitie
 			return;
 		}
 		call_prom("close", 1, 0, root);
+		prom_printf(" not implemented\n");
 	}
 
 	/* no ibm,client-architecture-support call, try the old way */
