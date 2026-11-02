Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0D606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 22:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=km0KRzyr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJRcH65z8z3c1w;
	Tue, 03 Nov 2026 09:45:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793633587;
	cv=none; b=ZtmBu1DrPfjcv53w4bt4Apm09eeeruBS2yWsGEwDPpDEAPSv0AhY5cVGZeWA0C7Ln1F3iewyfWvIV7Gy7Y6rSfYHLF2XeLnBzjZWyoo7eNeT0zgv8H53qSUpJqte5RUw2ePwM1Y2DxmjtXjIdgYExcvEnHR4JacxXbJTlH4UXJ8FOQKA6QnX+gz/5NjDHPAnYAY8EUMW7RMWvxx0Z4l8Ni91TfVOMo1D7NYi5dC6ZRDERHe00vHkpGjxXps4ufDyLPlxp6mmZMsvx/5BGOa8h7h/Az9Nm4vcNlTFe/PtYxM7Z5AeZItWRbjL4QQmgU6tcILO455qd+UNrhvNGP+kJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793633587; c=relaxed/relaxed;
	bh=BQsaASFcwTR98Ua/j2/w7tivjnC0NUs/EPQM2iEIWxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS+L0iOZ8AcdnNxYPxVV3YMfbeexi+1ilBLuYwTagk97Rgs/zMe8WQiQ9KoqqtdBaW78vZBZAVM58Q/Qv+/fgMYfXhfVnCcIHuzxY7LKJlQWXOp3VVa7mXlvnGhDheSzU8UkAU/cM7JvM8F5Gil7ZBdkGAY5EbO2V6WldK4x4prhKF+N/FM1+HWrS1YeuIi5ITDszOrVig5w8u5h+Oejwbxh8k3aoTDPtDdVht9O4/b6Z6rxtQz4B6y0teRXNiPgGd7nCgetkG4xqut1Y4wwkRtvaoLSYMDV1TO7Qg5KdjyKxP6WMpIGSu2PI3EmbXoYgSm4r4PQj4r+nOkmVlFIXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=km0KRzyr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=seiden@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=km0KRzyr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=seiden@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJG1Z0FJHz3blk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 02:33:05 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEFDH3333621;
	Mon, 2 Nov 2026 15:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BQsaASFcwTR98Ua/j2/w7tivjnC0NU
	s/EPQM2iEIWxg=; b=km0KRzyrvJCvYWGvdxZLIQtpVChnlJb09PzDpSMrjXB+y2
	EiEtQfSUoklr4D7ZLh98AvH4myEMejuvNotugTEDk+hc9IH7sBGPC4XNbh+CkmJ0
	+HzZAOHhqosaf7waExH3cFRGjqkQNjEd0VW5D8xQYNU0LzVZLt5HMxuwvff3/IMA
	+ggupIXDvaRZDKuTLLD+rCJzOSj/A6/UD9excoqDFlPSHXeO2LkSAXr/cwZ77ksM
	U09ej/4wKCOvha+VgMWDi+xIuMLlni3IjPdfdnlGlxcl+MezqxSHAKNIL2e7VSx/
	D0jSPesAcXu/7UJmjIE5DJyVdWwxoxvrPRwtBKhQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u39cp5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:32:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2Dp3k8932188;
	Mon, 2 Nov 2026 15:32:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjxhmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 15:32:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2FWUrY45220142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 15:32:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DAF120043;
	Mon,  2 Nov 2026 15:32:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6387620040;
	Mon,  2 Nov 2026 15:32:29 +0000 (GMT)
Received: from osiris (unknown [9.87.153.156])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 15:32:29 +0000 (GMT)
Date: Mon, 2 Nov 2026 16:32:28 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>, Fuad Tabba <fuad.tabba@linux.dev>,
        Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
        Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Subject: Re: [PATCH 1/7] KVM: s390: Drop unused and unreachable
 kvm_arch_vcpu_should_kick()
Message-ID: <20261102153228.240804-H-seiden@linux.ibm.com>
References: <20261028190259.1819571-1-seanjc@google.com>
 <20261028190259.1819571-2-seanjc@google.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028190259.1819571-2-seanjc@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae8ad13 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=1XWaLZrsAAAA:8
 a=e2WrUwKQfGWSWgw8ceQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: TmxCuOpzq6vA5Vx27S-wl8VaUu08c3rl
X-Proofpoint-GUID: KVXVtrhgD1GJzUOP0CvMGutz2Xg2IILr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfX7bqvyy+G4IRi
 YuDNWW2rtZhIuWgYthjFwF9+9BvaQqjUd0NCjGgytPI2kgitQSqHnwzde0DvmKT5ekh2NyjS0Nq
 F9Z/Zdzj1pOgrZG2yR5VLS36NId8bM3pN7WDBUKOt9UCD+QFNKQAZu+Jyci2pVHVvCbSWlrBtzk
 4AIduMbPdqh6wI13eR6unsEG4RU8A4ZAJXpBquIr8jswWYP5JT1UMzhOQVTUhyasVm3yKq19/37
 g8IQ6IsFUU0CmiqM7aH5od6K0UDK4Pufp7iAip5do5FEjWgMz0BL8a8ds/SYC3EFA4Du3R6hGdA
 0zHdfqn6psBiKyEKCPFmlpIxWnmBKc5C9d6tL8dsAaGzrFS280m4gYPAHt09nU+p77BxB+4etoO
 zPcjuUT7rpSjV4uYvQkRwMMejfxArhysp1beSjd8DEChKl+d8KSwLwvy9Sujp9ZrxPVJILSraLV
 unHwMnZGlBbuYsnY1Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MCBTYWx0ZWRfXzMWFCRCaICBW
 YVdaYUPRVlAbXrli6ZNZR2sTDTrenRk6sxAut1SiSIk+5dhzpZRcRftKd34+qSoKLUq5b5QITXp
 q7EjnwMhcLT8GbXDC7vsw0JN8N6I7PQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020060
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 12:02:53PM -0700, Sean Christopherson wrote:
> Drop s390's kvm_arch_vcpu_should_kick() stub as the one and only call site
> is wrapped with "#ifndef CONFIG_S390".

In the somehow near future I'll remove those #ifdefs and use the kick
stuff for kvm_arm64. The native s390 KVM then must at least keep an
(unused) symbol at hand. It seems that the compiler could not optimize
those calls away. So let's keep it there so I do not have to re-add it
soon.

	Steffen
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/s390/kvm/s390/s390.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index 18fb200f854a..9900a1a1c148 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
> @@ -3922,13 +3922,6 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
>  	return false;
>  }
>  
> -int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
> -{
> -	/* kvm common code refers to this, but never calls it */
> -	BUG();
> -	return 0;
> -}
> -
>  static int kvm_arch_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu,
>  					   struct kvm_one_reg *reg)
>  {
> -- 
> 2.56.0.313.g2479322e68-goog
> 

