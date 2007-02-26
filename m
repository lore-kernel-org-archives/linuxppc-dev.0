Return-Path: <dgibson@ozlabs.org>
Date: Mon, 26 Feb 2007 11:02:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Fix flat_dt_property structure
Message-ID: <20070226000224.GB29826@localhost.localdomain>
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

The structure in flat_dt.h defining the layout of a proprety within
the flat device tree is incorrect.  It has the offset to the
property's name, then the length when in fact (according to
booting-without-of.txt and the output of dtc) then length should come
first, followed by the name offset.

In fact, this structure is never used so the mistake doesn't break
anything, but it should still be fixed to avoid misleading people.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/flat_dt.h
===================================================================
--- dtc.orig/flat_dt.h	2007-02-26 10:59:03.000000000 +1100
+++ dtc/flat_dt.h	2007-02-26 10:59:45.000000000 +1100
@@ -37,8 +37,8 @@ struct reserve_entry {
 };
 
 struct flat_dt_property {
-	uint32_t nameoff;
 	uint32_t len;
+	uint32_t nameoff;
 	char data[0];
 };
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
