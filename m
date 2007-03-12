Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id AE726DDFCA
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:52 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:47 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 06/19] bootwrapper: Preserve the pp pointer in ft_make_space()
	when calling ft_reorder().
Message-ID: <20070312204147.GF28545@ld0162-tx32.am.freescale.net>
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

The ft_reorder() function may change the start of the region of interest,
so the pointer provided by the caller into that region must be fixed up
to still point to the same datum.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 6c18773..0fa4f98 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -261,8 +261,14 @@ static int ft_make_space(struct ft_cxt *cxt, char **pp, enum ft_rgn_id rgn,
 	char *str, *next;
 	enum ft_rgn_id r;
 
-	if (!cxt->isordered && !ft_reorder(cxt, nextra))
-		return 0;
+	if (!cxt->isordered) {
+		unsigned long rgn_off = *pp - cxt->rgn[rgn].start;
+
+		if (!ft_reorder(cxt, nextra))
+			return 0;
+
+		*pp = cxt->rgn[rgn].start + rgn_off;
+	}
 	if (ft_shuffle(cxt, pp, rgn, nextra))
 		return 1;
 
-- 
1.5.0.3
