Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 18AF3DE14B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:07 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0TKC61r019055
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:06 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0TKC54u010466
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:05 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsF3B014747
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:15 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 51E454B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:04 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKC4DI013530
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:04 -0600
Date: Mon, 29 Jan 2007 14:12:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/18] bootwrapper: Modify *pp, not *p, in ft_shuffle().
Message-ID: <20070129201204.GH13485@ld0162-tx32.am.freescale.net>
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

Move the caller's pointer back to match the change in the region's start,
rather than alter a byte of the device tree's content.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 0fa4f98..f2a29ca 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -246,7 +246,7 @@ static int ft_shuffle(struct ft_cxt *cxt
 			if (rgn == FT_STRUCT)
 				ft_node_update_before(cxt, p, -nextra);
 		}
-		*p -= nextra;
+		*pp -= nextra;
 		cxt->rgn[rgn].start -= nextra;
 		cxt->rgn[rgn].size += nextra;
 		return 1;
-- 
1.4.4
