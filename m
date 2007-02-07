Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 87DC0DE1F5
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:58 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:40 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 15/19] bootwrapper: Add initrd information to the device tree
	in ft_finalize().
Message-ID: <20070207230140.GO3849@ld0162-tx32.am.freescale.net>
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
