Return-Path: <linuxppc-dev+bounces-20443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2694CD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:32:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8sFK4BXJz2xSF;
	Tue, 05 May 2026 18:32:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777969925;
	cv=none; b=dtY02+WHjt3vOD2Dy8afqsn2eVyJYsuCXBBMOKQGdEawK3DKYsu605DFD9UqjeF1cfucaElj19vtKVE0L8vuzv1AJC1WoslZcreEcNZGB+cBgmRmxFQA8aeRpjmhire199VoOAmaNcp2l+g/qxmL5dbC1ETTtGYhFoULatNl3Et+tG0eU7jWF2hAegmPyil/OqcbcJbxtQl0hwz2tMOiyfah75eckfOC9dqJwehIFLlhTWrPx44XkBM6gB060SmqRMkPqa8oBKtZL3/mbeIDxubFPxsYkn1CMqdjoXOGXqZzVpq5FpQ4+gA4jC1ly0pLVN3FnW3yLHwSTr8SMSd5ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777969925; c=relaxed/relaxed;
	bh=eaJj1ZjQaCtE8Ym/FuUd6FqlOIOFMMoDDBlh+ytlNAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cf34er1DzUrg5qDojfRov0J5oC4LJefeazKI0EpUUxftz6jspc6TLZ7MA1lONBN35Tmc6+qqSrKn1KvkmTUTRyATVYsPZqN8WPe29BaQ6WuyvajWmFu1XfyjceCaMXQpusAoQMJ10TfEivfzTz6ZRB0SndV9ESGNTwufrJ4nLXUlwXDrcrCXD7YMDtykFWV3BdvAhS2T03B0N53akT8BbGR90y+ywwZHh0y5tQ7UgDdleD9rrSbrqighcmvjcuVKiqT4yaHZIAjzJVltLMh2PtAIAu2xK9fifbViSvPvAmAAMI4+nEqDGqnxvfNq0efKVSiANuNhIXoyWjEYGPwjow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tX7P9zZs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tX7P9zZs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8sFJ0frrz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:32:03 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644LUNgU1302390;
	Tue, 5 May 2026 08:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eaJj1Z
	jQaCtE8Ym/FuUd6FqlOIOFMMoDDBlh+ytlNAc=; b=tX7P9zZsjgsUJ2NG8mhw+R
	TUgwE1cz+1pYQ64UwJFn8MHG9PxgFq3ULSE+c9TjP34/J6KmYRpVopK2iqa76ba2
	YQCQ268n+gbCN8z84Uadu/BmzGR1IuZykp6TEEaB44qV9oGnFeXm6GPS82JHpMl+
	0ggap5HsOfeTAmaRGOI/DGPCmTHarReI5h4UUoNVk0PiujifolKbGwsqnko6ymqG
	WwBN9QThnx9r1A8JONRnGkhUGmSBiDqi9iFDI2kmxrkPds7/vL5M6DUa0vNbe44b
	u1Krx/2mmdAulAZER7U5Kj4dCEhOGKOPfD+nvm0oOVrsQqq1EzOFlDfgJJPvdmdQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7aqpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:31:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6458OSH2018104;
	Tue, 5 May 2026 08:31:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq8wb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 08:31:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6458Vns926280564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 08:31:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE81D58055;
	Tue,  5 May 2026 08:31:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C525803F;
	Tue,  5 May 2026 08:31:46 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 08:31:45 +0000 (GMT)
Message-ID: <8c72bee5-664d-4ecc-b4c5-03f825febc75@linux.ibm.com>
Date: Tue, 5 May 2026 14:01:44 +0530
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
Subject: Re: [PATCH 2/6] KVM: PPC: Introduce KVM_CAP_PPC_COMPAT_CAPS and
 KVM_PPC_GET_COMPAT_CAPS
