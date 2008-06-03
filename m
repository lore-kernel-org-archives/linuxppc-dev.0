Return-Path: <borntraeger@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46C5DDDE45
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jun 2008 22:47:01 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id m53CkH5E554702
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 12:46:17 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m53CkH5s3469396
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:46:17 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m53CkGIl020549
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Jun 2008 14:46:17 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Linux PPC devel <linuxppc-dev@ozlabs.org>
Subject: [RFC 2/3] virtio_console: use virtqueue notification for hvc_console
Date: Tue, 3 Jun 2008 14:46:15 +0200
References: <200806031444.21945.borntraeger@de.ibm.com>
In-Reply-To: <200806031444.21945.borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806031446.15330.borntraeger@de.ibm.com>
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

This patch exploits the new notifier callbacks of the hvc_console. We can
use the virtio callbacks instead of the polling code. 

I also added a small Kconfig change that allows the user to specify the 
virtio console in menuconfig. 


Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/Kconfig          |    6 +++++-
 drivers/char/virtio_console.c |   27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

Index: kvm/drivers/char/Kconfig
===================================================================
--- kvm.orig/drivers/char/Kconfig
+++ kvm/drivers/char/Kconfig
@@ -637,8 +637,12 @@ config HVC_XEN
 	  Xen virtual console device driver
 
 config VIRTIO_CONSOLE
-	bool
+	bool "Virtio console"
+	depends on VIRTIO
 	select HVC_DRIVER
+	help
+	  Virtio console for use with lguest and other hypervisors.
+
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
Index: kvm/drivers/char/virtio_console.c
===================================================================
--- kvm.orig/drivers/char/virtio_console.c
+++ kvm/drivers/char/virtio_console.c
@@ -46,6 +46,9 @@ static char *in, *inbuf;
 /* The operations for our console. */
 static struct hv_ops virtio_cons;
 
+/* The hvc device */
+struct hvc_struct *hvc;
+
 /*D:310 The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the output
@@ -134,6 +137,25 @@ int __init virtio_cons_early_init(int (*
 	return hvc_instantiate(0, 0, &virtio_cons);
 }
 
+/*
+ * we support only one console, the hvc struct is a global var
+ * There is no need to do anything
+ */
+static int notifier_add_vio(struct hvc_struct *hp, int data)
+{
+	return 0;
+}
+
+static void notifier_del_vio(struct hvc_struct *hp, int data)
+{
+}
+
+static void hvc_handle_input(struct virtqueue *vq)
+{
+	if (hvc_poll(hvc))
+		hvc_kick();
+}
+
 /*D:370 Once we're further in boot, we get probed like any other virtio 
device.
  * At this stage we set up the output virtqueue.
  *
@@ -144,7 +166,6 @@ int __init virtio_cons_early_init(int (*
 static int __devinit virtcons_probe(struct virtio_device *dev)
 {
 	int err;
-	struct hvc_struct *hvc;
 
 	vdev = dev;
 
@@ -158,7 +179,7 @@ static int __devinit virtcons_probe(stru
 	/* Find the input queue. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	in_vq = vdev->config->find_vq(vdev, 0, NULL);
+	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input);
 	if (IS_ERR(in_vq)) {
 		err = PTR_ERR(in_vq);
 		goto free;
@@ -173,6 +194,8 @@ static int __devinit virtcons_probe(stru
 	/* Start using the new console output. */
 	virtio_cons.get_chars = get_chars;
 	virtio_cons.put_chars = put_chars;
+	virtio_cons.notifier_add = notifier_add_vio;
+	virtio_cons.notifier_del = notifier_del_vio;
 
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the interrupt number; we
