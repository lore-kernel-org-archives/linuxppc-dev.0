Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03017606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dI+C5NBW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZqyY4k72z2yDs;
	Thu, 26 Nov 2026 19:51:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795683061;
	cv=none; b=XjlWQJw4e4ra2JpzQ4B3VjctmtM6son6emzgpp8kwrTz77mAVxLZYG1RTOMsnfxRMCDZnthq1lAFQR4NXIqW4c37rXYWawOpjAX1CfyUjH79O8yI9/BL3HoiIBGg3wkMqrOrwGyqVQ2ja1Dkyl4feYIDTuXJ9Gr74xsGYKWR/2Aza4LvokMM245VDmm1sNyzRojHQR8KHHqCmI/FHpQNlkrLZOcRCvhjWJw7ueDGXEoAOLP076mHOAsz9VftXXC9WYRKmtFkvkkn6mgzzvfu4ghCHivE9C4HbODdQQjhcqx3wpFyl60lg3MLC0+QmeQR1DnN4mS58yW0Jler0HgPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795683061; c=relaxed/relaxed;
	bh=g389o+KT7vrNbAW7fBufTnpZjz6PZDKd5MQe7ojY3cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfi9qo2/y61NwUkP+nxd1uFYxP1R9Xe59MFM6qDn6/zPOSm6iGs5jeDnqA6aj2l4/cnV+12pkZWfmS1gfL4d1AfR4qAdzmgGofTuLUZrY5nALoLAHppjTXd6Nsr2H99nfQ65ivkn5eSUClrCFUPLox4lDrCzNkp/R2tjSvawlJ/Oxw61DdX09mx9xxR2X2NypNLTjjhS6sojya+TqDZ/mU4AZ+c5wKxPY4hqwNo+edeIqgw1X6N+X90qcdTL31ZPVkV1fd4HeufvX6zZWpAEBasy+X+1s3WVq5qeIR30OAo+p2i5pIZCwb5B86FG2EcCaEaHJWD9wgwqEFOvc1NBLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dI+C5NBW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dI+C5NBW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZqyX5lqVz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:51:00 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7YcOL3848620;
	Thu, 26 Nov 2026 08:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=g389o+KT7vrNbAW7f
	BufTnpZjz6PZDKd5MQe7ojY3cA=; b=dI+C5NBW17uDrPS2XXpJBlBLFfNf7t71P
	BW1pJX2TGr2wWe0d9D3KO8fKtPkugRhIp8IXhVWhgPFEFwwk2EvC8szYgkIC9Env
	Xwjq886u4v64FdqM+tL+6LiWj5plbgIkGk6eiwVnRyrXkST+n12MubXHAlsEee4Q
	PYoXPwN+kz50K6f6EEOKfc6tMK0cxYPF8AAxejGeZR/GLqtWRy2qPwOPpjgrSTN+
	Mpq4YNPJlHfNUsycmsUVIrDHQWJlhY4oA3R8bxayWQxiW0WUIm5J+k0Fje79ZWl9
	ICU+HZ3yDppFsGK+kBQJDos3QxAM4diQVRgV7jzRzUMt28OaQv4fw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34faghrm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JKEJ1263893;
	Thu, 26 Nov 2026 08:50:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx42yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8oZ4Q54919656
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:50:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A48320043;
	Thu, 26 Nov 2026 08:50:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD6512004F;
	Thu, 26 Nov 2026 08:50:32 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:50:32 +0000 (GMT)
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
Subject: [PATCH v2 1/3] KVM: PPC: Book3S: Hold a reference to sPAPR TCE tables during hcalls
Date: Thu, 26 Nov 2026 14:20:09 +0530
Message-ID: <20261126085008.34532-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
References: <20261126084351.32375-5-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX//mnzgUN7gmY
 uzyyW1XKyPQ8mDTtqvfJx230p/vce33zu44fk+cPrYPc4ZAIpNnlKjimyICAaGRHGNMYzN3epBQ
 pchUrKS6bavIGo8+dz0Yj/F4Rh+IYA2P3w9lxBsjl2xdRPaUQJAWJZZBGk0Nxxmh7A3v3qGIN1B
 qOYLKIVwJYUxNz3Iza1xok2d38BttM4OCQ5+5ZYdnVxdsQEQYZW+uasmOkJSz+kiw7ELQz8UMLP
 47AdrysaiacgP0eduB/ldoT4kfG7HlAylXHzNzVRrJGQHm36M709GSTyEt/DFw2zEva8UI+K9k1
 aW1vAENk178Qzxy8jraf4pXqXj0+GnBygEEaS/tv/96mAYrOx3+sMjjDNsIYHusJqtsGl2eSbUr
 m2jehwtIncAIpObLbMmYJC/ENw0Qh/2v63LyvFJSn8skZSqAkE2DZ7bt+VBZ4IgAD6Wfb1vb4Dg
 eqQZ+jPsRoS4QDBKWWw==
