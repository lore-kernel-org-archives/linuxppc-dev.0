Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 09:34:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix FAIL() macro varargs
Message-ID: <20071204223453.GA9406@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The way the checking subsystem FAIL() macro is currently implemented
it must take at least one paramater after the format string.  This
patch corrects the problem.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-04 16:42:48.000000000 +1100
+++ dtc/checks.c	2007-12-04 17:17:42.000000000 +1100
@@ -101,11 +101,11 @@ static inline void check_msg(struct chec
 	fprintf(stderr, "\n");
 }
 
-#define FAIL(c, fmt, ...) \
+#define FAIL(c, ...) \
 	do { \
 		TRACE((c), "\t\tFAILED at %s:%d", __FILE__, __LINE__); \
 		(c)->status = FAILED; \
-		check_msg((c), fmt, __VA_ARGS__); \
+		check_msg((c), __VA_ARGS__); \
 	} while (0)
 
 static void check_nodes_props(struct check *c, struct node *dt, struct node *node)

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
