Return-Path: <dgibson@ozlabs.org>
Date: Mon, 1 Feb 2010 15:52:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [resend] Make the kernel accept ePAPR style phandle information
Message-ID: <20100201045242.GB8095@yookeroo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant, I've updated this for your current test-devicetree branch.
Please apply.

Currently when processing flattened device trees, the kernel expects
the phandle in a property called "linux,phandle".  The ePAPR spec -
not being Linux specific - instead requires phandles to be encoded in
a property named simply "phandle".  This patch makes the kernel accept
either form when unflattening the device tree.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/of/fdt.c
===================================================================
--- working-2.6.orig/drivers/of/fdt.c	2010-02-01 15:51:44.000000000 +1100
+++ working-2.6/drivers/of/fdt.c	2010-02-01 15:51:46.458557615 +1100
@@ -310,10 +310,19 @@ unsigned long __init unflatten_dt_node(u
 		pp = unflatten_dt_alloc(&mem, sizeof(struct property),
 					__alignof__(struct property));
 		if (allnextpp) {
-			if (strcmp(pname, "linux,phandle") == 0) {
+			/* We accept flattened tree phandles either in
+			 * ePAPR-style "phandle" properties, or the
+			 * legacy "linux,phandle" properties.  If both
+			 * appear and have different values, things
+			 * will get weird.  Don't do that. */
+			if ((strcmp(pname, "phandle") == 0)
+			    || (strcmp(pname, "linux,phandle") == 0)) {
 				if (np->phandle == 0)
 					np->phandle = *((u32 *)*p);
 			}
+			/* And we process the "ibm,phandle" property
+			 * used in pSeries dynamic device tree
+			 * stuff */
 			if (strcmp(pname, "ibm,phandle") == 0)
 				np->phandle = *((u32 *)*p);
 			pp->name = pname;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
