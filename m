Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 13626DE090
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:36 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:25 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 06/19] bootwrapper: Make ft_get_phandle() accept and return
	NULL.
Message-ID: <20070207230125.GF3849@ld0162-tx32.am.freescale.net>
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
