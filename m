Return-Path: <linuxppc-dev+bounces-20795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79280CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 17:49:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFPH40NgBz2xjQ;
	Wed, 13 May 2026 03:49:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778608159;
	cv=none; b=QJ/seL6aBiVzzFDXbalFUJoEqVKAsZe8GbywjRRng7K8z32wVbSIkhsKNQwCT+q5tTP8ZU7dSFQ5NsO5APfjd8fKjn+3t1+eM3HQhcAqKqag7F5UMQ0PGI5Y3M8IpqpGUYLo5HSniBBIhuHWYTy5Sh8GP5oO58URubEQItmvQgyM6MFTzq8iP+gyuU5wJ21PQmwz96COrGlENMZ6e6vmPApkDUtOTus6ThHQPjmEXY2oaV/GI5+aOXVZQJUCd8RE91Gri5zjtoDVMutv/QDQMy7RjVc/y/jWdxIvrsM5vgsE7vjYOH8I6xKjc/R+Dp/TAV+Rw7fk7tYwB3qr0LA/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778608159; c=relaxed/relaxed;
	bh=sgKv5WSjC1uwg0aFrRmpDhDFDivxM5A6u6vQa/XfzoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQCKJoXSU1dZmi3DnhR6ej3pQe7gnFbwNfcvE3psEmbHyBhd20iVKv2PNg4p+Et3BD18RmR2dF1CqZiY3+yMvEpaMvTSoY/o5ZpY55f+k8hTJHKOmCVrbumK9ATxeDGOjFtSMfRA6l6Ly+1EixG6Lxh29T3ebPxeDnswV8XHiQbg5d5xjWkZYQukwaYLvlrk5QN2MlPHatgDtXRWPngL5ii0SO16u/8cnBi7oFog85b7UASMyNOR0ByGXmGORJh9SmWn7o7MJklddC1J8ckjKuIuOo1Z0QaL78yLoz0nr6HXUxY0xU5MZNsBMi5KCbvGxAs75BlClGqM4QzB6Tkbgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kjwz4pEl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kjwz4pEl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFPH268yjz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 03:49:18 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCWqis2608399;
	Tue, 12 May 2026 17:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sgKv5W
	SjC1uwg0aFrRmpDhDFDivxM5A6u6vQa/XfzoU=; b=kjwz4pElgqlzMaf+nYMAAc
	B/uSprDCMEl4Mcvb7lz0esWTPKTkyNqWk80tP/WdMa5J4dvGgDTV1ejOr/nUPrml
	QCJgAa+gYOitZXj8A9858DeH0ZWbQ0n9Qt9stzmlZYZxccrFlp4ldzvAJIgLzKW5
	YTowxn1QjtgHbLBWFExXWrAKxfDrHCMFoOr3j0QSCZKbRmPu/XLbZT66+iVBVR73
	x0EU4FA8ycLi3jEGTc7TgfeuYzvNGX9kquFC0iNYhTcjM3VRaXYS73GHz0NGSK1S
	z7qKV3wv1kKfMWHhBUyWPKWdKEKGfy4bPCL1MYqQ77bu15mU1ZZZ3X2UEf3fFqTQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv54bff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:49:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdUN4024342;
	Tue, 12 May 2026 17:49:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm7ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:49:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHn46e15794928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:49:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13FF458059;
	Tue, 12 May 2026 17:49:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0002158043;
	Tue, 12 May 2026 17:49:00 +0000 (GMT)
Received: from [9.39.27.160] (unknown [9.39.27.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:49:00 +0000 (GMT)
Message-ID: <e162af5c-5438-42db-ba90-28fb439017ec@linux.ibm.com>
Date: Tue, 12 May 2026 23:18:59 +0530
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
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for
 h_facility_unavailable
Content-Language: en-GB
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfX7iJJgCfmzkXp
 +vrx61zBam3ssLK4coxeA4JfY8mTY0A2oosZz91FGrfVYBajMC4LxYu/WFPD6pjsXTqEiLcPwsO
 sGrUzfHiKMuGknL8rXzq7SunGZdzjGkrNuq/AiRxU1eG+wswpxEK8zJtP223eN6qkdh5C31fIcl
 qCx+h3AvOKNhVJzm7xqP3+Pk/xIkxvCphJmaAvDA5Hjvkd/1qlALm5gBqis4I5yGUZaOiskYKpK
 77aIlqPmaJziVgeAZKI5OFsFqscB2miTVdcRi4cbsJat2/MrFwcVl5E4LO3VmuBlmZKtRnPRnnI
 I1BoR2I8J/BN1nX+UixdkOZHNluZPNHdklDw4Y2Pqano719lHr6jNYOvRV87kJM9BlbTQXWPgft
 O96QPXRtACCsF+O5FyVwnHW7z9KSGcfPSbHFRkgrNdSNoXl+7OlLY74jFllIRnoignJ6jV0cVZK
 oQucvcPhowy03HXA2eA==
X-Proofpoint-ORIG-GUID: 4DJQc0sMcMfaDXP93UvUHagcCT1o8BKi
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a036812 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=H539haAobqM9mTtHvcoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: co6K7XIulD5N_QA1U5iXLrT8rHBUPzoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120183



On 11/05/26 1:34 pm, Gautam Menghani wrote:
> From: Gautam Menghani <gautam@linux.ibm.com>
> 
> The comments explaining the h_facility_unavailable interrupt have mentioned
> the vector number as 0xf60 instead of 0xf80. Fix this typo.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   arch/powerpc/kernel/exceptions-64s.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index b7229430ca94..2696fbbca3b6 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -2498,7 +2498,7 @@ EXC_COMMON_BEGIN(facility_unavailable_common)
>   
>   
>   /**
> - * Interrupt 0xf60 - Hypervisor Facility Unavailable Interrupt.
> + * Interrupt 0xf80 - Hypervisor Facility Unavailable Interrupt.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>    * This is a synchronous interrupt in response to
>    * executing an instruction without access to the facility that can only
>    * be resolved in HV mode (e.g., HFSCR).


