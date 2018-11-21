Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B85CC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:39:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C0221104
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08C0221104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430BGV0f9pzF3DT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 16:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=bharata@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430B2W3fRnzF3f4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 16:29:07 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAL5T1KJ143407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:29:05 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2nw0td8xcc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:29:03 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Wed, 21 Nov 2018 05:28:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 21 Nov 2018 05:28:20 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAL5SIm27995818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Nov 2018 05:28:18 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 806234C044;
 Wed, 21 Nov 2018 05:28:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA3F04C052;
 Wed, 21 Nov 2018 05:28:16 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.234])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 21 Nov 2018 05:28:16 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 1/4] kvmppc: HMM backend driver to manage pages of
 secure guest
Date: Wed, 21 Nov 2018 10:58:08 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121052811.4819-1-bharata@linux.ibm.com>
References: <20181121052811.4819-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112105-0020-0000-0000-000002EB47B9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112105-0021-0000-0000-0000213A7D47
Message-Id: <20181121052811.4819-2-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-21_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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

HMM driver for KVM PPC to manage page transitions of
secure guest via H_SVM_PAGE_IN and H_SVM_PAGE_OUT hcalls.

H_SVM_PAGE_IN: Move the content of a normal page to secure page
H_SVM_PAGE_OUT: Move the content of a secure page to normal page

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h    |   4 +
 arch/powerpc/include/asm/kvm_host.h  |  14 +
 arch/powerpc/include/asm/kvm_ppc.h   |  28 ++
 arch/powerpc/include/asm/ucall-api.h |  22 ++
 arch/powerpc/kvm/Makefile            |   3 +
 arch/powerpc/kvm/book3s_hv.c         |  21 ++
 arch/powerpc/kvm/book3s_hv_hmm.c     | 457 +++++++++++++++++++++++++++
 7 files changed, 549 insertions(+)
 create mode 100644 arch/powerpc/include/asm/ucall-api.h
 create mode 100644 arch/powerpc/kvm/book3s_hv_hmm.c

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 33a4fc891947..c900f47c0a9f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -336,6 +336,10 @@
 #define H_ENTER_NESTED		0xF804
 #define H_TLB_INVALIDATE	0xF808
 
+/* Platform-specific hcalls used by the Ultravisor */
+#define H_SVM_PAGE_IN		0xFF00
+#define H_SVM_PAGE_OUT		0xFF04
+
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR		1
 #define H_SET_MODE_RESOURCE_SET_DAWR		2
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index fac6f631ed29..729bdea22250 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -842,4 +842,18 @@ static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_block_finish(struct kvm_vcpu *vcpu) {}
 
+#ifdef CONFIG_PPC_SVM
+extern int kvmppc_hmm_init(void);
+extern void kvmppc_hmm_free(void);
+extern void kvmppc_hmm_release_pfns(struct kvm_memory_slot *free);
+#else
+static inline int kvmppc_hmm_init(void)
+{
+	return 0;
+}
+
+static inline void kvmppc_hmm_free(void) {}
+static inline void kvmppc_hmm_release_pfns(struct kvm_memory_slot *free) {}
+#endif /* CONFIG_PPC_SVM */
+
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 9b89b1918dfc..659c80982497 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -908,4 +908,32 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
 
 extern void xics_wake_cpu(int cpu);
 
