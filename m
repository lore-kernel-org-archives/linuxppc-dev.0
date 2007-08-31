Return-Path: <dgibson@ozlabs.org>
Date: Fri, 31 Aug 2007 14:30:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Fix use of uninitialized variable in fdt_get_path()
Message-ID: <20070831043016.GM19271@localhost.localdomain>
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

My recent implemenetation of fdt_get_path() had a bug - the while loop
tested offset which was unitialized on the first iteration.  Depending
on code surrounding the call, this could cause fdt_get_path() to
return incorrect results.

This patch corrects the problem by applying some more correct thinking
to the loop condition.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-31 14:26:26.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-31 14:26:31.000000000 +1000
@@ -302,7 +302,7 @@
 	buf[0] = '/';
 	p = 1;
 
-	while (offset < nodeoffset) {
+	while (nextoffset <= nodeoffset) {
 		offset = nextoffset;
 		tag = _fdt_next_tag(fdt, offset, &nextoffset);
 		switch (tag) {

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
