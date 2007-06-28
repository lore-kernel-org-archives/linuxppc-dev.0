Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 15:56:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: In booting-without-of.txt,
	clarify that properties must precede subnodes
Message-ID: <20070628055626.GB10769@localhost.localdomain>
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

A strict reading of the flattened device tree format defined in
booting-without-of.txt does in fact require that all the tags defining
properties for a node go before any definitions of subnodes, however
it's not particularly emphasised.  Although allowing intermingled
properties and subnodes would not be ambiguous in meaning, the kernel
parser does currently require that properties precede subnodes.
Furthermore, keeping this constraint makes life easier for various
device tree scanning tools.

Therefore, re-emphasise in booting-without-of.txt that this is a
strict requirement of the flattened device tree format.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/Documentation/powerpc/booting-without-of.txt
===================================================================
--- working-2.6.orig/Documentation/powerpc/booting-without-of.txt	2007-06-28 15:47:47.000000000 +1000
+++ working-2.6/Documentation/powerpc/booting-without-of.txt	2007-06-28 15:51:56.000000000 +1000
@@ -626,6 +626,14 @@
 a list of properties, a list of child nodes, and an end token. Every
 child node is a full node structure itself as defined above.
 
+NOTE: The above definition requires that all property definitions for
+a particular node MUST precede any subnode definitions for that node.
+Although the structure would not be ambiguous if properties and
+subnodes were intermingled, the kernel parser requires that the
+properties come first (up until at least 2.6.22).  Any tools
+manipulating a flattened tree must take care to preserve this
+constraint.
+
 4) Device tree "strings" block
 
 In order to save space, property names, which are generally redundant,

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
