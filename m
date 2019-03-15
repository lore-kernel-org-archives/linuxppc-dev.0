Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD2C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08DF20854
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 13:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08DF20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LRHx3yspzDqT7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 00:29:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.32.116.78; helo=8.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 4709 seconds by postgrey-1.36 at bilbo;
 Sat, 16 Mar 2019 00:27:27 AEDT
Received: from 8.mo5.mail-out.ovh.net (8.mo5.mail-out.ovh.net [178.32.116.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LRFq37XDzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 00:27:24 +1100 (AEDT)
Received: from player793.ha.ovh.net (unknown [10.109.143.208])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 79A8B224ED7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 13:08:51 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player793.ha.ovh.net (Postfix) with ESMTPSA id 64CA83CD2031;
 Fri, 15 Mar 2019 12:08:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v3 12/17] KVM: PPC: Book3S HV: XIVE: add a TIMA mapping
Date: Fri, 15 Mar 2019 13:06:04 +0100
Message-Id: <20190315120609.25910-13-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190315120609.25910-1-clg@kaod.org>
References: <20190315120609.25910-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10795972732990294999
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

Each thread has an associated Thread Interrupt Management context
composed of a set of registers. These registers let the thread handle
priority management and interrupt acknowledgment. The most important
are :

    - Interrupt Pending Buffer     (IPB)
    - Current Processor Priority   (CPPR)
    - Notification Source Register (NSR)

They are exposed to software in four different pages each proposing a
view with a different privilege. The first page is for the physical
thread context and the second for the hypervisor. Only the third
(operating system) and the fourth (user level) are exposed the guest.

A custom VM fault handler will populate the VMA with the appropriate
pages, which should only be the OS page for now.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/xive.h            |  1 +
 arch/powerpc/include/uapi/asm/kvm.h        |  2 ++
 arch/powerpc/kvm/book3s_xive_native.c      | 39 ++++++++++++++++++++++
 arch/powerpc/sysdev/xive/native.c          | 11 ++++++
 Documentation/virtual/kvm/devices/xive.txt | 23 +++++++++++++
 5 files changed, 76 insertions(+)

diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
index 46891f321606..eb6d302082da 100644
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
index 3de0d1395c01..6836d38a517c 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -720,4 +720,6 @@ struct kvm_ppc_xive_eq {
 #define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
 #define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
 
+#define KVM_XIVE_TIMA_PAGE_OFFSET	0
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 675c209cf570..f10087dbcac2 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -170,6 +170,44 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static int xive_native_tima_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+
+	switch (vmf->pgoff - vma->vm_pgoff) {
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
+static int kvmppc_xive_native_mmap(struct kvm_device *dev,
+				   struct vm_area_struct *vma)
+{
+	/* We only allow mappings at fixed offset for now */
+	if (vma->vm_pgoff == KVM_XIVE_TIMA_PAGE_OFFSET) {
+		if (vma_pages(vma) > 4)
+			return -EINVAL;
+		vma->vm_ops = &xive_native_tima_vmops;
+	} else {
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached_wc(vma->vm_page_prot);
+	return 0;
+}
+
 static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
 					 u64 addr)
 {
@@ -1038,6 +1076,7 @@ struct kvm_device_ops kvm_xive_native_ops = {
 	.set_attr = kvmppc_xive_native_set_attr,
 	.get_attr = kvmppc_xive_native_get_attr,
 	.has_attr = kvmppc_xive_native_has_attr,
+	.mmap = kvmppc_xive_native_mmap,
 };
 
 void kvmppc_xive_native_init_module(void)
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
 
diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/virtual/kvm/devices/xive.txt
index eb864d72ddc3..fbb51c4798fe 100644
--- a/Documentation/virtual/kvm/devices/xive.txt
+++ b/Documentation/virtual/kvm/devices/xive.txt
@@ -13,6 +13,29 @@ requires a POWER9 host and the guest OS should have support for the
 XIVE native exploitation interrupt mode. If not, it should run using
 the legacy interrupt mode, referred as XICS (POWER7/8).
 
+* Device Mappings
+
+  The KVM device exposes different MMIO ranges of the XIVE HW which
+  are required for interrupt management. These are exposed to the
+  guest in VMAs populated with a custom VM fault handler.
+
+  1. Thread Interrupt Management Area (TIMA)
+
+  Each thread has an associated Thread Interrupt Management context
+  composed of a set of registers. These registers let the thread
+  handle priority management and interrupt acknowledgment. The most
+  important are :
+
+      - Interrupt Pending Buffer     (IPB)
+      - Current Processor Priority   (CPPR)
+      - Notification Source Register (NSR)
+
+  They are exposed to software in four different pages each proposing
+  a view with a different privilege. The first page is for the
+  physical thread context and the second for the hypervisor. Only the
+  third (operating system) and the fourth (user level) are exposed the
+  guest.
+
 * Groups:
 
   1. KVM_DEV_XIVE_GRP_CTRL
-- 
2.20.1

