Return-Path: <dgibson@ozlabs.org>
Date: Thu, 7 Jun 2007 12:07:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix recognition of whitespace characters
Message-ID: <20070607020735.GD24230@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Mark Lacas <lacas@synapse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At present, the lexer in dtc recognizes only space, tab and newline as
whitespace characters.  This is broken; in particular this means that
dtc will get syntax errors on files with DOS-style (CR-LF) newlines.

This patch fixes the problem, using flex's built-int [:space:]
character class.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Jon, please apply.

Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-06-07 12:00:31.000000000 +1000
+++ dtc/dtc-lexer.l	2007-06-07 12:03:31.000000000 +1000
@@ -27,7 +27,7 @@
 
 PROPCHAR	[a-zA-Z0-9,._+*#?-]
 UNITCHAR	[0-9a-f,]
-WS		[ \t\n]
+WS		[[:space:]]
 
 REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
