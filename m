Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E335EDE106
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:05 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TKC47Y012986
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:04 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKC3rI014715
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:04 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsDS3014737
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:14 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id D60C34B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:02 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKC2cf013526
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:02 -0600
Date: Mon, 29 Jan 2007 14:12:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/18] bootwrapper: Preserve the pp pointer in ft_make_space()
	when calling ft_reorder().
Message-ID: <20070129201202.GG13485@ld0162-tx32.am.freescale.net>
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
@@ -261,8 +261,14 @@ static int ft_make_space(struct ft_cxt *
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
1.4.4
