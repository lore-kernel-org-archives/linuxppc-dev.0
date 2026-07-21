Return-Path: <linuxppc-dev+bounces-24588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7912BC44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:16:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4BZt3QfZz2xjd;
	Tue, 21 Jul 2026 19:16:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784625382;
	cv=none; b=GStO5Lflw+DgbUhVK07uG5EbfG+OOEjM29hsXJ6Yvyljvk8467k+Ycd+8WyrgU5eBuOPppMNWTK+IMel25og2sCnk0FcCye0yxoFBNyjVrD2i6QuYlU+rfr6Nesnia7jugreT7nvoSSmrk5vXFNshPJVkTVqfJRyB0MBXJaxA94cT+IbDluJh6wyORuLdZr/fJVdsSW6XZKpIehRdu8TeoZ4VckoOXewuecR5s0+43vACGi6Mk2czd6ujy6V7sNA6cEMJQVQpF2XW2jsf7mmzPYZ7Ro9m4Cyl0ote7LHUqcwjTfqYbI9nFJUJG5h4whgITV0dWBUjAEcRKIYZF+uWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784625382; c=relaxed/relaxed;
	bh=fHLWqUgFHQNKvwXtyU54BaREnD+CKEefOneTW1ZDfwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bEdN0nb/tXjauEoWJgRKXvwmC6nZ/Zob82fRwwk2p4/tNnSlVPPhkSBkixicNCYqBVDI26cpuZ8pom/X0PzI6oFR13l/Zd2ZHgVPKZ0OM8dXuzvgy6MzBXEomUToSls75NH/NSZHkUkrGbVw4aS5vTs6oTQ32JDSaTnoNMk0pHpPsGPV9Vppr2aL1yDaDCY37euGJ1u80DOvvHYoeaELf419bg64YeyGc15zOGogegrQoZElKIid2CrUW+0Q5PoUrGc0fkZXo5jYlpBtbD4FI4nn5Yir5HHIva/dOnrvGB244iyy1B3/9YizmMtaARkg8iBaP8gqoAkxV2FKbSHs4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HuURaZfv; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HuURaZfv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4BZs4NWGz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 19:16:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNE9N33463514;
	Tue, 21 Jul 2026 09:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fHLWqU
	gFHQNKvwXtyU54BaREnD+CKEefOneTW1ZDfwQ=; b=HuURaZfv3xbO9U5xwlEZCZ
	RTMsT7AfK6aOB5U285EoQPi24W8zFDNOVQ8oOijoCm/dsTqaO6e4NrCV2GFjFlkE
	hi5ySI32cGiv498GJRp771Qg94mlht/U0kLVdiWUpk+Yg0YW+yDthAjoEaYDJnG+
	z903+21WUOObICEOj8QfzuRCqc+9qBZ4V0wD1GfnybIuwVumdTUw9EhmNICyZGhJ
	AcziAIlZzz/hBNuHhPxYzLG/IqlqMC8z5UrJ+y/TZVGXr1h8psQOVI/gCLYLx/mL
	nefdeNDdkEafSD+rM9iM24dSVXBlwthCWRmxB7w743ummX/NDzU4FiScHApLx2Yw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g3dbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:16:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L94Zbp009041;
	Tue, 21 Jul 2026 09:16:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah1j71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:16:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L9G47G52167030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 09:16:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D03058062;
	Tue, 21 Jul 2026 09:16:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 406B85805A;
	Tue, 21 Jul 2026 09:16:02 +0000 (GMT)
Received: from [9.123.5.176] (unknown [9.123.5.176])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 09:16:01 +0000 (GMT)
Message-ID: <32f5998a-6ae7-4556-a78a-760e78d18e87@linux.ibm.com>
Date: Tue, 21 Jul 2026 14:46:00 +0530
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
Subject: Re: [PATCH 2/5] powerpc/msi: Treat bitmap size as allocation failure
To: Yury Norov <ynorov@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260709020312.133977-1-ynorov@nvidia.com>
 <20260709020312.133977-3-ynorov@nvidia.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260709020312.133977-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfX3r4Vpo0ZDr2x
 BP/VVnVTXP+H9FDB4Ju+SNlDanO3YCE2GtBLgW+YK5eDnbL/6D25AMqYPNHMtCvFIiUKYUcWwbP
 XTT7+jdaKnMTRODV+ShvKMh4RFGvEhn4uz8/aV2+T9q6Cw4T9HPcnUkHd6znAC1nD4QiO/mgBnA
 l8VeS61sFpx6IzghCHkW3G+jDoP1xJbFDSbFf8yJQuoCtQiq+S/hDWTsqhaL944EV6+g9KM2k4g
 tuzd6kOWhjoSMRvY2bIcspcCesxFERvi20IwlnFltiDhXSHGAR0HtMCFEmzlEmzQ/hUpi004ruY
 keQ0A+uDY07b4Hb6SjWgkufpvEJaB6FJrlW5x1Aq89FfQhCXpCmP/W1QxDH3r49qSSs8RDCpx+h
 BoEArOsxAvj5Tw7Zvt5eT2eszsGmu0jj7EmLadTyhkCEEAmUsogjnQtitqNr/NHHaVl2OqZ2ANI
 sWM6GQewKA28dT8NMsw==
X-Proofpoint-GUID: IHg63qAuoW_1YE4aMagp2Xrd5jCCD2Wc
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5f38d6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Ikd4Dj_1AAAA:8 a=phWOeXBnrK0COOzqZscA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5NiBTYWx0ZWRfXyxH/b34QOE6N
 wsk1JCb6CudjsphRXGBeREiBCsMCYkb0RVdU/M8nQLZiBNcqvhb/LZYD8ab3U+8YtZPHNUFKvpY
 zkRirPTvOnCek30feKFgOtljjJSwwJg=
X-Proofpoint-ORIG-GUID: bFLdXb6l0KnV9cugHfs5JQ10xHlbPWnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210096


On 7/9/26 7:33 AM, Yury Norov wrote:
> bitmap_find_next_zero_area() uses an out-of-range return value to
> indicate failure. Check for values greater than or equal to the bitmap
> size so the caller does not depend on the exact failure sentinel.
Changes seems to fine.
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>

When reviewing this, I did find the return value of 
bitmap_find_next_zero_area
to be unsigned long, but we are casting it to int. Not as concern at 
this point
this will be an issue when irq_count exceeds. May be a follow patch is 
needed
to fix this I guess.
Maddy

> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   arch/powerpc/sysdev/msi_bitmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
> index 456a4f64ae0a..2f38d4b41ad3 100644
> --- a/arch/powerpc/sysdev/msi_bitmap.c
> +++ b/arch/powerpc/sysdev/msi_bitmap.c
> @@ -21,7 +21,7 @@ int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
>   
>   	offset = bitmap_find_next_zero_area(bmp->bitmap, bmp->irq_count, 0,
>   					    num, (1 << order) - 1);
> -	if (offset > bmp->irq_count)
> +	if (offset >= bmp->irq_count)
>   		goto err;
>   
>   	bitmap_set(bmp->bitmap, offset, num);

