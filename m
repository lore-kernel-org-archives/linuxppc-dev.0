Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5857CC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:29:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB032085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB032085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQS36YnPzDqQD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.40.176; helo=9.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 1802 seconds by postgrey-1.36 at bilbo;
 Tue, 08 Jan 2019 06:22:09 AEDT
Received: from 9.mo4.mail-out.ovh.net (9.mo4.mail-out.ovh.net [46.105.40.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YQJ15V1KzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:22:09 +1100 (AEDT)
Received: from player737.ha.ovh.net (unknown [10.109.146.106])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id D71341C89C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2019 19:45:09 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
 [90.89.196.110]) (Authenticated sender: clg@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 08A4F1866417;
 Mon,  7 Jan 2019 18:44:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 07/19] KVM: PPC: Book3S HV: add a GET_TIMA_FD control to XIVE
 native device
Date: Mon,  7 Jan 2019 19:43:19 +0100
Message-Id: <20190107184331.8429-8-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107184331.8429-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11400018033937255383
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrvdejgdduudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

This will let the guest create a memory mapping to expose the XIVE
MMIO region (TIMA) used for interrupt management at the CPU level.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/asm/xive.h       |  1 +
 arch/powerpc/include/uapi/asm/kvm.h   |  1 +
 arch/powerpc/kvm/book3s_xive_native.c | 57 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/xive/native.c     | 11 ++++++
 4 files changed, 70 insertions(+)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index d6be3e4d9fa4..7a7aa22d8258 100644
--- a/arch/powerpc/include/asm/xive.h
+++ b/arch/powerpc/include/asm/xive.h
@@ -23,6 +23,7 @@
  * same offset regardless of where the code is executing
  */
 extern void __iomem *xive_tima;
+extern unsigned long xive_tima_os;
 
 /*
  * Offset in the TM area of our current execution level (provided by
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 6bb61ba141c2..89c140cb9e79 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -678,5 +678,6 @@ struct kvm_ppc_cpu_char {
 /* POWER9 XIVE Native Interrupt Controller */
 #define KVM_DEV_XIVE_GRP_CTRL		1
 #define   KVM_DEV_XIVE_GET_ESB_FD	1
+#define   KVM_DEV_XIVE_GET_TIMA_FD	2
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index e20081f0c8d4..ee9d12bf2dae 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -232,6 +232,60 @@ static int kvmppc_xive_native_get_esb_fd(struct kvmppc_xive *xive, u64 addr)
 	return put_user(ret, ubufp);
 }
 
+static int xive_native_tima_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+
+	switch (vmf->pgoff) {
+	case 0: /* HW - forbid access */
+	case 1: /* HV - forbid access */
+		return VM_FAULT_SIGBUS;
+	case 2: /* OS */
+		vmf_insert_pfn(vma, vmf->address, xive_tima_os >> PAGE_SHIFT);
+		return VM_FAULT_NOPAGE;
+	case 3: /* USER - TODO */
+	default:
+		return VM_FAULT_SIGBUS;
+	}
+}
+
+static const struct vm_operations_struct xive_native_tima_vmops = {
+	.fault = xive_native_tima_fault,
+};
+
+static int xive_native_tima_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/*
+	 * The TIMA is four pages wide but only the last two pages (OS
+	 * and User view) are accessible to the guest. The page fault
+	 * handler will handle the permissions.
+	 */
+	if (vma_pages(vma) + vma->vm_pgoff > 4)
+		return -EINVAL;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
+	vma->vm_ops = &xive_native_tima_vmops;
+	return 0;
+}
+
+static const struct file_operations xive_native_tima_fops = {
+	.mmap = xive_native_tima_mmap,
+};
+
+static int kvmppc_xive_native_get_tima_fd(struct kvmppc_xive *xive, u64 addr)
+{
+	u64 __user *ubufp = (u64 __user *) addr;
+	int ret;
+
+	ret = anon_inode_getfd("[xive-tima]", &xive_native_tima_fops, xive,
+			       O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		return ret;
+
+	return put_user(ret, ubufp);
+}
+
 static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
 				       struct kvm_device_attr *attr)
 {
@@ -248,6 +302,8 @@ static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
 		switch (attr->attr) {
 		case KVM_DEV_XIVE_GET_ESB_FD:
 			return kvmppc_xive_native_get_esb_fd(xive, attr->addr);
+		case KVM_DEV_XIVE_GET_TIMA_FD:
+			return kvmppc_xive_native_get_tima_fd(xive, attr->addr);
 		}
 		break;
 	}
@@ -261,6 +317,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
 	case KVM_DEV_XIVE_GRP_CTRL:
 		switch (attr->attr) {
 		case KVM_DEV_XIVE_GET_ESB_FD:
+		case KVM_DEV_XIVE_GET_TIMA_FD:
 			return 0;
 		}
 		break;
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 0c037e933e55..7782201e5fe8 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -521,6 +521,9 @@ u32 xive_native_default_eq_shift(void)
 }
 EXPORT_SYMBOL_GPL(xive_native_default_eq_shift);
 
+unsigned long xive_tima_os;
+EXPORT_SYMBOL_GPL(xive_tima_os);
+
 bool __init xive_native_init(void)
 {
 	struct device_node *np;
@@ -573,6 +576,14 @@ bool __init xive_native_init(void)
 	for_each_possible_cpu(cpu)
 		kvmppc_set_xive_tima(cpu, r.start, tima);
 
+	/* Resource 2 is OS window */
+	if (of_address_to_resource(np, 2, &r)) {
+		pr_err("Failed to get thread mgmnt area resource\n");
+		return false;
+	}
+
+	xive_tima_os = r.start;
+
 	/* Grab size of provisionning pages */
 	xive_parse_provisioning(np);
 
-- 
2.20.1

