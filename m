Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF983C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C20120674
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 17:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C20120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fW9S1HYkzDqQF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.140; helo=5.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo179.mail-out.ovh.net (5.mo179.mail-out.ovh.net
 [46.105.43.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fVtw1yMjzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 03:06:46 +1000 (AEST)
Received: from player157.ha.ovh.net (unknown [10.109.159.157])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 23672124A83
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 19:06:42 +0200 (CEST)
Received: from kaod.org (lfbn-tou-1-40-22.w86-201.abo.wanadoo.fr
 [86.201.133.22]) (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 740C0492A540;
 Wed, 10 Apr 2019 17:06:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 13/16] KVM: PPC: Book3S HV: XIVE: add a mapping for the
 source ESB pages
Date: Wed, 10 Apr 2019 19:04:45 +0200
Message-Id: <20190410170448.3923-14-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190410170448.3923-1-clg@kaod.org>
References: <20190410170448.3923-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 2495557144996711383
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
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Each source is associated with an Event State Buffer (ESB) with a
even/odd pair of pages which provides commands to manage the source:
to trigger, to EOI, to turn off the source for instance.

The custom VM fault handler will deduce the guest IRQ number from the
offset of the fault, and the ESB page of the associated XIVE interrupt
will be inserted into the VMA using the internal structure caching
information on the interrupts.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 57 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  7 +++
 3 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 0998e8edc91a..b0f72dea8b11 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -721,5 +721,6 @@ struct kvm_ppc_xive_eq {
 #define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
 
 #define KVM_XIVE_TIMA_PAGE_OFFSET	0
+#define KVM_XIVE_ESB_PAGE_OFFSET	4
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index f5314da0cb45..465eb90ff23e 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -165,6 +165,59 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static vm_fault_t xive_native_esb_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct kvm_device *dev = vma->vm_file->private_data;
+	struct kvmppc_xive *xive = dev->private;
+	struct kvmppc_xive_src_block *sb;
+	struct kvmppc_xive_irq_state *state;
+	struct xive_irq_data *xd;
+	u32 hw_num;
+	u16 src;
+	u64 page;
+	unsigned long irq;
+	u64 page_offset;
+
+	/*
+	 * Linux/KVM uses a two pages ESB setting, one for trigger and
+	 * one for EOI
+	 */
+	page_offset = vmf->pgoff - vma->vm_pgoff;
+	irq = page_offset / 2;
+
+	sb = kvmppc_xive_find_source(xive, irq, &src);
+	if (!sb) {
+		pr_devel("%s: source %lx not found !\n", __func__, irq);
+		return VM_FAULT_SIGBUS;
+	}
+
+	state = &sb->irq_state[src];
+	kvmppc_xive_select_irq(state, &hw_num, &xd);
+
+	arch_spin_lock(&sb->lock);
+
+	/*
+	 * first/even page is for trigger
+	 * second/odd page is for EOI and management.
+	 */
+	page = page_offset % 2 ? xd->eoi_page : xd->trig_page;
+	arch_spin_unlock(&sb->lock);
+
+	if (WARN_ON(!page)) {
+		pr_err("%s: acessing invalid ESB page for source %lx !\n",
+		       __func__, irq);
+		return VM_FAULT_SIGBUS;
+	}
+
+	vmf_insert_pfn(vma, vmf->address, page >> PAGE_SHIFT);
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct xive_native_esb_vmops = {
+	.fault = xive_native_esb_fault,
+};
+
 static vm_fault_t xive_native_tima_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -194,6 +247,10 @@ static int kvmppc_xive_native_mmap(struct kvm_device *dev,
 		if (vma_pages(vma) > 4)
 			return -EINVAL;
 		vma->vm_ops = &xive_native_tima_vmops;
+	} else if (vma->vm_pgoff == KVM_XIVE_ESB_PAGE_OFFSET) {
+		if (vma_pages(vma) > KVMPPC_XIVE_NR_IRQS * 2)
+			return -EINVAL;
+		vma->vm_ops = &xive_native_esb_vmops;
 	} else {
 		return -EINVAL;
 	}
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index 0cd7847ec38a..69ee62d3d4dc 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -36,6 +36,13 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
   third (operating system) and the fourth (user level) are exposed the
   guest.
 
+  2. Event State Buffer (ESB)
+
+  Each source is associated with an Event State Buffer (ESB) with
+  either a pair of even/odd pair of pages which provides commands to
+  manage the source: to trigger, to EOI, to turn off the source for
+  instance.
+
 * Groups:
 
   1. KVM_DEV_XIVE_GRP_CTRL
-- 
2.20.1