+#ifdef CONFIG_PPC_SVM
+extern unsigned long kvmppc_h_svm_page_in(struct kvm *kvm,
+					  unsigned int lpid,
+					  unsigned long gra,
+					  unsigned long flags,
+					  unsigned long page_shift);
+extern unsigned long kvmppc_h_svm_page_out(struct kvm *kvm,
+					  unsigned int lpid,
+					  unsigned long gra,
+					  unsigned long flags,
+					  unsigned long page_shift);
+#else
+static inline unsigned long
+kvmppc_h_svm_page_in(struct kvm *kvm, unsigned int lpid,
+		     unsigned long gra, unsigned long flags,
+		     unsigned long page_shift)
+{
+	return H_UNSUPPORTED;
+}
+
+static inline unsigned long
+kvmppc_h_svm_page_out(struct kvm *kvm, unsigned int lpid,
+		      unsigned long gra, unsigned long flags,
+		      unsigned long page_shift)
+{
+	return H_UNSUPPORTED;
+}
+#endif
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
new file mode 100644
index 000000000000..a84dc2abd172
--- /dev/null
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_UCALL_API_H
+#define _ASM_POWERPC_UCALL_API_H
+
+#define U_SUCCESS 0
+
+/*
+ * TODO: Dummy uvcalls, will be replaced by real calls
+ */
+static inline int uv_page_in(u64 lpid, u64 src_ra, u64 dst_gpa, u64 flags,
+			     u64 page_shift)
+{
+	return U_SUCCESS;
+}
+
+static inline int uv_page_out(u64 lpid, u64 dst_ra, u64 src_gpa, u64 flags,
+			      u64 page_shift)
+{
+	return U_SUCCESS;
+}
+
+#endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index 64f1135e7732..a9547318662e 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -76,6 +76,9 @@ kvm-hv-y += \
 	book3s_64_mmu_radix.o \
 	book3s_hv_nested.o
 
+kvm-hv-$(CONFIG_PPC_SVM) += \
+	book3s_hv_hmm.o
+
 kvm-hv-$(CONFIG_PPC_TRANSACTIONAL_MEM) += \
 	book3s_hv_tm.o
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d65b961661fb..7e413605e7c4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -74,6 +74,7 @@
 #include <asm/opal.h>
 #include <asm/xics.h>
 #include <asm/xive.h>
+#include <asm/kvm_host.h>
 
 #include "book3s.h"
 
@@ -991,6 +992,20 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 		if (nesting_enabled(vcpu->kvm))
 			ret = kvmhv_do_nested_tlbie(vcpu);
 		break;
+	case H_SVM_PAGE_IN:
+		ret = kvmppc_h_svm_page_in(vcpu->kvm,
+					   kvmppc_get_gpr(vcpu, 4),
+					   kvmppc_get_gpr(vcpu, 5),
+					   kvmppc_get_gpr(vcpu, 6),
+					   kvmppc_get_gpr(vcpu, 7));
+		break;
+	case H_SVM_PAGE_OUT:
+		ret = kvmppc_h_svm_page_out(vcpu->kvm,
+					    kvmppc_get_gpr(vcpu, 4),
+					    kvmppc_get_gpr(vcpu, 5),
+					    kvmppc_get_gpr(vcpu, 6),
+					    kvmppc_get_gpr(vcpu, 7));
+		break;
 
 	default:
 		return RESUME_HOST;
@@ -4345,6 +4360,7 @@ static void kvmppc_core_free_memslot_hv(struct kvm_memory_slot *free,
 					struct kvm_memory_slot *dont)
 {
 	if (!dont || free->arch.rmap != dont->arch.rmap) {
+		kvmppc_hmm_release_pfns(free);
 		vfree(free->arch.rmap);
 		free->arch.rmap = NULL;
 	}
@@ -5357,11 +5373,16 @@ static int kvmppc_book3s_init_hv(void)
 			no_mixing_hpt_and_radix = true;
 	}
 
