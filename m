Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8733B606A31D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N3EK8n56
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9tRp5J41z2yFQ;
	Fri, 23 Oct 2026 17:30:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792737014;
	cv=none; b=ZPIZe0iGeq3TytmDWdCScrunfVu/IBTvaoZE4WnelXvJPxlgKwm64WjMrMxMXiJBGzgRu7EBIl2sRsAFLYDCaSk/UN/cfnBG9/06XXeCucO1DvuYfkkvceNOCOIgiQayWT8eLon1hO7j7mZZCJS+miThTJDb5Ww5eQFB4oEWmy130PFbY1cFAAiidexBWJFKjZXGNtTxuHxfIGyqT0ZDV3kmPPuWCjcUJslCv4mzj5A1vki1cXOOf1LP3WGTvC9OuIFUTD+bnP3OCoAv3DWslzXv25/AnyGdRAXkTz539PvV1c/gm95VcJnHSbx/1C6BT+yrAimUcMNpu/w8A5Rv+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792737014; c=relaxed/relaxed;
	bh=7lw0H2LbzbhjiWgEPqMCL4TOhF9iPd7aDQ7ovzInLvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHEM800PUDjLIrFA4gXMvJ9aFB5mqj9c7b+qBbIcZ1yAbSeFUM6x3jJuf7y4ej6QPzXEbPGbQLbyy9WxX1K5ZolbTEMKlqx/TWNVKCovwEWoyts1a4u4oFOM3MAs/QpO4ih/9Cru4PFYH2sxHC1Ka5J75oSSb69lMy0g5fpvWlzktgtGtS45ICBFRRRMc6wDfJlx9vtxD47+ecPlf3ZZWGIdx9FJxHaiu/dJWjhbw1KYKBY9qfcdsZyanZ1ec3o1dKUwOa7LZS5e6dItO8TAg0RmongDJV+9X//os8CrNONdfWhK77PMQKgxCx/taaDTiWx9hl+9MFBJfKNCVb70bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N3EK8n56; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N3EK8n56;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9tRn6Lhrz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 17:30:13 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N1EHmQ1491335;
	Fri, 23 Oct 2026 06:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7lw0H2
	LbzbhjiWgEPqMCL4TOhF9iPd7aDQ7ovzInLvE=; b=N3EK8n56efyEOfTLB3TQkh
	4vbK4qtDmaok9+QVHruAVq5K2467NmBlFQKsSweRapYUBDy5A5WOtRF09ZiRDdLB
	KK13PpfkbCJ0yeuQ/lhPRKPVnGhDZtx9JY1yZ+x5sbFH/8Mvb61gnosb9Y2+vZ+8
	ZBwjfQYgfmVrc/gyfODHUdUfhh1jkgrw7C0vA1iNgOGDY0ToTyaC/tUMmq4oZexg
	xRdFL1ySzbhgl2ozH2ut0d48C0sGbDUZ4emscOP+5yKJkwsmgXW8j7RKjXDTDbyk
	bxhu5w4Nsb0DcgQV/A2yDcsa0lyvTfZS9atB72BRkI9crtGCDlDq8rLxo4P4W/yQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5akj2g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 06:30:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N6H01U1410598;
	Fri, 23 Oct 2026 06:30:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck48db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 06:30:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N6U5KK31195436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 06:30:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35C52004D;
	Fri, 23 Oct 2026 06:30:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0102620040;
	Fri, 23 Oct 2026 06:30:05 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 06:30:04 +0000 (GMT)
Message-ID: <7c4eb75e-2e11-485e-8438-eef24201c567@linux.ibm.com>
Date: Fri, 23 Oct 2026 12:00:04 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update EEH maintainer details
To: Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>
References: <20261022101342.2962384-1-mahesh@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20261022101342.2962384-1-mahesh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfX8cCCYzOVS82R
 ikVDunJSeGxMg/IDAH1RYP9cRlpv6SOlEHmj04zqlvqmqg4qqgsD99pRsm8dItz3+49peC4SFpq
 Dq1xELWprjyOQ7OAWSkzphkbGWzi9DM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyNCBTYWx0ZWRfX3PpE9oU8MPV/
 Rm6MXnqn76G5GZXbt9L+oF2F6FGooPbnXsWYuqCzu9tc2FhARmt68JQ8pR6+plG2cEZUuqlETI2
 S84Dz/Vy43uuv8iFDCCsaL0zgRIllx37uVUc0LzPQHCX4FS4p9KdTPl6ruIhl4yh472iRgurj9O
 JwE+L0cdKdZ+XvkyBO+wlmeDjULy2Ntuv+Iw2Wb3i072gKG9LCesvRDYLkySCbs5sRrRj1jttD8
 sU6QWf1rfuZJ85pf2EudZ51+d/m9K9+fWG62m2qPqvrvpqTD/dUdgijTRCTvYcmpGDnHqcyXDMr
 Yf6SNGd+UjNnCLjJjJqhmBBTh4Pn+qgHEb9PTcBhxmuFnoQ+EehALyw+KjzVrkwThgTeBlLAyvD
 FyWLQIEj7Ct5jD4IhMuSdfja3w54C6A424ixpfOOwW2Y27nT8Ipc6FSg4KpHhV0RDrpUo+i/rSq
 Vm8bcPJWsAEdpa8vKLw==
X-Proofpoint-GUID: otMcKrtXBoG6j6s_8lt1njHJY2BnwiFT
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adafef3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=CjOHaDgk-Ss2aPD01hIA:9 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: otMcKrtXBoG6j6s_8lt1njHJY2BnwiFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230024
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 22/10/26 15:43, Mahesh Salgaonkar wrote:
> I no longer have the bandwidth to maintain EEH. Sourabh Jain has
> graciously agreed to take over as the new maintainer.
>
> - Add Sourabh Jain as EEH maintainer
> - Remove myself from the EEH maintainer role

Thanks for the trust. I will do my best to maintain and support EEH 
going forward.

Acked-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>
> Thank you Sourabh for stepping up and ensuring continued support for
> EEH.
>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9fe9c2a39b..e7bc0bb7353d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21092,7 +21092,7 @@ F:	drivers/pci/endpoint/
>   F:	tools/testing/selftests/pci_endpoint/
>   
>   PCI ENHANCED ERROR HANDLING (EEH) FOR POWERPC
> -M:	Mahesh J Salgaonkar <mahesh@linux.ibm.com>
> +M:	Sourabh Jain <sourabhjain@linux.ibm.com>
>   R:	Oliver O'Halloran <oohall@gmail.com>
>   L:	linuxppc-dev@lists.ozlabs.org
>   S:	Supported


