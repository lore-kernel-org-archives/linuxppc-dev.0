Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 15:15:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Don't include libfdt in global LDFLAGS
Message-ID: <20071102041517.GJ19839@localhost.localdomain>
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

Remove the uneccessary LDFLAGS from the top-level makefile.  It only
added libfdt/ to the link path.  dtc doesn't need libfdt at all, and
the testcases which do, already link libfdt.a by explicit path.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/Makefile
===================================================================
--- dtc.orig/Makefile	2007-11-02 15:06:24.000000000 +1100
+++ dtc/Makefile	2007-11-02 15:06:30.000000000 +1100
@@ -17,7 +17,6 @@ CONFIG_LOCALVERSION =
 
 CPPFLAGS = -I libfdt
 CFLAGS = -Wall -g -Os
-LDFLAGS = -Llibfdt
 
 BISON = bison
 LEX = flex


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
