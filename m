Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B5FE3DDF72
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:50 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:45 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 05/19] bootwrapper: Make ft_get_phandle() accept and return
	NULL.
Message-ID: <20070312204145.GE28545@ld0162-tx32.am.freescale.net>
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
@@ -40,6 +40,9 @@ static void *ft_get_phandle(struct ft_cxt *cxt, char *node)
 {
 	unsigned int i;
 
+	if (!node)
+		return NULL;
+
 	for (i = 1; i < cxt->nodes_used; i++)	/* already there? */
 		if (cxt->node_tbl[i] == node)
 			return (void *)i;
-- 
1.5.0.3
