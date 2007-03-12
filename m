Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A2392DE004
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:54 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:48 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 07/19] bootwrapper: Modify *pp, not *p, in ft_shuffle().
Message-ID: <20070312204148.GG28545@ld0162-tx32.am.freescale.net>
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
@@ -246,7 +246,7 @@ static int ft_shuffle(struct ft_cxt *cxt, char **pp, enum ft_rgn_id rgn,
 			if (rgn == FT_STRUCT)
 				ft_node_update_before(cxt, p, -nextra);
 		}
-		*p -= nextra;
+		*pp -= nextra;
 		cxt->rgn[rgn].start -= nextra;
 		cxt->rgn[rgn].size += nextra;
 		return 1;
-- 
1.5.0.3
