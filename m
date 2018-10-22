Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A798BC67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 05:24:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5D62083A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 05:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5D62083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dlLv6v3fzDrpn
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 16:24:23 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dlDk05glzDrhp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 16:19:01 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9M59klE131344
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 01:19:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n976tsxw0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 01:18:59 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.ibm.com>;
 Mon, 22 Oct 2018 06:18:57 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 06:18:54 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9M5Irhi1769772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 05:18:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06E28AE04D;
 Mon, 22 Oct 2018 05:18:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64B13AE045;
 Mon, 22 Oct 2018 05:18:51 +0000 (GMT)
Received: from bharata.in.ibm.com (unknown [9.124.35.126])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 05:18:51 +0000 (GMT)
From: Bharata B Rao <bharata@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v1 2/4] kvmppc: Add support for shared pages in HMM driver
Date: Mon, 22 Oct 2018 10:48:35 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022051837.1165-1-bharata@linux.ibm.com>
References: <20181022051837.1165-1-bharata@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18102205-0008-0000-0000-0000028318EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102205-0009-0000-0000-000021EC95F0
Message-Id: <20181022051837.1165-3-bharata@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-21_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=544 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220049
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

A secure guest will share some of its pages with hypervisor (Eg. virtio
bounce buffers etc). Support shared pages in HMM driver.

Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_hmm.c | 69 ++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_hmm.c b/arch/powerpc/kvm/book3s_hv_hmm.c
index a2ee3163a312..09b8e19b7605 100644
--- a/arch/powerpc/kvm/book3s_hv_hmm.c
+++ b/arch/powerpc/kvm/book3s_hv_hmm.c
@@ -50,6 +50,7 @@ struct kvmppc_hmm_page_pvt {
 	struct hlist_head *hmm_hash;
 	unsigned int lpid;
 	unsigned long gpa;
+	bool skip_page_out;
 };
 
 struct kvmppc_hmm_migrate_args {
@@ -278,6 +279,65 @@ static unsigned long kvmppc_gpa_to_hva(struct kvm *kvm, unsigned long gpa,
 	return hva;
 }
 
+/*
+ * Shares the page with HV, thus making it a normal page.
+ *
+ * - If the page is already secure, then provision a new page and share
+ * - If the page is a normal page, share the existing page
+ *
+ * In the former case, uses the HMM fault handler to release the HMM page.
+ */
+static unsigned long
+kvmppc_share_page(struct kvm *kvm, unsigned long gpa,
+		  unsigned long addr, unsigned long page_shift)
+{
+
+	int ret;
+	struct hlist_head *list, *hmm_hash;
+	unsigned int lpid = kvm->arch.lpid;
+	unsigned long flags;
+	struct kvmppc_hmm_pfn_entry *p;
+	struct page *hmm_page, *page;
+	struct kvmppc_hmm_page_pvt *pvt;
+	unsigned long pfn;
+
+	/*
+	 * First check if the requested page has already been given to
+	 * UV as a secure page. If so, ensure that we don't issue a
+	 * UV_PAGE_OUT but instead directly send the page
+	 */
+	spin_lock_irqsave(&kvmppc_hmm_lock, flags);
+	hmm_hash = kvm->arch.hmm_hash;
+	list = &hmm_hash[kvmppc_hmm_pfn_hash_fn(gpa)];
+	hlist_for_each_entry(p, list, hlist) {
+		if (p->addr == gpa) {
+			hmm_page = pfn_to_page(p->hmm_pfn);
+			get_page(hmm_page); /* TODO: Necessary ? */
+			pvt = (struct kvmppc_hmm_page_pvt *)
+				hmm_devmem_page_get_drvdata(hmm_page);
+			pvt->skip_page_out = true;
+			put_page(hmm_page);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&kvmppc_hmm_lock, flags);
+
+	ret = get_user_pages_fast(addr, 1, 0, &page);
+	if (ret != 1)
+		return H_PARAMETER;
+
+	pfn = page_to_pfn(page);
+	if (is_zero_pfn(pfn)) {
+		put_page(page);
+		return H_SUCCESS;
+	}
+
+	ret = uv_page_in(lpid, pfn << page_shift, gpa, 0, page_shift);
+	put_page(page);
+
+	return (ret == U_SUCCESS) ? H_SUCCESS : H_PARAMETER;
+}
+
 /*
  * Move page from normal memory to secure memory.
  */
@@ -300,8 +360,8 @@ kvmppc_h_svm_page_in(struct kvm *kvm, unsigned long gpa,
 		return H_PARAMETER;
 	end = addr + (1UL << page_shift);
 
-	if (flags)
-		return H_P2;
+	if (flags & H_PAGE_IN_SHARED)
+		return kvmppc_share_page(kvm, gpa, addr, page_shift);
 
 	args.hmm_hash = kvm->arch.hmm_hash;
 	args.lpid = kvm->arch.lpid;
@@ -349,8 +409,9 @@ kvmppc_hmm_fault_migrate_alloc_and_copy(struct vm_area_struct *vma,
 	       hmm_devmem_page_get_drvdata(spage);
 
 	pfn = page_to_pfn(dpage);
-	ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
-			  pvt->gpa, 0, PAGE_SHIFT);
+	if (!pvt->skip_page_out)
+		ret = uv_page_out(pvt->lpid, pfn << PAGE_SHIFT,
+				  pvt->gpa, 0, PAGE_SHIFT);
 	if (ret == U_SUCCESS)
 		*dst_pfn = migrate_pfn(pfn) | MIGRATE_PFN_LOCKED;
 }
-- 
2.17.1

