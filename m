Return-Path: <linuxppc-dev+bounces-26016-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF6FC5DF87
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 10:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQgBf6ZTLz2xT6;
	Thu, 20 Aug 2026 20:47:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787222874;
	cv=none; b=d3sfL/eZD0lBOesuCsdk981apB2C8Uy+INqTioBiWgNJdpzv2cebmt3Ob+BWF8CN1mBS60rgAP0rureXRb8ELc3uUXAA961WB9WPecr/pfsMzYQDTOImxR38qTM26LKpbNvK4SoGe3SsmennAOPb/ngxdcnvunf0VFBh0p9SEgw/lbPDHNNowVAc7E+LIllG/rV5qKxzHrURKaIDrWcUC4T7eP6n2yHxWOZYfvGrqwyQ6xDYyC8/nzjuvsZjwZTEfa0Jzb9jMspL6eIi9Rjv3fAjs3tP/Qb5GyMGDM0lewaPhRykqjY9SL2Zii5HYwQxNaORpqvA7VMDpC5xvtHwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787222874; c=relaxed/relaxed;
	bh=czT1ImPU/vWc2M0tWEKBT0LXpRCVrV75Wfn03rEOF2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohn+bS08OzH0GIY3RJpesLwPuzzCBHspNTZh/EFHs70nIkVfgfthhYuvXsmXxATOZgv0WbmcCPipPGJwn2LJk6Vy2BQNTjkbXRGUoaLumJmJJIszpiYovvYXkBfQs0vEU7V6ipo7kydv1O/P3JuMDsBVQdr26GFhCMF5cH44EPiAXroAlZK7ZsUIeMq5jbGGYHwZrEYBcZ3QfV2fBT3WrGw7uwhr0ngVZCNW8yeaFiyHz+G596hqEMeCzJ7+kmrY7KrI1qvLF3vHKzAXjn3nLUW8zAb8dAfqnG5MTh4y6UVmY/vMBKdNirrRuDZAG79JMwABI+BrTHdbFuvoCiKn3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VFp46JEp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VFp46JEp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQgBd2VT3z2xJJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2026 20:47:52 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K8psXX503930;
	Thu, 20 Aug 2026 10:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=czT1Im
	PU/vWc2M0tWEKBT0LXpRCVrV75Wfn03rEOF2c=; b=VFp46JEphllpw7qtyJNBx1
	CaVenj+Rdg6kMHAyun/leFK4fPjzBLdY43BTvCm0r20SF8NRJ17NDVEUINVxkX2f
	dujD0NQz3qQ7m0zO3xs9P02S1kxeSEsGvFiTkyy71sDmPCa47W0q7/Nr0em6wVhf
	Th7I4886yY9Ww8KFAZ/sulpfpgo8txaPaUjtuFOn/paI7hzL53leG67MGZ8+i0Am
	LsOim3vbqCPgz/COWWYtl/xy5PayeZbfKOR8IGLm1tbqtfbmwIGP5JExMBBiTmKX
	i7W3MfpeOJdrbuMa+UQRiYtW19e6zAq56CFWAMf3KMWfswNDkwVI+e5cosZ43Txw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu49j7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 10:46:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KAfGvU024130;
	Thu, 20 Aug 2026 10:46:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ynsek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 10:46:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KAktPu46072234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 10:46:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A9FA20043;
	Thu, 20 Aug 2026 10:46:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8EA120040;
	Thu, 20 Aug 2026 10:46:41 +0000 (GMT)
