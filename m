Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7F117DDF8B
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:18 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7DKj020536
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:13 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7CaV013119
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:13 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnZxl008119
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:35 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id E077C4B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:11 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7B5J010575
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:11 -0600
Date: Wed, 24 Jan 2007 15:07:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/18] Preserve the pp pointer in ft_make_space() when calling
	ft_reorder().
Message-ID: <20070124210711.GG10527@ld0162-tx32.am.freescale.net>
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

The ft_reorder() function may change the start of the region of interest,
so the pointer provided by the caller into that region must be fixed up
to still point to the same datum.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 55b6699..90db08e 100644
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
