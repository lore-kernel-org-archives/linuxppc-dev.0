Return-Path: <dgibson@ozlabs.org>
Date: Mon, 29 Jan 2007 15:30:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Remove check for linux,platform property in /chosen
Message-ID: <20070129043059.GC14216@localhost.localdomain>
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

Jon, please apply:

The linux,platform property in /chosen was obsolete almost as soon as
it was invented.  Remove the check for it from dtc, which just tends
to lead to irritating spurious failures.  

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-01-29 15:16:45.000000000 +1100
+++ dtc/livetree.c	2007-01-29 15:20:43.000000000 +1100
@@ -568,8 +568,6 @@ static int check_chosen(struct node *roo
 		return 0;
 	}
 
-	CHECK_HAVE_ONECELL(chosen, "linux,platform");
-
 	CHECK_HAVE_WARN_STRING(chosen, "bootargs");
 	CHECK_HAVE_WARN_STRING(chosen, "linux,stdout-path");
 	CHECK_HAVE_WARN_PHANDLE(chosen, "interrupt-controller", root);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
