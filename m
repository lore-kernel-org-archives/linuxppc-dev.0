Return-Path: <linuxppc-dev+bounces-26482-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F901C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 10:50:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbGbG42ZBz2xpv;
	Thu, 03 Sep 2026 20:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788432634;
	cv=none; b=dMdwouUjliLe/TzwvcQD8215A7qWhcYDHgIcxGassWWXPRVk0zm0bKVtjk+BpwAkOrg6qiVZMH12xteqZvLajRI9m7GJ0QKJYchZt2YFJTgiy7jnT8IVRHrxFPlEHq6mSiSSXMMbC+TmLrrSSkbOjEYww4iwqURFwniH/vvUZNHKWwEkKJnYsBntTM+QWkTlLcKbmtKJvFw4T8o+jb6IgLaU36TggZCygTM+goYBPzsOej/gb8OoN+DqW3ex5h4ae0S1PeP/a4KmOIXCH13vZIqLufJa0ZhYlkFT2jeApPwGDqTKEDrt6/+SXZvzS9KPUHVM1RMf5ktFj6PTaXOpjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788432634; c=relaxed/relaxed;
	bh=iZm24leahG5JFj3KBON21PICNS65Lr7a10zJpTkxY2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvkyMXtUpN4JBhqxdBpf3Aag+U12twM+czqzPWiCoWw8S/bbnlBghK5RDyWK7yFr5HRJUCmlaENTa9I8iFmq4b3m2lyEqhYA/BJ64LcAQnBxFCrNVE+gI7VCMfc6fVt3cEDeDYRU0RbSese82hJHsvHN639KQ8r2LFFFBbxVm4pXEHURnWL4ew7V34SyoxqCuBgNZdaDeHCT6WnHEdoqwCTDXtEuPmXRQfW1s9jzJzSUsWOxqBfrH+/wIVfCKBYzQUleQykOKhqvCHQnrfoBejQP0SX9ost1HTiUv9mn4KRLV9p8CEicprnqPCW2B1ud1WL2XivAlD7vRtgZJOiDNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DW9Jcq0y; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DW9Jcq0y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbGbF06Ktz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 20:50:32 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AWCoJ2789753;
	Thu, 3 Sep 2026 10:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iZm24l
	eahG5JFj3KBON21PICNS65Lr7a10zJpTkxY2w=; b=DW9Jcq0y3sp+DxVjWrDyC2
	QrlJEF+WkQHyOuYSO5JwGXm518W2KRrmp9p4/17tUtaql+of0nAV84b8lJu4eRYZ
	aRt2G4KaU0nuCjIw0FAdFTiNv/TOg2StZqDvJg6d4cAh1kSwO9QvNTkrJfHCh0iE
	SrzwA7Kl/R2S1IecbNz3KQRxt+Kp3RIy6pTjZoCG3zJPsF/mxn8LJHSwetWmvOil
	mPO2IDivy7qgtCUtZzt3Fzj71eLc5a1t4BWh3FaDVBRdYQRIX5PM+Mpq/EDe7ge+
	BRkVlalHm7BxwjQ6WkhdWZDCwpCvhkAUwYaPvXYXy9CQ67mzYSvCBEoMIO+vf62g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tktvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 10:50:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683AfJEa014630;
	Thu, 3 Sep 2026 10:50:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkf9y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 10:50:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683AoFmi43909580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 10:50:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124F22004E;
	Thu,  3 Sep 2026 10:50:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4D8C2004B;
	Thu,  3 Sep 2026 10:50:13 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 10:50:13 +0000 (GMT)
Message-ID: <d8aa7dde-4ed9-45d2-8439-f4bfe30387cb@linux.ibm.com>
Date: Thu, 3 Sep 2026 16:20:13 +0530
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
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260818035037.613186-1-maddy@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260818035037.613186-1-maddy@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9950eb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8
 a=LGVRRqk8s3OqH75BFNQA:9 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MSBTYWx0ZWRfXyguzWQL+QctD
 8nxTTwIgZlmEhxn2HbiDC0m4BNYpUPlK2AEOIvcqOPiABVtLz7tUs8LLk5Q5YnmqyeHZ/n95vKc
 a3c7nwnVWfMM5zxl3B0LQ9fZpKszQfI=
X-Proofpoint-ORIG-GUID: xe83nuCIOaX5GYNAp9_HMJWvQ707I_-G
X-Proofpoint-GUID: DjYwkipcOAcq3Cjo5QPMDmoOuBcBVauE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MSBTYWx0ZWRfXxBWmJBmongs5
 fZZERonsEY7Wup134THdVKHyzKiXFzYF/1ESosGjjE0wCRMKD/mySB8OWXHLOgK9zmwRw4pRzI+
 kcZnSCKuavGpGJqpsc5e1xWCPP2tjibL/UtZt8zuQ2vYxMtxlAjbBSTQx2KYK38NVX27HzeP8y9
 acL/aVatyCp3wKys3lhzjBt3nTui4y5pJRmes9fDyedDWPaLl/WH429v9zLnE6GIx301tjBKHPx
 a5YhjzejqAspIZ2eW9BzcfQgsXyT7dAJRgWBi4nIc5freZmihYUrQtwhjUv+pSQ55qr3kKdEiGg
 4dswQuQpHyLGPx8yavuNdgvjYTbNa0RHq5XuWF2HJBLneOebYTmSFTc1f/8zq+ji4XdNxPllxJa
 G6Xf1M60TwZAmIDhrGkTXs6tDGBAotNUeVbbMdJZnTEzbChrJa45vW7D1/oUSXiNBfat0DCNBjd
 ivTCVGpqA87aAQ3X+VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030091

Hi.

On 8/18/26 9:20 AM, Madhavan Srinivasan wrote:
> Ritesh and Shrikanth has been helping in the powerpc mailing list
> patch reviews, adding them as reviewers.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7094a616afd..e1c5e6ed5ed0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14876,6 +14876,8 @@ M:	Madhavan Srinivasan <maddy@linux.ibm.com>
>   R:	Michael Ellerman <mpe@ellerman.id.au>
>   R:	Nicholas Piggin <npiggin@gmail.com>
>   R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Shrikanth Hegde <sshegde@linux.ibm.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported
>   W:	https://github.com/linuxppc/wiki/wiki

Acked-by: Shrikanth Hegde <sshegde@linux.ibm.com>

