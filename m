Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE26606B243
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kfzAJFFI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQDTC2RnMz2yKn;
	Thu, 12 Nov 2026 19:44:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794473055;
	cv=none; b=HlA67O0gNTXRgNWpFLtDem3H9g1d0fZOcPvIGkxKJxNGgQNWKi5gtRdPg5Um5+ZLoS2LjAuGgo5qDEGMf0lILv1Cs2pYzv27kVoIzGdezjN3VckIlz4BsQrHwPKhKKU+Nv0KL84FsAQViPM3TMcLOTzDYQdZ3wUZjECMZurkVcA/+Cqzw8yTzSThjLK/2W09XHUShhzRmWCFaPPWlx/BjUzHt9TrEa8CCDCGcqbujcKdAIPsiDoCmayRNC5222m/DIZwET3rzvtVBs/QK9CTiwlZp3K9MZ+RQjBnhpeQvlbOZoFlN+eHg+CH8zjkfiQtBHXaYzXuq1FmEbrtczjKGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794473055; c=relaxed/relaxed;
	bh=9SpBZGxUtba6ow8shCnowhpSC9YarN02m5LXry2AQuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXz2S5A2YTwnJYmmV1rsql9Y3nBNzGX4VdcwbiRPq/KSk3CZj8oPoWV3o8gFcxZz10x7lkxCpNzc7f4U6/1pl7jDxeNgwvSmFh7c+xoiwcUSp9L6xhJuafrD3CyGKgPJxDwwvuy6moXKVCzPnfkM8J8JVDhIHc+lBi/QMurTAHHIEF2mWrGDFQbUB/uDeVZ5eF0eErnetX2ulYbrHx2fjt4Ai5gxvYWnkfRRbDPTKcn3hXQvlx/jzh42aX3Co12mLrthemEhMA96WhrLBRizlbzWwCWLykP/nO/vEsxfezmxobEydhIC7v8TUV0B8eOM3FgL6uu05sVWq6eBiIuQgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kfzAJFFI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kfzAJFFI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQDTB25jjz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 19:44:13 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2i8T53053570;
	Thu, 12 Nov 2026 08:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9SpBZG
	xUtba6ow8shCnowhpSC9YarN02m5LXry2AQuU=; b=kfzAJFFIXgpFQ7RJcur4cL
	vUrPMgLDX0cuPSAACYkc6EAL2CPaNyhNX2oDJUOFYkEHN6MmX/qf2yn41IkT5KUY
	ENll3+n57xCipfuqd8nUsM5GBXY5Z09ivHRLyjWq0Hn+8VkL7pEiikrotLnVUtUB
	4s5mqlFFzaIRgcPoE2wBqldXa8AzDbskis/i8Mq8Y4BRJAqm85LGNb44xRNcbhYR
	R/roe/Uf6cI0b6gJO4oeb867uiXCb8vLU7vjXQuANin4KBuFCkOpnNWKqBFEqs1x
	sOD4fskYEZEak6cZ4+PUg6eMY3zGEbQ00b8S3atXInk389nWPbkYLNtLm08U7MaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6ekjp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 08:44:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC88jAr3145596;
	Thu, 12 Nov 2026 08:44:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51wq5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 08:44:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC8hvru44171664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 08:43:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D67542004B;
	Thu, 12 Nov 2026 08:43:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8013A20040;
	Thu, 12 Nov 2026 08:43:54 +0000 (GMT)
Received: from [9.124.214.132] (unknown [9.124.214.132])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 08:43:54 +0000 (GMT)
Message-ID: <aafdbe35-0482-4649-b99d-3180aee112c9@linux.ibm.com>
Date: Thu, 12 Nov 2026 14:13:53 +0530
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
Subject: Re: [PATCH v2 3/3] KVM: PPC: Use ppc_hard_irq_disable before guest
 entry
