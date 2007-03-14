Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Mar 2007 11:50:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Update documentation for flat device tree format v17
Message-ID: <20070314005040.GF25514@localhost.localdomain>
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

This patch updates booting-without-of.txt to describe version 17 of
the flattened device tree format.  Version 17 is a small, backwards
compatible change from version 16, adding an extra field giving the
size of the device tree's structure block.  At this time, the kernel
has no use for the extra information, however its presence can make
life easier for bootloaders or other software manipulating the tree.

In addition this patch adds information on the size_dt_strings field
of the device tree header, present since version 3 of the flattened
tree format, but omitted from the documentation.  It also makes
changes to consistently refer to versions 16 and 17 as versions 16 and
17 in decimal, rather than version 0x10 which was occasionally used
for version 16 previously.

Finally, we also add the new field to the definition of the device
tree header structure in prom.h

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Paulus, please apply.

Index: working-2.6/include/asm-powerpc/prom.h
===================================================================
--- working-2.6.orig/include/asm-powerpc/prom.h	2007-03-14 11:38:34.000000000 +1100
+++ working-2.6/include/asm-powerpc/prom.h	2007-03-14 11:38:40.000000000 +1100
@@ -59,6 +59,8 @@ struct boot_param_header
 	u32	boot_cpuid_phys;	/* Physical CPU id we're booting on */
 	/* version 3 fields below */
 	u32	dt_strings_size;	/* size of the DT strings block */
+	/* version 17 fields below */
+	u32	dt_struct_size;		/* size of the DT structure block */
 };
 
 
Index: working-2.6/Documentation/powerpc/booting-without-of.txt
===================================================================
--- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-03-14 11:38:34.000000000 +1100
+++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-03-14 11:42:20.000000000 +1100
@@ -265,6 +265,9 @@ struct boot_param_header {
                                            booting on */
         /* version 3 fields below */
         u32     size_dt_strings;        /* size of the strings block */
+
+        /* version 17 fields below */
+        u32	size_dt_struct;		/* size of the DT structure block */
 };
 
    Along with the constants:
@@ -335,10 +338,13 @@ struct boot_param_header {
      to reallocate it easily at boot and free up the unused flattened
      structure after expansion. Version 16 introduces a new more
      "compact" format for the tree itself that is however not backward
-     compatible. You should always generate a structure of the highest
-     version defined at the time of your implementation. Currently
-     that is version 16, unless you explicitly aim at being backward
-     compatible.
+     compatible. Version 17 adds an additional field, size_dt_struct,
+     allowing it to be reallocated or moved more easily (this is
+     particularly useful for bootloaders which need to make
+     adjustments to a device tree based on probed information). You
+     should always generate a structure of the highest version defined
+     at the time of your implementation. Currently that is version 17,
+     unless you explicitly aim at being backward compatible.
 
    - last_comp_version
 
@@ -347,7 +353,7 @@ struct boot_param_header {
      is backward compatible with version 1 (that is, a kernel build
      for version 1 will be able to boot with a version 2 format). You
      should put a 1 in this field if you generate a device tree of
-     version 1 to 3, or 0x10 if you generate a tree of version 0x10
+     version 1 to 3, or 16 if you generate a tree of version 16 or 17
      using the new unit name format.
 
    - boot_cpuid_phys
@@ -360,6 +366,17 @@ struct boot_param_header {
      point (see further chapters for more informations on the required
      device-tree contents)
 
+   - size_dt_strings
+
+     This field only exists on version 3 and later headers.  It
+     gives the size of the "strings" section of the device tree (which
+     starts at the offset given by off_dt_strings).
+
+   - size_dt_struct
+
+     This field only exists on version 17 and later headers.  It gives
+     the size of the "structure" section of the device tree (which
+     starts at the offset given by off_dt_struct).
 
    So the typical layout of a DT block (though the various parts don't
    need to be in that order) looks like this (addresses go from top to
@@ -417,7 +434,7 @@ root node who has no parent.
 A node has 2 names. The actual node name is generally contained in a
 property of type "name" in the node property list whose value is a
 zero terminated string and is mandatory for version 1 to 3 of the
-format definition (as it is in Open Firmware). Version 0x10 makes it
+format definition (as it is in Open Firmware). Version 16 makes it
 optional as it can generate it from the unit name defined below.
 
 There is also a "unit name" that is used to differentiate nodes with

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
