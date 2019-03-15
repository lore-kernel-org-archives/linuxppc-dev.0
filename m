Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A71C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:31:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC3820854
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC3820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LRKs640vzDqRc
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 00:30:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=188.165.53.149; helo=2.mo2.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 2395 seconds by postgrey-1.36 at bilbo;
 Sat, 16 Mar 2019 00:28:02 AEDT
Received: from 2.mo2.mail-out.ovh.net (2.mo2.mail-out.ovh.net [188.165.53.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LRGV71WdzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 00:28:01 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.146.168])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7D66518A1B6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:09:12 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 503713CD20E6;
 Fri, 15 Mar 2019 12:09:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 14/17] KVM: PPC: Book3S HV: XIVE: add passthrough support
Date: Fri, 15 Mar 2019 13:06:06 +0100
Message-Id: <20190315120609.25910-15-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10801883708500184023
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
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The KVM XICS-over-XIVE device and the proposed KVM XIVE native device
implement an IRQ space for the guest using the generic IPI interrupts
of the XIVE IC controller. These interrupts are allocated at the OPAL
level and "mapped" into the guest IRQ number space in the range 0-0x1FFF.
Interrupt management is performed in the XIVE way: using loads and
stores on the addresses of the XIVE IPI interrupt ESB pages.

Both KVM devices share the same internal structure caching information
on the interrupts, among which the xive_irq_data struct containing the
addresses of the IPI ESB pages and an extra one in case of pass-through.
The later contains the addresses of the ESB pages of the underlying HW
controller interrupts, PHB4 in all cases for now.

A guest, when running in the XICS legacy interrupt mode, lets the KVM
XICS-over-XIVE device "handle" interrupt management, that is to
perform the loads and stores on the addresses of the ESB pages of the
guest interrupts. However, when running in XIVE native exploitation
mode, the KVM XIVE native device exposes the interrupt ESB pages to
the guest and lets the guest perform directly the loads and stores.

The VMA exposing the ESB pages make use of a custom VM fault handler
which role is to populate the VMA with appropriate pages. When a fault
occurs, the guest IRQ number is deduced from the offset, and the ESB
pages of associated XIVE IPI interrupt are inserted in the VMA (using
the internal structure caching information on the interrupts).

Supporting device passthrough in the guest running in XIVE native
exploitation mode adds some extra refinements because the ESB pages
of a different HW controller (PHB4) need to be exposed to the guest
along with the initial IPI ESB pages of the XIVE IC controller. But
the overall mechanic is the same.

When the device HW irqs are mapped into or unmapped from the guest
IRQ number space, the passthru_irq helpers, kvmppc_xive_set_mapped()
and kvmppc_xive_clr_mapped(), are called to record or clear the
passthrough interrupt information and to perform the switch.

The approach taken by this patch is to clear the ESB pages of the
guest IRQ number being mapped and let the VM fault handler repopulate.
The handler will insert the ESB page corresponding to the HW interrupt
of the device being passed-through or the initial IPI ESB page if the
device is being removed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---

 Changes since v2 :

 - extra comment in documentation

 arch/powerpc/kvm/book3s_xive.h             |  9 +++++
 arch/powerpc/kvm/book3s_xive.c             | 15 ++++++++
 arch/powerpc/kvm/book3s_xive_native.c      | 41 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt | 19 ++++++++++
 4 files changed, 84 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 622f594d93e1..e011622dc038 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -94,6 +94,11 @@ struct kvmppc_xive_src_block {
 	struct kvmppc_xive_irq_state irq_state[KVMPPC_XICS_IRQ_PER_ICS];
 };
 
