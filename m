Return-Path: <haren@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A7691B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 16:37:31 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 20 Mar 2012 23:37:23 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A546C19D804E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 23:37:13 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2L5bKtm214848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 23:37:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2L5bJRv027097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 23:37:19 -0600
Subject: [PATCH] Disable /dev/port interface on powerpc systems
From: Haren Myneni <haren@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Mar 2012 22:37:17 -0700
Message-ID: <1332308237.23222.49.camel@hbabu-laptop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Some power systems do not have legacy ISA devices. So, /dev/port is not
a valid interface on these systems. User level tools such as kbdrate is
trying to access the device using this interface which is causing the
system crash. 

This patch will fix this issue by not creating this interface on these
powerpc systems. 

Signed-off-by: Haren Myneni <haren@us.ibm.com>


diff -Naurp linux.orig/arch/powerpc/kernel/isa-bridge.c
linux/arch/powerpc/kernel/isa-bridge.c
--- linux.orig/arch/powerpc/kernel/isa-bridge.c	2012-02-11
02:08:08.780005293 -0800
+++ linux/arch/powerpc/kernel/isa-bridge.c	2012-02-11 02:16:25.080003386
-0800
@@ -255,6 +255,14 @@ static struct notifier_block isa_bridge_
 	.notifier_call = isa_bridge_notify
 };
 
+int __init legacy_isa_device_found(void)
+{
+	if (isa_bridge_pcidev)
+		return 1;
+	
+	return 0;
+}
+
 /**
  * isa_bridge_init - register to be notified of ISA bridge
addition/removal
  *
diff -Naurp linux.orig/drivers/char/mem.c linux/drivers/char/mem.c
--- linux.orig/drivers/char/mem.c	2012-02-11 02:08:42.710002440 -0800
+++ linux/drivers/char/mem.c	2012-03-20 20:40:43.650000003 -0700
@@ -35,6 +35,8 @@
 # include <linux/efi.h>
 #endif
 
+#define DEVPORT_MINOR	4
+
 static inline unsigned long size_inside_page(unsigned long start,
 					     unsigned long size)
 {
@@ -910,6 +912,11 @@ static char *mem_devnode(struct device *
 
 static struct class *mem_class;
 
+int __init __weak legacy_isa_device_found(void)
+{
+	return 1;
+}
+
 static int __init chr_dev_init(void)
 {
 	int minor;
@@ -930,6 +937,13 @@ static int __init chr_dev_init(void)
 	for (minor = 1; minor < ARRAY_SIZE(devlist); minor++) {
 		if (!devlist[minor].name)
 			continue;
+
+		/*
+		 * Create /dev/port? 
+		 */
+		if ((minor == DEVPORT_MINOR) && !legacy_isa_device_found())
+			continue;
+
 		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
 			      NULL, devlist[minor].name);
 	}
diff -Naurp linux.orig/include/linux/isa.h linux/include/linux/isa.h
--- linux.orig/include/linux/isa.h	2012-02-11 02:07:52.030019810 -0800
+++ linux/include/linux/isa.h	2012-02-11 02:16:49.810002296 -0800
@@ -36,4 +36,5 @@ static inline void isa_unregister_driver
 }
 #endif
 
+extern int __init legacy_isa_device_found(void);
 #endif /* __LINUX_ISA_H */
