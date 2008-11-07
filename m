Return-Path: <dgibson@ozlabs.org>
Date: Fri, 7 Nov 2008 11:45:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Use noinput flex option for convert-dtsv0 to remove warning
Message-ID: <20081107004548.GH6692@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The convert-dtsv0 lexer doesn't use lex's input() macro/function.
This can result in "defined but not used" warnings.  This patch uses
flex's noinput option to prevent this warning (as we already do for
dtc-lexer.l).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/convert-dtsv0-lexer.l
===================================================================
--- dtc.orig/convert-dtsv0-lexer.l	2008-11-07 11:43:05.000000000 +1100
+++ dtc/convert-dtsv0-lexer.l	2008-11-07 11:43:20.000000000 +1100
@@ -17,7 +17,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput
+%option noyywrap nounput noinput
 
 %x INCLUDE
 %x BYTESTRING

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
