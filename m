Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Mar 2008 15:48:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Abolish asize field of struct data
Message-ID: <20080306044804.GD18315@localhost.localdomain>
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

The asize field in struct data is a hangover from the early days when
a struct data was sometimes allowed to refer to a static chunk of
memory rather than a malloc()ed block.

That's long gone, since the lifetime issues were far more trouble than
it was worth, so get rid of the asize field.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2008-03-06 15:43:56.000000000 +1100
+++ dtc/dtc.h	2008-03-06 15:44:06.000000000 +1100
@@ -118,7 +118,6 @@
 struct data {
 	int len;
 	char *val;
-	int asize;
 	struct marker *markers;
 };
 
Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-03-06 15:44:27.000000000 +1100
+++ dtc/data.c	2008-03-06 15:45:01.000000000 +1100
@@ -32,8 +32,6 @@
 		m = nm;
 	}
 
-	assert(!d.val || d.asize);
-
 	if (d.val)
 		free(d.val);
 }
@@ -43,9 +41,6 @@
 	struct data nd;
 	int newsize;
 
-	/* we must start with an allocated datum */
-	assert(!d.val || d.asize);
-
 	if (xlen == 0)
 		return d;
 
@@ -56,11 +51,8 @@
 	while ((d.len + xlen) > newsize)
 		newsize *= 2;
 
-	nd.asize = newsize;
 	nd.val = xrealloc(d.val, newsize);
 
-	assert(nd.asize >= (d.len + xlen));
-
 	return nd;
 }
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
