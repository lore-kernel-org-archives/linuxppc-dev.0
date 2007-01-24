Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 242CADE08E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:18 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7F1M020543
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:15 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7ESc002818
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:14 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnbHk008123
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:37 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id DEA734B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:13 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7Dxd010579
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:13 -0600
Date: Wed, 24 Jan 2007 15:07:13 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/18] Modify *pp, not *p, in ft_shuffle().
Message-ID: <20070124210713.GH10527@ld0162-tx32.am.freescale.net>
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

Move the caller's pointer back to match the change in the region's start,
rather than alter a byte of the device tree's content.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 90db08e..e72a898 100644
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
