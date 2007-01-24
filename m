Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 0F45DDE0C2
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:22 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7M1c020585
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:22 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7LXF002852
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:21 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKniBv008131
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:44 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 553D14B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:20 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7KdK010588
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:20 -0600
Date: Wed, 24 Jan 2007 15:07:20 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/18] Add ft_find_device_rel().
Message-ID: <20070124210720.GJ10527@ld0162-tx32.am.freescale.net>
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

Add a function to look up a relative, rather than absolute, path name.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   12 ++++++++++++
 arch/powerpc/boot/flatdevtree.h |    1 +
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index e46346b..87a4a06 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -654,6 +654,18 @@ void *ft_find_device(struct ft_cxt *cxt,
 	return ft_node_add(cxt, node);
 }
 
+void *ft_find_device_rel(struct ft_cxt *cxt, void *top, const char *srch_path)
+{
+	char *node;
+
+	node = ft_node_ph2node(cxt, top);
+	if (node == NULL)
+		return NULL;
+
+	node = ft_find_descendent(cxt, node, srch_path);
+	return ft_node_add(cxt, node);
+}
+
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path)
 {
 	struct ft_atom atom;
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index b9cd9f6..462fbb9 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -97,6 +97,7 @@ int ft_add_rsvmap(struct ft_cxt *cxt, u6
 void ft_dump_blob(const void *bphp);
 void ft_merge_blob(struct ft_cxt *cxt, void *blob);
 void *ft_find_device(struct ft_cxt *cxt, const char *srch_path);
+void *ft_find_device_rel(struct ft_cxt *cxt, void *top, const char *srch_path);
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path);
 int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		void *buf, const unsigned int buflen);
-- 
1.4.4
