Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 Jul 2008 14:51:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Remove unused lexer function
Message-ID: <20080729045136.GD19856@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

dtc does not use the input() function in flex.  Apparently on some gcc
versions the unused function will cause warnings.  Therefore, this
patch removes the function by using the 'noinput' option to flex.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2008-07-29 14:48:08.000000000 +1000
+++ dtc/dtc-lexer.l	2008-07-29 14:48:27.000000000 +1000
@@ -18,7 +18,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput yylineno
+%option noyywrap nounput noinput yylineno
 
 %x INCLUDE
 %x BYTESTRING

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
