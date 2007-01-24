Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 43C66DDF50
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:12 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0OL7B34029250
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:11 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7ANb029216
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:11 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnXVm008116
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:33 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id D55404B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:09 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL79q7010571
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:09 -0600
Date: Wed, 24 Jan 2007 15:07:09 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/18] Make ft_node_add() accept and return NULL.
Message-ID: <20070124210709.GF10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, if ft_node_add() is passed NULL it will allocate an entry for
it and return a non-NULL phandle.  This patch makes it simply pass the
NULL through.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 78e179f..55b6699 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -40,6 +40,9 @@ static void *ft_node_add(struct ft_cxt *
 {
 	unsigned int i;
 
+	if (!node)
+		return NULL;
+
 	for (i = 1; i < cxt->nodes_used; i++)	/* already there? */
 		if (cxt->node_tbl[i] == node)
 			return (void *)i;
-- 
1.4.4
