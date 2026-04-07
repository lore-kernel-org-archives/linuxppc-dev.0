Return-Path: <linuxppc-dev+bounces-19448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73401FF5104
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 15:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqqsy716Kz2yZ3;
	Wed, 08 Apr 2026 01:31:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775575878;
	cv=none; b=Hw2y4yloD+kkMIvoch9vWyusZQgPiWudF9+zuWCsiF+FrWBCdgcLCHOoeKtunPsuutGUDZNVoeFIdrbE0n/D9v8Y8MS2lCBVJrclQtgRDeVgCfPIWbCLS2pRG/i0hVUzw9Uy1cvcJyie/WpoO0hiFXDBnsXDSldkBEH4UsctspNovwcvqv+ikBja6gHnubPH09i7vn/oM6oqjN8Y61yFs/fbc5/uMvSm84hwyAyvYOtE2dhOptGq3WHMDHGhZTT+Q4ot/YsIBSGA7pjpzUB36YjfWK+TZ/hoiyQ6GW3QwQ5vfF6q8sw+6xzIZy/f4zsQwX58dHUBxquhz4EsOsYRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775575878; c=relaxed/relaxed;
	bh=DKShMzUixgQl2xbM9z6mJi1AiZrr9z6eMZ04FMv8+5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jr4EfQPVBYeyP9+QKA17hK/w3Gs0suNt6OuD4SJZ9NWaWgxaEsGuh25Cdz+XHln//WkCfFbkyOq1xUAXNefideO0lqdDAe2K3bVrz72mZUo9GgtzE1hnGExrZhesVKGfFxk+9bKB9cltnqUBMF+lWvSfGe1T4p5sm93/Yy1m0TWw+VNjP6UXcA8zVUGhUIcQa9Op9HkUu/qt44b0XBrrLdniZxdphpEoICllpaNsmcpknFPiKpehPJqQ0/Sjri2wOmci/8hXb01TBw3MWqQYGXNwM1yJBxSQkouVgfUsOiaXGmWDR4IFLkNE9QrMXarH0Dqbx+W6dcQvRqjPDAaLjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XHLETSw9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XHLETSw9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqqsx5Ws9z2ySC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 01:31:16 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637E3EsZ2302533;
	Tue, 7 Apr 2026 15:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DKShMz
	UixgQl2xbM9z6mJi1AiZrr9z6eMZ04FMv8+5M=; b=XHLETSw9DGzb06IUoO7+O1
	8gj7zSicsX63dA2hcEJNwRDPPlCmUP4pDmRdIKeTNE0wEgIgwrKt7eFqUlMa30Km
	r73Q9AQK28bpj387RDEA6a78anPYiduIctw2a1y4l1cNUjuSvDWV0th5cTvvT0iL
	83B4uQ5UEryufbvGj++Ix/9DbUBCfY4UJKootrabQ+ygKYraCja6g7CS8oUDLFqI
	GydLMaKS22Nr1zIM2J4ui9j/7Gzvs2CX9zaw5jlQfFRVwQ4RMnhMI74pa+kzZMCf
	ERILxz4VKGIHh3UmCkJpYV6ZjBG2+fzr0KhIf6AT2FOeclBonpzAFdC4kht28Amw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fbt15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 15:31:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637Eapsf014356;
	Tue, 7 Apr 2026 15:30:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg4kr48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 15:30:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637FUtcU62325066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 15:30:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC11320040;
	Tue,  7 Apr 2026 15:30:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF0962004D;
	Tue,  7 Apr 2026 15:30:52 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 15:30:52 +0000 (GMT)