Received: from [9.39.17.85] (unknown [9.39.17.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 10:46:41 +0000 (GMT)
Message-ID: <99bdc3e0-0e0f-4cb1-8747-dd7667307492@linux.ibm.com>
Date: Thu, 20 Aug 2026 16:16:40 +0530
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
Subject: Re: [PATCH RESEND] sched: Convert paravirt_steal to new static key
 APIs
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: Jiazi Li <jiazi.li@transsion.com>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>, Ajay Kaher <ajay.kaher@broadcom.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <20260819081207.12150-1-hongyan.xia@transsion.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260819081207.12150-1-hongyan.xia@transsion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a86db23 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=3xJz9W2bAAAA:8
 a=VnNF1IyMAAAA:8 a=iox4zFpeAAAA:8 a=xzwhdZQ7njCJ2XY4-I0A:9 a=QEXdDO2ut3YA:10
 a=amiGZ1mxdzcEAW_x1qlF:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: 1wZ5c2qM7g5x0jx-qb5t7EiwBQISCVhp
X-Proofpoint-GUID: itVss8-eLfuaCICc2HK-kMCuGgzSwFvE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3NyBTYWx0ZWRfXy1Knef7euqva
 B2wMTxAUFMf0GbqrSemw+AgaY+wNIewR8/vNhiPmdrebwSaAtFgbUClfT7lyMMabKF1jdmhCukv
 nr1v7az3rtSi3DUGh3ib1xdiKCYVnZg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3NyBTYWx0ZWRfX60/6Dl3nOmKx
 1lgDs9d2yIy0QyPoRMAQMzaFP01pLEWEulDqKdCZ3F6qDr3NEiEADGM2eMQnstQbmSYnYcBwNjK
 hYFPSUus//RGGLcarRg+E6axxBj3cxk7gBG2T8OjN97OxqZ9rI5pI4vUVXhXILTmckLXOi9a4I3
 MoyHW222X4NoFlq4ynf22eXvKMiPfG/Xu4Q7UUfJRau6RKD4izhXUGu12jnr6O8gXDaA3aZRAOx
 MuuA52c8OIb1esLmNTU4vQce+tqTAWrEo6EbROCul8IF1KNHGDNf/cl8nGs/R4mOfrjSsH3UgUC
 QEfOV3KYChX2RlYM8p6C+EHa7k7heWKVeKCTp/8zCebWTMfdNHtOjUgI9gRkWPhGSC2OMKPO5sR
 VflLI0qnlEsop/LaVZCG8Y9aXymFW6vJu2Q1kpkLrY+WSbBzqGsJpBBazuvASI6CZb6TNG/I2Gs
 KijXc6TfURnVr9wKn/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200077

Hi Hongyan.

On 8/19/26 1:42 PM, Hongyan Xia wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> paravirt_steal_rq_enabled and paravirt_steal_enabled use raw static_key
> APIs which are now deprecated. Use the new API instead.
> 
> No functional change.
> 

FWIW, looks good to me. One minor nit.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> Acked-by: Juergen Gross <jgross@suse.com>
> ---
> Changed in RESEND:
> - Separate the original series into individual patches. They aren't easy
>    to review as a series.
> 
>   arch/arm64/kernel/paravirt.c           | 4 ++--
>   arch/loongarch/kernel/paravirt.c       | 4 ++--
>   arch/powerpc/platforms/pseries/setup.c | 4 ++--
>   arch/riscv/kernel/paravirt.c           | 4 ++--
>   arch/x86/kernel/cpu/vmware.c           | 4 ++--
>   arch/x86/kernel/kvm.c                  | 4 ++--
>   drivers/xen/time.c                     | 4 ++--
>   include/linux/sched/cputime.h          | 6 +++---
>   kernel/sched/core.c                    | 4 ++--
>   kernel/sched/cputime.c                 | 4 ++--
>   10 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> index 572efb96b23f..30bf61d031eb 100644
> --- a/arch/arm64/kernel/paravirt.c
> +++ b/arch/arm64/kernel/paravirt.c
> @@ -157,9 +157,9 @@ int __init pv_time_init(void)
>   
>   	static_call_update(pv_steal_clock, para_steal_clock);
>   
> -	static_key_slow_inc(&paravirt_steal_enabled);
> +	static_branch_inc(&paravirt_steal_enabled);
>   	if (steal_acc)
> -		static_key_slow_inc(&paravirt_steal_rq_enabled);
> +		static_branch_inc(&paravirt_steal_rq_enabled);
>   
>   	pr_info("using stolen time PV\n");
>   
> diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
> index 10821cce554c..e8965a3f8082 100644
> --- a/arch/loongarch/kernel/paravirt.c
> +++ b/arch/loongarch/kernel/paravirt.c
> @@ -308,10 +308,10 @@ int __init pv_time_init(void)
>   
>   	static_call_update(pv_steal_clock, paravt_steal_clock);
>   
> -	static_key_slow_inc(&paravirt_steal_enabled);
> +	static_branch_inc(&paravirt_steal_enabled);
>   #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
>   	if (steal_acc)
> -		static_key_slow_inc(&paravirt_steal_rq_enabled);
> +		static_branch_inc(&paravirt_steal_rq_enabled);
>   #endif
>   
>   	if (static_key_enabled(&virt_preempt_key))
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 1223dc961242..8dcbc4bb7025 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -852,9 +852,9 @@ static void __init pSeries_setup_arch(void)
>   			static_branch_enable(&shared_processor);
>   			pv_spinlocks_init();
>   #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> -			static_key_slow_inc(&paravirt_steal_enabled);
> +			static_branch_inc(&paravirt_steal_enabled);
>   			if (steal_acc)
> -				static_key_slow_inc(&paravirt_steal_rq_enabled);
> +				static_branch_inc(&paravirt_steal_rq_enabled);
>   #endif
>   		}
>   
> diff --git a/arch/riscv/kernel/paravirt.c b/arch/riscv/kernel/paravirt.c
> index 5f56be79cd06..9c13a6f1ea2a 100644
> --- a/arch/riscv/kernel/paravirt.c
> +++ b/arch/riscv/kernel/paravirt.c
> @@ -116,9 +116,9 @@ int __init pv_time_init(void)
>   
>   	static_call_update(pv_steal_clock, pv_time_steal_clock);
>   
> -	static_key_slow_inc(&paravirt_steal_enabled);
> +	static_branch_inc(&paravirt_steal_enabled);
>   	if (steal_acc)
> -		static_key_slow_inc(&paravirt_steal_rq_enabled);
> +		static_branch_inc(&paravirt_steal_rq_enabled);
>   
>   	pr_info("Computing paravirt steal-time\n");
>   
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index 34b73573b108..f7ab9e7902cf 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -328,9 +328,9 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
>   static __init int activate_jump_labels(void)
>   {
>   	if (has_steal_clock) {
> -		static_key_slow_inc(&paravirt_steal_enabled);
> +		static_branch_inc(&paravirt_steal_enabled);
>   		if (steal_acc)
> -			static_key_slow_inc(&paravirt_steal_rq_enabled);
> +			static_branch_inc(&paravirt_steal_rq_enabled);
>   	}
>   
>   	return 0;
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index dcef84da304b..d3dcd64f22c2 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -1052,9 +1052,9 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
>   static __init int activate_jump_labels(void)
>   {
>   	if (has_steal_clock) {
> -		static_key_slow_inc(&paravirt_steal_enabled);
> +		static_branch_inc(&paravirt_steal_enabled);
>   		if (steal_acc)
> -			static_key_slow_inc(&paravirt_steal_rq_enabled);
> +			static_branch_inc(&paravirt_steal_rq_enabled);
>   	}
>   
>   	return 0;
> diff --git a/drivers/xen/time.c b/drivers/xen/time.c
> index a2be0a4d45b0..a02d48a2aa68 100644
> --- a/drivers/xen/time.c
> +++ b/drivers/xen/time.c
> @@ -169,7 +169,7 @@ void __init xen_time_setup_guest(void)
>   
>   	static_call_update(pv_steal_clock, xen_steal_clock);
>   
> -	static_key_slow_inc(&paravirt_steal_enabled);
> +	static_branch_inc(&paravirt_steal_enabled);
>   	if (xen_runstate_remote)
> -		static_key_slow_inc(&paravirt_steal_rq_enabled);
> +		static_branch_inc(&paravirt_steal_rq_enabled);
>   }
> diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
> index e90efaf6d26e..694126411dfe 100644
> --- a/include/linux/sched/cputime.h
> +++ b/include/linux/sched/cputime.h
> @@ -182,9 +182,9 @@ extern unsigned long long
>   task_sched_runtime(struct task_struct *task);
>   
>   #ifdef CONFIG_PARAVIRT
> -struct static_key;
> -extern struct static_key paravirt_steal_enabled;
> -extern struct static_key paravirt_steal_rq_enabled;
> +#include <linux/jump_label.h>

nit:

This looks bit odd to see includes in the middle. I know it is including
only if necessary.
maybe worth an unconditional include in the beginning?

> +DECLARE_STATIC_KEY_FALSE(paravirt_steal_enabled);
> +DECLARE_STATIC_KEY_FALSE(paravirt_steal_rq_enabled);
>   
>   #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
>   u64 dummy_steal_clock(int cpu);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5c07d53e43b5..84d090581a08 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -795,7 +795,7 @@ struct rq *_task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>   
>   /* Use CONFIG_PARAVIRT as this will avoid more #ifdef in arch code. */
>   #ifdef CONFIG_PARAVIRT
> -struct static_key paravirt_steal_rq_enabled;
> +DEFINE_STATIC_KEY_FALSE(paravirt_steal_rq_enabled);
>   #endif
>   
>   static void update_rq_clock_task(struct rq *rq, s64 delta)
> @@ -834,7 +834,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>   	}
>   #endif
>   #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> -	if (static_key_false((&paravirt_steal_rq_enabled))) {
> +	if (static_branch_unlikely(&paravirt_steal_rq_enabled)) {
>   		u64 prev_steal;
>   
>   		steal = prev_steal = paravirt_steal_clock(cpu_of(rq));
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 06bddaa738e5..f16970ca81d0 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -255,7 +255,7 @@ void __account_forceidle_time(struct task_struct *p, u64 delta)
>    * occasion account more time than the calling functions think elapsed.
>    */
>   #ifdef CONFIG_PARAVIRT
> -struct static_key paravirt_steal_enabled;
> +DEFINE_STATIC_KEY_FALSE(paravirt_steal_enabled);
>   
>   #ifdef CONFIG_HAVE_PV_STEAL_CLOCK_GEN
>   static u64 native_steal_clock(int cpu)
> @@ -270,7 +270,7 @@ DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
>   static __always_inline u64 steal_account_process_time(u64 maxtime)
>   {
>   #ifdef CONFIG_PARAVIRT
> -	if (static_key_false(&paravirt_steal_enabled)) {
> +	if (static_branch_unlikely(&paravirt_steal_enabled)) {
>   		u64 steal;
>   
>   		steal = paravirt_steal_clock(smp_processor_id());


