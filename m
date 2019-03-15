Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9F6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:44:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC1820854
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC1820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LQHn5Mh6zDqTF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:44:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.50.32; helo=7.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 597 seconds by postgrey-1.36 at bilbo;
 Fri, 15 Mar 2019 23:27:39 AEDT
Received: from 7.mo69.mail-out.ovh.net (7.mo69.mail-out.ovh.net [46.105.50.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPwq6607zDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:27:37 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.146.32])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 3B2164B2F5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:09:35 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 4ACC93CD21A7;
 Fri, 15 Mar 2019 12:09:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 16/17] KVM: introduce a KVM_DESTROY_DEVICE ioctl
Date: Fri, 15 Mar 2019 13:06:08 +0100
Message-Id: <20190315120609.25910-17-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10808357632757173207
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrheehgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The 'destroy' method is currently used to destroy all devices when the
VM is destroyed after the vCPUs have been freed.

This new KVM ioctl exposes the same KVM device method. It acts as a
software reset of the VM to 'destroy' selected devices when necessary
and perform the required cleanups on the vCPUs. Called with the
kvm->lock.

The 'destroy' method could be improved by returning an error code.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

  Changes since v2 :

 - checked that device is owned by VM
 
 include/uapi/linux/kvm.h          |  7 ++++++
 virt/kvm/kvm_main.c               | 42 +++++++++++++++++++++++++++++++
 Documentation/virtual/kvm/api.txt | 20 +++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52bf74a1616e..d78fafa54274 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1183,6 +1183,11 @@ struct kvm_create_device {
 	__u32	flags;	/* in: KVM_CREATE_DEVICE_xxx */
 };
 
+struct kvm_destroy_device {
+	__u32	fd;	/* in: device handle */
+	__u32	flags;	/* in: unused */
+};
+
 struct kvm_device_attr {
 	__u32	flags;		/* no flags currently defined */
 	__u32	group;		/* device-defined */
@@ -1331,6 +1336,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_destroy_device)
+
 /*
  * ioctls for vcpu fds
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e4881a8c2a6f..7b616a1d48cf 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3026,6 +3026,34 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
 	return 0;
 }
 
+static int kvm_ioctl_destroy_device(struct kvm *kvm,
+				    struct kvm_destroy_device *dd)
+{
+	struct fd f;
+	struct kvm_device *dev;
+
+	f = fdget(dd->fd);
+	if (!f.file)
+		return -EBADF;
+
+	dev = kvm_device_from_filp(f.file);
+	fdput(f);
+
+	if (!dev)
+		return -ENODEV;
+
+	if (dev->kvm != kvm)
+		return -EPERM;
+
+	mutex_lock(&kvm->lock);
+	list_del(&dev->vm_node);
+	dev->ops->destroy(dev);
+	mutex_unlock(&kvm->lock);
+
+	/* TODO: kvm_put_kvm() crashes the host on some occasion ? */
+	return 0;
+}
+
 static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 {
 	switch (arg) {
@@ -3270,6 +3298,20 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_DESTROY_DEVICE: {
+		struct kvm_destroy_device dd;
+
+		r = -EFAULT;
+		if (copy_from_user(&dd, argp, sizeof(dd)))
+			goto out;
+
+		r = kvm_ioctl_destroy_device(kvm, &dd);
+		if (r)
+			goto out;
+
+		r = 0;
+		break;
+	}
 	case KVM_CHECK_EXTENSION:
 		r = kvm_vm_ioctl_check_extension_generic(kvm, arg);
 		break;
diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 1db1435769b4..914471494602 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3857,6 +3857,26 @@ number of valid entries in the 'entries' array, which is then filled.
 'index' and 'flags' fields in 'struct kvm_cpuid_entry2' are currently reserved,
 userspace should not expect to get any particular value there.
 
+4.119 KVM_DESTROY_DEVICE
+
+Capability: KVM_CAP_DEVICE_CTRL
+Type: vm ioctl
+Parameters: struct kvm_destroy_device (in)
+Returns: 0 on success, -1 on error
+Errors:
+  ENODEV: The device type is unknown or unsupported
+  EPERM: The device does not belong to the VM
+
+  Other error conditions may be defined by individual device types or
+  have their standard meanings.
+
+Destroys an emulated device in the kernel.
+
+struct kvm_destroy_device {
+	__u32	fd;	/* in: device handle */
+	__u32	flags;	/* unused */
+};
+
 5. The kvm_run structure
 ------------------------
 
-- 
2.20.1

