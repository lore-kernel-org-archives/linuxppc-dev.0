Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 16:54:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Don't force alignment of cell list data
Message-ID: <20071102055426.GN19839@localhost.localdomain>
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

At present, defining a property as, say:
	foo = [abcd], <ffffffff>;

Will cause dtc to insert 2 bytes of zeros between the abcd and the
ffffffff, to align the cell form data.

Doing so seemed like a good idea at the time, but I don't believe
there are any users who actually rely on this behaviour.  Segher
claims that OF has some defined bindings which include properties an
unaligned subsection of which is interpreted as 32-bit ints (i.e. like
cell data).

Worse, this alignment will cause nothing but pain when we add
expression support to dtc (when celldata is included in a larger
bytestring expession, we won't know the size of the preceding chunk of
the expression until it's evaluated, so we would have to carry
alignment fixup information right through the expression evaluation
process).

Therefore, this patch kills off this alignment behaviour.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-11-02 16:45:00.000000000 +1100
+++ dtc/dtc-parser.y	2007-11-02 16:45:42.000000000 +1100
@@ -149,8 +149,7 @@ propdata:
 		}
 	| propdataprefix '<' celllist '>'
 		{
-			$$ = data_merge(data_append_align($1,
-							  sizeof(cell_t)), $3);
+			$$ = data_merge($1, $3);
 		}
 	| propdataprefix '[' bytestring ']'
 		{

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
