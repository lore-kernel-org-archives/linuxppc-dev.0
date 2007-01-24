Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 29C89DE082
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:18 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7HgO020549
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:17 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7GkE013139
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:16 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnd7w008127
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:39 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id E1BB14B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:15 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7FAw010584
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:15 -0600
Date: Wed, 24 Jan 2007 15:07:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/18] Use map_string() instead of lookup_string() in
	ft_prop().
Message-ID: <20070124210715.GI10527@ld0162-tx32.am.freescale.net>
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

When adding a property, the property name should be added to the string
table if it doesn't already exist.  map_string() does that;
lookup_string() will fail instead.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index e72a898..e46346b 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -429,7 +429,7 @@ int ft_prop(struct ft_cxt *cxt, const ch
 {
 	int off, len;
 
-	off = lookup_string(cxt, name);
+	off = map_string(cxt, name);
 	if (off == NO_STRING)
 		return -1;
 
-- 
1.4.4
