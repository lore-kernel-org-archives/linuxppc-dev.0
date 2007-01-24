Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B063FDE1CC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:33 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0OL7WsH029359
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:32 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0OL7U9p007477
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:31 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnrkc008150
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:53 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id E4FB14B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:29 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7Taq010609
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:29 -0600
Date: Wed, 24 Jan 2007 15:07:29 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/18] Add initrd information to the device tree in
	ft_finalize().
Message-ID: <20070124210729.GO10527@ld0162-tx32.am.freescale.net>
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

linux,initrd-start and linux,initrd-end are added to the device tree
based on the values that platform code puts in the initrd struct.
ft_finalize() is also made global, so that platform code can do further
manipulation before returning to generic code.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree_misc.c |   14 +++++++++++++-
 arch/powerpc/boot/ops.h              |    1 +
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index da49ffb..eb8d48d 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
 	return ft_set_prop(&fdtm_cxt, phandle, propname, buf, buflen);
 }
 
-static unsigned long ft_finalize(void)
+unsigned long ft_finalize(void)
 {
+	unsigned long initrd_end = initrd.addr + initrd.size;
+	void *devp;
+
+	if (initrd.size && (devp = finddevice("/chosen"))) {
+		setprop(devp, "linux,initrd-start", &initrd.addr,
+		        sizeof(initrd.addr));
+		setprop(devp, "linux,initrd-end", &initrd_end,
+		        sizeof(initrd_end));
+
+		ft_add_rsvmap(&fdtm_cxt, initrd.addr, initrd.size);
+	}
+
 	ft_end_tree(&fdtm_cxt);
 	return (unsigned long)fdtm_cxt.bph;
 }
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 42c723d..0bc4a68 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -63,6 +63,7 @@ int platform_init(unsigned long r3, unsi
                   unsigned long r6, unsigned long r7,
                   char *dt_blob_start, char *dt_blob_end);
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device);
+unsigned long ft_finalize(void);
 int serial_console_init(void);
 int ns16550_console_init(void *devp, struct serial_console_data *scdp);
 void *simple_alloc_init(char *base, u32 heap_size, u32 granularity,
-- 
1.4.4
