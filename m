Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 04 Jul 2006 17:13:23 +1000
Subject: [PATCH] Fix mem= handling when the memory limit is > RMO size
Message-Id: <20060704071326.D785B67D31@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There's a bug in my cleaned up mem= handling, if the memory limit is
larger than the RMO size we'll erroneously enlarge the RMO size.

Fix is to only change the RMO size if the memory limit is less than
the current RMO value.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/lmb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: to-merge/arch/powerpc/mm/lmb.c
===================================================================
--- to-merge.orig/arch/powerpc/mm/lmb.c
+++ to-merge/arch/powerpc/mm/lmb.c
@@ -320,7 +320,8 @@ void __init lmb_enforce_memory_limit(uns
 		break;
 	}
 
-	lmb.rmo_size = lmb.memory.region[0].size;
+	if (lmb.memory.region[0].size < lmb.rmo_size)
+		lmb.rmo_size = lmb.memory.region[0].size;
 
 	/* And truncate any reserves above the limit also. */
 	for (i = 0; i < lmb.reserved.cnt; i++) {
