Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D7EF7DE16A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:29 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7Sl9020617
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:28 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7RBc002874
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:28 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnokS008146
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:51 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 2184E4B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:27 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7RY5010605
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:27 -0600
Date: Wed, 24 Jan 2007 15:07:26 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/18] Make flatdevtree_misc's cxt global.
Message-ID: <20070124210726.GN10527@ld0162-tx32.am.freescale.net>
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

This allows platform code to use flatdevtree functions directly.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree_misc.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 04da38f..da49ffb 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -14,29 +14,29 @@
 #include "flatdevtree.h"
 #include "ops.h"
 
-static struct ft_cxt cxt;
+struct ft_cxt fdtm_cxt;
 
 static void *ft_finddevice(const char *name)
 {
-	return ft_find_device(&cxt, name);
+	return ft_find_device(&fdtm_cxt, name);
 }
 
 static int ft_getprop(const void *phandle, const char *propname, void *buf,
 		const int buflen)
 {
-	return ft_get_prop(&cxt, phandle, propname, buf, buflen);
+	return ft_get_prop(&fdtm_cxt, phandle, propname, buf, buflen);
 }
 
 static int ft_setprop(const void *phandle, const char *propname,
 		const void *buf, const int buflen)
 {
-	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
+	return ft_set_prop(&fdtm_cxt, phandle, propname, buf, buflen);
 }
 
 static unsigned long ft_finalize(void)
 {
-	ft_end_tree(&cxt);
-	return (unsigned long)cxt.bph;
+	ft_end_tree(&fdtm_cxt);
+	return (unsigned long)fdtm_cxt.bph;
 }
 
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
@@ -46,6 +46,6 @@ int ft_init(void *dt_blob, unsigned int
 	dt_ops.setprop = ft_setprop;
 	dt_ops.finalize = ft_finalize;
 
-	return ft_open(&cxt, dt_blob, max_size, max_find_device,
+	return ft_open(&fdtm_cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
 }
-- 
1.4.4
