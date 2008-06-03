Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 781DEDDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 22:47:32 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m53CklEZ251700
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 12:46:47 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m53CklOS2687058
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:46:47 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m53CklPO001271
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:46:47 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Linux PPC devel <linuxppc-dev@ozlabs.org>
Subject: [RFC 3/3] s390: use virtio_console for KVM on s390
Date: Tue, 3 Jun 2008 14:46:45 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
In-Reply-To: <200806031444.21945.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031446.45759.borntraeger@de.ibm.com>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables virtio_console as the default console on kvm for
s390. We currently use the same notify hack as lguest for early
console output. I will try to address this for lguest and s390 later.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/Kconfig             |    1 +
 arch/s390/kernel/setup.c      |    4 +++-
 drivers/s390/kvm/kvm_virtio.c |   20 ++++++++++++++++++++
 include/asm-s390/kvm_virtio.h |   10 ++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

Index: kvm/arch/s390/Kconfig
===================================================================
--- kvm.orig/arch/s390/Kconfig
+++ kvm/arch/s390/Kconfig
@@ -540,6 +540,7 @@ bool "s390 guest support (EXPERIMENTAL)"
 	depends on 64BIT && EXPERIMENTAL
 	select VIRTIO
 	select VIRTIO_RING
+	select VIRTIO_CONSOLE
 	help
 	  Select this option if you want to run the kernel under s390 linux
 endmenu
Index: kvm/arch/s390/kernel/setup.c
===================================================================
--- kvm.orig/arch/s390/kernel/setup.c
+++ kvm/arch/s390/kernel/setup.c
@@ -54,6 +54,7 @@
 #include <asm/sections.h>
 #include <asm/ebcdic.h>
 #include <asm/compat.h>
+#include <asm/kvm_virtio.h>
 
 long psw_kernel_bits	= (PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY |
 			   PSW_MASK_MCHECK | PSW_DEFAULT_KEY);
@@ -799,7 +800,8 @@ setup_arch(char **cmdline_p)
 		printk("We are running under VM (64 bit mode)\n");
 	else if (MACHINE_IS_KVM) {
 		printk("We are running under KVM (64 bit mode)\n");
-		add_preferred_console("ttyS", 1, NULL);
+		add_preferred_console("hvc", 0, NULL);
+		s390_virtio_console_init();
 	} else
 		printk("We are running native (64 bit mode)\n");
 #endif /* CONFIG_64BIT */
Index: kvm/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- kvm.orig/drivers/s390/kvm/kvm_virtio.c
+++ kvm/drivers/s390/kvm/kvm_virtio.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
+#include <linux/virtio_console.h>
 #include <linux/interrupt.h>
 #include <linux/virtio_ring.h>
 #include <linux/pfn.h>
@@ -338,6 +339,25 @@ static int __init kvm_devices_init(void)
 	return 0;
 }
 
+/* code for early console output with virtio_console */
+static __init int early_put_chars(u32 vtermno, const char *buf, int count)
+{
+	char scratch[17];
+	unsigned int len = count;
+
+	if (len > sizeof(scratch) - 1)
+		len = sizeof(scratch) - 1;
+	scratch[len] = '\0';
+	memcpy(scratch, buf, len);
+	kvm_hypercall1(KVM_S390_VIRTIO_NOTIFY, __pa(scratch));
+	return len;
+}
+
+void s390_virtio_console_init(void)
+{
+	virtio_cons_early_init(early_put_chars);
+}
+
 /*
  * We do this after core stuff, but before the drivers.
  */
Index: kvm/include/asm-s390/kvm_virtio.h
===================================================================
--- kvm.orig/include/asm-s390/kvm_virtio.h
+++ kvm/include/asm-s390/kvm_virtio.h
@@ -50,4 +50,14 @@ struct kvm_vqconfig {
 #define KVM_S390_VIRTIO_RESET		1
 #define KVM_S390_VIRTIO_SET_STATUS	2
 
+#ifdef __KERNEL__
+/* early virtio console setup */
+#ifdef CONFIG_VIRTIO_CONSOLE
+extern void s390_virtio_console_init(void);
+#else
+static inline void s390_virtio_console_init(void)
+{
+}
+#endif /* CONFIG_VIRTIO_CONSOLE */
+#endif /* __KERNEL__ */
 #endif