X-Proofpoint-ORIG-GUID: 7Yf-dikadHKX9swJMRW6NKns8KCMU4pM
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b07f2e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=NjdCC93HCG2rpk-b1XYA:9
X-Proofpoint-GUID: 3O_rfX8ewYkidYH96rjkjqcy6gSeEl_s
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX9+olYQ/FiFvd
 IgB1XBA74YgpALxHkJuU0wrUmG3/Y4vJ473HQ/0jiw19j85yeaSvrhF5p3nk2SXO33AryUFD1Sp
 bQiQw4I2xkixxUyCMaSTf7ekK1KvmIo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611260033
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real
mode handlers") moved TCE hypercalls to preemptible virtual
mode. However, kvmppc_find_table() returns a table pointer without
holding a reference, allowing concurrent fd release to free it
while a hypercall is still using it.

Add a kref to the sPAPR TCE table and acquire it under RCU during
lookup. Release the reference when the hypercall completes.

Use kvm->srcu to synchronize active table accesses with fd release
before dropping the locked-memory accounting.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |   1 +
 arch/powerpc/kvm/book3s_64_vio.c    | 136 ++++++++++++++++++++--------
 2 files changed, 101 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 708a32f89776..13e8c5b12f40 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -198,6 +198,7 @@ struct kvmppc_spapr_tce_table {
 	struct kvm *kvm;
 	u64 liobn;
 	struct rcu_head rcu;
+	struct kref kref;
 	u32 page_shift;
 	u64 offset;		/* in pages */
 	u64 size;		/* window size in pages */
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c5f3f5b29d89..e9370b0e9afe 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -38,9 +38,17 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm *kvm,
 {
 	struct kvmppc_spapr_tce_table *stt;
 
-	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
-		if (stt->liobn == liobn)
+	rcu_read_lock();
+	list_for_each_entry_rcu(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn != liobn)
+			continue;
+
+		if (kref_get_unless_zero(&stt->kref)) {
+			rcu_read_unlock();
 			return stt;
+		}
+	}
+	rcu_read_unlock();
 
 	return NULL;
 }
@@ -205,6 +213,19 @@ static void release_spapr_tce_table(struct rcu_head *head)
 	kfree(stt);
 }
 
+static void kvm_spapr_tce_table_release(struct kref *kref)
+{
+	struct kvmppc_spapr_tce_table *stt = container_of(kref,
+			struct kvmppc_spapr_tce_table, kref);
+
+	call_rcu(&stt->rcu, release_spapr_tce_table);
+}
+
+static void kvmppc_spapr_tce_table_put(struct kvmppc_spapr_tce_table *stt)
+{
+	kref_put(&stt->kref, kvm_spapr_tce_table_release);
+}
+
 static struct page *kvm_spapr_get_tce_page(struct kvmppc_spapr_tce_table *stt,
 		unsigned long sttpage)
 {
@@ -271,12 +292,20 @@ static int kvm_spapr_tce_release(struct inode *inode, struct file *filp)
 		}
 	}
 
+	/*
+	 * The table is already off kvm->arch.spapr_tce_tables, so hcalls
+	 * that start after this point cannot find it. Wait for hcalls that
+	 * already located it, which run under kvm->srcu, before removing the
+	 * accounting for its pages.
+	 */
+	synchronize_srcu(&kvm->srcu);
+
 	account_locked_vm(kvm->mm,
 		kvmppc_stt_pages(kvmppc_tce_pages(stt->size)), false);
 
-	kvm_put_kvm(stt->kvm);
+	kvmppc_spapr_tce_table_put(stt);
 
-	call_rcu(&stt->rcu, release_spapr_tce_table);
+	kvm_put_kvm(kvm);
 
 	return 0;
 }
@@ -314,6 +343,7 @@ int kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 	stt->offset = args->offset;
 	stt->size = args->size;
 	stt->kvm = kvm;
+	kref_init(&stt->kref);
 	mutex_init(&stt->alloc_lock);
 	INIT_LIST_HEAD_RCU(&stt->iommu_tables);
 
@@ -579,25 +609,27 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
-	if (!stt)
+	if (!stt) {
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		return H_TOO_HARD;
+	}
 
 	ret = kvmppc_ioba_validate(stt, ioba, 1);
 	if (ret != H_SUCCESS)
-		return ret;
-
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
+		goto put_exit;
 
 	ret = kvmppc_tce_validate(stt, tce);
 	if (ret != H_SUCCESS)
-		goto unlock_exit;
+		goto put_exit;
 
 	dir = iommu_tce_direction(tce);
 
 	if ((dir != DMA_NONE) && kvmppc_tce_to_ua(vcpu->kvm, tce, &ua)) {
 		ret = H_PARAMETER;
-		goto unlock_exit;
+		goto put_exit;
 	}
 
 	entry = ioba >> stt->page_shift;
@@ -613,15 +645,17 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 		if (ret != H_SUCCESS) {
 			kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl, entry);
-			goto unlock_exit;
+			goto put_exit;
 		}
 	}
 
 	kvmppc_tce_put(stt, entry, tce);
 
