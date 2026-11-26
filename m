Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAEB606A326
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HfCENpZI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZqyt60yMz2xns;
	Thu, 26 Nov 2026 19:51:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795683078;
	cv=none; b=C1X8lLyRAuHJSiddzcA0WO9Lj/JwieVtEGH0JZJgUBhBSFMA/UJ6At7iQjOA1pjMziQ05d3iOs1RiEXqlGyVOHABuBEBfQGOb+8Q3UWPnOKcsGoubYXY45U0E9yYUz/wLAmQRkE/I/nHv6bKqSLN10F0wNps78nKuQJ1VSxyn0AM+46aOreZ6VTHTUeC2YZISQPKjnqnkL657PNyfPcH1PxAZMYj8rHJR9NQvdIVjFeP8bZ4kOpDcbPomuJGuAxEWalatwaBbhhI2Oda8maNy3nN6im4RA4+Gft7T5ZxKWhiibjrfErUu2mpiCS92CbKrGD6YwY4w7mEHIGF6M4tCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795683078; c=relaxed/relaxed;
	bh=Ss6bkxLzwbRqu0owlG29fZSsXYRPf2Vp7DTmPazcx28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KC2Yh46VsPE7rTOvke51R1XRndExHw5FLwuPzcKr71fYuNlTYCo7olTUVqHYgYMy0Fbc762H2w1wjDjbVdtQsJTJLl22jUpoxGyA2bPISToERN78maBgMw+R2TZbvaqFqySbg0I90zyIaZs1sJr10rBvMB2QT/vK4jUeGSZASQ+u6Utkqb8kvDKQN2E4tgjnZIv8sULMxRtRrcnN8ObCpCVsnuNvqpTOOjwvIAmqwPMq2eAHUGkpcnrRd/yNn0px4eVAjs/clszIBMHcrZ020pigv40treSuuAmWI66k9uSGvb6gUGw8VS9IygHrczZK4chTnXb7M1xqBb9HtO1wYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HfCENpZI; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HfCENpZI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZqyt0cg1z2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:51:17 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YcF62430885;
	Thu, 26 Nov 2026 08:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ss6bkxLzwbRqu0owl
	G29fZSsXYRPf2Vp7DTmPazcx28=; b=HfCENpZI0E5RYbJwuG0vjfaYplIMQRcpI
	G5oTfMfiH6pnPZ7AZmGQoYmviJTnvxghdOHnond5+BiZjbvE1GH9TJ68T2O2019M
	9aqS4FmI9/JQGy3IQ0FB1RHuZZQPmSEtxoKnH9f9cOQC79lYvneNf6CbbCtWbWRr
	KqEFsOaKGZ1xb7CTlQrJY9gKfi/to6eKT0EdNgZs26qiLyPzCr3UMVHsh8eOPlPO
	B3yRkCjz6UzC3HK7G0zaW24iNAOmzU7r2zGJJE0wXOUkybYQ51J20RzC1jBkTmJv
	OO/j70apONGM1l05brH/Tmfk86zpgy/lZHZDDggUBKPXnrjzMVaUg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4qrck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JHX61263834;
	Thu, 26 Nov 2026 08:50:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx430a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8ohgM48300500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:50:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72C1E20043;
	Thu, 26 Nov 2026 08:50:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B3E82004B;
	Thu, 26 Nov 2026 08:50:41 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:50:40 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Narayana Murty N <nnmlinux@linux.ibm.com>,
        linux-kernel@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v2 2/3] KVM: PPC: Book3S: Synchronize TCE hcalls with IOMMU table detach
Date: Thu, 26 Nov 2026 14:20:10 +0530
Message-ID: <20261126085008.34532-5-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126085008.34532-4-nnmlinux@linux.ibm.com>
References: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
 <20261126085008.34532-4-nnmlinux@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX+rYFOB8/WiIJ
 KgabvMC+26pp6xVoEhttjkrxEMcSeosnQfNujEEyWW2w6LQkgOsSHlH5em+0xhADDtnWsTzvCdJ
 r3dOwo0y/xzLdbT2AmjSWdM/ejr1HGc=
X-Proofpoint-GUID: BhLWOF8tqZoKyiGkaPuN45ORyN02iwpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX9jotfKtnLKds
 zP3UMXIutLoiF0DCfk3WKsRsB14r6hX+0n13fwctCdG2Y74RbrW+AhkJ9pYMal2i742eXqtjjvq
 kR2JmfNw6sBkqz1GCidnc4DqAbzedPpuuqjt4H3Yoiaq1aLVn6VdVWUK3ngmzkwPOlkTuZmIP2a
 a2pGDH5wp+j/HCCcJ6RPxuujggzue0yYaqJTmn4PxaVfSnyzwyCVfYtL+/fYs9cf0F/SEdfk/WU
 zTjiY/3Vb4m6qrbIm/tnIqhM0B2NQu6CcRH1FvxEUKkKUbF3t+/atDUObwksMWfka1b7/hrMoHc
 PU3UA3ERT8QLeeD9TRjTlz67qKDQvmM0SCGp6QGBcuRJ5HWIPnWq433dNrl2zWjbuQjofJ3oMmA
 8szYz/TyuFvLYDONsPzvjPuc8IFnb9YwckEQ/vAtjDg2tDlVBlZaXFf1H9Z/Hdm52WhMNhKVFsV
 7vpceF65/f9G6hk0Vdg==
X-Proofpoint-ORIG-GUID: 9ZpB2h7AVPfkOlb9i5OzjrLv5u-sH5BK
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b07f2e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GmGZdm6FdJCgxKN2JD4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260033
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TCE hypercalls traverse stt->iommu_tables while VFIO detach may
remove attachments and return hardware window ownership before
in-flight TCE updates complete.

Use the existing kvm->srcu read-side protection for IOMMU table
traversal and synchronize SRCU readers during detach.

This ensures that TCE hardware updates complete before the
detached window is returned to VFIO.

The following patch addresses safe reclamation of child entries
accessed by these SRCU readers.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index e9370b0e9afe..afa7ce57f5ae 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -112,6 +112,13 @@ void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
 		cond_resched_rcu();
 	}
 	rcu_read_unlock();
+
+	/*
+	 * Wait for hcalls that may still be programming the detached
+	 * window. They run under kvm->srcu, so once this returns, no
+	 * TCE update can touch the hardware after ownership is released.
+	 */
+	synchronize_srcu(&kvm->srcu);
 }
 
 long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
@@ -634,7 +641,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	entry = ioba >> stt->page_shift;
 
-	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+	list_for_each_entry_srcu(stit, &stt->iommu_tables, next,
+				 srcu_read_lock_held(&vcpu->kvm->srcu)) {
 		if (dir == DMA_NONE)
 			ret = kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
 					stit->tbl, entry);
@@ -738,7 +746,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 			goto put_exit;
 		}
 
-		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		list_for_each_entry_srcu(stit, &stt->iommu_tables, next,
+					 srcu_read_lock_held(&vcpu->kvm->srcu)) {
 			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt,
 					stit->tbl, entry + i, ua,
 					iommu_tce_direction(tce));
@@ -788,7 +797,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 		goto put_exit;
 	}
 
-	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+	list_for_each_entry_srcu(stit, &stt->iommu_tables, next,
+				 srcu_read_lock_held(&vcpu->kvm->srcu)) {
 		unsigned long entry = ioba >> stt->page_shift;
 
 		for (i = 0; i < npages; ++i) {
-- 
2.54.0