+struct kvmppc_xive;
+
+struct kvmppc_xive_ops {
+	int (*reset_mapped)(struct kvm *kvm, unsigned long guest_irq);
+};
 
 struct kvmppc_xive {
 	struct kvm *kvm;
@@ -132,6 +137,10 @@ struct kvmppc_xive {
 
 	/* Flags */
 	u8	single_escalation;
+
+	struct kvmppc_xive_ops *ops;
+	struct address_space   *mapping;
+	struct mutex mapping_lock;
 };
 
 #define KVMPPC_XIVE_Q_COUNT	8
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index c1b7aa7dbc28..480a3fc6b9fd 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -937,6 +937,13 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
 	/* Turn the IPI hard off */
 	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
 
+	/*
+	 * Reset ESB guest mapping. Needed when ESB pages are exposed
+	 * to the guest in XIVE native mode
+	 */
+	if (xive->ops && xive->ops->reset_mapped)
+		xive->ops->reset_mapped(kvm, guest_irq);
+
 	/* Grab info about irq */
 	state->pt_number = hw_irq;
 	state->pt_data = irq_data_get_irq_handler_data(host_data);
@@ -1022,6 +1029,14 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
 	state->pt_number = 0;
 	state->pt_data = NULL;
 
+	/*
+	 * Reset ESB guest mapping. Needed when ESB pages are exposed
+	 * to the guest in XIVE native mode
+	 */
+	if (xive->ops && xive->ops->reset_mapped) {
+		xive->ops->reset_mapped(kvm, guest_irq);
+	}
+
 	/* Reconfigure the IPI */
 	xive_native_configure_irq(state->ipi_number,
 				  kvmppc_xive_vp(xive, state->act_server),
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index e465d4c53f5c..67a1bb26a4cc 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
+#include <linux/file.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
@@ -170,6 +171,35 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+/*
+ * Device passthrough support
+ */
+static int kvmppc_xive_native_reset_mapped(struct kvm *kvm, unsigned long irq)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+
+	if (irq >= KVMPPC_XIVE_NR_IRQS)
+		return -EINVAL;
+
+	/*
+	 * Clear the ESB pages of the IRQ number being mapped (or
+	 * unmapped) into the guest and let the the VM fault handler
+	 * repopulate with the appropriate ESB pages (device or IC)
+	 */
+	pr_debug("clearing esb pages for girq 0x%lx\n", irq);
+	mutex_lock(&xive->mapping_lock);
+	if (xive->mapping)
+		unmap_mapping_range(xive->mapping,
+				    irq * (2ull << PAGE_SHIFT),
+				    2ull << PAGE_SHIFT, 1);
+	mutex_unlock(&xive->mapping_lock);
+	return 0;
+}
+
+static struct kvmppc_xive_ops kvmppc_xive_native_ops =  {
+	.reset_mapped = kvmppc_xive_native_reset_mapped,
+};
+
 static int xive_native_esb_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -247,6 +277,8 @@ static const struct vm_operations_struct xive_native_tima_vmops = {
 static int kvmppc_xive_native_mmap(struct kvm_device *dev,
 				   struct vm_area_struct *vma)
 {
+	struct kvmppc_xive *xive = dev->private;
+
 	/* We only allow mappings at fixed offset for now */
 	if (vma->vm_pgoff == KVM_XIVE_TIMA_PAGE_OFFSET) {
 		if (vma_pages(vma) > 4)
@@ -262,6 +294,13 @@ static int kvmppc_xive_native_mmap(struct kvm_device *dev,
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
+
+	/*
+	 * Grab the KVM device file address_space to be able to clear
+	 * the ESB pages mapping when a device is passed-through into
+	 * the guest.
+	 */
+	xive->mapping = vma->vm_file->f_mapping;
 	return 0;
 }
 
@@ -959,6 +998,7 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	xive->dev = dev;
 	xive->kvm = kvm;
 	kvm->arch.xive = xive;
+	mutex_init(&xive->mapping_lock);
 
 	/*
 	 * Allocate a bunch of VPs. KVM_MAX_VCPUS is a large value for
@@ -972,6 +1012,7 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 		ret = -ENXIO;
 
 	xive->single_escalation = xive_native_has_single_escalation();
+	xive->ops = &kvmppc_xive_native_ops;
 
 	if (ret)
 		kfree(xive);
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 686cca450f9f..9aa48efca1cb 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -43,6 +43,25 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
   manage the source: to trigger, to EOI, to turn off the source for
   instance.
 
+  3. Device pass-through
+
+  When a device is passed-through into the guest, the source
+  interrupts are from a different HW controller (PHB4) and the ESB
+  pages exposed to the guest should accommadate this change.
+
+  The passthru_irq helpers, kvmppc_xive_set_mapped() and
+  kvmppc_xive_clr_mapped() are called when the device HW irqs are
+  mapped into or unmapped from the guest IRQ number space. The KVM
+  device extends these helpers to clear the ESB pages of the guest IRQ
+  number being mapped and then lets the VM fault handler repopulate.
+  The handler will insert the ESB page corresponding to the HW
+  interrupt of the device being passed-through or the initial IPI ESB
+  page if the device has being removed.
+
+  The ESB remapping is fully transparent to the guest and the OS
+  device driver. All handling is done within VFIO and the above
+  helpers in KVM-PPC.
+
 * Groups:
 
   1. KVM_DEV_XIVE_GRP_CTRL
-- 
2.20.1

