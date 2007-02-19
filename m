Return-Path: <b08248@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D4DA8DDE44
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 04:29:01 +1100 (EST)
Date: Mon, 19 Feb 2007 11:28:27 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702191728.l1JHSRfo025427@ld0164-tx32.am.freescale.net>
To: jdl@jdl.com
Subject: [DTC PATCH] remove check for interrupt-controller property under
	/chosen
Cc: linuxppc-dev@ozlabs.org, linuxppc-release@sourceforge.freescale.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove warning for missing interrupt-controller property
under /chosen.  There is consensus that this
property does not belong here.

Also, add a warning if interrupt-controller _is_ found
under /chosen.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 livetree.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/livetree.c b/livetree.c
index ede29fb..1a2764d 100644
--- a/livetree.c
+++ b/livetree.c
@@ -594,7 +594,14 @@ static int check_chosen(struct node *roo
 
 	CHECK_HAVE_WARN_STRING(chosen, "bootargs");
 	CHECK_HAVE_WARN_STRING(chosen, "linux,stdout-path");
-	CHECK_HAVE_WARN_PHANDLE(chosen, "interrupt-controller", root);
+
+        /* give warning for obsolete interrupt-controller property */
+	do {
+		if ((prop = get_property(chosen, "interrupt-controller")) != NULL) {
+			WARNMSG("%s has obsolete \"%s\" property\n",
+                                 chosen->fullpath, "interrupt-controller"); 
+                }
+	} while (0);
 
 	return ok;	
 }
-- 
1.4.4
