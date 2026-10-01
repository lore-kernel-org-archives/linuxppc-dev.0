Return-Path: <linuxppc-dev+bounces-28643-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED62CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:27:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwV4b3j9rz2xSV;
	Thu, 01 Oct 2026 21:27:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790854031;
	cv=none; b=kEJ262aiqSMDhmaz2+nwzaRf0TpXACnlpE8JJW21cjMtVIkE4cRLPazAU8axRpMzsDL4lfJFe1eMDWjjpMZaQJe4ej82FLzv64km6MKlSPq2xxhakpuL6l1/5u88xCdFvvZ4CyA2a3NBdIqbhFEUoQJ06OXkdTeN6XcCaIFvAo7nkF0J4OGIyRCDRb6f1ST0NAuq0n9sdXAe5jCDMqEuyACyOgpZfeOKFN/k72Xc7V7KQTEewaeaPaowzVGLr7r2Hdty2I4Mef5B32l5coxNck+/fyRH1/W8/6WgFkCFOe4KbqWd0jyrxThTanMBz/exEipQON/tKsH4Ue3ET9UuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790854031; c=relaxed/relaxed;
	bh=G+JMOx3eyLZi5m7sHNbAvGBo5rXVbzWrPNE7O72wjsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAYD1LqOgLnI0tog63UcyILHeQjQ+ityFyB/siuwYsnTO9NBr1hQ9yeeWjDcKJWK44B8Jt72qYraA9tc+itZMAKZHpjMQ30gJrJn7OSsGuYgZx8LwOPs0B2wHPd9ssTfvLyo5q5pOjcb8DWxkY1/NfPRA7Eda6oflzj9FoO8B+dEYt8/CwUxwc2z9zLJHDpuCLN8ifrab1yfiUVTQWl6FclHsoImsIQPtV75Y1cmcPAWSlxyZGKo3CgMQKLUI+DUt5q4X8IEoGF53qGXKhc4oRXjotfr3re0s2tRMgvS4spymYGjyQsuV3Nv4qq9clitGGLgBLJPP3zyGS8kEMnlPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kPLS+Sf3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kPLS+Sf3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwV4X4kWNz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 21:27:07 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Ur01086044;
	Thu, 1 Oct 2026 11:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G+JMOx
	3eyLZi5m7sHNbAvGBo5rXVbzWrPNE7O72wjsk=; b=kPLS+Sf3IiN6W+lyf2OLUX
	EihD1XfN4iAs5gKoXaJ0S3H1OKhrpS/VYYFFQ8V6sD1vU3UgYejrCvnDiJSV6asf
	uaayXo2UdwOIp/gvsgvZgKYALcuD97/fk+/yrvFUGHi2bgohnzWazdHF2UT05BVb
	nno5M71Pgg0jF8nzmpcqSksF03uPMGK/2QFRKEImKwNGTGmcaEjwCRCwtrPzywm7
	woSOJQFxFNJmoDUcp/0P2B4+NOpCBfVGdHsM3iLjOfQ0lAn09Zsqin30Nz8bG+dL
	mIcJTlRcptf4j1kHwGaasynLcLRIHLS8BO/KlfWP9jJb6obJAi9EXSNbbicbvEOA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5pthk1m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:26:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6917Hqi5545802;
	Thu, 1 Oct 2026 11:26:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsdngv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:26:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691BQmub49152486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:26:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E010E20043;
	Thu,  1 Oct 2026 11:26:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B329520040;
	Thu,  1 Oct 2026 11:26:45 +0000 (GMT)
