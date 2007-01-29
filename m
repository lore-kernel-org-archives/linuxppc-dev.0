Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 1FB47DE849
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:13:07 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TKD6Xu013279
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:13:07 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKD5vY015029
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:06 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJtF73014942
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:55:16 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id F03D14B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:04 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKD4IW013562
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:13:04 -0600
Date: Mon, 29 Jan 2007 14:13:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/18] bootwrapper: Add initrd information to the device tree
	in ft_finalize().
Message-ID: <20070129201304.GN13485@ld0162-tx32.am.freescale.net>
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
index 04da38f..39fa010 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -33,8 +33,20 @@ static int ft_setprop(const void *phandl
 	return ft_set_prop(&cxt, phandle, propname, buf, buflen);
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
+		ft_add_rsvmap(&cxt, initrd.addr, initrd.size);
+	}
+
 	ft_end_tree(&cxt);
 	return (unsigned long)cxt.bph;
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
