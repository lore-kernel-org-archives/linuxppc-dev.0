Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C59BEDE15A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:04 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0TKC3sO019033
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:03 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0TKC2fq010451
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:02 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsCep014729
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:12 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 4D6A54B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:01 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKC1kB013522
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:01 -0600
Date: Mon, 29 Jan 2007 14:12:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/18] bootwrapper: Make ft_get_phandle() accept and return
	NULL.
Message-ID: <20070129201201.GF13485@ld0162-tx32.am.freescale.net>
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

Currently, if ft_get_phandle() is passed NULL it will allocate an entry
for it and return a non-NULL phandle.  This patch makes it simply pass
the NULL through.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 971420a..6c18773 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -40,6 +40,9 @@ static void *ft_get_phandle(struct ft_cx
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
