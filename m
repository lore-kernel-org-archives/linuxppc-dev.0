Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 27A74DDFBE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:11:15 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2MGBCgX008290
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:11:12 -0700 (MST)
Date: Thu, 22 Mar 2007 11:11:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: jdl@freescale.com
Subject: [PATCH] Remove bogus errors from check_chosen.
Message-ID: <20070322161109.GA20512@ld0162-tx32.am.freescale.net>
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

It is not an error for /chosen (or any of its children) to be missing.

It is not a requirement that the output of dtc be a complete, valid
device tree, as it may be intended that the dtb be passed through boot
code that will complete it.  Thus, do not complain.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 livetree.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/livetree.c b/livetree.c
index 45642dc..ce73f50 100644
--- a/livetree.c
+++ b/livetree.c
@@ -588,13 +588,8 @@ static int check_chosen(struct node *root)
 	int ok = 1;
 
 	chosen = get_subnode(root, "chosen");
-	if (! chosen) {
-		ERRMSG("Missing /chosen node\n");
-		return 0;
-	}
-
-	CHECK_HAVE_WARN_STRING(chosen, "bootargs");
-	CHECK_HAVE_WARN_STRING(chosen, "linux,stdout-path");
+	if (!chosen)
+		return ok;
 
         /* give warning for obsolete interrupt-controller property */
 	do {
-- 
1.5.0.3
