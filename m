Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 23 Jun 2006 18:20:10 +1000
Subject: [PATCH 3/8] Make rtas_call() safe if RTAS hasn't been initialised
Message-Id: <20060623082007.EA02A67AC5@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently it's unsafe to call rtas_call() prior to rtas_initialize(). This
is because the rtas.entry value hasn't been setup and so we don't know
where to enter, but we just try anyway.

We can't do anything intelligent without rtas.entry, so if it's not set, just
return. Code that calls rtas_call() early needs to be aware that the call
might fail.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/rtas.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: to-merge/arch/powerpc/kernel/rtas.c
===================================================================
--- to-merge.orig/arch/powerpc/kernel/rtas.c
+++ to-merge/arch/powerpc/kernel/rtas.c
@@ -328,7 +328,7 @@ int rtas_call(int token, int nargs, int 
 	char *buff_copy = NULL;
 	int ret;
 
-	if (token == RTAS_UNKNOWN_SERVICE)
+	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
 		return -1;
 
 	/* Gotta do something different here, use global lock for now... */
