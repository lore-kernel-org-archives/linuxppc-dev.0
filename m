Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 48863DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 14:16:19 +1000 (EST)
Date: Thu, 24 May 2007 14:16:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] [POWERPC] suppress modpost warnings for references from the
	.toc
Message-Id: <20070524141613.4ba38e2f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should do better here by effetively "dereferencing" references to
the .toc (or the .got2) section, but that is much harder.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/mod/modpost.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 8e5610d..fe5f89b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -865,9 +865,12 @@ static void warn_sec_mismatch(const char *modname, const char *fromsec,
 		return;
 
 	/* fromsec whitelist - without a valid 'before'
-	 * powerpc has a GOT table in .got2 section */
+	 * powerpc has a GOT table in .got2 section
+	 * and also a .toc section */
 	if (strcmp(fromsec, ".got2") == 0)
 		return;
+	if (strcmp(fromsec, ".toc") == 0)
+		return;
 
 	if (before && after) {
 		warn("%s(%s+0x%llx): Section mismatch: reference to %s:%s "
-- 
1.5.1.4
