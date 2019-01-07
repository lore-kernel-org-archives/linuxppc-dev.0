Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A400C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:14:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97DD0206B7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Jan 2019 19:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97DD0206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YQ7d33wGzDqJs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 06:14:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43YQ2W2kgQzDqNd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 06:10:27 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x07J3nuD031657
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jan 2019 14:10:24 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pvc5dsux3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Jan 2019 14:10:24 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@kaod.org>;
 Mon, 7 Jan 2019 19:10:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Jan 2019 19:10:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x07JAI6Z35258422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Jan 2019 19:10:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78D424204F;
 Mon,  7 Jan 2019 19:10:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C39B42041;
 Mon,  7 Jan 2019 19:10:18 +0000 (GMT)
Received: from smtp.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.1])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Jan 2019 19:10:18 +0000 (GMT)
Received: from zorba.kaod.org.com (sig-9-145-153-156.de.ibm.com
 [9.145.153.156])
 by smtp.lab.toulouse-stg.fr.ibm.com (Postfix) with ESMTP id 93738220359;
 Mon,  7 Jan 2019 20:10:17 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
Date: Mon,  7 Jan 2019 20:10:05 +0100
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107191006.10648-1-clg@kaod.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107191006.10648-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19010719-0016-0000-0000-000002418864
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010719-0017-0000-0000-0000329B9849
Message-Id: <20190107191006.10648-2-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-07_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=843 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901070160
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

Clear the ESB pages from the VMA of the IRQ being pass through to the
guest and let the fault handler repopulate the VMA when the ESB pages
are accessed for an EOI or for a trigger.

Storing the VMA under the KVM XIVE device is a little ugly.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/powerpc/kvm/book3s_xive.h        |  8 +++++++
 arch/powerpc/kvm/book3s_xive.c        | 15 ++++++++++++++
 arch/powerpc/kvm/book3s_xive_native.c | 30 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
index 31e598e62589..6e64d3496a2c 100644
--- a/arch/powerpc/kvm/book3s_xive.h
+++ b/arch/powerpc/kvm/book3s_xive.h
@@ -90,6 +90,11 @@ struct kvmppc_xive_src_block {
 	struct kvmppc_xive_irq_state irq_state[KVMPPC_XICS_IRQ_PER_ICS];
 };
 
+struct kvmppc_xive;
+
+struct kvmppc_xive_ops {
+	int (*reset_mapped)(struct kvm *kvm, unsigned long guest_irq);
+};
 
 struct kvmppc_xive {
 	struct kvm *kvm;
@@ -131,6 +136,9 @@ struct kvmppc_xive {
 
 	/* VC base address for ESBs */
 	u64     vc_base;
+
+	struct kvmppc_xive_ops *ops;
+	struct vm_area_struct *vma;
 };
 
 #define KVMPPC_XIVE_Q_COUNT	8
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index e9f05d9c9ad5..9b4751713554 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -946,6 +946,13 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,
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
@@ -1031,6 +1038,14 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigned long guest_irq,
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
 				  xive_vp(xive, state->act_server),
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 1aefb366df0b..12edac29995e 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -240,6 +240,32 @@ static int kvmppc_xive_native_get_vc_base(struct kvmppc_xive *xive, u64 addr)
 	return 0;
 }
 
+static int kvmppc_xive_native_reset_mapped(struct kvm *kvm, unsigned long irq)
+{
+	struct kvmppc_xive *xive = kvm->arch.xive;
+	struct mm_struct *mm = kvm->mm;
+	struct vm_area_struct *vma = xive->vma;
+	unsigned long address;
+
+	if (irq >= KVMPPC_XIVE_NR_IRQS)
+		return -EINVAL;
+
+	pr_debug("clearing esb pages for girq 0x%lx\n", irq);
+
+	down_read(&mm->mmap_sem);
+	/* TODO: can we clear the PTEs without keeping a VMA pointer ? */
+	if (vma) {
+		address = vma->vm_start + irq * (2ull << PAGE_SHIFT);
+		zap_vma_ptes(vma, address, 2ull << PAGE_SHIFT);
+	}
+	up_read(&mm->mmap_sem);
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
@@ -292,6 +318,8 @@ static const struct vm_operations_struct xive_native_esb_vmops = {
 
 static int xive_native_esb_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct kvmppc_xive *xive = vma->vm_file->private_data;
+
 	/* There are two ESB pages (trigger and EOI) per IRQ */
 	if (vma_pages(vma) + vma->vm_pgoff > KVMPPC_XIVE_NR_IRQS * 2)
 		return -EINVAL;
@@ -299,6 +327,7 @@ static int xive_native_esb_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_IO | VM_PFNMAP;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	vma->vm_ops = &xive_native_esb_vmops;
+	xive->vma = vma; /* TODO: get rid of the VMA pointer */
 	return 0;
 }
 
@@ -992,6 +1021,7 @@ static int kvmppc_xive_native_create(struct kvm_device *dev, u32 type)
 	xive->vc_base = XIVE_VC_BASE;
 
 	xive->single_escalation = xive_native_has_single_escalation();
+	xive->ops = &kvmppc_xive_native_ops;
 
 	if (ret)
 		kfree(xive);
-- 
2.20.1

