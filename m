Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2C836DE031
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:35 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 05/19] bootwrapper: Rename ft_node_add() to ft_get_phandle().
Message-ID: <20070207230123.GE3849@ld0162-tx32.am.freescale.net>
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
