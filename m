Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 46E0ADE273
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:10 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0TKC9wV019064
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:09 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKC8ZV022991
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:08 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsHPI014756
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:17 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CBD184B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:06 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKC6Wt013534
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:06 -0600
Date: Mon, 29 Jan 2007 14:12:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/18] bootwrapper: Use map_string() instead of
	lookup_string() in ft_prop().
Message-ID: <20070129201206.GI13485@ld0162-tx32.am.freescale.net>
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

When adding a property, the property name should be added to the string
table if it doesn't already exist.  map_string() does that;
lookup_string() will fail instead.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index f2a29ca..e319a65 100644
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
