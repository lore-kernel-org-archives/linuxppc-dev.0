Return-Path: <dgibson@ozlabs.org>
Date: Tue, 18 Mar 2008 14:04:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Change exit code for usage message
Message-ID: <20080318030419.GE18217@localhost.localdomain>
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

If dtc's command line arguments are invalid, it prints a usage message
and returns exit code 2.  That's the same exit code as for a failed
check, which is potentially confusing if running dtc from an automated
harness.  Therefore this patch changes the usage exit code to 3.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc.c
===================================================================
--- dtc.orig/dtc.c	2008-03-18 14:02:42.000000000 +1100
+++ dtc/dtc.c	2008-03-18 14:02:46.000000000 +1100
@@ -106,7 +106,7 @@ static void  __attribute__ ((noreturn)) 
 	fprintf(stderr, "\t\tForce - try to produce output even if the input tree has errors\n");
 	fprintf(stderr, "\t-v\n");
 	fprintf(stderr, "\t\tPrint DTC version and exit\n");
-	exit(2);
+	exit(3);
 }
 
 int main(int argc, char *argv[])

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
