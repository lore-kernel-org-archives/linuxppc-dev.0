Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE4CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:58:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830B420700
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830B420700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445VGJ4BtrzDqLM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:58:00 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Td44176zDqWN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:29:12 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1MBO7m1040653
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:03 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qtefsnddc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 06:29:02 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Fri, 22 Feb 2019 11:29:01 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Feb 2019 11:28:58 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1MBSvfo35455092
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Feb 2019 11:28:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52827A4060;
 Fri, 22 Feb 2019 11:28:57 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 381FCA405F;
 Fri, 22 Feb 2019 11:28:57 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 22 Feb 2019 11:28:57 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-77-130.uk.ibm.com [9.145.77.130])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id
 787C9220296; Fri, 22 Feb 2019 12:28:56 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v2 13/16] KVM: PPC: Book3S HV: XIVE: add a mapping for the
 source ESB pages
Date: Fri, 22 Feb 2019 12:28:37 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222112840.25000-1-clg@kaod.org>
References: <20190222112840.25000-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022211-4275-0000-0000-00000312A5A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022211-4276-0000-0000-00003820DCCF
Message-Id: <20190222112840.25000-14-clg@kaod.org>
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

Each source is associated with an Event State Buffer (ESB) with a
even/odd pair of pages which provides commands to manage the source:
to trigger, to EOI, to turn off the source for instance.

The custom VM fault handler will deduce the guest IRQ number from the
offset of the fault, and the ESB page of the associated XIVE interrupt
will be inserted into the VMA using the internal structure caching
information on the interrupts.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/include/uapi/asm/kvm.h        |  1 +
 arch/powerpc/kvm/book3s_xive_native.c      | 57 ++++++++++++++++++++++
 Documentation/virtual/kvm/devices/xive.txt |  7 +++
 3 files changed, 65 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index be9b255e061d..d8990e9044e3 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -721,5 +721,6 @@ struct kvm_ppc_xive_eq {
 #define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
 
 #define KVM_XIVE_TIMA_PAGE_OFFSET	0
+#define KVM_XIVE_ESB_PAGE_OFFSET	4
 
 #endif /* __LINUX_KVM_POWERPC_H */
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index c6ac818a13b2..92cab6409e8e 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -176,6 +176,59 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 	return rc;
 }
 
+static int xive_native_esb_fault(struct vm_fault *vmf)
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
 static int xive_native_tima_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -205,6 +258,10 @@ static int kvmppc_xive_native_mmap(struct kvm_device *dev,
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
index 4d6b41609fd9..be5000b2eb5a 100644
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

