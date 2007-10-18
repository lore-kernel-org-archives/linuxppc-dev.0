Return-Path: <dgibson@ozlabs.org>
Date: Thu, 18 Oct 2007 14:14:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make helper macros in trees.S more flexible
Message-ID: <20071018041409.GC8206@localhost.localdomain>
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

This patch makes the helper macros in trees.S use separate labels for
the end of each dt subblock, rather than using only start labels.
This means that the macros can now be used to create trees with the
subblocks in non-standard orders.

In addition, it adds a bunch of extra ; after lines of asm code in
macros, making them safe to use in nested macros.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/trees.S
===================================================================
--- dtc.orig/tests/trees.S	2007-10-17 10:27:35.000000000 +1000
+++ dtc/tests/trees.S	2007-10-18 14:09:06.000000000 +1000
@@ -5,7 +5,7 @@
 	.byte	((val) >> 24) & 0xff ; \
 	.byte	((val) >> 16) & 0xff ; \
 	.byte	((val) >> 8) & 0xff ; \
-	.byte	(val) & 0xff
+	.byte	(val) & 0xff	;
 
 #define FDTQUAD(val) \
 	.byte	((val) >> 56) & 0xff ; \
@@ -15,10 +15,10 @@
 	.byte	((val) >> 24) & 0xff ; \
 	.byte	((val) >> 16) & 0xff ; \
 	.byte	((val) >> 8) & 0xff ; \
-	.byte	(val) & 0xff
+	.byte	(val) & 0xff	;
 
 #define TREE_HDR(tree) \
-	.balign	4		; \
+	.balign	8		; \
 	.globl	_##tree		; \
 _##tree:	\
 tree:	\
@@ -30,17 +30,18 @@
 	FDTLONG(0x11)		; \
 	FDTLONG(0x10)		; \
 	FDTLONG(0)		; \
-	FDTLONG(tree##_end - tree##_strings) ; \
-	FDTLONG(tree##_strings - tree##_struct) ;
+	FDTLONG(tree##_strings_end - tree##_strings) ; \
+	FDTLONG(tree##_struct_end - tree##_struct) ;
 
 #define RSVMAP_ENTRY(addr, len) \
 	FDTQUAD(addr)		; \
-	FDTQUAD(len)		;
+	FDTQUAD(len)		; \
 
 #define EMPTY_RSVMAP(tree) \
 	.balign	8		; \
 tree##_rsvmap:			; \
-	RSVMAP_ENTRY(0, 0)
+	RSVMAP_ENTRY(0, 0) \
+tree##_rsvmap_end:		;
 
 #define PROPHDR(tree, name, len) \
 	FDTLONG(FDT_PROP)	; \
@@ -50,26 +51,26 @@
 #define PROP_INT(tree, name, val) \
 	PROPHDR(tree, name, 4) \
 	/* For ease of testing the property values go in native-endian */ \
-	.long	val
+	.long	val		;
 
 #define PROP_STR(tree, name, str) \
 	PROPHDR(tree, name, 55f - 54f) \
 54:	\
 	.string	str		; \
 55:	\
-	.balign	4
+	.balign	4		;
 
 #define BEGIN_NODE(name) \
 	FDTLONG(FDT_BEGIN_NODE)	; \
 	.string	name		; \
-	.balign 4
+	.balign 4		;
 
 #define END_NODE \
 	FDTLONG(FDT_END_NODE)	;
 
 #define STRING(tree, name, str) \
-tree##_##name:	\
-	.string	str
+tree##_##name:			; \
+	.string	str		;
 
 	.data
 
@@ -80,6 +81,7 @@
 	RSVMAP_ENTRY(TEST_ADDR_1, TEST_SIZE_1)
 	RSVMAP_ENTRY(TEST_ADDR_2, TEST_SIZE_2)
 	RSVMAP_ENTRY(0, 0)
+test_tree1_rsvmap_end:
 
 test_tree1_struct:
 	BEGIN_NODE("")
@@ -108,13 +110,16 @@
 
 	END_NODE
 	FDTLONG(FDT_END)
+test_tree1_struct_end:
 
 test_tree1_strings:
 	STRING(test_tree1, compatible, "compatible")
 	STRING(test_tree1, prop_int, "prop-int")
 	STRING(test_tree1, prop_str, "prop-str")
+test_tree1_strings_end:
 test_tree1_end:
 
+
 	TREE_HDR(truncated_property)
 	EMPTY_RSVMAP(truncated_property)
 
@@ -122,7 +127,10 @@
 	BEGIN_NODE("")
 	PROPHDR(truncated_property, prop_truncated, 4)
 	/* Oops, no actual property data here */
+truncated_property_struct_end:
 
 truncated_property_strings:
 	STRING(truncated_property, prop_truncated, "truncated")
+truncated_property_strings_end:
+
 truncated_property_end:

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
