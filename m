Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7AC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:22:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72F82082A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72F82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fWF12Dz6zDqSr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:22:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.172.162; helo=18.mo3.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 18.mo3.mail-out.ovh.net (18.mo3.mail-out.ovh.net
 [87.98.172.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVvM6WL3zDqPw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:07:10 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.143.249])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id E2503207608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:07:06 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id EC351492A603;
 Wed, 10 Apr 2019 17:06:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a 'release'
 device operation
Date: Wed, 10 Apr 2019 19:04:48 +0200
Message-Id: <20190410170448.3923-17-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2502312544547605463
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudejgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

When a P9 sPAPR VM boots, the CAS negotiation process determines which
interrupt mode to use (XICS legacy or XIVE native) and invokes a
machine reset to activate the chosen mode.

To be able to switch from one mode to another, we introduce the
capability to release a KVM device without destroying the VM. The KVM
device interface is extended with a new 'release' operation which is
called when the file descriptor of the device is closed.

Such operations are defined for the XICS-on-XIVE and the XIVE native
KVM devices. They clear the vCPU interrupt presenters that could be
attached and then destroy the device.

This is not considered as a safe operation as the vCPUs are still
running and could be referencing the KVM device through their
presenters. To protect the system from any breakage, the kvmppc_xive
objects representing both KVM devices are now stored in an array under
the VM. Allocation is performed on first usage and memory is freed
only when the VM exits.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/kvm_host.h   |  1 +
 arch/powerpc/kvm/book3s_xive.h        |  1 +
 include/linux/kvm_host.h              |  1 +
 arch/powerpc/kvm/book3s_xive.c        | 99 ++++++++++++++++++++++++++-
 arch/powerpc/kvm/book3s_xive_native.c | 45 +++++++++++-
 virt/kvm/kvm_main.c                   | 13 ++++
 6 files changed, 156 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 9cc6abdce1b9..ed059c95e56a 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -314,6 +314,7 @@ struct kvm_arch {
 #ifdef CONFIG_KVM_XICS
 	struct kvmppc_xics *xics;
 	struct kvmppc_xive *xive;
+	struct kvmppc_xive *xive_devices[2];
 	struct kvmppc_passthru_irqmap *pimap;
 #endif
 	struct kvmppc_ops *kvm_ops;
diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index e011622dc038..426146332984 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -283,6 +283,7 @@ void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
 int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
 int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
 				  bool single_escalation);
+struct kvmppc_xive *kvmppc_xive_get_device(struct kvm *kvm, u32 type);
 
 #endif /* CONFIG_KVM_XICS */
 #endif /* _KVM_PPC_BOOK3S_XICS_H */
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 831d963451d8..3b444620d8fc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1246,6 +1246,7 @@ struct kvm_device_ops {
 	long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
 		      unsigned long arg);
 	int (*mmap)(struct kvm_device *dev, struct vm_area_struct *vma);
+	void (*release)(struct kvm_device *dev);
 };
 
 void kvm_device_get(struct kvm_device *dev);
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 480a3fc6b9fd..064a9f2ae678 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
 void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
-	struct kvmppc_xive *xive = xc->xive;
+	struct kvmppc_xive *xive;
 	int i;
 
+	if (!kvmppc_xics_enabled(vcpu))
+		return;
+
+	if (!xc)
+		return;
+
 	pr_devel("cleanup_vcpu(cpu=%d)\n", xc->server_num);
 
+	xive = xc->xive;
+
 	/* Ensure no interrupt is still routed to that VP */
 	xc->valid = false;
 	kvmppc_xive_disable_vcpu_interrupts(vcpu);
@@ -1141,6 +1149,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	}
 	/* Free the VP */
 	kfree(xc);
+
+	/* Cleanup the vcpu */
+	vcpu->arch.irq_type = KVMPPC_IRQ_DEFAULT;
+	vcpu->arch.xive_vcpu = NULL;
 }
 
 int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
@@ -1158,7 +1170,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	}
 	if (xive->kvm != vcpu->kvm)
 		return -EPERM;
-	if (vcpu->arch.irq_type)
+	if (vcpu->arch.irq_type != KVMPPC_IRQ_DEFAULT)
 		return -EBUSY;
 	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
 		pr_devel("Duplicate !\n");
@@ -1824,6 +1836,9 @@ void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
 	}
 }
 
+/*
+ * Called when VM is destroyed
+ */
 static void kvmppc_xive_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
@@ -1851,6 +1866,83 @@ static void kvmppc_xive_free(struct kvm_device *dev)
 	kfree(dev);
 }
 
