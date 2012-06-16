Return-Path: <haren@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 126E6B7110
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 16:42:21 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Sat, 16 Jun 2012 00:42:18 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0152BC90057
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 02:42:15 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5G6gFNQ181572
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 02:42:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5G6gFWl002078
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 02:42:15 -0400
Subject: [PATCH] Disable /dev/port interface on powerpc systems
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 15 Jun 2012 23:42:13 -0700
Message-ID: <1339828933.22619.15.camel@hbabu-laptop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael, Thanks for the comment. Here it is the updated patch which
fixes x86 build.

Thanks
Haren

Some power systems do not have legacy ISA devices. So, /dev/port is not
a valid interface on these systems. User level tools such as kbdrate is
trying to access the device using this interface which is causing the
system crash. 

This patch will fix this issue by not creating this interface on these
powerpc systems. 

Signed-off-by: Haren Myneni <haren@us.ibm.com>

diff -Naurp linux.orig/arch/powerpc/include/asm/io.h linux/arch/powerpc/include/asm/io.h
--- linux.orig/arch/powerpc/include/asm/io.h	2012-06-16 01:15:11.000000000 -0500
+++ linux/arch/powerpc/include/asm/io.h	2012-06-16 01:15:20.000000000 -0500
@@ -20,6 +20,14 @@ extern int check_legacy_ioport(unsigned 
 #define _PNPWRP		0xa79
 #define PNPBIOS_BASE	0xf000
 
+#ifdef CONFIG_PPC64
+extern struct pci_dev *isa_bridge_pcidev;
+/*
+ * has legacy ISA devices ?
+ */
+#define arch_has_dev_port()	(isa_bridge_pcidev != NULL)
+#endif
+
 #include <linux/device.h>
 #include <linux/io.h>
 
diff -Naurp linux.orig/drivers/char/mem.c linux/drivers/char/mem.c
--- linux.orig/drivers/char/mem.c	2012-06-16 01:15:42.000000000 -0500
+++ linux/drivers/char/mem.c	2012-06-16 01:15:53.000000000 -0500
@@ -27,14 +27,16 @@
 #include <linux/splice.h>
 #include <linux/pfn.h>
 #include <linux/export.h>
+#include <linux/io.h>
 
 #include <asm/uaccess.h>
-#include <asm/io.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
 #endif
 
+#define DEVPORT_MINOR	4
+
 static inline unsigned long size_inside_page(unsigned long start,
 					     unsigned long size)
 {
@@ -894,6 +896,13 @@ static int __init chr_dev_init(void)
 	for (minor = 1; minor < ARRAY_SIZE(devlist); minor++) {
 		if (!devlist[minor].name)
 			continue;
+
+		/*
+		 * Create /dev/port? 
+		 */
+		if ((minor == DEVPORT_MINOR) && !arch_has_dev_port())
+			continue;
+
 		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
 			      NULL, devlist[minor].name);
 	}
diff -Naurp linux.orig/include/linux/io.h linux/include/linux/io.h
--- linux.orig/include/linux/io.h	2012-06-16 01:16:13.000000000 -0500
+++ linux/include/linux/io.h	2012-06-16 01:16:24.000000000 -0500
@@ -67,4 +67,13 @@ int check_signature(const volatile void 
 			const unsigned char *signature, int length);
 void devm_ioremap_release(struct device *dev, void *res);
 
+/*
+ * Some systems do not have legacy ISA devices.
+ * /dev/port is not a valid interface on these systems.
+ * So for those archs, <asm/io.h> should define the following symbol.
+ */
+#ifndef arch_has_dev_port
+#define arch_has_dev_port()     (1)
+#endif
+
 #endif /* _LINUX_IO_H */
