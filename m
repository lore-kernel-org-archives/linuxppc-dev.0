Return-Path: <dgibson@ozlabs.org>
Date: Tue, 26 Jun 2007 11:30:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Accept NOPs in dtb input regardless of version
Message-ID: <20070626013047.GB4383@localhost.localdomain>
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

Since Milton's patch, dtc will accept (and, correctly, ignore) NOP
tags when given dtb input v16 or later.  However, although NOPs
weren't defined in earlier versions, they're not ambiguous, so should
be accepted there as well.  This patch does so, printing a mere
warning when finding NOPs in a too-early dtb version.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-25 14:08:27.000000000 +1000
+++ dtc/flattree.c	2007-06-25 14:08:29.000000000 +1000
@@ -776,10 +776,12 @@
 			break;
 
 		case OF_DT_NOP:
-			if (flags & FTF_NOPS)
+			if (!(flags & FTF_NOPS))
+				fprintf(stderr, "Warning: NOP tag found in flat tree"
+					" version <16\n");
 				break;
 
-			die("OF_DT_NOP in device tree blob\n");
+			/* Ignore */
 			break;
 
 		default:

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
