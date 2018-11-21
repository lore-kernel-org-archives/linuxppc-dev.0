Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9288C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:34:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C712087E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C712087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430B8X0bdhzF3CX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 16:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bharata@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430B1s5FrKzF3Dw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 16:28:33 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAL5SOQu130661
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:28:31 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nvwd9fjee-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:28:31 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Wed, 21 Nov 2018 05:28:28 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 21 Nov 2018 05:28:25 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAL5SORt7078256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Nov 2018 05:28:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 211A64C044;
 Wed, 21 Nov 2018 05:28:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92AAC4C04A;
 Wed, 21 Nov 2018 05:28:22 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.234])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 21 Nov 2018 05:28:22 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 3/4] kvmppc: H_SVM_INIT_START and H_SVM_INIT_DONE hcalls
Date: Wed, 21 Nov 2018 10:58:10 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121052811.4819-1-bharata@linux.ibm.com>
References: <20181121052811.4819-1-bharata@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112105-0020-0000-0000-000002EB47BD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112105-0021-0000-0000-0000213A7D4A
Message-Id: <20181121052811.4819-4-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-21_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210050
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, benh@linux.ibm.com, linux-mm@kvack.org,
 jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com, paulus@au1.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

H_SVM_INIT_START: Initiate securing a VM
H_SVM_INIT_DONE: Conclude securing a VM

During early guest init, these hcalls will be issued by UV.
As part of these hcalls, [un]register memslots with UV.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h    |  2 ++
 arch/powerpc/include/asm/kvm_host.h  |  1 +
 arch/powerpc/include/asm/kvm_ppc.h   | 12 ++++++++++
 arch/powerpc/include/asm/ucall-api.h |  6 +++++
 arch/powerpc/kvm/book3s_hv.c         |  6 +++++
 arch/powerpc/kvm/book3s_hv_hmm.c     | 33 ++++++++++++++++++++++++++++
 6 files changed, 60 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 34791c627f87..4872b044cca8 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -342,6 +342,8 @@
 /* Platform-specific hcalls used by the Ultravisor */
 #define H_SVM_PAGE_IN		0xFF00
 #define H_SVM_PAGE_OUT		0xFF04
+#define H_SVM_INIT_START	0xFF08
+#define H_SVM_INIT_DONE		0xFF0C
 
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR		1
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 729bdea22250..174aa7e30ff7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -296,6 +296,7 @@ struct kvm_arch {
 	struct dentry *htab_dentry;
 	struct dentry *radix_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
+	bool secure; /* Indicates H_SVM_INIT_START has been called */
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 659c80982497..5f4b6a73789f 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -919,6 +919,8 @@ extern unsigned long kvmppc_h_svm_page_out(struct kvm *kvm,
 					  unsigned long gra,
 					  unsigned long flags,
 					  unsigned long page_shift);
+extern unsigned long kvmppc_h_svm_init_start(struct kvm *kvm);
+extern unsigned long kvmppc_h_svm_init_done(struct kvm *kvm);
 #else
 static inline unsigned long
 kvmppc_h_svm_page_in(struct kvm *kvm, unsigned int lpid,
@@ -935,5 +937,15 @@ kvmppc_h_svm_page_out(struct kvm *kvm, unsigned int lpid,
 {
 	return H_UNSUPPORTED;
 }
+
+static inline unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
+{
+	return H_UNSUPPORTED;
+}
+
+static inline unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
+{
+	return H_UNSUPPORTED;
+}
 #endif
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
index a84dc2abd172..347637995b1b 100644
--- a/arch/powerpc/include/asm/ucall-api.h
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -19,4 +19,10 @@ static inline int uv_page_out(u64 lpid, u64 dst_ra, u64 src_gpa, u64 flags,
 	return U_SUCCESS;
 }
 
+static inline int uv_register_mem_slot(u64 lpid, u64 start_gpa, u64 size,
+				       u64 flags, u64 slotid)
+{
+	return 0;
+}
+
 #endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7e413605e7c4..d7aa85330016 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1006,6 +1006,12 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 					    kvmppc_get_gpr(vcpu, 6),
 					    kvmppc_get_gpr(vcpu, 7));
 		break;
+	case H_SVM_INIT_START:
+		ret = kvmppc_h_svm_init_start(vcpu->kvm);
+		break;
+	case H_SVM_INIT_DONE:
+		ret = kvmppc_h_svm_init_done(vcpu->kvm);
+		break;
 
 	default:
 		return RESUME_HOST;
diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
index 2730ab832330..e138b0edee9f 100644
--- a/arch/powerpc/kvm/book3s_hv_hmm.c
+++ b/arch/powerpc/kvm/book3s_hv_hmm.c
@@ -55,6 +55,39 @@ struct kvmppc_hmm_migrate_args {
 	unsigned long page_shift;
 };
 
+unsigned long kvmppc_h_svm_init_start(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *memslot;
+	int ret = H_SUCCESS;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+	slots = kvm_memslots(kvm);
+	kvm_for_each_memslot(memslot, slots) {
+		ret = uv_register_mem_slot(kvm->arch.lpid,
+					   memslot->base_gfn << PAGE_SHIFT,
+					   memslot->npages * PAGE_SIZE,
+					   0, memslot->id);
+		if (ret < 0) {
+			ret = H_PARAMETER; /* TODO: proper retval */
+			goto out;
+		}
+	}
+	kvm->arch.secure = true;
+out:
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	return ret;
+}
+
+unsigned long kvmppc_h_svm_init_done(struct kvm *kvm)
+{
+	if (kvm->arch.secure)
+		return H_SUCCESS;
+	else
+		return H_UNSUPPORTED;
+}
+
 #define KVMPPC_PFN_HMM		(0x1ULL << 61)
 
 static inline bool kvmppc_is_hmm_pfn(unsigned long pfn)
-- 
2.17.1

