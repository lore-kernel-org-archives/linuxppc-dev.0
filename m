Return-Path: <linuxppc-dev+bounces-29233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DD1CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 08:29:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j39cv4SW5z30hC;
	Mon, 12 Oct 2026 19:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791793791;
	cv=none; b=cbsz9qKlrls+qkSLAryzE9u8YiZ9VNAaM0RIbfBYdbCtT3wsTMXCBC+t7BqiQrDacfHXP2vmNlUJoNJe0iMrhkgMTQpQ1LD63i2ImTVxVuGjbefKYvd9/N3VwQP7uQEMlUYFpxu4I+m7mXY8BQ1emzveIH5xydw9xWnnYAPC3RIakaIqp+Lilwyur0YusjYsRkyr6Bm8nAoyk9E/Soyd2zUIsmh/EjnBu17yjqxgHvbAopY4Yqw+nzn1BjAcnLMm4ZYkqQw/7jlVHxF6hTJKFMUFV3OzfqvEPUttyGtPIyWiBfG+awQ3443uWCRZVsvsc0FdNQGM0jLcagiYxSHQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791793791; c=relaxed/relaxed;
	bh=ZF7QR8uQzOEu8sn18pPTCUuBQ1fvlGaQn3JalaXlTkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXCXjQvxrBbEtwnWClyTaW3LHcJVeS58ML3u3fvSrixpvziBPAKbqO8yDIF71imd/+8ITG52Q+ISy7eDpVZ5QHLLLgJvyGQwqxv2ixsssWMMhNNOjkgz5z/FxaR6ko6zHxqSg3r/4AFCSmO0idXYDn5Boy8n75E9izLhHF3nYHMbTZTxEsjj15AK4wMpu/5AVYWVFqzMcECRTD6NwY2HuoVIaR0txl7CSLE4EPAooXilWSCy3SwVr/jCC7HqsWXYGHYB3M4ayZDcN0S93eDQW0eA4hsIoav/YhPDSnhv35plskrpnRJ3iZ3F4kb3uoxqsNzdoH75QmVXdbDYItizVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMmdXNZi; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PMmdXNZi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j39ct5lF3z2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 19:29:50 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5ELSH2260460;
	Mon, 12 Oct 2026 08:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZF7QR8uQzOEu8sn18
	pPTCUuBQ1fvlGaQn3JalaXlTkw=; b=PMmdXNZii1Xl0VblnIW2l8rhBt0uEMTyl
	PmRuZzclYmImMXYRBE0HVkTtDnedRd3loNSLox74KvuV+SXRdXFiVZ4LUbRvHIW5
	DlEwFkE4ZUi9ufbZ3kL4pGDON/iYdRl+1Q2tFYN6oFmNK3wbRjKvEk3sPEiLFnGW
	0obRVLbEttDazq5YBVO6GuV2bO5sx6ratwiVhwZZMOOrcnpEGnI8VMbAVwiiiLX5
	uRN40GMMbXinq5V6eNtY/3bv/ZpjFClBC3imMwdq45TOYswPDxKPV5R5obZbl6Kt
	7p4kVQzrrwtWI74yZl4sxUk3rdLqaX/REFW30JNn2qh4v31xOvYQg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv07m0q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K1Ko1014037;
	Mon, 12 Oct 2026 08:29:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gv99v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8TaTG37880282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0708C2004B;
	Mon, 12 Oct 2026 08:29:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CCEB20043;
	Mon, 12 Oct 2026 08:29:33 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:33 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
Date: Mon, 12 Oct 2026 13:59:17 +0530
Message-ID: <20261012082922.218799-2-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX8ZRtN9wHqKuz
 WykvxEuLeCLgvePR1D4stQ7KR+GidFR4qyexMW36NqYAOQgyHi07ok9v3tFNlxu48XZwISw6hZv
 ukBbbTu3c4FHTZP4vEci6Eu/WUhoP276iMP2lKIw2ZgNXtQdZsze3BOFgp2UxRxPqFIPABzuuFg
 3Swu8BiVAxOjZc41FoiBY/eGcTgL40GYeg4jXUUiDS8jrTSl8q+E3gyAAI9NIQT7ckhXrG8C25F
 PlCJeSUyQz3Sy4lt+n6v1UeayfmvHggwparzZ6TqDA48oHld4BWq0S72mcKgz2PkUa9bA8xLmaC
 TN9tLV7xe4jN3SNX5fMYf7dsBSxojmbzYXNSvo0Wo8wVVJ5NEVC9+nnohIJ832GjiBAD8uJJwaj
 lXSCtB7fsQ8ZkO5gFdquP2+icl+pB924jsxfQuhQoU3/q5hnkFmABDXYR7h82of+qdTf7M87WTa
 P2ES1n1zris3ERe9FVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX3qxgqYvSXNoT
 xx6vfqFfmqiPeQam/Cb57MpIzmGdsqc654mPZP4i59+IrWSpGq8nQYXhYhWY8oys0vDByTNwmAU
 fU6PmTcOaL3qGEBUjBOB3vCOMpuOED0=
