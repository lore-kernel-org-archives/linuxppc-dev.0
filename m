Return-Path: <anton@samba.org>
Date: Tue, 15 Nov 2011 09:55:47 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: panic if we can't instantiate RTAS
Message-ID: <20111115095547.61e28e44@kryten>
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


I had to debug a strange situation where all manner of things were
failing. SMT threads, storage and network were all completely broken.

The root cause was we couldn't find enough memory to instantiate RTAS -
this was a network install so the initrd was huge.

Instead of limping along and failing in mysterious ways we should just
panic up front if RTAS exists and we can't allocate space for it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/prom_init.c	2011-11-03 10:49:02.735081551 +1100
+++ linux-powerpc/arch/powerpc/kernel/prom_init.c	2011-11-03 10:49:06.371143032 +1100
@@ -1579,10 +1579,8 @@ static void __init prom_instantiate_rtas
 		return;
 
 	base = alloc_down(size, PAGE_SIZE, 0);
-	if (base == 0) {
-		prom_printf("RTAS allocation failed !\n");
-		return;
-	}
+	if (base == 0)
+		prom_panic("Could not allocate memory for RTAS\n");
 
 	rtas_inst = call_prom("open", 1, 1, ADDR("/rtas"));
 	if (!IHANDLE_VALID(rtas_inst)) {
