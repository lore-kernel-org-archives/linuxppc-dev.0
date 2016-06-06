Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNhb1459YzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 03:31:57 +1000 (AEST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Wolfram Sang <wsa@the-dreams.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] of: fix autoloading due to broken modalias with no
 'compatible'
Date: Mon,  6 Jun 2016 18:48:38 +0200
Message-Id: <1465231718-2577-1-git-send-email-wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because of an improper dereference, a stray 'C' character was output to
the modalias when no 'compatible' was specified. This is the case for
some old PowerMac drivers which only set the 'name' property. Fix it to
let them match again.

Reported-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Tested-by: Mathieu Malaterre <malat@debian.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Fixes: 6543becf26fff6 ("mod/file2alias: make modalias generation safe for cross compiling")
---

I think it makes sense if this goes in via ppc (with stable tag added).
D'accord?

 scripts/mod/file2alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index a9155077feefb9..fec75786f75bbb 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -384,7 +384,7 @@ static void do_of_entry_multi(void *symval, struct module *mod)
 	len = sprintf(alias, "of:N%sT%s", (*name)[0] ? *name : "*",
 		      (*type)[0] ? *type : "*");
 
-	if (compatible[0])
+	if ((*compatible)[0])
 		sprintf(&alias[len], "%sC%s", (*type)[0] ? "*" : "",
 			*compatible);
 
-- 
2.8.1
