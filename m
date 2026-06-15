Return-Path: <linuxppc-dev+bounces-22615-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6C0CD98C5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 05:27:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdzCC4vLFz3bqD;
	Mon, 15 Jun 2026 15:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781501239;
	cv=none; b=C7DGxYzTBICd3eGvFExfVHHZkxmUDPMsQ9nOy/C7RzzMo/tiqeyr3+K4rPtYwziJ6AyWgxZZlC5CZKy9Gm1xQed1ZEVfKkEzzJYnfWM7r3z0svKbWDpLd/8QqvSI18fYtuKbg1Ok9gCc+5TUEpRL9opPNXVJPYcRZHaHvfe4sOWK7PVXilXRDRGwfGYgWo1UXqRPbCCjHaU0uNicy/9oMOGK+lfGv8fGF5mmn0lr/P7xBB/F+/sz7C9OzOmR81Ksr/wn6kMWNaIG/WHIwVRxAjBm7r09A63BHtMFQ8HMNXN/QQhEE8HQAyiyIEcA6ceYOeIQLWiaSmLWRWOJN8U4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781501239; c=relaxed/relaxed;
	bh=MTXDBWTfXt6cRYUwdTw+t527GMCbeNvBgpmrxZxDt/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2cepC9LMr0zEONbBafG3mIiXELkm64AqUpsc/MNBZ2gbUE9R9ESaCejQRBiYowvZpLXgkYQZiVAyDtjWqAMLRN9c5BvE8dZEo0hztlEe5jEsl1PIUOzC9/1wGLMr7ztWtB073+Fq4iovvs5Zg/0Ga4nHZokPl4l6G/GvdR8Imf+pG67ruXPvjTM+21IB7a7FU8X/3E5MgAnvADirVWCmMBfXlOMlVHGbSiE4q+/D30olSc2E1yjXO3tUJRhyjnxWZvSLl2PhmqSC4oViS190SZ9b0Ww0CNb4ZRApiVBsLF+3pGSLDsv38dvDsaezVzqJPaN5jaP36URs5B6bQvaHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T6NZwl5p; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=T6NZwl5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdzCB2qbsz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2026 15:27:17 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1mUk9932245;
	Mon, 15 Jun 2026 05:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MTXDBW
	TfXt6cRYUwdTw+t527GMCbeNvBgpmrxZxDt/0=; b=T6NZwl5pASScA8Y7flVAtv
	9nAgS0int6yeFvxNEoQ2qBcKbMAgjEim8OueXfVcYK9Ra6bZyLiZkKOWBjXHceeC
	5w3B2XF9UScG8sKjyOaGnbdE+Kd4wsMzVgrymq5W31plG+ETnyt8P/G9xW2mUO9W
	a8mZDUuioTIwMZrah9rkopmk+lKoPDOXox2NcgwVwiJlSiw6AnZR0VyyE4TIGeOt
	c7J+QaZeG6Z3G9Bge6eTq9MCycn2rXpF8SSznEs/fMAtks/bE9aJ2BHXZdvDqcJ7
	gqEugLlE2QZs+hgYD25YkRCfhkIeZdrNmlha7CHzZHhmH6L3x278DPpQUEiovYmg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wkxwvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 05:21:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F5JlpI029730;
	Mon, 15 Jun 2026 05:21:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjw3c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 05:21:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F5Lkh850266394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 05:21:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D7BF2004E;
	Mon, 15 Jun 2026 05:21:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DDBB20040;
	Mon, 15 Jun 2026 05:21:44 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 05:21:43 +0000 (GMT)
Message-ID: <c08eaf78-38ce-47f9-883d-5a009e768584@linux.ibm.com>
Date: Mon, 15 Jun 2026 10:51:43 +0530
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
Subject: Re: [PATCH] powerpc: Restore kuap regs during syscall restart exit
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Sayali Patil <sayalip@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        mkchauras@linux.ibm.com, ruanjinjie@huawei.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260613123831.1510474-1-mkchauras@gmail.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260613123831.1510474-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfX8pa1Z/dsU/wp
 hX+A2RMFf4/1kBaimQ24N/R20ymFoOffqIehViXy59PnigfMx0K7POAVw8L50rzATanr+CZJCH5
 cmkUrsEg966ZjUpIjvbKqQw49DqpN/g=
X-Proofpoint-GUID: ZrDr8-1oWe6NMI5_RFi6ctSV26R0G8TJ
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2f8bef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=NTBBhXH5AvtzSzspoF0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA1MyBTYWx0ZWRfXwOjsosSgUxAm
 ID68n3i+z0dzv6WFT93EgNFix2Zd/bZM/EMjI3gfs8iaZUnNm4sh2RFCbbnvOBscqIlSg7nHH/s
 txLHv9TqkNkWq3myUKdUB/Tt+CYkmUbDlIYKEah9ImIv/jxcA90XsbZqQjUosCCK3G04MC9xnn2
 bQminwL/RvbYCMc9KJ1IXqI7+Mt/vLqWa4qHBB1x/aRy4uWSPmFp4LuKmZhmXIYw+M/uxLWxdQ9
 ZhcJ4ilPMpffHzoq39hjyYFZgh8tMaAGJvW2AMVviarwP0ezPadSJ0io9MjDGPGukzaPzZlHN1I
 bH0DKmeO5hNoLQ7d4oLlsRQc9mbIQnp7OAvxnHxiahHRjOjVnDaHmSyuRvpQiKrch0Em0luX2H/
 hPHUmadqLQQwBa2G/z9MjTcwg5zz8VK3s1g9hkoHzpaLA8IWVCDORRX3BQDcg/92pU5x7dhrRaA
 nwa5ZR3Yx6Un/Os09AQ==
X-Proofpoint-ORIG-GUID: SFj63Ts2DWjLimsohPgAkDCz16C182Wl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150053

Hi Mukesh.

On 6/13/26 6:08 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> During syscall restart, we block the kuap as we need to replay
> interrupts. Which are not restored when we exit to the user, hence we
> get a fault which ends up with `bad_access_pkey` and hence crashing the
> kernel.
> 
> We have already stored the kuap values during the entry, just restore
> them when we exit.
> 
> Applies on linux-next (next-20260610).
> 

Please re-write the changelog in imperative mood.
i.e Avoid we/you/I.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes


> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Sayali Patil <sayalip@linux.ibm.com>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/kernel/interrupt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 89a999be1352..159901d6ba8c 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -165,7 +165,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
>   		local_irq_disable();
>   		goto again;
>   	}
> -
> +	kuap_user_restore(regs);

Please describe where was kuap save was done in the stack.

>   	regs->exit_result |= regs->exit_flags;
>   
>   	return regs->exit_result;