To: linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        nnmlinux@linux.ibm.com, ritesh.list@gmail.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, maddy@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com, mkchauras@gmail.com
References: <20261110053238.3794500-1-sshegde@linux.ibm.com>
 <20261110053238.3794500-4-sshegde@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261110053238.3794500-4-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wPHfaJarynP4BGzuUada3BdtrjJKFSP9
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af57c52 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=scWtL-x6Enx3ky8QdPEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ym0croEtdha4ozCvusTLD-sOo9cgirBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfXwRcnJEtUfdZJ
 mrpd7lfqDrvYuNXEVlfGZfWNko4g5dAXq2MLdO2rz8dCYxVcBpJaqwQRYTH94X5T7qhM8OHxvSz
 Gb3Fb5awmgSu1fYEdRyvuUeyisZU03goa8q5oXHoc0cttinwzOkTcQi5X0AKP8N/6JKPc4iuR/T
 GA3q1jZP6pJszVg66DjDZicrNEN/qRzZF6WntQ6w8ASoaBJ+1UIjbzJOvsMPIvUHhzayuSdVRvW
 CsKBsD6UlEJpUMOvIbUJHVwSxxXh5gPHMIA4pTnDJiY6uZlz1l//szbk/ONVJTA2/e06/OeRKQ8
 MzHqXgFal6+8rbwfOeLp0FqyoeYd4lo1nQyekWfHRfONjHliOpyjIoyScHoZjv2dY7XixMSy3Vs
 0v2OskXJdsZ6pV20uIl+iGIqCuWr4y3muxJewdekgBDOF8BqcwPQIsfZGae4fpM02DME38+U+l4
 PcqndHZBq6wocFln8Kw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfX7eOpteLnl5OF
 g+0EdDvt8ScoyvKl8hDDnp0ew+bTWdNnW8LNGQXglFvkj9eEt+Yx+rKf2bCb+VyLqVIyY0MVKTE
 4JFMHK55yoMmnHqH6WG3BbbONVjbdew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120034
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 11:02 AM, Shrikanth Hegde wrote:
> After applying preempt disable patch, i.e PATCH 2/3, Christian reported
> a subsequent warning stopping his board to boot properly.
> 
> WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
> CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
> Tainted: [W]=WARN
> Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
> NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
> LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
> Call Trace:
> [c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
> [c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c
> 
> It triggers below warning...
> 
> static inline void kvmppc_fix_ee_before_entry(void)
> {
>          trace_hardirqs_on();
> 
>          /*
>           * To avoid races, the caller must have gone directly from having
>           * interrupts fully-enabled to hard-disabled.
>           */
>          WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
> 
> This happens since kvmppc_prepare_to_enter does first local_irq_disable
> followed by hard_irq_disable. This leaves a small window where interrupt
> may occur and it could set the irq pending bit in PACA.
> 
> That local_irq_disable was necessary for PPC32 to track the lockdep
> state etc. On PPC64 hard_irq_disable is good enough. There is no need to
> do both. Use the new irq api to do the necessary one.
> 
> Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kvm/powerpc.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..4ee3d7bfe917 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -81,13 +81,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   	int r;
>   
>   	WARN_ON(irqs_disabled());
> -	/*
> -	 * local_irq_disable() first: on 32-bit, hard_irq_disable() alone is a
> -	 * raw MSR[EE] clear that bypasses the lockdep/irq-tracing state, and
> -	 * the xfer_to_guest_mode helpers assert IRQs are seen as disabled.
> -	 */
> -	local_irq_disable();
> -	hard_irq_disable();
> +	ppc_hard_irq_disable();
>   
>   	while (true) {
>   		xfer_to_guest_mode_prepare();
> @@ -101,8 +95,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   			 */
>   			local_irq_enable();
>   			r = kvm_xfer_to_guest_mode_handle_work(vcpu);
> -			local_irq_disable();
> -			hard_irq_disable();
> +			ppc_hard_irq_disable();
>   			if (r) {
>   				/*
>   				 * The generic helper does not set the exit
> @@ -134,8 +127,7 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   			local_irq_enable();
>   			trace_kvm_check_requests(vcpu);
>   			r = kvmppc_core_check_requests(vcpu);
> -			local_irq_disable();
> -			hard_irq_disable();
> +			ppc_hard_irq_disable();
>   			if (r > 0)
>   				continue;
>   			break;

This patch had missed converting one more booke callsite. Will do that.
Will address other nits and send out next version soon.

Thanks for review and testing.

