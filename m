Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 2D43FDE0D0
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:35 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l0OL7YNs028916
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:34 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0OL7XlI007497
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:34 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnunv008158
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:56 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id DD7084B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:32 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7WrZ010617
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:32 -0600
Date: Wed, 24 Jan 2007 15:07:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/18] Add a get_parent method to dt_ops.
Message-ID: <20070124210732.GQ10527@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree_misc.c |    6 ++++++
 arch/powerpc/boot/ops.h              |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index eb8d48d..3ce109e 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -51,12 +51,18 @@ unsigned long ft_finalize(void)
 	return (unsigned long)fdtm_cxt.bph;
 }
 
+void *fdtm_get_parent(const void *phandle)
+{
+	return ft_get_parent(&fdtm_cxt, phandle);
+}
+
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 {
 	dt_ops.finddevice = ft_finddevice;
 	dt_ops.getprop = ft_getprop;
 	dt_ops.setprop = ft_setprop;
 	dt_ops.finalize = ft_finalize;
+	dt_ops.get_parent = fdtm_get_parent;
 
 	return ft_open(&fdtm_cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 0bc4a68..65abba5 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -36,6 +36,7 @@ struct dt_ops {
 			const int buflen);
 	int	(*setprop)(const void *phandle, const char *name,
 			const void *buf, const int buflen);
+	void *(*get_parent)(const void *phandle);
 	unsigned long (*finalize)(void);
 };
 extern struct dt_ops dt_ops;
@@ -69,7 +70,6 @@ int ns16550_console_init(void *devp, str
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
 		u32 max_allocs);
 
-
 static inline void *finddevice(const char *name)
 {
 	return (dt_ops.finddevice) ? dt_ops.finddevice(name) : NULL;
@@ -85,6 +85,11 @@ static inline int setprop(void *devp, co
 	return (dt_ops.setprop) ? dt_ops.setprop(devp, name, buf, buflen) : -1;
 }
 
+static inline void *get_parent(const char *devp)
+{
+	return dt_ops.get_parent ? dt_ops.get_parent(devp) : NULL;
+}
+
 static inline void *malloc(u32 size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
-- 
1.4.4
