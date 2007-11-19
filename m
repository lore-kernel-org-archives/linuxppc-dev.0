Return-Path: <dgibson@ozlabs.org>
Date: Mon, 19 Nov 2007 17:26:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: libfdt: Abolish fdt_offset_ptr_typed()
Message-ID: <20071119062622.GL20794@localhost.localdomain>
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

The fdt_offset_ptr_typed() macro seemed like a good idea at the time.
However, it's not actually used all that often, it can silently throw
away const qualifications and it uses a gcc extension (typeof) which
I'd prefer to avoid for portability.

Therefore, this patch gets rid of it (and the fdt_offset_ptr_typed_w()
variant which was never used at all).  It also makes a few variables
const in testcases, which always should have been const, but weren't
caught before because of the aforementioned silent discards.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/libfdt.h
===================================================================
--- dtc.orig/libfdt/libfdt.h	2007-11-19 17:22:28.000000000 +1100
+++ dtc/libfdt/libfdt.h	2007-11-19 17:22:55.000000000 +1100
@@ -128,12 +128,6 @@ static inline void *fdt_offset_ptr_w(voi
 	return (void *)fdt_offset_ptr(fdt, offset, checklen);
 }
 
-
-#define fdt_offset_ptr_typed(fdt, offset, var) \
-	((typeof(var))(fdt_offset_ptr((fdt), (offset), sizeof(*(var)))))
-#define fdt_offset_ptr_typed_w(fdt, offset, var) \
-	((typeof(var))(fdt_offset_ptr_w((fdt), (offset), sizeof(*(var)))))
-
 uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset);
 
 /**********************************************************************/
Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-11-19 17:22:28.000000000 +1100
+++ dtc/libfdt/fdt_ro.c	2007-11-19 17:22:55.000000000 +1100
@@ -249,7 +249,7 @@ const struct fdt_property *fdt_get_prope
 
 		case FDT_PROP:
 			err = -FDT_ERR_BADSTRUCTURE;
-			prop = fdt_offset_ptr_typed(fdt, offset, prop);
+			prop = fdt_offset_ptr(fdt, offset, sizeof(*prop));
 			if (! prop)
 				goto fail;
 			namestroff = fdt32_to_cpu(prop->nameoff);
Index: dtc/tests/root_node.c
===================================================================
--- dtc.orig/tests/root_node.c	2007-11-19 17:22:28.000000000 +1100
+++ dtc/tests/root_node.c	2007-11-19 17:22:55.000000000 +1100
@@ -32,12 +32,12 @@
 int main(int argc, char *argv[])
 {
 	void *fdt;
-	struct fdt_node_header *nh;
+	const struct fdt_node_header *nh;
 
 	test_init(argc, argv);
 	fdt = load_blob_arg(argc, argv);
 
-	nh = fdt_offset_ptr_typed(fdt, 0, nh);
+	nh = fdt_offset_ptr(fdt, 0, sizeof(*nh));
 
 	if (! nh)
 		FAIL("NULL retrieving root node");
Index: dtc/tests/path_offset.c
===================================================================
--- dtc.orig/tests/path_offset.c	2007-11-19 17:22:28.000000000 +1100
+++ dtc/tests/path_offset.c	2007-11-19 17:22:55.000000000 +1100
@@ -31,7 +31,7 @@
 int check_subnode(void *fdt, int parent, const char *name)
 {
 	int offset;
-	struct fdt_node_header *nh;
+	const struct fdt_node_header *nh;
 	uint32_t tag;
 
 	verbose_printf("Checking subnode \"%s\" of %d...", name, parent);
@@ -39,7 +39,7 @@ int check_subnode(void *fdt, int parent,
 	verbose_printf("offset %d...", offset);
 	if (offset < 0)
 		FAIL("fdt_subnode_offset(\"%s\"): %s", name, fdt_strerror(offset));
-	nh = fdt_offset_ptr_typed(fdt, offset, nh);
+	nh = fdt_offset_ptr(fdt, offset, sizeof(*nh));
 	verbose_printf("pointer %p\n", nh);
 	if (! nh)
 		FAIL("NULL retrieving subnode \"%s\"", name);
Index: dtc/tests/subnode_offset.c
===================================================================
--- dtc.orig/tests/subnode_offset.c	2007-11-19 17:22:28.000000000 +1100
+++ dtc/tests/subnode_offset.c	2007-11-19 17:22:55.000000000 +1100
@@ -31,7 +31,7 @@
 int check_subnode(struct fdt_header *fdt, int parent, const char *name)
 {
 	int offset;
-	struct fdt_node_header *nh;
+	const struct fdt_node_header *nh;
 	uint32_t tag;
 
 	verbose_printf("Checking subnode \"%s\" of %d...", name, parent);
@@ -39,7 +39,7 @@ int check_subnode(struct fdt_header *fdt
 	verbose_printf("offset %d...", offset);
 	if (offset < 0)
 		FAIL("fdt_subnode_offset(\"%s\"): %s", name, fdt_strerror(offset));
-	nh = fdt_offset_ptr_typed(fdt, offset, nh);
+	nh = fdt_offset_ptr(fdt, offset, sizeof(*nh));
 	verbose_printf("pointer %p\n", nh);
 	if (! nh)
 		FAIL("NULL retrieving subnode \"%s\"", name);
Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- dtc.orig/tests/dtbs_equal_ordered.c	2007-11-19 17:22:28.000000000 +1100
+++ dtc/tests/dtbs_equal_ordered.c	2007-11-19 17:22:55.000000000 +1100
@@ -93,10 +93,10 @@ void compare_structure(const void *fdt1,
 			break;
 
 		case FDT_PROP:
-			prop1 = fdt_offset_ptr_typed(fdt1, offset1, prop1);
+			prop1 = fdt_offset_ptr(fdt1, offset1, sizeof(*prop1));
 			if (!prop1)
 				FAIL("Could get fdt1 property at %d", offset1);
-			prop2 = fdt_offset_ptr_typed(fdt2, offset2, prop2);
+			prop2 = fdt_offset_ptr(fdt2, offset2, sizeof(*prop2));
 			if (!prop2)
 				FAIL("Could get fdt2 property at %d", offset2);
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