+	r = kvmppc_hmm_init();
+	if (r < 0)
+		pr_err("KVM-HV: kvmppc_hmm_init failed %d\n", r);
+
 	return r;
 }
 
 static void kvmppc_book3s_exit_hv(void)
 {
+	kvmppc_hmm_free();
 	kvmppc_free_host_rm_ops();
 	if (kvmppc_radix_possible())
 		kvmppc_radix_exit();
diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
new file mode 100644
index 000000000000..5f2a924a4f16
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_hmm.c
@@ -0,0 +1,457 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMM driver to manage page migration between normal and secure
+ * memory.
+ *
+ * Based on Jérôme Glisse's HMM dummy driver.
+ *
+ * Copyright 2018 Bharata B Rao, IBM Corp. <bharata@linux.ibm.com>
+ */
+
+/*
+ * A pseries guest can be run as a secure guest on Ultravisor-enabled
+ * POWER platforms. On such platforms, this driver will be used to manage
+ * the movement of guest pages between the normal memory managed by
+ * hypervisor (HV) and secure memory managed by Ultravisor (UV).
+ *
+ * Private ZONE_DEVICE memory equal to the amount of secure memory
+ * available in the platform for running secure guests is created
+ * via a HMM device. The movement of pages between normal and secure
+ * memory is done by ->alloc_and_copy() callback routine of migrate_vma().
+ *
+ * The page-in or page-out requests from UV will come to HV as hcalls and
+ * HV will call back into UV via uvcalls to satisfy these page requests.
+ *
+ * For each page that gets moved into secure memory, a HMM PFN is used
+ * on the HV side and HMM migration PTE corresponding to that PFN would be
+ * populated in the QEMU page tables.
+ */
+
+#include <linux/hmm.h>
+#include <linux/kvm_host.h>
+#include <linux/sched/mm.h>
+#include <asm/ucall-api.h>
+
+struct kvmppc_hmm_device {
+	struct hmm_device *device;
+	struct hmm_devmem *devmem;
+	unsigned long *pfn_bitmap;
+};
+
+static struct kvmppc_hmm_device kvmppc_hmm;
+spinlock_t kvmppc_hmm_lock;
+
+struct kvmppc_hmm_page_pvt {
+	unsigned long *rmap;
+	unsigned int lpid;
+	unsigned long gpa;
+};
+
+struct kvmppc_hmm_migrate_args {
+	unsigned long *rmap;
+	unsigned int lpid;
+	unsigned long gpa;
+	unsigned long page_shift;
+};
+
+#define KVMPPC_PFN_HMM		(0x1ULL << 61)
+
+static inline bool kvmppc_is_hmm_pfn(unsigned long pfn)
+{
+	return !!(pfn & KVMPPC_PFN_HMM);
+}
+
+void kvmppc_hmm_release_pfns(struct kvm_memory_slot *free)
+{
+	int i;
+
+	for (i = 0; i < free->npages; i++) {
+		unsigned long *rmap = &free->arch.rmap[i];
+
+		if (kvmppc_is_hmm_pfn(*rmap))
+			put_page(pfn_to_page(*rmap & ~KVMPPC_PFN_HMM));
+	}
+}
+
+/*
+ * Get a free HMM PFN from the pool
+ *
+ * Called when a normal page is moved to secure memory (UV_PAGE_IN). HMM
+ * PFN will be used to keep track of the secure page on HV side.
+ */
+/*
+ * TODO: In this and subsequent functions, we pass around and access
+ * individual elements of kvm_memory_slot->arch.rmap[] without any
+ * protection. Figure out the safe way to access this.
+ */
+static struct page *kvmppc_hmm_get_page(unsigned long *rmap,
+					unsigned long gpa, unsigned int lpid)
+{
+	struct page *dpage = NULL;
+	unsigned long bit, hmm_pfn;
+	unsigned long nr_pfns = kvmppc_hmm.devmem->pfn_last -
+				kvmppc_hmm.devmem->pfn_first;
+	unsigned long flags;
+	struct kvmppc_hmm_page_pvt *pvt;
+
+	if (kvmppc_is_hmm_pfn(*rmap))
+		return NULL;
+
+	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
+	bit = find_first_zero_bit(kvmppc_hmm.pfn_bitmap, nr_pfns);
+	if (bit >= nr_pfns)
+		goto out;
+
+	bitmap_set(kvmppc_hmm.pfn_bitmap, bit, 1);
+	hmm_pfn = bit + kvmppc_hmm.devmem->pfn_first;
+	dpage = pfn_to_page(hmm_pfn);
+
+	if (!trylock_page(dpage))
+		goto out_clear;
+
+	*rmap = hmm_pfn | KVMPPC_PFN_HMM;
+	pvt = kzalloc(sizeof(*pvt), GFP_ATOMIC);
+	if (!pvt)
+		goto out_unlock;
+	pvt->rmap = rmap;
+	pvt->gpa = gpa;
+	pvt->lpid = lpid;
+	hmm_devmem_page_set_drvdata(dpage, (unsigned long)pvt);
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+
+	get_page(dpage);
+	return dpage;
+
+out_unlock:
+	unlock_page(dpage);
+out_clear:
+	bitmap_clear(kvmppc_hmm.pfn_bitmap,
+		     hmm_pfn - kvmppc_hmm.devmem->pfn_first, 1);
+out:
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+	return NULL;
+}
+
+/*
+ * Release the HMM PFN back to the pool
+ *
+ * Called when secure page becomes a normal page during UV_PAGE_OUT.
+ */
+static void kvmppc_hmm_put_page(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned long flags;
+	struct kvmppc_hmm_page_pvt *pvt;
+
+	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
+	pvt = (struct kvmppc_hmm_page_pvt *)hmm_devmem_page_get_drvdata(page);
+	hmm_devmem_page_set_drvdata(page, 0);
+
+	bitmap_clear(kvmppc_hmm.pfn_bitmap,
+		     pfn - kvmppc_hmm.devmem->pfn_first, 1);
+	*(pvt->rmap) = 0;
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+	kfree(pvt);
+}
+
+/*
+ * migrate_vma() callback to move page from normal memory to secure memory.
+ *
+ * We don't capture the return value of uv_page_in() here because when
+ * UV asks for a page and then fails to copy it over, we don't care.
+ */
+static void
+kvmppc_hmm_migrate_alloc_and_copy(struct vm_area_struct *vma,
+				  const unsigned long *src_pfn,
+				  unsigned long *dst_pfn,
+				  unsigned long start,
+				  unsigned long end,
+				  void *private)
+{
+	struct kvmppc_hmm_migrate_args *args = private;
+	struct page *spage = migrate_pfn_to_page(*src_pfn);
+	unsigned long pfn = *src_pfn >> MIGRATE_PFN_SHIFT;
+	struct page *dpage;
+
+	*dst_pfn = 0;
+	if (!(*src_pfn & MIGRATE_PFN_MIGRATE))
+		return;
+
+	dpage = kvmppc_hmm_get_page(args->rmap, args->gpa, args->lpid);
+	if (!dpage)
+		return;
+
+	if (spage)
+		uv_page_in(args->lpid, pfn << args->page_shift,
+			   args->gpa, 0, args->page_shift);
+
+	*dst_pfn = migrate_pfn(page_to_pfn(dpage)) |
+		    MIGRATE_PFN_DEVICE | MIGRATE_PFN_LOCKED;
+}
+
+/*
+ * This migrate_vma() callback is typically used to updated device
+ * page tables after successful migration. We have nothing to do here.
+ *
+ * Also as we don't care if UV successfully copied over the page in
+ * kvmppc_hmm_migrate_alloc_and_copy(), we don't bother to check
+ * dst_pfn for any errors here.
+ */
+static void
+kvmppc_hmm_migrate_finalize_and_map(struct vm_area_struct *vma,
+				    const unsigned long *src_pfn,
+				    const unsigned long *dst_pfn,
+				    unsigned long start,
+				    unsigned long end,
+				    void *private)
+{
+}
+
+static const struct migrate_vma_ops kvmppc_hmm_migrate_ops = {
+	.alloc_and_copy = kvmppc_hmm_migrate_alloc_and_copy,
+	.finalize_and_map = kvmppc_hmm_migrate_finalize_and_map,
+};
+
+/*
+ * Move page from normal memory to secure memory.
+ */
+unsigned long
+kvmppc_h_svm_page_in(struct kvm *kvm, unsigned long gpa,
+		     unsigned long flags, unsigned long page_shift)
+{
+	unsigned long addr, end;
+	unsigned long src_pfn, dst_pfn;
+	struct kvmppc_hmm_migrate_args args;
+	struct mm_struct *mm = get_task_mm(current);
+	struct vm_area_struct *vma;
+	int srcu_idx;
+	unsigned long gfn = gpa >> page_shift;
+	struct kvm_memory_slot *slot;
+	unsigned long *rmap;
+	int ret = H_SUCCESS;
+
+	if (page_shift != PAGE_SHIFT)
+		return H_P3;
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+	slot = gfn_to_memslot(kvm, gfn);
+	rmap = &slot->arch.rmap[gfn - slot->base_gfn];
+	addr = gfn_to_hva(kvm, gpa >> page_shift);
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	if (kvm_is_error_hva(addr))
+		return H_PARAMETER;
+
+	end = addr + (1UL << page_shift);
+
+	if (flags)
+		return H_P2;
+
+	args.rmap = rmap;
+	args.lpid = kvm->arch.lpid;
+	args.gpa = gpa;
+	args.page_shift = page_shift;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma_intersection(mm, addr, end);
+	if (!vma || vma->vm_start > addr || vma->vm_end < end) {
+		ret = H_PARAMETER;
+		goto out;
+	}
+	ret = migrate_vma(&kvmppc_hmm_migrate_ops, vma, addr, end,
+			  &src_pfn, &dst_pfn, &args);
+	if (ret < 0)
+		ret = H_PARAMETER;
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+static void
+kvmppc_hmm_fault_migrate_alloc_and_copy(struct vm_area_struct *vma,
+					const unsigned long *src_pfn,
+					unsigned long *dst_pfn,
+					unsigned long start,
+					unsigned long end,
+					void *private)
+{
+	struct page *dpage, *spage;
+	struct kvmppc_hmm_page_pvt *pvt;
+	unsigned long pfn;
+	int ret = U_SUCCESS;
+
+	*dst_pfn = MIGRATE_PFN_ERROR;
+	spage = migrate_pfn_to_page(*src_pfn);
+	if (!spage || !(*src_pfn & MIGRATE_PFN_MIGRATE))
+		return;
+	if (!is_zone_device_page(spage))
+		return;
+	dpage = hmm_vma_alloc_locked_page(vma, start);
+	if (!dpage)
+		return;
+	pvt = (struct kvmppc_hmm_page_pvt *)
+	       hmm_devmem_page_get_drvdata(spage);
+
+	pfn = page_to_pfn(dpage);
+	ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
+			  pvt->gpa, 0, PAGE_SHIFT);
+	if (ret == U_SUCCESS)
+		*dst_pfn = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
+}
+
+/*
+ * This migrate_vma() callback is typically used to updated device
+ * page tables after successful migration. We have nothing to do here.
+ */
+static void
+kvmppc_hmm_fault_migrate_finalize_and_map(struct vm_area_struct *vma,
+					  const unsigned long *src_pfn,
+					  const unsigned long *dst_pfn,
+					  unsigned long start,
+					  unsigned long end,
+					  void *private)
+{
+}
+
+static const struct migrate_vma_ops kvmppc_hmm_fault_migrate_ops = {
+	.alloc_and_copy = kvmppc_hmm_fault_migrate_alloc_and_copy,
+	.finalize_and_map = kvmppc_hmm_fault_migrate_finalize_and_map,
+};
+
+/*
+ * Fault handler callback when HV touches any page that has been
+ * moved to secure memory, we ask UV to give back the page by
+ * issuing a UV_PAGE_OUT uvcall.
+ */
+static int kvmppc_hmm_devmem_fault(struct hmm_devmem *devmem,
+				   struct vm_area_struct *vma,
+				   unsigned long addr,
+				   const struct page *page,
+				   unsigned int flags,
+				   pmd_t *pmdp)
+{
+	unsigned long end = addr + PAGE_SIZE;
+	unsigned long src_pfn, dst_pfn = 0;
+
+	if (migrate_vma(&kvmppc_hmm_fault_migrate_ops, vma, addr, end,
+			&src_pfn, &dst_pfn, NULL))
+		return VM_FAULT_SIGBUS;
+	if (dst_pfn == MIGRATE_PFN_ERROR)
+		return VM_FAULT_SIGBUS;
+	return 0;
+}
+
+static void kvmppc_hmm_devmem_free(struct hmm_devmem *devmem,
+				   struct page *page)
+{
+	kvmppc_hmm_put_page(page);
+}
+
+static const struct hmm_devmem_ops kvmppc_hmm_devmem_ops = {
+	.free = kvmppc_hmm_devmem_free,
+	.fault = kvmppc_hmm_devmem_fault,
+};
+
+/*
+ * Move page from secure memory to normal memory.
+ */
+unsigned long
+kvmppc_h_svm_page_out(struct kvm *kvm, unsigned long gpa,
+		      unsigned long flags, unsigned long page_shift)
+{
+	unsigned long addr, end;
+	struct mm_struct *mm = get_task_mm(current);
+	struct vm_area_struct *vma;
+	unsigned long src_pfn, dst_pfn = 0;
+	int srcu_idx;
+	int ret = H_SUCCESS;
+
+	if (page_shift != PAGE_SHIFT)
+		return H_P3;
+
+	if (flags)
+		return H_P2;
+
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+	addr = gfn_to_hva(kvm, gpa >> page_shift);
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+	if (kvm_is_error_hva(addr))
+		return H_PARAMETER;
+
+	end = addr + (1UL << page_shift);
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma_intersection(mm, addr, end);
+	if (!vma || vma->vm_start > addr || vma->vm_end < end) {
+		ret = H_PARAMETER;
+		goto out;
+	}
+	ret = migrate_vma(&kvmppc_hmm_fault_migrate_ops, vma, addr, end,
+			  &src_pfn, &dst_pfn, NULL);
+	if (ret < 0)
+		ret = H_PARAMETER;
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+}
+
+/*
+ * TODO: Number of secure pages and the page size order would probably come
+ * via DT or via some uvcall. Return 8G for now.
+ */
+static unsigned long kvmppc_get_secmem_size(void)
+{
+	return (1UL << 33);
+}
+
+static int kvmppc_hmm_pages_init(void)
+{
+	unsigned long nr_pfns = kvmppc_hmm.devmem->pfn_last -
+				kvmppc_hmm.devmem->pfn_first;
+
+	kvmppc_hmm.pfn_bitmap = kcalloc(BITS_TO_LONGS(nr_pfns),
+					 sizeof(unsigned long), GFP_KERNEL);
+	if (!kvmppc_hmm.pfn_bitmap)
+		return -ENOMEM;
+
+	spin_lock_init(&kvmppc_hmm_lock);
+
+	return 0;
+}
+
+int kvmppc_hmm_init(void)
+{
+	int ret = 0;
+	unsigned long size = kvmppc_get_secmem_size();
+
+	kvmppc_hmm.device = hmm_device_new(NULL);
+	if (IS_ERR(kvmppc_hmm.device)) {
+		ret = PTR_ERR(kvmppc_hmm.device);
+		goto out;
+	}
+
+	kvmppc_hmm.devmem = hmm_devmem_add(&kvmppc_hmm_devmem_ops,
+					   &kvmppc_hmm.device->device, size);
+	if (IS_ERR(kvmppc_hmm.devmem)) {
+		ret = PTR_ERR(kvmppc_hmm.devmem);
+		goto out_device;
+	}
+	ret = kvmppc_hmm_pages_init();
+	if (ret < 0)
+		goto out_devmem;
+
+	return ret;
+
+out_devmem:
+	hmm_devmem_remove(kvmppc_hmm.devmem);
+out_device:
+	hmm_device_put(kvmppc_hmm.device);
+out:
+	return ret;
+}
+
+void kvmppc_hmm_free(void)
+{
+	kfree(kvmppc_hmm.pfn_bitmap);
+	hmm_devmem_remove(kvmppc_hmm.devmem);
+	hmm_device_put(kvmppc_hmm.device);
+}
-- 
2.17.1

