Return-Path: <linuxppc-dev+bounces-21938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D84CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 03:55:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVYlD4Q41z2yRF;
	Wed, 03 Jun 2026 13:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780458952;
	cv=none; b=YNbZS0mKUYQwNU8g/UFmiKUuWvViAkhqBfsd+h/kB2gXYM3ynqY177RxHJOunJSbFoOc8Dmzz922HKu/+LcYh84YYPAgw43klFWWsuvUumBs+51+BnxmYjXFGgJXJMESW2HwVp1pWSx8R0xtrl509Kvm05HjkVTWJBcI2xuauSVLX3hXYSwm2MXbWavZB2dLYp4GYxq3ocWBXNME6kgTwr5T+yisXJKseZRIsQQ/Iffo3jHvtw8PXqT97vIpdMoaWWYPuUfCLh5c889usYIEdqeKOkoqILdOAn2/oXeeIKbiSLCfsZVi2pG82kVvNxBjL0Anq+QnIJg4W6UEXYirgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780458952; c=relaxed/relaxed;
	bh=UTe67gRysya+FLFm9n25Sp1pv8SAKJcGXgCz46hg4d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7c9x0VUSxxcqPUsd7UTnx+ZCVc3POyVqZytkoRbBccj47z2MCjuNsACmjPaO4uz7wxMAm2EHchGBoKdAAmMwvzmYaL4GWczg3+QshAI+B5VwASDvCMvjmw8n9jrtQCQ7+S97HdJzY+Qtn4mP8vtWZvsO9m5qyi4JwlD0kjtcsGZBcg+MKfAdvQFXyvsQcammYDR22bd02i2oS9B0mVRbau95OX8EPG4xOUtdlej8G5RjZvg/QjicWF6dGOzTWBSE0tKgPtdoopxKBJYNGgpPOSkd3reFc2ZNOnrQS8U3mr1Dj1HDJucccWbx+uQwalUGaa3wt017TqiPmn2JiW3yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DxDaIYnX; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DxDaIYnX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVYlC5C7tz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 13:55:51 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H6M9C2667091;
	Wed, 3 Jun 2026 03:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UTe67g
	Rysya+FLFm9n25Sp1pv8SAKJcGXgCz46hg4d4=; b=DxDaIYnX9vfO/py3fbulZP
	JSRmue2ckKnfHOV/EidnGFyY5mdBW00NJDCdXEp4IKc/y2j2GxeV7mxPs0lOBGpc
	ehKGDy0cZmGp2gwfMITl2CIq1NGy9l4PRr47YWHf4amKdPNgt9cs0El+7m+FfDCH
	dKccPkSghQ87DAIcSAr3S7QBQtW09142mLWTUaH6gJSUycSeUPilVJi7RRYNlum3
	oi4KiHOGc8IXkF4Ya36bvix53eFJ1nehDqc7bjS4NcheCi1CPNZzUdGMk9sNUuji
	ijRt35uJvcqPkmBEvfxJLQY9jXVfg2qCYiHfiA+Ty+cSGdG7JS75RmWhHWe6GQug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht8fww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:55:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6533dAPC031302;
	Wed, 3 Jun 2026 03:55:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegp5e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 03:55:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6533taDb54460692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 03:55:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 729982004B;
	Wed,  3 Jun 2026 03:55:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C29B20040;
	Wed,  3 Jun 2026 03:55:34 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 03:55:33 +0000 (GMT)
Message-ID: <7f616ef5-3e90-4ddb-874b-64ba98267192@linux.ibm.com>
Date: Wed, 3 Jun 2026 09:25:33 +0530
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
Subject: Re: [PATCH] powerpc/prom: Remove redundant early_init_dt_scan_root()
 call
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Aditya Gupta <adityag@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20260418091250.134111-1-sourabhjain@linux.ibm.com>
 <ah2KsuPcOu8tVOXo@shivang.upadyay>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ah2KsuPcOu8tVOXo@shivang.upadyay>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: imuYLwH-oIc-o3Sc3c7fz821VaZfS2jQ
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1fa5bd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=_Z-rJtdiRSFCPLDzg7YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDAzMCBTYWx0ZWRfX7t7kJO9s47V9
 L8o9lWM1BpcYU40W9PxDW9O2hwS+c9D6g+MxkjjBOugX3IbV5Wac+hALxaXH5oLh/zLBzEVP8TP
 TCMQtPrfqeHLYSoHvjcq8a+x4LsmOJ+3vHdC8wkCVcIgfT219oVbCsofhrh9PdBfE+i9GjTK0Pf
 nOmq8woYpck6gC8n/dN6JHwBPw6hh2dF77QjbymUIAiYWn5eRN5ixzCRCNv955C3j7c3arImo9k
 mmv0Z30WyuOf+4HGG07BVVBSd/uH7awMJJkXNkwU3Swti6/lqkOfGVFEL02t3VzmFCsNHx0wfBi
 tQCUyUKLTg3MPaYxqdHxg2Pi/BDrIJjyu3pH/sMi3jozE1rNR9m3SecXUGerkdCWpkORLToooA0
 38Wus8YUcMWXLhsjmrJwk6zBIpKSsH4lFBS1aKJTz4y5cygUAuvld7ZmOgezzvzt0F8uBGNwo/+
 HrOqiPytkV0RdK4/QPw==
X-Proofpoint-ORIG-GUID: WIZrBEHjAeUuzxO5yjbSuP36AiiD4Eln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030030



On 01/06/26 19:10, Shivang Upadhyay wrote:
> On Sat, Apr 18, 2026 at 02:42:50PM +0530, Sourabh Jain wrote:
>> Commit 554b66233623 ("of/fdt: Scan the root node properties earlier")
>> moved the invocation of early_init_dt_scan_root() into
>> early_init_dt_verify().
>>
>> early_init_devtree() already calls early_init_dt_verify(), so the root
>> node properties are parsed before reaching the explicit call in this
>> function.
>>
>> Keeping the call here results in scanning the root node twice. Remove
>> the redundant call and rely on the invocation from
>> early_init_dt_verify().
>>
>> This change keeps the behavior the same and removes an unnecessary
>> duplicate call.
>>
>> Cc: Aditya Gupta <adityag@linux.ibm.com>
>> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
>> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
>> Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/prom.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 9ed9dde7d231..d218c8cc1f73 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -824,7 +824,6 @@ void __init early_init_devtree(void *params)
>>   	fadump_append_bootargs();
>>   
>>   	/* Scan memory nodes and rebuild MEMBLOCKs */
>> -	early_init_dt_scan_root();
>>   	early_init_dt_scan_memory_ppc();
>>   
>>   	/*
>> -- 
>> 2.52.0
>>
> Hi Sourabh,
>
> Patch Looks good to me. Ran a quick boot test also.
> Feel free to add.
>
> Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>

Thanks for the testing and review, Shivang.

- Sourabh Jain

