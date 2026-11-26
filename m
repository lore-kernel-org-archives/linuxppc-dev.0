Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74F606A32E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SLe6fPch
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZqym45TVz2yQl;
	Thu, 26 Nov 2026 19:51:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795683072;
	cv=none; b=nRGQNFfzHiCzl4HbV5d5PKGELLzYn3t9DO9OcFdJqmKxHRkCL1WDDiC4I7w9TJfl50zjthgLMw+7DNSl/AFFe/U+sT37AHy1X7aPkgYVBTNQPpVlVy0O1Ki6ckRfS2xuUz59xmVEHkS/JUDfwbG8IOwBsK8yD3H5b1v9L2nwLCy7xghGSiyUb51YYKT/zlSzfVHNWKYN7ePXk0gDaSFtOi5dEhkusep3PatHnZIszi7gH+HTHVue7JLKrnvHSNVTwhtRp9icP7+Tek5Ps2nV08+bSt0njKIS0BHwVYLvNMp0uNSy0N8NoghBaZlrYTpcD6ysRD1yYNlRgJ2KUpMdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795683072; c=relaxed/relaxed;
	bh=zj+EFDuJlxj1hevU4hrO0QdQylTuyH9tQPOYwYgUNek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h29aXpF+K0jYUN+gQpp9j52P5yLM3QpEzLm/ZQsUr7msTIv+zdgRLteY2Ni845Ami3g9R27fwBojT3CBKkWJ5iWy0S/mcN/zUj3kX8Lml8zFNPlL1X6x/rcelIvghneFPWNVUQqfDMh1UOVUHQoW5QvDFDXYFJCyIOG9uHnPNUldWJCYls6qvggcRNPGSBFS+H6ULriaTg53OFnQi9Uyj6FgRNwKmsmic8wtV7lSNtzHpcx/JuELlrKU1K9FVtZQmlQPtsvVTzT00QtkGcL2tz/hLydAHuQ3esgie7BLSoZoe59hGHiW8aC0m2jhrdwa1nFMF7xglq1OZaAj1SPlrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SLe6fPch; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SLe6fPch;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZqyl5hZbz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 19:51:11 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7Yfd42431098;
	Thu, 26 Nov 2026 08:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zj+EFDuJlxj1hevU4
	hrO0QdQylTuyH9tQPOYwYgUNek=; b=SLe6fPchY/51zCWLbEzeVGfS/H18+co9h
	nGEzY6o2ciBViKBoe3rKIe+jAoosLVrDKiySX9tsQ//p9lOeoX0ReLCjbDp8LPOo
	PQ9yv0iV6Oo7Z5YHCIp9hj8tl6sKi2Etj6fSSZ1MjzKLZtMVIT9UORXprqTtA6tB
	Hu+vo8IUvWE6xcT1EPsUQ6ouSYfZOfVvbCFThOBJ1Vt9GVHemRe/Qtk9x5MvxaEZ
	FIXC3UXb9+arrBtjKNcv0WcYBxan+6gjuiqFcCbgLNrS/gim6fSst4v3xib4qdhg
	eFV4dqgKaaMe0PFFBSWvSitgSo1U/4MPjgsQdWSHeqc0QPPvNPV7g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4qrd3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ7JJ0p2009616;
	Thu, 26 Nov 2026 08:50:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuxrpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 08:50:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ8oqTk43581922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 08:50:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01B4B20043;
	Thu, 26 Nov 2026 08:50:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FBC620040;
	Thu, 26 Nov 2026 08:50:49 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Nov 2026 08:50:49 +0000 (GMT)
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
Subject: [PATCH v2 3/3] KVM: PPC: Book3S: Free child IOMMU tables after an SRCU grace period
Date: Thu, 26 Nov 2026 14:20:11 +0530
Message-ID: <20261126085008.34532-6-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX+OlepiTVJee4
 2yWuNqGHk5mKeHIVHX8rEeT5hZXIwP1+N3dcM2KyZSvXKEyBwFyFkPa1fc5iIkL42GSHX3xlaTe
 cWIq2ODzx75DFc+jvinCJ+pnssVh0iU=
