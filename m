Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D42C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F5D20643
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F5D20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445V1j0007zDqRD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:47:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td11KvjzDqWZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:08 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBO9CT040767
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:02 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtefsndcw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:02 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:29:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSufK59310198
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86DA052057;
 Fri, 22 Feb 2019 11:28:56 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 75E7952059;
 Fri, 22 Feb 2019 11:28:56 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 BA9C722026B; Fri, 22 Feb 2019 12:28:55 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 12/16] KVM: PPC: Book3S HV: XIVE: add a TIMA mapping
Date: Fri, 22 Feb 2019 12:28:36 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-0028-0000-0000-0000034BB554
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-0029-0000-0000-00002409FDC6
Message-Id: <20190222112840.25000-13-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220081
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
index 42d4ef93ec2d..be9b255e061d 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -720,4 +720,6 @@ struct kvm_ppc_xive_eq {
 #define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
 #define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
 
+#define KVM_XIVE_TIMA_PAGE_OFFSET	0
+
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 132bff52d70a..c6ac818a13b2 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -176,6 +176,44 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
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
@@ -1005,6 +1043,7 @@ struct kvm_device_ops kvm_xive_native_ops = {
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
index 1b8957c50c53..4d6b41609fd9 100644
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

