Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA09C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 09:29:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30A421BE5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 09:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30A421BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nc905k3lzDqGM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 19:29:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=us.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=linuxram@us.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nbxX0DRbzDrDl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 19:19:59 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05I91n1l096509; Thu, 18 Jun 2020 05:19:49 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31r589gkj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 05:19:49 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05I9BNKM026610;
 Thu, 18 Jun 2020 09:19:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by ppma01fra.de.ibm.com with ESMTP id 31qyx1g7bb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2020 09:19:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05I9JiaN43843624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jun 2020 09:19:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D497842047;
 Thu, 18 Jun 2020 09:19:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A95F42049;
 Thu, 18 Jun 2020 09:19:41 +0000 (GMT)
Received: from oc0525413822.ibm.com (unknown [9.211.71.42])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jun 2020 09:19:40 +0000 (GMT)
From: Ram Pai <linuxram@us.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/4] KVM: PPC: Book3S HV: migrate hot plugged memory
Date: Thu, 18 Jun 2020 02:19:05 -0700
Message-Id: <1592471945-24786-5-git-send-email-linuxram@us.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592471945-24786-1-git-send-email-linuxram@us.ibm.com>
References: <1592471945-24786-1-git-send-email-linuxram@us.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-18_04:2020-06-17,
 2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 cotscore=-2147483648 mlxscore=0 clxscore=1015
 suspectscore=2 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180065
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
Cc: ldufour@linux.ibm.com, linuxram@us.ibm.com, cclaudio@linux.ibm.com,
 bharata@linux.ibm.com, sathnaga@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com,
 sukadev@linux.vnet.ibm.com, bauerman@linux.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Laurent Dufour <ldufour@linux.ibm.com>

When a memory slot is hot plugged to a SVM, PFNs associated with the
GFNs in that slot must be migrated to the secure-PFNs, aka device-PFNs.

kvmppc_uv_migrate_mem_slot() is called to accomplish this. UV_PAGE_IN
ucall is skipped, since the ultravisor does not trust the content of
those pages and hence ignores it.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
	[resolved conflicts, and modified the commit log]
Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_book3s_uvmem.h |  2 ++
 arch/powerpc/kvm/book3s_hv.c                | 10 ++++++----
 arch/powerpc/kvm/book3s_hv_uvmem.c          |  2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_uvmem.h b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
index f0c5708..05ae789 100644
--- a/arch/powerpc/include/asm/kvm_book3s_uvmem.h
+++ b/arch/powerpc/include/asm/kvm_book3s_uvmem.h
@@ -23,6 +23,8 @@ unsigned long kvmppc_h_svm_page_out(struct kvm *kvm,
 void kvmppc_uvmem_drop_pages(const struct kvm_memory_slot *free,
 			     struct kvm *kvm, bool skip_page_out,
 			     bool purge_gfn);
+int kvmppc_uv_migrate_mem_slot(struct kvm *kvm,
+				const struct kvm_memory_slot *memslot);
 #else
 static inline int kvmppc_uvmem_init(void)
 {
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6cf80e5..bf7324d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4531,10 +4531,12 @@ static void kvmppc_core_commit_memory_region_hv(struct kvm *kvm,
 	case KVM_MR_CREATE:
 		if (kvmppc_uvmem_slot_init(kvm, new))
 			return;
-		uv_register_mem_slot(kvm->arch.lpid,
-				     new->base_gfn << PAGE_SHIFT,
-				     new->npages * PAGE_SIZE,
-				     0, new->id);
+		if (uv_register_mem_slot(kvm->arch.lpid,
+					 new->base_gfn << PAGE_SHIFT,
+					 new->npages * PAGE_SIZE,
+					 0, new->id))
+			return;
+		kvmppc_uv_migrate_mem_slot(kvm, new);
 		break;
 	case KVM_MR_DELETE:
 		uv_unregister_mem_slot(kvm->arch.lpid, old->id);
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 78f8580..4d8f5bc 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -451,7 +451,7 @@ static int kvmppc_svm_migrate_page(struct vm_area_struct *vma,
 	return ret;
 }
 
-static int kvmppc_uv_migrate_mem_slot(struct kvm *kvm,
+int kvmppc_uv_migrate_mem_slot(struct kvm *kvm,
 		const struct kvm_memory_slot *memslot)
 {
 	unsigned long gfn = memslot->base_gfn;
-- 
1.8.3.1

