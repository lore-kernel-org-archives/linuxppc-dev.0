Return-Path: <linuxppc-dev+bounces-28404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40D2CA5FA2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 12:29:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htgbh4m4Dz2yqq;
	Mon, 28 Sep 2026 22:29:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790598560;
	cv=none; b=HGVUMgAkvxUeAQcdd3K+FLliO0eHxfDXFwsC349Q5wrIcMNTRCAvcXRcecC0Kyb1PjfUBtAIFMbLe7C9hSnAf/X5NkSw8uq52i0n5ntdsJAZ6nfP6FTkyLgPXT9vnzbCQiigFH5uLblbIoQsLxVtStooTeQCe2G+ckpuBJFybWoLCgkxS6aG0CjVIP/bmhO8M0mzIrrG8khrCiNtrTTv7QB3lNd28NRYzIyHAmzjOyD4TXtqmEaaBEm1AXgK3O2WtP06EZx4fivL0G8/NzI8QP6sMyCu56dKsRA120RMDalO3MKX36mvj5iazQRQZMN77ByiV0FkUL32wzCaY/hBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790598560; c=relaxed/relaxed;
	bh=2Y2UbgdV+77CAyq+MVK/R24FHgPjixP/AxA2RLOoCjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juGLFHK8gM8eF+h4PumSaSteYnAXkKDERrk6dsnichq1tT7vmH8ZYbuxEg6qgw89qVkIEeY+JLi3ybMqmUW5zNuAKvEgvgQEjOaaBKVBBONWj0/7oUZCDb1e3np9kwE8eVCgV3IVqOyJl1MnS//qcuKr00sET8UGWR33fG/O5kOjxIxgjFkAVfMUBAxjS2ht/WoE5y6nwoInwI7vRwAXGMTIepJCTt4V3NY80F5U8XqC8UVcr4ArIoVV6f2Er3SN86gJO4PR9mqKEMpW6TE6KZ80+sPVx09TkSD5sXWODcEN8FM0y5UOxCff36EqsEZ1yFQNA0fbNnZa47c6n4iJ1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7qlTRnS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7qlTRnS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htgbg5lSPz2y25
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 22:29:19 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZW4K3971195;
	Mon, 28 Sep 2026 12:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Y2Ubg
	dV+77CAyq+MVK/R24FHgPjixP/AxA2RLOoCjo=; b=e7qlTRnSkaXHbePaVmfJ6e
	y9UarR2qc3YUr1O1JfHFEf/BLM4k+6vU1SWSYt7ir3+QKfW/JjtnoEnSp4DxIEhy
	tOiHvYfAPKQh5WIxtmlmUf1K0VY1SDkc2yMEUaNSJm+b9+iw/3hPXDNIkBHFOOa9
	ZsRwNLwfpfdu5ufMAGJNeZ2AkxmZ+RSQDrBkOnMihV1Wv3zHL0Ri3z92BucuLcaI
	zTn4RM+qAFOiOEuRk6LTJIPtznj7MNnrshHQ8li5meUUO8i84IxqsSb/6ojD7bZ5
	4Yinl4TsTwEgeJaef6UkfPM9KNMo2zDFNrEKJBjj/8Z8lt/0NjR3be1Ef5EdlmrQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe0yjb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:29:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHX9R069407;
	Mon, 28 Sep 2026 12:29:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpnawc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:29:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCT4eP17236386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:29:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF4A420049;
	Mon, 28 Sep 2026 12:29:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93B0B20040;
	Mon, 28 Sep 2026 12:29:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:29:00 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [RESEND PATCH 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Mon, 28 Sep 2026 17:58:37 +0530
Message-ID: <20260928122837.8782-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928122837.8782-1-amachhiw@linux.ibm.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6aba5d95 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX2P2BRo1CjjVg
 zWyzmgOJwwPMAt/G9F+rhyITKaHfkTjJQFBsxfv6mOcJmn7/As7ygt2sskVmLrLskz9xfjnxWcP
 LSyTg+UhjNnS/w5a8WsfX89WLJULIa8=
X-Proofpoint-ORIG-GUID: QeW55F1-NeXaPWm6KxJ_mgznFsazK91V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX5mY1ak6FMoL2
 OrhPNIwFxQg1BRKRzhHkugITgX+11x6f5JwTinqHbKHu/u7LoOXNa3Cpbj/FVROhrwfNQJHRR/D
 NIctN4d+BT1sdUb6h8CDNJc41r1o6iW0fDxiue4RdfIue23YmZ+KORekZk8dUi1264iGYBlSa4D
 V3ab2mz3purUBauZpq7MYKTeGFHa5Aip5dI9KJyfCGsOMz/bW1aamN9F7+LtE9idJxDsgc6ec3C
 l0KRfPH9I3KmBScfed/9Wxc0tZzPjbkbMQ4RLbCwT5UqsoqP4hrNNqs7xjkUBrj1phPpWq53bCd
 FSvpdEN/JRsRzZ6naB9eb6LJ+z51gvTCpArmgp3zccNZjJyLvcwH1NNf2hl2IZ+kssexMwG/OtN
 bqPWytrKRdWtA/eXov1ddCk5594QiN/THcFn+7L65KX86aFAKx9S5DwECnEhJp/T+TdqJGa3wVT
 tDFr0K+RhYWa3awz+8g==
X-Proofpoint-GUID: wNslpQ4PfKg_tBauqa648K6_t9rDmket
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280048

get_d_signext() has two compounding bugs since its introduction in 2010:

1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
   field (PPC ISA bits 21-23), corrupting any displacement that has any
   of those bits set.

2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
   for D=0xFFC (encoding of -4) it returns -252 instead of -4.

Together these errors produce a wrong effective address for psq_l, psq_lu,
psq_st, and psq_stu whenever the displacement is negative or is a positive
value >= 0x100 with bits 8-10 set — essentially any real-world paired-
single stack-relative access.

The D field occupies the bottom 12 bits of the instruction word (confirmed
by the adjacent W and I extractions via inst_get_field(inst,16,16) and
inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
sign extension from 12 bits to 32 bits.

Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index bc39c76c9d9f..532f96293de0 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
 
 static int get_d_signext(u32 inst)
 {
-	int d = inst & 0x8ff;
-
-	if (d & 0x800)
-		return -(d & 0x7ff);
-
-	return (d & 0x7ff);
+	return sign_extend32(inst & 0xfff, 11);
 }
 
 static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
-- 
2.54.0 (Apple Git-157)