Received: from [9.124.216.115] (unknown [9.124.216.115])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:26:45 +0000 (GMT)
Message-ID: <9d83e196-4d6b-4be1-811c-eb72527d3cdd@linux.ibm.com>
Date: Thu, 1 Oct 2026 16:56:44 +0530
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
Subject: Re: [PATCH 1/2] KVM: PPC: BookE: Disable preemption before loading
 guest FP and Altivec
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-2-sshegde@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260928110411.844582-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Kne6Ru6fHKCy0JZNtiEBfpsyQsLbFApA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfX38BxkTVeQnXc
 6Vl9D51e7Nu1f6D83yROyZbg5VKExqIogxPk7Ndj3CoY3uQiS6Qe1bobyxaXViUWVevb4vtQbWH
 uH7HZNB4PiuF1XEJRC0BnvvUp/TpkaT2T1fV4JAl26kgAgFzI9cX2niZIU+MNaWPsDvsH8ZCkdx
 TiRU43DNmGSqKQVzdtNaHuci2uu5g3r5vMKj6VPk9JKamH64ezR0dlgQACrJKT6+4k/1OLffI6N
 QRmsPrhOjFyFxVBXPHdVOW7id5MBx8Ilw6avocGq5Ih/a8pp7zYlVdzYwn6jU+t6c1XprHwCnpN
 m+XL2wKldgkRlaypZAZvrm26FFyWzNl9NTUudyLxQ687fhb9qU7VVMJ20/inuQPgbh4RJUboPpw
 5JlIcJcUvbg5L+zDioNFLElHcBU+zaQB0+aNH9pGZBoQ3yU+NPS/SncY3kGpyVHtJHcg7d6E/aq
 9Q321k9XSgtLhdUlEpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfX/2yrfWEng1un
 shyrDKrF7Coc7Qzo+K93NWZc48ETUCuhIAoToK8kptuBBrEqWhWSH/Lm0qvF2xUw8wlPKS/SMpB
 E30jHLVugjTMb4m5W1IRHI8UfLraxs8=
X-Authority-Analysis: v=2.4 cv=EY5d0/mC c=1 sm=1 tr=0 ts=6abe437d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sxMExUxU4yiBR1plgyEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 94ZXvcctEXV5iOGxujJlL6wkQSmQbPum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010044

Hi Shrikanth,
Thanks for the fixes. I had one question on patch 1.

On 28/09/26 4:34 PM, Shrikanth Hegde wrote:
> Christian reported that booting preemptible kernel on FSL Cyrus+ board
> causes boot hang.
> 
> The logs pointed that system was busy in printing below warning.
> 
> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
> Modules linked in:
> CPU: 3 UID: 1000 PID: 4884 Comm: qemu-system-ppc Not tainted 7.3.0-rc1-powerpc64-smp-preempt #1 PREEMPT
> NIP [c000000000003338] .enable_kernel_fp+0x30/0x78
> LR [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> Call Trace:
> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
> 
> Which is...
> 
> void enable_kernel_fp(void)
> {
>          unsigned long cpumsr;
>          WARN_ON(preemptible());
> 
> And...
> 
> Though irq's are hard disabled after kvmppc_prepare_to_enter, but
> kvmppc_fix_ee_before_entry enables the softmask's IRQ state.
> That causes the irqs_disabled to return false.
> Hence leading to the warnings.
> 
> Fix it by disabling the preemption using the preempt disable.
> Note, it is calling noresched variant of preempt enable, since hard
> irq are disabled. It is likely not a good idea to call schedule.
> 
> Fixes: 3efc7da61f6c ("KVM: PPC: Book3E: Increase FPU laziness")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kvm/booke.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 13ad4cf5fa71..5b9118eefe1d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, unsigned int exit_nr)
>   		if (s <= 0)
>   			r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>   		else {
> -			/* interrupts now hard-disabled */
> +			/*
> +			 * kvmppc_fix_ee_before_entry() marks the software
> +			 * IRQ state enabled while interrupts are still
> +			 * hard-disabled. So disable preemption while loading
> +			 * guest FP and Altivec.
> +			 */
>   			kvmppc_fix_ee_before_entry();
> +			preempt_disable();
>   			kvmppc_load_guest_fp(vcpu);
>   			kvmppc_load_guest_altivec(vcpu);
> +			preempt_enable_no_resched();
Would it be simpler to move kvmppc_fix_ee_before_entry() after the
FP/Altivec loads instead?

The normal kvmppc_vcpu_run() entry path already loads the guest
FP/Altivec state while interrupts are still disabled and calls
kvmppc_fix_ee_before_entry() immediately before entering the guest.

So could this path follow the same ordering:

kvmppc_load_guest_fp(vcpu);
kvmppc_load_guest_altivec(vcpu);
kvmppc_fix_ee_before_entry();

That would avoid making the software IRQ state enabled before loading
the guest FP/Altivec state, and also avoid the additional
preempt_disable()/preempt_enable_no_resched() pair.

Thanks,
Narayana Murty.
>   		}
>   	}
>   


