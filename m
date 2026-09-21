Return-Path: <linuxppc-dev+bounces-27833-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC27AC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:09:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHVp2kv4z2yfH;
	Mon, 21 Sep 2026 19:09:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981794;
	cv=none; b=HVbzsbOVCJ9iz0n21jnjrXgoaJOBdt0WfA4n6qC4izJMDlF3Xtyrks5uBoFDgzEMZRDSm1fWR5KTjwBFwWNpq2Zapqyjv16dBlyF/MEZZNh8b8qNwfwU+s7hUefdmBUagwlNxbbu8u5vdx2IUaq1E13kau+tud30abTZ7UcUIw4dZn3BSMVcKaT5AdNYkgp3hitFDNK8GhAHQrbYIJndXJfPmZnB6cZQ/SPEyRR26b/RjJeclHT1GUkW3t5lXqpCZj2ZBxDEXG9r+VpvGdhvjy8mM/VVWyODdYKhGch+SKxUEoq0FZKHVlZY1V/TJ9+wiaeyd/39Mk9g7YcDpw/Exw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981794; c=relaxed/relaxed;
	bh=4ZIsYWUVn7guBQOBOTbKiEq7QO0teNhYsfMnJtt9g80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxSCMjrlXcNkKd9wUEogBR0MHI2Hy7q3QTG8JKpxqjo6debb/BxP+ULMQ80dlw+w6ndwEA9wEpxbYemCLcwvZ99QfxqqG6N+dPG1Jz6RS1u5wRAiLhhGuUnFQJsDIVhftLKi9Vu8ncaIfFyrvO34Fb6yRPyIFQ3H7QQkzGQPhqiV/Avoa21yAOQCGTiYJK1B7UrRMDd0SQKs8HtpOwtjC7hpdcw+xYeAfpu5QhKacI1VTQGk0EQ6DBXEuio6uPFz0avOSqvEpg4VZrLil55LVKrhaFqiGpiwbr4orbRzh79dScA/swmRFLRoCjkdfHFQnLWDYk47fnWciZsWTIw4ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lDpJ5m46; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lDpJ5m46;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHVn3jHRz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:09:53 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZZmB3856783;
	Mon, 21 Sep 2026 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4ZIsYW
	UVn7guBQOBOTbKiEq7QO0teNhYsfMnJtt9g80=; b=lDpJ5m46AV/NUrV8otXfLy
	IVe0gEViJQF82mSfydssR1fcRXPZTkh0V2d5sqRX4gBqRArkYXDxuQr62Hc9FYp1
	qa0bGiuIxmHxFaOpl2u1sa5m8vGcCM1QPpx/TsWYxNZz/U/ovsM1uwkRu82XDSRf
	LqK9kW6SzxXLieTnRhvn1h+iSJdR0BulWIdIAEWef7L+wzadaB6ytts2cFnW6exc
	c0msvcZmr8UCLLwcQxfLNRgGnJFL9BKqPXIa5ZbyyEhuwC0TEMvH8OpK34uP0FK2
	cpB/yjlrtYP2xDOz1NqhzfP47Tip4FZHA0J25jAJU3n5vugeLX893alrC7SR2Xfg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgq7fv6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:09:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HUsR924413;
	Mon, 21 Sep 2026 09:09:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qq4r54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:09:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L99c6329426126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:09:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8709520040;
	Mon, 21 Sep 2026 09:09:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E07382004B;
	Mon, 21 Sep 2026 09:09:35 +0000 (GMT)
Received: from [9.124.208.199] (unknown [9.124.208.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:09:35 +0000 (GMT)
Message-ID: <aed4e6a7-1678-4e27-9091-d621d3fe1535@linux.ibm.com>
Date: Mon, 21 Sep 2026 14:39:34 +0530
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
Subject: Re: [PATCH] KVM: PPC: use assign_bit() where applicable
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260920022618.3145649-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab0f455 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=8AirrxEcAAAA:8
 a=VnNF1IyMAAAA:8 a=Nid3tJT5lt5-er1BLS4A:9 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfXw9Z+eF+SZmPD
 +Qoaa60PKvIkNklTODfHdllh5WfKewFYmCLfylfWncUtePFdB8b5akdHv5pu/cE3/K2QipcdMNL
 C2B9s8FXFlb4T1zFZYXX/zsxUJ91OJFk7CeEOJ1S1kc0uTVJUBrjgw52vLhjTD9AX4kCfBnc1S2
 6PO86dtSWTu2IZsrj25XHK43cynoVKt81mbBjlGSzgohCo44bY1mPI9v7dFDRRzHU9lTkLxm2+p
 Us4NSJyfKodPMJHDe7yXtNZdBeEFWvM9uW14bZh/O1EgTe9csU+dUGwdF2Dhsv+3qXNK/iM/H/P
 x+vXk12Fnpii0cUwfSqfhOz8y6DLvzzYAJ+4m6NKC/YTw6OCohxi5ftQaQkmpqAsJQQDGhA2Y8R
 tlbwRgRXhZ9ahAN+bPbJWWvMywAVhjcbkQoJYKM5WNJWtVIIjvzicV+BDBIUSJMkpTu7rdLx2ZT
 932rfYPYwLkfDLzb/Tw==
X-Proofpoint-ORIG-GUID: 26wd-gAuxDGHB4yJx885WrLhHeVZ4hEv
X-Proofpoint-GUID: vVT54iSS5N2yMyLnpAkFyrMWLjO-j_IU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEzMCBTYWx0ZWRfX0NbGaXikVMbw
 yfvcadrd2EEx9jtjqCqWhhbKD0FPcPn0T/iAJr16KfRCrwWxZmNj/pWBFlrTg7K8vy6255Idkb3
 KNkBDKLC85yvaQVePk91/dG30rZIjjI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210130

Hi Peng.

On 9/20/26 7:56 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/powerpc/kvm/powerpc.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..a567b63a5f1f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2210,10 +2210,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>   			break;
>   		if (!kvmppc_book3s_hcall_implemented(kvm, hcall))
>   			break;
> -		if (cap->args[1])
> -			set_bit(hcall / 4, kvm->arch.enabled_hcalls);
> -		else
> -			clear_bit(hcall / 4, kvm->arch.enabled_hcalls);
> +		assign_bit(hcall / 4, kvm->arch.enabled_hcalls, cap->args[1]);
>   		r = 0;
>   		break;
>   	}


Just ensure you have covered all such possible open coding where applicable
in arch/powerpc/.