X-Proofpoint-ORIG-GUID: t-Nqlme-bYxs5DKPavD_VrkM-YlUT-it
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acc9a75 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=nGxc2afJ-JXm4Ai_qTIA:9
X-Proofpoint-GUID: OZxeKsKl2FixN_m5LBcCmFZp7ceNrLar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120032

Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
According to the documentation [1], the caller should provide their own
locking to prevent concurrent modifications to the idr to prevent bugs.

__prealloc_nested() calls idr_alloc() with GFP_KERNEL which can
sleep and mmu_lock is a spinlock. So idr_alloc() cannot be moved under
mmu_lock. In such cases the idr Documentation says:
    If you need to take a lock while allocating a new ID from the IDR,
    you may need to pass a restrictive set of GFP flags, which can lead
    to the IDR being unable to allocate memory.  To work around this,
    you can call idr_preload() before taking the lock, and then
    idr_preload_end() after the allocation.

Hence preload the idr memory with idr_preload() before taking mmu_lock,
which allows us to use idr_alloc(..., GFP_NOWAIT) under the spinlock.

This also allows to kill __prealloc_nested() and __add_nested(), as they
are not needed anymore with idr_preload().

[1]: lib/idr.c

Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
Cc: stable@vger.kernel.org # 5.19+
Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
1. Fix the patch description to accurately describe the code change.
(Ritesh)

v2:
1. None

 arch/powerpc/kvm/book3s_hv_nested.c | 34 +++++++++--------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index a6ff42d7666c..e893fdd24f0a 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -702,20 +702,6 @@ static struct kvm_nested_guest *__find_nested(struct kvm *kvm, int lpid)
 	return idr_find(&kvm->arch.kvm_nested_guest_idr, lpid);
 }
 
-static bool __prealloc_nested(struct kvm *kvm, int lpid)
-{
-	if (idr_alloc(&kvm->arch.kvm_nested_guest_idr,
-				NULL, lpid, lpid + 1, GFP_KERNEL) != lpid)
-		return false;
-	return true;
-}
-
-static void __add_nested(struct kvm *kvm, int lpid, struct kvm_nested_guest *gp)
-{
-	if (idr_replace(&kvm->arch.kvm_nested_guest_idr, gp, lpid))
-		WARN_ON(1);
-}
-
 static void __remove_nested(struct kvm *kvm, int lpid)
 {
 	idr_remove(&kvm->arch.kvm_nested_guest_idr, lpid);
@@ -862,21 +848,21 @@ struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
 	if (!newgp)
 		return NULL;
 
-	if (!__prealloc_nested(kvm, l1_lpid)) {
-		kvmhv_release_nested(newgp);
-		return NULL;
-	}
-
+	idr_preload(GFP_KERNEL);
 	spin_lock(&kvm->mmu_lock);
 	gp = __find_nested(kvm, l1_lpid);
 	if (!gp) {
-		__add_nested(kvm, l1_lpid, newgp);
-		++newgp->refcnt;
-		gp = newgp;
-		newgp = NULL;
+		if (idr_alloc(&kvm->arch.kvm_nested_guest_idr, newgp,
+			      l1_lpid, l1_lpid + 1, GFP_NOWAIT) >= 0) {
+			++newgp->refcnt;
+			gp = newgp;
+			newgp = NULL;
+		}
 	}
-	++gp->refcnt;
+	if (gp)
+		++gp->refcnt;
 	spin_unlock(&kvm->mmu_lock);
+	idr_preload_end();
 
 	if (newgp)
 		kvmhv_release_nested(newgp);
-- 
2.54.0


