Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D484CDE04B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:56 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 09/19] bootwrapper: Use map_string() instead of
	lookup_string() in ft_prop().
Message-ID: <20070312204151.GI28545@ld0162-tx32.am.freescale.net>
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

When adding a property, the property name should be added to the string
table if it doesn't already exist.  map_string() does that;
lookup_string() will fail instead.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 0c8970e..605d248 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -433,7 +433,7 @@ int ft_prop(struct ft_cxt *cxt, const char *name, const void *data,
 {
 	int off, len;
 
-	off = lookup_string(cxt, name);
+	off = map_string(cxt, name);
 	if (off == NO_STRING)
 		return -1;
 
-- 
1.5.0.3