-unlock_exit:
+put_exit:
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
+	kvmppc_spapr_tce_table_put(stt);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
@@ -637,42 +671,49 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	u64 tce;
 	struct kvmppc_spapr_tce_iommu_table *stit;
 
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
-	if (!stt)
+	if (!stt) {
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		return H_TOO_HARD;
+	}
 
 	entry = ioba >> stt->page_shift;
 	/*
 	 * SPAPR spec says that the maximum size of the list is 512 TCEs
 	 * so the whole table fits in 4K page
 	 */
-	if (npages > 512)
-		return H_PARAMETER;
+	if (npages > 512) {
+		ret = H_PARAMETER;
+		goto put_exit;
+	}
 
-	if (tce_list & (SZ_4K - 1))
-		return H_PARAMETER;
+	if (tce_list & (SZ_4K - 1)) {
+		ret = H_PARAMETER;
+		goto put_exit;
+	}
 
 	ret = kvmppc_ioba_validate(stt, ioba, npages);
 	if (ret != H_SUCCESS)
-		return ret;
+		goto put_exit;
 
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	if (kvmppc_tce_to_ua(vcpu->kvm, tce_list, &ua)) {
 		ret = H_TOO_HARD;
-		goto unlock_exit;
+		goto put_exit;
 	}
 	tces = (u64 __user *) ua;
 
 	for (i = 0; i < npages; ++i) {
 		if (get_user(tce, tces + i)) {
 			ret = H_TOO_HARD;
-			goto unlock_exit;
+			goto put_exit;
 		}
 		tce = be64_to_cpu(tce);
 
 		ret = kvmppc_tce_validate(stt, tce);
 		if (ret != H_SUCCESS)
-			goto unlock_exit;
+			goto put_exit;
 	}
 
 	for (i = 0; i < npages; ++i) {
@@ -688,13 +729,13 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		 */
 		if (get_user(tce, tces + i)) {
 			ret = H_TOO_HARD;
-			goto unlock_exit;
+			goto put_exit;
 		}
 		tce = be64_to_cpu(tce);
 
 		if (kvmppc_tce_to_ua(vcpu->kvm, tce, &ua)) {
 			ret = H_PARAMETER;
-			goto unlock_exit;
+			goto put_exit;
 		}
 
 		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
@@ -705,16 +746,18 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 			if (ret != H_SUCCESS) {
 				kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl,
 						 entry + i);
-				goto unlock_exit;
+				goto put_exit;
 			}
 		}
 
 		kvmppc_tce_put(stt, entry + i, tce);
 	}
 
-unlock_exit:
+put_exit:
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
+	kvmppc_spapr_tce_table_put(stt);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
@@ -724,20 +767,26 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 		unsigned long tce_value, unsigned long npages)
 {
 	struct kvmppc_spapr_tce_table *stt;
-	long i, ret;
+	long i, ret, idx;
 	struct kvmppc_spapr_tce_iommu_table *stit;
 
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
-	if (!stt)
+	if (!stt) {
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		return H_TOO_HARD;
+	}
 
 	ret = kvmppc_ioba_validate(stt, ioba, npages);
 	if (ret != H_SUCCESS)
-		return ret;
+		goto put_exit;
 
 	/* Check permission bits only to allow userspace poison TCE for debug */
-	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
-		return H_PARAMETER;
+	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)) {
+		ret = H_PARAMETER;
+		goto put_exit;
+	}
 
 	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
 		unsigned long entry = ioba >> stt->page_shift;
@@ -750,7 +799,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 				continue;
 
 			if (ret == H_TOO_HARD)
-				return ret;
+				goto put_exit;
 
 			WARN_ON_ONCE(1);
 			kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl, entry + i);
@@ -760,6 +809,11 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
 
+put_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	kvmppc_spapr_tce_table_put(stt);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
@@ -769,28 +823,38 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 {
 	struct kvmppc_spapr_tce_table *stt;
 	long ret;
+	int srcu;
 	unsigned long idx;
 	struct page *page;
 	u64 *tbl;
 
+	srcu = srcu_read_lock(&vcpu->kvm->srcu);
+
 	stt = kvmppc_find_table(vcpu->kvm, liobn);
-	if (!stt)
+	if (!stt) {
+		srcu_read_unlock(&vcpu->kvm->srcu, srcu);
 		return H_TOO_HARD;
+	}
 
 	ret = kvmppc_ioba_validate(stt, ioba, 1);
 	if (ret != H_SUCCESS)
-		return ret;
+		goto put_exit;
 
 	idx = (ioba >> stt->page_shift) - stt->offset;
 	page = stt->pages[idx / TCES_PER_PAGE];
 	if (!page) {
 		kvmppc_set_gpr(vcpu, 4, 0);
-		return H_SUCCESS;
+		goto put_exit;
 	}
 	tbl = (u64 *)page_address(page);
 
 	kvmppc_set_gpr(vcpu, 4, tbl[idx % TCES_PER_PAGE]);
 
-	return H_SUCCESS;
+put_exit:
+	srcu_read_unlock(&vcpu->kvm->srcu, srcu);
+
+	kvmppc_spapr_tce_table_put(stt);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
-- 
2.54.0


