Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Dec 2007 18:08:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Allow gcc format warnings for check_msg()
Message-ID: <20071207070803.GF566@localhost.localdomain>
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

check_msg() takes printf() like arguments, so tell gcc to produce
printf() like warnings for it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2007-12-07 17:10:23.000000000 +1100
+++ dtc/checks.c	2007-12-07 17:13:16.000000000 +1100
@@ -87,6 +87,9 @@ struct check {
 #define BATCH_CHECK(nm, lvl, ...) \
 	CHECK(nm, NULL, NULL, NULL, NULL, lvl, __VA_ARGS__)
 
+#ifdef __GNUC__
+static inline void check_msg(struct check *c, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
+#endif
 static inline void check_msg(struct check *c, const char *fmt, ...)
 {
 	va_list ap;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
