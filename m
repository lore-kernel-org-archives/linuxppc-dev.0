Return-Path: <linuxppc-dev+bounces-28966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA69FCA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 12:25:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzb6q412gz30TL;
	Tue, 06 Oct 2026 23:24:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791289491;
	cv=none; b=cRj/3waugRv0trHP5adA2ODz1IdNzZojVhPmh+D+aMBv8ODElga7snbIh3a0pY+3rx9Ds6++Nwv2Wp69vF7zl/AMng5VkPk98E8qH+3zJOsqOKF9DXfr4kIQSjY1ruXqEe/zYU/r4iidxrQMN0E7UJLCiI7IzlWhpUg8a2ts0nw0Qv6MQoRMmdTOIPgXTXRX+O2YawseQoeCKHkOp377CquwWYciY7xmr3O8WZqFoO1OfKYd/LpjM78WLRnggdJpiO8ZRBe4WsMdENnqYcCgti2w14WJNyxb2hk53a6Mgx7En0TDSkjCanYXV6kOkDlKj06JIzg+3cblWFm8d1gshA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791289491; c=relaxed/relaxed;
	bh=3oFm4tubtIMTZpZXRbTObhEsOwplB8DoBjWuq0KDJ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9rNMF7C7C6Bjcw3p+xenMsBinbT5g1X+6cK5y0G5Ie+Zd4NwuWDj36G3+WT+oQVztKVT5Ub0TwT5vDZOyHf0lD3n4AWP9sIVq3TSJk+GMiOB92PsVr5UIceeKDulvNwMnxIZmKyus/R9WeFp2BI8ISzYrqI0wgCKS5w809ZRAlGnWeqTLTD3nWyr82lhpqA4aDVMjK3g4BS/dOhxBzfOPTlLs1H0tFBbAgy6jTr6f34Q/Oc5jvRwADUz6kv5qC0fU9kz2q3Z4T6NeLzYmlw9x0nwsiznFOAaFaIlh+jAXSRktPwiUgjzrAFL7dwOy+iqcbTuzOWPlN3G9i1U9xN5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQmw+79G; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQmw+79G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzb6p57m2z30St
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 23:24:50 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZgKQ3474077;
	Tue, 6 Oct 2026 12:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3oFm4t
	ubtIMTZpZXRbTObhEsOwplB8DoBjWuq0KDJ7I=; b=gQmw+79GXUNpO5GnCoFEtV
	RdlDy29UNp0GkkTVITyo6BE+g+W3cKgGQVInbLDD+fzhcWB0z1ttGzH3pGrYjnq8
	stW+/7COBJC7OpgkcTyfOOcp+LDfRi9m5lbWoOX9s6ofDvxcCaMvd38wVITUVa06
	IjX9C4QJOT9/AfCzqq1U0oKHL+61BvmFXBhuQqsL/s+XT6Yb3wmT1YYrgoKB/khU
	pYjvn5CbQn5ExVPDtMXsqsbh5YUpxR8FewY6yxWJHjkpcI4ZFoX9Rl6qX+c+JLt0
	mNQW0ArFdNC+cq+aNnmlNV0FBUK2Cuv1qLQegVpaYcfXL1aDSorMdY93U9Ytv9jA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jqans-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWbmn270002;
	Tue, 6 Oct 2026 12:24:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsr6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696COXH443843916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3139620040;
	Tue,  6 Oct 2026 12:24:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884202004B;
	Tue,  6 Oct 2026 12:24:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:28 +0000 (GMT)
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
Subject: [PATCH v3 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Tue,  6 Oct 2026 17:54:04 +0530
Message-ID: <20261006122404.99358-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006122404.99358-1-amachhiw@linux.ibm.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: RjurgE7iBOXIogRNExUsJsoeSeNMcwx7
X-Proofpoint-GUID: FUu8Psf17YyBlKXopUSoJL1aMyC-iyJ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX9hfIeWIH2KAI
 CioNvRq5ovIZQa7ZUSd1xgmPE6p2XjuOWjwHHG+caMR8G8Q1hEP44WemldqI3OQN3iBXZH/DJBK
 QHmKAvJXzw1j1M/7GqeLNq7ZdgfKZfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX9loWTdA9Qro5
 xrqLN/auGFWoAZ6Fr8jFQAZtYFTOdKt9QlcaORkV3oE7IBERKZrnwwFbTjq3kHBuoqn4Cuecbc2
 SbRKZ/Dy7UxwgFiXIhf8jTyijXv4zoKcGz0zKAM4arC18Tuue+kazsn0Ubd22Xca87+6a34i5/H
 fR9yVBhZR0MfINJTM8PyclpABtASkj1xXuLsJmWdmu/EsW9jU6RI3LQB+LvmgioG0Rh37YUfCtF
 sFTKWyvLetKAoLLVE9jPOS1jiFkIPNJC3FMtGPVZN6yVQSEX6/kdimtkgrfs0EMqJ/zjoeUuDs1
 YWhRmC7GZjU9Lze1po/nZMnSwERUSpslmaeDy7hoe+jJpuhEVvbx1+qOq4RWlwzvm6muECreCJd
 ODZ0nXVpkEGeOej6Bf7v97ZvSEtxJfBZE9kolYHDgqw8YQpt58b89MMt5MRG6oxMzzUT/wIDkVz
 JSjgxC4ycz1RUbVBegA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4e886 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

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
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v3:
- Picked up Reviewed-by tag from Shrikanth Hegde.

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


