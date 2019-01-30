Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A28C282D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:15:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD6E2175B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 06:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD6E2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qClc0d9vzDqTC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 17:15:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qCZx2tBzzDqSH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 17:07:53 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0U64NSk055443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:07:51 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qb1k7hpbm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 01:07:51 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Wed, 30 Jan 2019 06:07:49 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 30 Jan 2019 06:07:46 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0U67juv42467504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Jan 2019 06:07:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0C4852080;
 Wed, 30 Jan 2019 06:07:44 +0000 (GMT)
Received: from bharata.ibmuc.com (unknown [9.199.36.73])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2EDAC5204F;
 Wed, 30 Jan 2019 06:07:43 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 4/4] kvmppc: Handle memory plug/unplug to secure VM
Date: Wed, 30 Jan 2019 11:37:26 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130060726.29958-1-bharata@linux.ibm.com>
References: <20190130060726.29958-1-bharata@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19013006-0028-0000-0000-000003409DC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19013006-0029-0000-0000-000023FDA3B1
Message-Id: <20190130060726.29958-5-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-30_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=807 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901300046
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
 jglisse@redhat.com, aneesh.kumar@linux.vnet.ibm.com, paulus@au1.ibm.com,
 sukadev@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Register the new memslot with UV during plug and unregister
the memslot during unplug.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/include/asm/ucall-api.h        |  7 +++++++
 arch/powerpc/include/uapi/asm/uapi_uvcall.h |  1 +
 arch/powerpc/kvm/book3s_hv.c                | 19 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/powerpc/include/asm/ucall-api.h b/arch/powerpc/include/asm/ucall-api.h
index d266670229cb..cbb8bb38eb8b 100644
--- a/arch/powerpc/include/asm/ucall-api.h
+++ b/arch/powerpc/include/asm/ucall-api.h
@@ -82,5 +82,12 @@ static inline int uv_register_mem_slot(u64 lpid, u64 start_gpa, u64 size,
 	return plpar_ucall(UV_REGISTER_MEM_SLOT, retbuf, lpid, start_gpa,
 			   size, flags, slotid);
 }
+
+static inline int uv_unregister_mem_slot(u64 lpid, u64 slotid)
+{
+	unsigned long retbuf[PLPAR_UCALL_BUFSIZE];
+
+	return plpar_ucall(UV_UNREGISTER_MEM_SLOT, retbuf, lpid, slotid);
+}
 #endif	/* __ASSEMBLY__ */
 #endif	/* _ASM_POWERPC_UCALL_API_H */
diff --git a/arch/powerpc/include/uapi/asm/uapi_uvcall.h b/arch/powerpc/include/uapi/asm/uapi_uvcall.h
index 79a11a6ee436..60e44c7b58c4 100644
--- a/arch/powerpc/include/uapi/asm/uapi_uvcall.h
+++ b/arch/powerpc/include/uapi/asm/uapi_uvcall.h
@@ -13,6 +13,7 @@
 #define UV_RESTRICTED_SPR_READ 0xf10C
 #define UV_RETURN	0xf11C
 #define UV_REGISTER_MEM_SLOT    0xF120
+#define UV_UNREGISTER_MEM_SLOT    0xF124
 #define UV_PAGE_IN	0xF128
 #define UV_PAGE_OUT	0xF12C
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1dfb42ac9626..61e36c4516d5 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -76,6 +76,7 @@
 #include <asm/xive.h>
 #include <asm/kvm_host.h>
 #include <asm/kvm_book3s_hmm.h>
+#include <asm/ucall-api.h>
 
 #include "book3s.h"
 
@@ -4433,6 +4434,24 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 	if (change == KVM_MR_FLAGS_ONLY && kvm_is_radix(kvm) &&
 	    ((new->flags ^ old->flags) & KVM_MEM_LOG_DIRTY_PAGES))
 		kvmppc_radix_flush_memslot(kvm, old);
+	/*
+	 * If UV hasn't yet called H_SVM_INIT_START, don't register memslots.
+	 */
+	if (!kvm->arch.secure_guest)
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
-- 
2.17.1

