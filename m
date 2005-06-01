Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id BE483679A6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 05:54:36 +1000 (EST)
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1117614390.19020.24.camel@gaston>
References: <1117614390.19020.24.camel@gaston>
Content-Type: text/plain
Message-Id: <1117655671.6517.99.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 01 Jun 2005 14:54:31 -0500
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-01 at 03:26, Benjamin Herrenschmidt wrote:
> DO NOT REPLY TO ALL LISTS PLEASE ! (and CC me on replies).
> 
> Here's the fourth version of my document along with new kernel patches
> for the new improved flattened format, and the first release of the
> device-tree "compiler" tool. The patches will be posted as a reply to
> this email. The compiler, dtc, can be downloaded, the URL is in the
> document.
> 
> ---

> 
> dtc source code can be found at <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>

Ben,

Here are diffs to:

    - Fix multi-line C-style comments.

    - Adjust the output of write_tree_source() such that it
      separates properties and nodes a bit better.

Thanks,
jdl


diff -u dtc.orig/dtc-lexer.l dtc/dtc-lexer.l
--- dtc.orig/dtc-lexer.l	2005-06-01 11:44:29.000002000 -0500
+++ dtc/dtc-lexer.l	2005-06-01 13:39:56.000001000 -0500
@@ -34,8 +34,6 @@
 
 #include "y.tab.h"
 
-#undef LEXDEBUG	1
-
 %}
 
 \"[^"]*\"	{
@@ -102,7 +100,7 @@
 
 <*>{WS}+	/* eat whitespace */
 
-<*>\/\*[^*]*(\*[^/][^*])*\*\/	/* eat comments */
+<*>\/\*([^*]|\**[^*/])*\*+\/	/* eat C comments */
 
 <*>\/\/.*\n	/* eat line comments */
 
diff -u dtc.orig/treesource.c dtc/treesource.c
--- dtc.orig/treesource.c	2005-06-01 11:44:29.000002000 -0500
+++ dtc/treesource.c	2005-06-01 13:58:33.000001000 -0500
@@ -131,10 +131,16 @@
 			break;
 		}
 	}
-	fprintf(f, "\n");
+	if (tree->children) {
+		fprintf(f, "\n");
+	}
 	for_each_child(tree, child) {
 		write_tree_source(f, child, level+1);
 	}
 	write_prefix(f, level);
 	fprintf(f, "};\n");
+
+	if (tree->next_sibling) {
+		fprintf(f, "\n");
+	}
 }
