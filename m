Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8C6606A320
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fY1iywxG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXFtP3lptz2yMP;
	Sun, 22 Nov 2026 15:08:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795320509;
	cv=none; b=lxZjprdIw0VbORyrpbZywb75spWbaW7tVQXVS7c9SKKWf8QamSSXG1EdtnDLx2Qffqo3+zygcBXrRuyI0Fqs8knNXIPATI+05rhar70u1PQrwybbgT70RW8jStDoNItT5bQzaVZG8+mIOKDbM3w7mbHd7PaTX5hwZvZ+EBPuBkXYvxAh8E1Pu3SQKJf0tj8In7LdofMBt2DitSq+azOBeTudn4IHckaaCcWSKK6vufJRV96jJehMjoexzyHFM5/6pXbctAJQRihJWwx+//LjAug6VtlBdrvZiPsB0bEbqECY9YimPCf5G2crRCt2EguBfg8AbVB4GZFN0fzJ2ss9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795320509; c=relaxed/relaxed;
	bh=Uv8h2L45V4jj5LVvESCeSMq451qPSPNLhaVFN3TApkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VzdFZ5ybczAbUKfKlvgtaGd4cAmKPnHcGjAq5zW1wmcLPl9URNjI9yLA+Q+aJK0zG0UoxI/6ideCuW4++hbtCj2wvw4UK2W+WMOa0Im29K8fY5B/YyLHmW44sG8ITWsW9J5X9Pme8Sq1u48WoDloyUOwcX8ETCj4NW+1lKTd0Onw0UW2WyGE6GyxmTbTvyWoYo5UniLJm6Rz24/Bg6Tw16rC6NFNzpwOrH75gAP/njXY+t+wcuHz1aq9cHLw5mom1PmMoFIDqEY0SKIdcA9UNRQZ0q4p1Z4wUlxhm4K3SzsVsDcAL7BmDQkPnDcw+QE+rLHhsSESRQEFuGgiw390Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fY1iywxG; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fY1iywxG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXFtN2hMRz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:08:27 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44Wnv3724081;
	Sun, 22 Nov 2026 04:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uv8h2L
	45V4jj5LVvESCeSMq451qPSPNLhaVFN3TApkA=; b=fY1iywxGSjyaQuK2adLxRj
	2CeiRAC5Q/x9YGowm2V3q+7wiQQrahExgsczFCn3nwUGPoF685L9931mDCjlnDLV
	OsLwn189d2a238bwXYEtOFUG5R3PBqqb9+qtQ6DIY02h1QkMNbWflWWhLIRKe93O
	wBl7hg9/F+XrgkFJuLbp6K9EBuV6TcjZ35IoPQ/9Bcin4qSh2Cqwzx0D0+7I6I71
	43+RJf86/8+J0FZzLWH+QSR8TuV6u8Wc8XLMGhMIS9ITYTubjJVpB42kElL8kbiZ
	30DHtzOuDyYmTlYGAOD37Im7iFA0tDIm6Es2vmu3D9lhyAUm7azG8K8zw/6Bnuxg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fk4uqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:08:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3nD751128197;
	Sun, 22 Nov 2026 04:08:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjrff0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:08:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM48NoS52953456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:08:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A336458055;
	Sun, 22 Nov 2026 04:08:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD0F58043;
	Sun, 22 Nov 2026 04:08:22 +0000 (GMT)
Received: from [9.43.90.96] (unknown [9.43.90.96])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:08:21 +0000 (GMT)
Message-ID: <ac3d60d5-1bd3-4f60-9933-e03af7323162@linux.ibm.com>
Date: Sun, 22 Nov 2026 09:38:20 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: PPC: remove unnecessary #ifdef
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20261120133413.475489-1-pbonzini@redhat.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20261120133413.475489-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxNiBTYWx0ZWRfX+0QTWCPrwkhd
 2Ny+u/rYMMxR0z4ARAskb2kgvEiRP4WLBNGEhT/+bPCJYxVjCEfHQ3uU5vQ3jOQ7KR2Va8y5iu3
 cYBk6biXug08Of/gBUaYqcoafEQAeKR7A/AbqhGym2zgxxWYviVFjtIW6jZcFIiPadbxTKNJ2O7
 QaiY1tXrzJbInqmFNNmzUPTmLJaRxAc290HUL6el1KoeztHfzymLHdxMJONzANupLDnh9NLanT7
 KIOFP6AGHgP1Kd6mDZX7ULUc4ky5PrPaEVCs1nMpcEw3QCkQ1XNODx3TE7d8fFDqdmsnRPvQG9h
 4dIUNJx9yPHWC1HMTTB1saT8l0Px31S4lAe/DX5EIflhTlO/sVXI8nbHSf/U+UXWGvrb5eL7Q9D
 P9UQ63QB+qNhAZVBoW8kQOm3d5boK/IN73OwzPll+BAXjX+JHEP/l+Udf9KvcLV2RAoDs0YN6xn
 Qs+vNVYkQ9LZYz1+yug==
X-Proofpoint-ORIG-GUID: hCpujaJVqeKogjbmvqemIG1K_zYI_K0k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxNiBTYWx0ZWRfX4GWVfEmf1jds
 a+TN+TbkXXod5hlOBO2b5yuiWXkelIyxC48jA8UG47OepvTrLoQviRF27TjM16JSywuG5UC+W4a
 u6DFCnpM6euGe9cyyc+Kwk143IwtPjM=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b026ab9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=BE-TfwSVDWWdQ4Vu56kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hCpujaJVqeKogjbmvqemIG1K_zYI_K0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220016
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

++linuxppc-dev

On 11/20/26 7:04 PM, Paolo Bonzini wrote:
> booke.o is only built as part of kvm-e500-objs (which is conditional
> on $(CONFIG_KVM_E500V2)) or kvm-e500mc-objs (likewise conditional
> on $(CONFIG_KVM_E500MC)).  Thus, the #ifdef in kvmppc_core_check_requests
> is always true.  Remove it.
yes kvmppc_core_flush_tlb() is defined in e500_mmu.c which is 
unconditionally linked in
both e500 config (kvm-e500mc-objs and kvm-e500-objs)
Nice catch. Thanks for the patch

Queued via PPC tree.

Maddy


> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   arch/powerpc/kvm/booke.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index fd7f24a68b31..ba762ac1fb56 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -738,10 +738,8 @@ int kvmppc_core_check_requests(struct kvm_vcpu *vcpu)
>   
>   	if (kvm_check_request(KVM_REQ_PENDING_TIMER, vcpu))
>   		update_timer_ints(vcpu);
> -#if defined(CONFIG_KVM_E500V2) || defined(CONFIG_KVM_E500MC)
>   	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
>   		kvmppc_core_flush_tlb(vcpu);
> -#endif
>   
>   	if (kvm_check_request(KVM_REQ_WATCHDOG, vcpu)) {
>   		vcpu->run->exit_reason = KVM_EXIT_WATCHDOG;

