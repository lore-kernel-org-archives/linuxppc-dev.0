Return-Path: <dgibson@ozlabs.org>
Date: Thu, 26 Nov 2009 16:16:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Make the kernel accept ePAPR style phandle information
Message-ID: <20091126051641.GB27334@yookeroo>
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

Grant, this is based on your test-devicetree branch, if it could be
merged via there would be great.

Currently when processing flattened device trees, the kernel expects
the phandle in a property called "linux,phandle".  The ePAPR spec -
not being Linux specific - instead requires phandles to be encoded in
a property named simply "phandle".  This patch makes the kernel accept
either form when unflattening the device tree.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/of/fdt.c
===================================================================
--- working-2.6.orig/drivers/of/fdt.c	2009-11-26 09:58:06.052792325 +1100
+++ working-2.6/drivers/of/fdt.c	2009-11-26 10:00:08.309570256 +1100
@@ -314,10 +314,19 @@ unsigned long __init unflatten_dt_node(u
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
