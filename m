Return-Path: <dgibson@ozlabs.org>
Date: Wed, 5 Dec 2007 10:27:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Generate useful error message for properties after subnodes
Message-ID: <20071204232704.GD9487@localhost.localdomain>
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

On several occasions, I've accidentally put properties after subnodes
in a dts file.  I've then spent ages thinking that the resulting
syntax error was because of something else.

This patch arranges for this specific syntax error to generate a more
specific and useful error message.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/prop-after-subnode.dts
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ dtc/tests/prop-after-subnode.dts	2007-12-05 10:24:52.000000000 +1100
@@ -0,0 +1,9 @@
+/dts-v1/;
+
+/ {
+	node1 {
+	};
+	prop;
+	node2 {
+	};
+};
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-12-05 10:12:10.000000000 +1100
+++ dtc/dtc-parser.y	2007-12-05 10:18:26.000000000 +1100
@@ -276,6 +276,11 @@
 		{
 			$$ = chain_node($1, $2);
 		}
+	| subnode propdef
+		{
+			yyerror("syntax error: properties must precede subnodes\n");
+			YYERROR;
+		}
 	;
 
 subnode:

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
