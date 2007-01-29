Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 41B5CDE294
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:11 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TKCADr013013
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:10 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKC9ha014756
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:09 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsJ1b014769
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:19 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 42DB94B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:08 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKC8KH013538
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:08 -0600
Date: Mon, 29 Jan 2007 14:12:08 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/18] bootwrapper: Add ft_find_device_rel().
Message-ID: <20070129201208.GJ13485@ld0162-tx32.am.freescale.net>
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

Add a function to look up a relative, rather than absolute, path name.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   13 +++++++++++++
 arch/powerpc/boot/flatdevtree.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index e319a65..bd006f7 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -654,6 +654,19 @@ void *ft_find_device(struct ft_cxt *cxt,
 	return ft_get_phandle(cxt, node);
 }
 
+void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
+                         const char *srch_path)
+{
+	char *node;
+
+	node = ft_node_ph2node(cxt, top);
+	if (node == NULL)
+		return NULL;
+
+	node = ft_find_descendent(cxt, node, srch_path);
+	return ft_get_phandle(cxt, node);
+}
+
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path)
 {
 	struct ft_atom atom;
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index b9cd9f6..1f37ca2 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -97,6 +97,8 @@ int ft_add_rsvmap(struct ft_cxt *cxt, u6
 void ft_dump_blob(const void *bphp);
 void ft_merge_blob(struct ft_cxt *cxt, void *blob);
 void *ft_find_device(struct ft_cxt *cxt, const char *srch_path);
+void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
+                         const char *srch_path);
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path);
 int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		void *buf, const unsigned int buflen);
-- 
1.4.4
