Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 11:32:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove bogus break statement
Message-ID: <20070628013231.GF15298@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: , linuxppc-dev@ozlabs.org, 5B@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 0738774fcc34b78a708a127fb4b2f193d08c94ba introduced some
incorrect indentation / bracketing in unflatten_tree().  By luck, the
extra break statement intended to be within an if block, but actually
afterwards has no semantic effect.  Still, this patch gets rid of it
for cleanliness.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-26 15:28:34.000000000 +1000
+++ dtc/flattree.c	2007-06-26 15:28:52.000000000 +1000
@@ -779,7 +779,6 @@ static struct node *unflatten_tree(struc
 			if (!(flags & FTF_NOPS))
 				fprintf(stderr, "Warning: NOP tag found in flat tree"
 					" version <16\n");
-				break;
 
 			/* Ignore */
 			break;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
