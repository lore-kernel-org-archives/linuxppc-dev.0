Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 83D9BDE0CD
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:02 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TKC1jY012962
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:01 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKC0SE022460
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:00 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsAtR014720
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:10 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id B0C3C4B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:11:59 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKBxem013518
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:11:59 -0600
Date: Mon, 29 Jan 2007 14:11:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/18] bootwrapper: Rename ft_node_add() to ft_get_phandle().
Message-ID: <20070129201159.GE13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca1ac163-f732-45ce-9629-e6f4a8c3a880@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This name better reflects what the function does, which is to
look up the phandle for an internal node pointer, and add it to the
internal pointer to phandle table if not found.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 02823a8..971420a 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -36,7 +36,7 @@ static char *ft_root_node(struct ft_cxt
 
 /* Routines for keeping node ptrs returned by ft_find_device current */
 /* First entry not used b/c it would return 0 and be taken as NULL/error */
-static void *ft_node_add(struct ft_cxt *cxt, char *node)
+static void *ft_get_phandle(struct ft_cxt *cxt, char *node)
 {
 	unsigned int i;
 
@@ -642,7 +642,7 @@ void *ft_find_device(struct ft_cxt *cxt,
 	if (srch_path[0] != '/')
 		return NULL;
 	node = ft_find_descendent(cxt, ft_root_node(cxt), srch_path);
-	return ft_node_add(cxt, node);
+	return ft_get_phandle(cxt, node);
 }
 
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path)
-- 
1.4.4