+/*
+ * Called when device fd is closed
+ */
+static void kvmppc_xive_release(struct kvm_device *dev)
+{
+	struct kvmppc_xive *xive = dev->private;
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	pr_devel("Releasing xive device\n");
+
+	/*
+	 * When releasing the KVM device fd, the vCPUs can still be
+	 * running and we should clean up the vCPU interrupt
+	 * presenters first.
+	 */
+	if (atomic_read(&kvm->online_vcpus) != 0) {
+		/*
+		 * call kick_all_cpus_sync() to ensure that all CPUs
+		 * have executed any pending interrupts
+		 */
+		if (is_kvmppc_hv_enabled(kvm))
+			kick_all_cpus_sync();
+
+		/*
+		 * TODO: There is still a race window with the early
+		 * checks in kvmppc_native_connect_vcpu()
+		 */
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xive_cleanup_vcpu(vcpu);
+	}
+
+	if (kvm)
+		kvm->arch.xive = NULL;
+
+	/* Mask and free interrupts */
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_free_sources(xive->src_blocks[i]);
+		kfree(xive->src_blocks[i]);
+		xive->src_blocks[i] = NULL;
+	}
+
+	if (xive->vp_base != XIVE_INVALID_VP)
+		xive_native_free_vp_block(xive->vp_base);
+
+	/* Do no free device private data. Destroy handler will */
+	kfree(dev);
+}
+
+/*
+ * When the guest chooses the interrupt mode (XICS legacy or XIVE
+ * native), the VM will switch of KVM device. The previous device will
+ * be "released" before the new one is created.
+ *
+ * Until we are sure all execution paths are well protected, provide a
+ * fail safe (transitional) method for device destruction, in which
+ * the XIVE device pointer is recycled and not directly freed.
+ */
+struct kvmppc_xive *kvmppc_xive_get_device(struct kvm *kvm, u32 type)
+{
+	struct kvmppc_xive *xive;
+	bool xive_native_index = type == KVM_DEV_TYPE_XIVE;
+
+	xive = kvm->arch.xive_devices[xive_native_index];
+
+	if (!xive) {
+		xive = kzalloc(sizeof(*xive), GFP_KERNEL);
+		kvm->arch.xive_devices[xive_native_index] = xive;
+	} else {
+		memset(xive, 0, sizeof(*xive));
+	}
+
+	return xive;
+}
+
 static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
 {
 	struct kvmppc_xive *xive;
@@ -1859,7 +1951,7 @@ static int kvmppc_xive_create(struct kvm_device *dev, u32 type)
 
 	pr_devel("Creating xive for partition\n");
 
-	xive = kzalloc(sizeof(*xive), GFP_KERNEL);
+	xive = kvmppc_xive_get_device(kvm, type);
 	if (!xive)
 		return -ENOMEM;
 
@@ -2024,6 +2116,7 @@ struct kvm_device_ops kvm_xive_ops = {
 	.name = "kvm-xive",
 	.create = kvmppc_xive_create,
 	.init = kvmppc_xive_init,
+	.release = kvmppc_xive_release,
 	.destroy = kvmppc_xive_free,
 	.set_attr = xive_set_attr,
 	.get_attr = xive_get_attr,
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 62648f833adf..ba1c55a93673 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -964,6 +964,9 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	return -ENXIO;
 }
 
+/*
+ * Called when VM is destroyed
+ */
 static void kvmppc_xive_native_free(struct kvm_device *dev)
 {
 	struct kvmppc_xive *xive = dev->private;
@@ -991,6 +994,45 @@ static void kvmppc_xive_native_free(struct kvm_device *dev)
 	kfree(dev);
 }
 
+/*
+ * Called when device fd is closed
+ */
+static void kvmppc_xive_native_release(struct kvm_device *dev)
+{
+	struct kvmppc_xive *xive = dev->private;
+	struct kvm *kvm = xive->kvm;
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	pr_devel("Releasing xive native device\n");
+
+	/*
+	 * When releasing the KVM device fd, the vCPUs can still be
+	 * running and we should clean up the vCPU interrupt
+	 * presenters first.
+	 */
+	if (atomic_read(&kvm->online_vcpus) != 0) {
+		kvm_for_each_vcpu(i, vcpu, kvm)
+			kvmppc_xive_native_cleanup_vcpu(vcpu);
+	}
+
+	if (kvm)
+		kvm->arch.xive = NULL;
+
+	for (i = 0; i <= xive->max_sbid; i++) {
+		if (xive->src_blocks[i])
+			kvmppc_xive_free_sources(xive->src_blocks[i]);
+		kfree(xive->src_blocks[i]);
+		xive->src_blocks[i] = NULL;
+	}
+
+	if (xive->vp_base != XIVE_INVALID_VP)
+		xive_native_free_vp_block(xive->vp_base);
+
+	/* Do no free device private data. Destroy handler will */
+	kfree(dev);
+}
+
 static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 {
 	struct kvmppc_xive *xive;
@@ -1002,7 +1044,7 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	if (kvm->arch.xive)
 		return -EEXIST;
 
-	xive = kzalloc(sizeof(*xive), GFP_KERNEL);
+	xive = kvmppc_xive_get_device(kvm, type);
 	if (!xive)
 		return -ENOMEM;
 
@@ -1182,6 +1224,7 @@ struct kvm_device_ops kvm_xive_native_ops = {
 	.name = "kvm-xive-native",
 	.create = kvmppc_xive_native_create,
 	.init = kvmppc_xive_native_init,
+	.release = kvmppc_xive_native_release,
 	.destroy = kvmppc_xive_native_free,
 	.set_attr = kvmppc_xive_native_set_attr,
 	.get_attr = kvmppc_xive_native_get_attr,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ea2018ae1cd7..ea2619d5ca98 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2938,6 +2938,19 @@ static int kvm_device_release(struct inode *inode, struct file *filp)
 	struct kvm_device *dev = filp->private_data;
 	struct kvm *kvm = dev->kvm;
 
+	if (!dev)
+		return -ENODEV;
+
+	if (dev->kvm != kvm)
+		return -EPERM;
+
+	if (dev->ops->release) {
+		mutex_lock(&kvm->lock);
+		list_del(&dev->vm_node);
+		dev->ops->release(dev);
+		mutex_unlock(&kvm->lock);
+	}
+
 	kvm_put_kvm(kvm);
 	return 0;
 }
-- 
2.20.1