Content-Language: en-GB
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430054906.94431-1-amachhiw@linux.ibm.com>
 <20260430054906.94431-3-amachhiw@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260430054906.94431-3-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA3NCBTYWx0ZWRfX9KOC+1u33PMS
 EtXmb47YOTat61uKHygQGBuv720+CIeB/qIXHyBndf1SmZIx/ZS8yoNrUqGp57qZh4KFdFRpDtP
 6yMq4T8CllduOOaM8070Vb1ep0HJgeh31pQ3NALQcG7nAk0lOC0KAI98caPd1bJC/JVICOC2Em/
 +L7L9ujJbtZGE39yXbtzx+18ND0LzarnF3WdlpaConA36Izdfraew7WsNEhHlP4mc6FWXNDO5xW
 M8auEbhmtq8whCl7wgb++3MesegKci+lFwAV7Ao/oKZfdzuQUhpY26tvXllz7OmcpLGvcjyc6qs
 eCkcO6rID/OKw8fdTENgtn2zPCeUDpBO3gLEzBaLX6paBY6iZoIrbR8rjuNar/cx//RkUyij49O
 3EzHZOL6/iQLs48Do2gontiBeYZLcWK3WaKv3CPyTmKdzxBOkYDDljzkGAQqACPqmq8/VBqK1SE
 vVA9U06UtcmRwpg/p5g==
X-Proofpoint-GUID: o59ZPpBlbnUmsti7_Mh6cxhtBfobLzmz
X-Proofpoint-ORIG-GUID: NvttF5c3fnTZWqALW5T8POHRWbpM_xXn
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9aaf8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VnNF1IyMAAAA:8 a=kGkaLfDY5_2FI7PzZF8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050074



On 30/04/26 11:19 am, Amit Machhiwal wrote:
> Introduce a new capability and ioctl to expose CPU compatibility modes
> supported by the host processor for nested guests.
> 
> Introduce a new KVM capability, KVM_CAP_PPC_COMPAT_CAPS, and a
> corresponding vm ioctl, KVM_PPC_GET_COMPAT_CAPS, to expose processor
> compatibility modes supported by the host.
> 
> On IBM POWER systems, newer processor generations (N) can operate in
> compatibility modes corresponding to earlier generations, like (N-1) and
> (N-2). This is particularly relevant for nested virtualization, where
> nested KVM guests may need to run with a specific processor compatibility
> level.
> 
> The new ioctl returns a bitmap describing the compatibility modes
> supported by the host in respective bit numbers. This allows userspace
> to select an appropriate compatibility level when configuring nested KVM
> guests.
> 
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>   arch/powerpc/include/uapi/asm/kvm.h | 6 ++++++
>   include/uapi/linux/kvm.h            | 4 ++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 077c5437f521..a38dff7a8aea 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -437,6 +437,12 @@ struct kvm_ppc_cpu_char {
>   	__u64	behaviour_mask;		/* valid bits in behaviour */
>   };
>   
> +/* For KVM_PPC_GET_COMPAT_CAPS */
> +struct kvm_ppc_compat_caps {
> +	__u32	flags;

You may either want flags to be __u64, or rearrange to keep variables in 
descending order of size or add padding as appropriate.
Also, if we are not using flags with this series, we need to document 
comment as /* reserved for future use */

> +	__u64	compat_capabilities;	/* Capabilities supported by the host */
> +};
> +
>   /*
>    * Values for character and character_mask.
>    * These are identical to the values used by H_GET_CPU_CHARACTERISTICS.
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6c8afa2047bf..1788a0068662 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -996,6 +996,7 @@ struct kvm_enable_cap {
>   #define KVM_CAP_S390_USER_OPEREXEC 246
>   #define KVM_CAP_S390_KEYOP 247
>   #define KVM_CAP_S390_VSIE_ESAMODE 248
> +#define KVM_CAP_PPC_COMPAT_CAPS 249
>   
>   struct kvm_irq_routing_irqchip {
>   	__u32 irqchip;
> @@ -1349,6 +1350,9 @@ struct kvm_s390_keyop {
>   #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>   #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
>   
> +/* Available with KVM_CAP_PPC_COMPAT_CAPS */
> +#define KVM_PPC_GET_COMPAT_CAPS	_IOR(KVMIO,  0xe4, struct kvm_ppc_compat_caps)
> +


This patch can actually be squashed with next patch where the struct, 
macros are actually being used.

>   /*
>    * ioctls for vcpu fds
>    */


