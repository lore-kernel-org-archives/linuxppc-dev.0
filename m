Return-Path: <linuxppc-dev+bounces-28944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F370ACA5FFD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 03:27:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzMC46bQkz304x;
	Tue, 06 Oct 2026 14:27:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791257264;
	cv=none; b=JGQlQX8eTWZo1TWZvgB9kHCJaq3mKKkm8sQNHfXWL5vfg1U0Ha9cEqcB2ZLVjTQKSUhaQnzY/4Z/Mk+an0F0cGgiqKT9gSV9lFe8gWvvenNj9cWobdM9pt+tH1jKr2NL07c+dQR1PVIYo8JImMWYEKMQLFokh41Ov/XG8ZcVF8EXkHpplXuJBVX1lbTJ+31qC+588iwjIfH0AxdevGxJ+yXtAT2nosIqxwm7EcYETIC2IPCqzx/4ENBVsLM7u/+NgAEESoceZKyr/6TVn7IaGS4oiHjRUaBDfrbNxFdylko756k/QCR4Dc5LE6FvmUSaAzDiFB6IxVYGz3TwWDWzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791257264; c=relaxed/relaxed;
	bh=0lBM0vUcupH/Y5YqGK9t8/tFQRI3XfjB4q1QDdrszOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mzi2W+5uec8ZsJCdU/WdOk4O7hTCnE9AypIOzAcXfUAJb6WCvxLM3qLOlYSye+byOd5J0ZN6DWHuO7tc9g+UJw/xJrcnNmDfSakOgbSfN6dW8UPpr6khshTnpMdC49jYI0DTL0N+Us05iROdZEEc5ipBmmv8W1SCmdIvem4tk9io9AjO5eoC/bHDu2s33wxFZ/brp8TV7ctx3mx+a2ydOUL9xIGQJ7ggIpFG1VAWPqhZVsmDXsgX6p3jpfNkJMF2PEURsngE0kj7A0uW4MUg10isA8V/QNgBIsXDQ6hZ1iNju36nd0SUCGzoxKUsV+YTmII5zwjG7R+CBz01pr9osA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvuHiY9a; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IvuHiY9a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzMC36Wlcz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 14:27:43 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695HZju91257718;
	Tue, 6 Oct 2026 03:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0lBM0v
	UcupH/Y5YqGK9t8/tFQRI3XfjB4q1QDdrszOc=; b=IvuHiY9aXOdgNLogatOE3m
	UfSlFo63cZLFOvhQYSYA2tRUryUUXOryRlndVIAJ/PIVZElKBZa83DBpBCDkMKEv
	7JJ/bKS1kTf+5i+neLCNdWMX/3iZUB66k0TEWQfozDHi6LJipRcXEkABIrKI+FDq
	8H/+uVH864z0TqoRS2hMeHwKln0VtFItsltCJVHweilsYiQd+eQnNyZmf6Ng1esk
	oBHOa33VbfOVDLAUddk8htd+avEJtbzyWF25jBpDdRVVdyauFC8+WxDeU7hoFWp9
	zvyMP+6YZ15j+orsKR2EJFv0X9tHF+obEXqxz9304Z740JPQwuNpaipGm7C41B2A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5dphe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:27:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6963HV4u3924960;
	Tue, 6 Oct 2026 03:27:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgr5ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 03:27:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6963RSfU48497038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 03:27:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA88820043;
	Tue,  6 Oct 2026 03:27:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99B3220040;
	Tue,  6 Oct 2026 03:27:24 +0000 (GMT)
Received: from [9.124.213.110] (unknown [9.124.213.110])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 03:27:24 +0000 (GMT)
Message-ID: <f5243a5c-a611-43a8-8350-7418b0dfd864@linux.ibm.com>
Date: Tue, 6 Oct 2026 08:57:23 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement
 for paired-single D-form
To: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
 <20260930173750.56759-4-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260930173750.56759-4-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAxMiBTYWx0ZWRfX3ObukXk0g2oB
 cUQXCoIBNSF/qFooWLyuauD0+zVH+11FE0mTaPvdVcrlpD7APOvS/yvtAIBsj2aFz9irCFDp74v
 Bx5C1F9ylkIl1low78ONPxodZOLhXaM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAxMiBTYWx0ZWRfX406dayzh01wP
 3GlwoVlzfyWnsf802olNfZqRvbPQ2oPgy8s7fuz139p9OBXT69s/7XIj4vY7F0gwEJroEmu4h67
 aGuHXGopq1uMlWy0NXmwrhK7vBdnR+FqeCJ4DBa8v1N+SDd67s+LxUJiABPVWUddbQp88/t1Yju
 mCwNP7IznH4evBiu8usaa5YOeohylx0XiExnA+448fVY/+4yu2NBae0zKhOy/WNpb6ovkaX8Jvz
 lpXEhiBfFIaOgmvW1JZ6Kavgm+jbaBnUMq53uCtBLO2bpfcoBgkq5lsaEwyLiQkKFHzgRBoVBF3
 Ti+4Zj38jFVbTN06xExkpPaAs2LkuYmUeDs4fV5GcsiiDsYGqszQ8C5SQRqaSMBGYX2yxfpHzVu
 PkjfLjGm4qP3A84ou/x6cfZQhzAu4gfwEcKRG0rbMFz0B5EJLPN/ustnXCGK1S8Tjboztg9C06K
 vIxjbBQ8M16B+jqYj2Q==
X-Proofpoint-GUID: rOW8sFFNC8rKqa3XTsPI_t-ZQX-Mrsuy
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac46aa6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WMBJgkUnEH5UdlDH4cMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PFNW8yP3hAGxY9v5rrxxnGVNiHZyOODw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060012



On 9/30/26 11:07 PM, Amit Machhiwal wrote:
> get_d_signext() has two compounding bugs since its introduction in 2010:
> 
> 1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
>     field (PPC ISA bits 21-23), corrupting any displacement that has any
>     of those bits set.
> 
> 2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
>     for D=0xFFC (encoding of -4) it returns -252 instead of -4.
> 
> Together these errors produce a wrong effective address for psq_l, psq_lu,
> psq_st, and psq_stu whenever the displacement is negative or is a positive
> value >= 0x100 with bits 8-10 set — essentially any real-world paired-
> single stack-relative access.
> 
> The D field occupies the bottom 12 bits of the instruction word (confirmed
> by the adjacent W and I extractions via inst_get_field(inst,16,16) and
> inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
> sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
> sign extension from 12 bits to 32 bits.
> 
> Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
> index bc39c76c9d9f..532f96293de0 100644
> --- a/arch/powerpc/kvm/book3s_paired_singles.c
> +++ b/arch/powerpc/kvm/book3s_paired_singles.c
> @@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
>   
>   static int get_d_signext(u32 inst)
>   {
> -	int d = inst & 0x8ff;
> -
> -	if (d & 0x800)
> -		return -(d & 0x7ff);
> -
> -	return (d & 0x7ff);
> +	return sign_extend32(inst & 0xfff, 11);
>   }
>   
>   static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,

If the intent was just to get the signed value based on bit11 (0 based index)
then patch looks right.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

