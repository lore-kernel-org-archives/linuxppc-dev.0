Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C506DDE22
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:15 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1XAp7018487
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:10 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1X91J001188
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:09 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18SQ2007841
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:28 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 90E15AEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:08 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1X8xJ015280
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:08 -0500
Date: Tue, 17 Jul 2007 20:33:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/61] bootwrapper: flatdevtree fixes
Message-ID: <20070718013308.GI15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. ft_create_node was returning the internal pointer rather than a phandle.
2. ft_find_device_rel was treating lookups relative to root as an error.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index b732644..5b69aeb 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -659,9 +659,13 @@ void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
 {
 	char *node;
 
-	node = ft_node_ph2node(cxt, top);
-	if (node == NULL)
-		return NULL;
+	if (top) {
+		node = ft_node_ph2node(cxt, top);
+		if (node == NULL)
+			return NULL;
+	} else {
+		node = ft_root_node(cxt);
+	}
 
 	node = ft_find_descendent(cxt, node, srch_path);
 	return ft_get_phandle(cxt, node);
@@ -990,7 +994,7 @@ void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 			cxt->p = p;
 			ft_begin_node(cxt, name);
 			ft_end_node(cxt);
-			return p;
+			return ft_find_device_rel(cxt, parent, name);
 		}
 		p = next;
 	}
-- 
1.5.0.3
