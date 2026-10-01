Return-Path: <linuxppc-dev+bounces-28644-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A31CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwV72391Xz2yYf;
	Thu, 01 Oct 2026 21:29:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790854158;
	cv=none; b=Yh971iAbHPwQG0Cimq7J4xo7mApzvgTKRfZd14qwdNOYffrHEayvui2VmyI1E6+m9hp1z4omiH5tAyrj9qXylZOTQfPdoxoC0MZDYurzVdn8vB+3Mjp1VXf+cpahu8ANRti2zJnkX4VxEZ0Q/SwOUy19WlbK1Rez4kyk/iOmgf+u3IKvQPYItuvW3wHFCxHQEQgyj2YcHPkH+vnEHQ6Y3yyvewVjYpD10WM3UO/BljFu9pMc69nm/FbAgFnqOk375D1QkwZ8P9RMr6CE4e2mfAKW6aPYgTxY54eGRj4cxUgDvgN3hxVoS30cvW9yFSQbuQ4mpx4mc6M5k2TyZuQDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790854158; c=relaxed/relaxed;
	bh=2mqT5ffLuTlAsQJJawrRUp+sTMvsiAITxlpxQQHyt38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMGRMRxwZMM0O/rsZVQD9ty4pWaJ/4R/C6n+p1ziXo0fc3M9Mr0GFaom/ADjqpwyh1H/eqRcs1L0GeNIeoZryUUYyzcrBZIrTLqoIDCzqbuqH5pKZdwdrfMldogstyayRv9GWmPnGxYhtSM70gbLvcxJq96V1oMyoAZxhaEhK75nDDPzcOU5lYCZY4lfs8HKHoKx3t4geNjwl86dnFNVZiC4lYtFA8zn7Op4/RUKEnezTeAa6xb4LKcsV0aZ5cPh5MmGxipY+QdcAYuyMIVflRiN9/z2L3UdAO5Wn7MAQhZNzLrOQx3IrgOro2B1xkpjVXo8k9Vge44s2HEXEcwsiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OtKbZ+eg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OtKbZ+eg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwV706FQSz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 21:29:16 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175i9u4041025;
	Thu, 1 Oct 2026 11:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2mqT5f
	fLuTlAsQJJawrRUp+sTMvsiAITxlpxQQHyt38=; b=OtKbZ+egwgzL0pdl+U+tJd
	SqMYCLQZ+65cjzZGcojGgWhH/y0e762CCg/uaNO/ZFXm7r3GaKI+nAbl4OjT2QlP
	Ga6OqfAyIqVJ2bH+2ayMa8VdgdGr86oA8STPpID0wff/d3UqqePyhbXDENtFB+dk
	RqYHzbyR/ebHRHwTLK/zqUGbw3//8VPFcoIVsVd6HG7guldDozDy4hSPD/u+DpKc
	m8LqEb2+EUibK3qdFspKE3MUJWIlutMU1iJBWlGMsWncbqRUsOtXKgXQWyhv1MtE
	TduMumsOjyrqoqXExA5KDnLJVYh2+UlQxzMBQ67CgKgqlYcokCIVoS/+FiNrjwJg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehpc4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:29:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BDKEY520693;
	Thu, 1 Oct 2026 11:29:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpgg2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:29:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691BSxl747120786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:29:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF74C20043;
	Thu,  1 Oct 2026 11:28:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBAD520040;
	Thu,  1 Oct 2026 11:28:56 +0000 (GMT)
Received: from [9.124.216.115] (unknown [9.124.216.115])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:28:56 +0000 (GMT)
Message-ID: <3d342788-b99e-447e-a664-8385c2b55475@linux.ibm.com>
Date: Thu, 1 Oct 2026 16:58:55 +0530
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
Subject: Re: [PATCH 2/2] KVM: PPC: Replay pending interrupts before entering
 the guest
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-3-sshegde@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260928110411.844582-3-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe4400 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lKvXAlz5IkXwsUspWBoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfXw9/+6EqeT6Ij
 C2yJNE35URdOIM/0C3lZN43tVmB4ti9s9NsrOTo3gi4fBSZVi6179T5nzsSxvaVBdbq4ekEE6rD
 KtLlK/VNag+XtEBPMtSwINVycLCmK/g=
X-Proofpoint-ORIG-GUID: jp92skmyR67JEnv7gFRpdh3c4Wyh4Ghr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NCBTYWx0ZWRfXwuxv1aiVA2vE
 +kFfLyTiMC7dJefO6jefJnav4s49FK0mUU0lzYN/ZMIyrqFu4P9Gkqwh3QINRUtMzQH1gBKgf/x
 /0Gv9YCEmtV73+f4B3gZSUeaiu9QLLiMQzRPY3ZxWNV7WAyD6OZvxmLZcmsGb3IdBXk44O3RO+i
 pg+Vtud9KcisCvXjrtetonDnkRK5ghjo97XQXBVlqTc5+UD86NRs0EeMcaZvMME8RGanmQM64Q3
 28NFMlhyEoyBp/FdmUXe2qq8m1FhTULP2S/LZlcu0IZ05ZYYuPIVQtNDbC3Y+Qzsl3nkFCZkKBo
 J+qLSp65KfRVERNy6MnfEpgTG5k/4VY+DGgz9Skky6uLDsxEeI8XWKdqT+iFJeeXL4epeMpj9CN
 2JwVXY4oJPLPLv0PZY5yOALBV8MiD3v7B1lgIEpcYi7jJDexppxdeATY8bV5XCB+yYGKQhvAXtc
 GcctmKuAmpFgbERNnbw==
X-Proofpoint-GUID: yl8-jb3vmJh9rDSn6oa1hOG0sWypVJIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010044

Hi Shrikanth,

On 28/09/26 4:34 PM, Shrikanth Hegde wrote:
> After applying preempt disable patch, i.e PATCH 1/2, Christian reported
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
> may occur and it could set the irq pending bit in PACA. When that
> happens replay that interrupt before entering the guest.
> 
> Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..847ff07c364b 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>   			continue;
>   		}
>   
> +#ifdef CONFIG_PPC64
> +		/*
> +		 * Interrupt arrived between the soft and hard
> +		 * disable. Replay it and retry guest entry.
> +		 */
> +		if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
> +			local_irq_enable();
> +			local_irq_disable();
> +			hard_irq_disable();
> +			continue;
> +		}
> +#endif
> +
>   		guest_enter_irqoff();
>   		return 1;
>   	}

It look good to me.

Thanks,
Narayana


