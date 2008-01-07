Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A71D0DE0EE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:28:07 +1100 (EST)
Date: Mon, 7 Jan 2008 14:27:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [DTC PATCH 2/2] Preserve scanner state when /include/ing.
Message-ID: <20080107202751.GB17782@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

This allows /include/s to work when in non-default states,
such as PROPNODECHAR.

We may want to use state stacks to get rid of BEGIN_DEFAULT() altogether...

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-lexer.l |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index f2836a8..920b87f 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -18,7 +18,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput yylineno
+%option noyywrap nounput yylineno stack
 
 %x INCLUDE
 %x BYTESTRING
@@ -55,7 +55,7 @@ static int dts_version; /* = 0 */
 %}
 
 %%
-<*>"/include/"		BEGIN(INCLUDE);
+<*>"/include/"		yy_push_state(INCLUDE);
 
 <INCLUDE>\"[^"\n]*\"	{
 			yytext[strlen(yytext) - 1] = 0;
@@ -63,7 +63,7 @@ static int dts_version; /* = 0 */
 				/* Some unrecoverable error.*/
 				exit(1);
 			}
-			BEGIN_DEFAULT();
+			yy_pop_state();
 		}
 
 
-- 
1.5.3
