Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2CD2BDE175
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:49 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 11/19] bootwrapper: Add ft_find_device_rel().
Message-ID: <20070207230133.GK3849@ld0162-tx32.am.freescale.net>
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

Add a function to look up a relative, rather than absolute, path name.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   13 +++++++++++++
 arch/powerpc/boot/flatdevtree.h |    2 ++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 605d248..b0d27c9 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -658,6 +658,19 @@ void *ft_find_device(struct ft_cxt *cxt,
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