X-Proofpoint-GUID: wbDqJFFPGSunOMzFK9xgU2ji33MtsX4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAzMyBTYWx0ZWRfX3AzNnskuYRSQ
 DQmCT5l2eA4Mm6tQVBOktQ6w76z9J+RbS3CIw/8xxGQ1rf4ok/yTyASXVmwDURyn86uslJwCBUy
 bt/jUzzTn34pJfHc0Yv1yNWLdhPjr0XtyL6DVvP+KiXpJVLItq/PXO4brsrGGq/qNOcJ3gtQUJe
 zF8m5rTLVxMU0BYyEF4Unk2r/Uf85sERQXJlIEn9mtEY+Mue76kKm5ICEuKro0ZEQzEKyloeELK
 T/chGN6OZpv0+eK/im6uptKsKrbTQ0TOlvobOsnEhINDbedCTHlgFY82FYbLD3RsEPsY6dbRC0V
 Ndwj/drSHOxIM3XrvpCSE3r1mklAM6OKiadLq7H98yNj/R7HH6XSm/1iyLTvY0WAKFAaYY8iIWK
 HMmzSoABxESgg2IA24fPQS52t0Uf5T/wQM+Pp6Ypb+U9gtD3Os7hqI2OmEsLZ0PUfxqodzNTL3N
 FA4L4gEb6pTKnQXtR0A==
X-Proofpoint-ORIG-GUID: Yqo_EV6Uxf37QGvcBEXndXWFxfcV-CfL
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b07f2f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=d9fdHMpkFR97eazZOqQA:9
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

TCE hypercalls access child IOMMU tables under kvm->srcu, but
the entries are currently reclaimed using call_rcu(). A classic
RCU grace period does not wait for SRCU readers, allowing an
attachment to be freed while a hypercall still uses it.

Defer reclamation through call_srcu(), followed by the existing
call_rcu() callback, to protect both SRCU and classic RCU readers.

Keep the KVM pointer in each attachment to identify its SRCU
domain during deferred reclamation.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/book3s_64_vio.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 13e8c5b12f40..28442cadcabd 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -188,6 +188,7 @@ struct kvmppc_spapr_tce_iommu_table {
 	struct rcu_head rcu;
 	struct list_head next;
 	struct iommu_table *tbl;
+	struct kvm *kvm;	/* SRCU domain of the hcalls using @tbl */
 	struct kref kref;
 };
 
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index afa7ce57f5ae..71835c58d25d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -76,6 +76,25 @@ static void kvm_spapr_tce_iommu_table_free(struct rcu_head *head)
 	kfree(stit);
 }
 
+/*
+ * The TCE hcalls walk stt->iommu_tables and program stit->tbl under
+ * kvm->srcu, while kvmppc_tce_validate() and the attach/detach paths use
+ * classic RCU. call_rcu() alone does not wait for SRCU readers, so wait
+ * for kvm->srcu first and then for a classic RCU grace period.
+ */
+static void kvm_spapr_tce_iommu_table_srcu_free(struct rcu_head *head)
+{
+	struct kvmppc_spapr_tce_iommu_table *stit = container_of(head,
+			struct kvmppc_spapr_tce_iommu_table, rcu);
+
+	call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
+}
+
+/*
+ * May run under rcu_read_lock(), so it must not sleep. kvm->srcu stays
+ * valid until the callback has run: every caller holds a reference on the
+ * VM, and kvm_destroy_vm() calls srcu_barrier() before cleanup_srcu_struct().
+ */
 static void kvm_spapr_tce_liobn_put(struct kref *kref)
 {
 	struct kvmppc_spapr_tce_iommu_table *stit = container_of(kref,
@@ -83,7 +102,8 @@ static void kvm_spapr_tce_liobn_put(struct kref *kref)
 
 	list_del_rcu(&stit->next);
 
-	call_rcu(&stit->rcu, kvm_spapr_tce_iommu_table_free);
+	call_srcu(&stit->kvm->srcu, &stit->rcu,
+		  kvm_spapr_tce_iommu_table_srcu_free);
 }
 
 void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
@@ -117,6 +137,10 @@ void kvm_spapr_tce_release_iommu_group(struct kvm *kvm,
 	 * Wait for hcalls that may still be programming the detached
 	 * window. They run under kvm->srcu, so once this returns, no
 	 * TCE update can touch the hardware after ownership is released.
+	 *
+	 * This must be unconditional: the attachment may already have been
+	 * unlinked by a concurrent close of the TCE table fd, which waits for
+	 * kvm->srcu on its own but may not have finished yet.
 	 */
 	synchronize_srcu(&kvm->srcu);
 }
@@ -200,6 +224,7 @@ long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
 	}
 
 	stit->tbl = tbl;
+	stit->kvm = kvm;
 	kref_init(&stit->kref);
 
 	list_add_rcu(&stit->next, &stt->iommu_tables);
-- 
2.54.0


