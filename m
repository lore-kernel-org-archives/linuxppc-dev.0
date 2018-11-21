Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:37:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFB9C21104
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB9C21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430BCz6nHzzF3DT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 16:37:19 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 430B1w4D3ZzF3cY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 16:28:36 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAL5SLfJ092953
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:28:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nw034a9fs-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 00:28:34 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Wed, 21 Nov 2018 05:28:32 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 21 Nov 2018 05:28:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAL5SRG65964158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 21 Nov 2018 05:28:27 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA0AE4C04A;
 Wed, 21 Nov 2018 05:28:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 634944C044;
 Wed, 21 Nov 2018 05:28:25 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.234])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 21 Nov 2018 05:28:25 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 4/4] kvmppc: Handle memory plug/unplug to secure VM
Date: Wed, 21 Nov 2018 10:58:11 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121052811.4819-1-bharata@linux.ibm.com>
References: <20181121052811.4819-1-bharata@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112105-4275-0000-0000-000002E44274
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112105-4276-0000-0000-000037F16C15
Message-Id: <20181121052811.4819-5-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-21_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
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

Register the new memslot with UV during plug and unregister
the memslot during unplug.

This needs addition of kvm_mr_change argument to
kvm_ops->commit_memory_region()

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h   |  6 ++++--
 arch/powerpc/include/asm/ucall-api.h |  5 +++++
 arch/powerpc/kvm/book3s.c            |  5 +++--
 arch/powerpc/kvm/book3s_hv.c         | 22 +++++++++++++++++++++-
 arch/powerpc/kvm/book3s_pr.c         |  3 ++-
 arch/powerpc/kvm/powerpc.c           |  2 +-
 6 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 5f4b6a73789f..1ac920f2e18b 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -224,7 +224,8 @@ extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 extern void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new);
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change);
 extern int kvm_vm_ioctl_get_smmu_info(struct kvm *kvm,
 				      struct kvm_ppc_smmu_info *info);
 extern void kvmppc_core_flush_memslot(struct kvm *kvm,
@@ -294,7 +295,8 @@ struct kvmppc_ops {
 	void (*commit_memory_region)(struct kvm *kvm,
 				     const struct kvm_userspace_memory_region *mem,
 				     const struct kvm_memory_slot *old,
-				     const struct kvm_memory_slot *new);
+				     const struct kvm_memory_slot *new,
+				     enum kvm_mr_change change);
 	int (*unmap_hva_range)(struct kvm *kvm, unsigned long start,
 			   unsigned long end);
 	int (*age_hva)(struct kvm *kvm, unsigned long start, unsigned long end);
diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
index 347637995b1b..02c9be311a4f 100644
--- a/arch/powerpc/include/asm/ucall-api.h
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -25,4 +25,9 @@ static inline int uv_register_mem_slot(u64 lpid, u64 start_gpa, u64 size,
 	return 0;
 }
 
+static inline int uv_unregister_mem_slot(u64 lpid, u64 dw0)
+{
+	return 0;
+}
+
 #endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index fd9893bc7aa1..a35fb4099094 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -830,9 +830,10 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 void kvmppc_core_commit_memory_region(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
-	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new);
+	kvm->arch.kvm_ops->commit_memory_region(kvm, mem, old, new, change);
 }
 
 int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d7aa85330016..351ce259d8bb 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -75,6 +75,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/kvm_host.h>
+#include <asm/ucall-api.h>
 
 #include "book3s.h"
 
@@ -4392,7 +4393,8 @@ static int kvmppc_core_prepare_memory_region_hv(struct kvm *kvm,
 static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
 	unsigned long npages = mem->memory_size >> PAGE_SHIFT;
 
@@ -4404,6 +4406,24 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 	 */
 	if (npages)
 		atomic64_inc(&kvm->arch.mmio_update);
+	/*
+	 * If UV hasn't yet called H_SVM_INIT_START, don't register memslots.
+	 */
+	if (!kvm->arch.secure)
+		return;
+
+	/*
+	 * TODO: Handle KVM_MR_MOVE
+	 */
+	if (change == KVM_MR_CREATE) {
+		uv_register_mem_slot(kvm->arch.lpid,
+					   new->base_gfn << PAGE_SHIFT,
+					   new->npages * PAGE_SIZE,
+					   0,
+					   new->id);
+	} else if (change == KVM_MR_DELETE) {
+		uv_unregister_mem_slot(kvm->arch.lpid, old->id);
+	}
 }
 
 /*
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 4efd65d9e828..3aeb17b88de7 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1913,7 +1913,8 @@ static int kvmppc_core_prepare_memory_region_pr(struct kvm *kvm,
 static void kvmppc_core_commit_memory_region_pr(struct kvm *kvm,
 				const struct kvm_userspace_memory_region *mem,
 				const struct kvm_memory_slot *old,
-				const struct kvm_memory_slot *new)
+				const struct kvm_memory_slot *new,
+				enum kvm_mr_change change)
 {
 	return;
 }
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2869a299c4ed..6a7a6a101efd 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -696,7 +696,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
-	kvmppc_core_commit_memory_region(kvm, mem, old, new);
+	kvmppc_core_commit_memory_region(kvm, mem, old, new, change);
 }
 
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-- 
2.17.1

