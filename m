Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B70B8DE022
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:42 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:28 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 08/19] bootwrapper: Modify *pp, not *p, in ft_shuffle().
Message-ID: <20070207230128.GH3849@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
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