Message-ID: <99c837d3-7b70-425e-b1e3-e4e5361eca5c@linux.ibm.com>
Date: Tue, 7 Apr 2026 21:00:51 +0530
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
Subject: Re: [PATCH] ppc/fadump: invoke kmsg_dump in fadump panic path
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>
References: <20260407054341.308710-1-shivangu@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260407054341.308710-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MCBTYWx0ZWRfX8cNrYR+8/kVa
 nKeOZexSBGjPRIkSwHlbx2HBhDQVeHsG+9lf6+ZefIPYKV4u87hJGEuBdH+2otHENCm+jANP95M
 +GUisM5yejA717IwWDLhAY1tt8SoOx6IZd52GsDFo5w9qqpWeRvulXLdh/PUNM6aQg2C/twc4hC
 umuZSWo18K73p2WtdP/DlEwHldrkdcwyUvrbVrRCw3QkrzVR7EXQwZHq3RHyC5BLX8fStl4MRDL
 5WKUf2eKx3ieyF0Bgc/msbWvyLnoPKLjhFFy9SEnSHiiHZA8CSbmq0lI9P0GCqGsbv78TAxpiTx
 YGhBND1qJWusKLc3L+r2Wt7iQGjZWGelNheTeKMfeUUg6Bt8Iymz25PZGz80AGoVAKyB3JnifUz
 QAZiPxUYwYTZgIukldJ5962CZx7ZLgbab2O1qpmA6p7Nzuqht6Ac5Vl/5fX/iG4eUaG/bFcqj8n
 dZ/UvgRqbkAt8hnDg8A==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d52334 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=PivQjEIRNmcMcH2j5rYA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 7MGC2XpGu9oHODopHJiYfrqtoI_B7J89
X-Proofpoint-GUID: ApRD9NDA92HH_pJiyMn_cXnqV8BH4wqJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070140

Hello Shivang,

On 07/04/26 11:13, Shivang Upadhyay wrote:
> fadump is registered in panic_notifier_list and gets triggered
> before kmsg_dump_desc() in the panic path. As a result,
> kmsg_dumpers (e.g. pstore) are not executed.

Can you emphasize why it is important to call kmsg_dump_desc()?
Because fadump captures the full memory dump anyway.


> Invoke kmsg_dump_desc() from the fadump handler to ensure
> kmsg_dumpers are called during panic.

Can you please add some command output from before and after
this patch series? It will make it easier to understand the impact of
the changes introduced.


>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reported-by: Shirisha G <shirisha@linux.ibm.com>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   arch/powerpc/kernel/setup-common.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index b1761909c23f..c329b071643d 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -68,6 +68,7 @@
>   #include <asm/kasan.h>
>   #include <asm/mce.h>
>   #include <asm/systemcfg.h>
> +#include <linux/kmsg_dump.h>
>   
>   #include "setup.h"
>   
> @@ -748,6 +749,8 @@ static int ppc_panic_fadump_handler(struct notifier_block *this,
>   	 * If firmware-assisted dump has been registered then trigger
>   	 * its callback and let the firmware handles everything else.
>   	 */
> +	kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);

Can you move the kmsg_dump_desc() function before the comment?
The comment was for crash_fadump() function.

Yes, panic() passes the reason for the panic as a string via ptr. So it 
is good
to pass the same to the message dumpers.

As sashiko suggested:
https://sashiko.dev/#/patchset/20260407054341.308710-1-shivangu%40linux.ibm.com 


I think we should call kmsg_dump_desc() only when fadump is registered, 
to avoid calling
it multiple times. If fadump is not registered, this can be called twice 
in the panic path,
first here and then again in the vpanic() function. Checkout 
should_fadump_crash() function.

The second point from Sashiko is about introducing something like 
crash_kexec_post_notifiers
to give users the option to call message dumpers on the vpanic path, or 
on the other two
paths as well (system reset and die) when fadump is configured.

I think this is not really needed because there are already existing 
crash paths hitting crash_fadump
(system reset and die) on which kmsg_dump_desc() is called directly.

> +
>   	crash_fadump(NULL, ptr);
>

As of now, crash_fadump() (which initiates memory dump
collection) is called through three different paths:

1. System Reset
2. die/oops
3. panic

We call kmsg_dump() -> kmsg_dump_desc() to invoke all message
dumpers on the system reset and die/oops paths. The only
remaining path where kmsg_dump_desc() is not called is the
panic path.

panic() -> vpanic() -> panic notifier call chain -> crash_fadump()

I think it is good to fix this path as well. Thanks for the fix.

- Sourabh Jain

