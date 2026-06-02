Return-Path: <linuxppc-dev+bounces-21916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC40CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 17:12:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVHSb5GpLz2yFK;
	Wed, 03 Jun 2026 03:12:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780420335;
	cv=none; b=B/DwAWkvEoEddpXqWJ0AHHtBHTGDIYPxFCyZvKAeZ8TK3hocn/Pl1uzYIc29cLBIBu4yJI3CVdqOL69195C31GTe8SnH54b0rykhre3GbxGrQpmgN3oIqoYq1WZt+zPFVgrTx0AWYQaCpQ6tzrd0YH6nf8GPZ96nE0E2mdjUlBYVkV/FgKPWsglSwX3lc6HAimEAUUPiZxfefsD2edQYeRryGFCO57013bd/OVHIjcGHohpNo8cHjf4XqPhf+rL5iEDJ+8NIxIppiu4dJ8CO/NSQZ/Rs5FIyOPR9QtjFnT1kGEFutusOykTwnWpGIzs0r+i23G4vVEwr9zQs1sTrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780420335; c=relaxed/relaxed;
	bh=YufuCSz70Yt9WriHh9ZEcr2U6703/0q6s7xt1awImM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UdoZuWtetpz5cmVcCZ43B/J/+2lOXl5Yk8oVLPFhzAfqpa+bCyv97b/Z2g5DyYliLJAiUrRcmoXhSxdbiMWkiTSOabREdb4qa0BgVCkdhaLIrw6W4yaO4rWIOzUHO0BM4PMWgSUMnasWjiE5oOWryFtA6SIg2bPvLrMsuokt5qhm9USk9ql8vEmnOePIiXplDees9TjF3GPEe2TP3yVzoe6EFM7q6hOp43vsGPnRJRNndwE4LcFu9aX1Q6+UAMtjL325AyjPhSz0M+mc0fbtrI3iau4XUsy8ZN/ItumpGCxoIbcfqJxhxpsXT8dJ5WnY7x3Gw3rLtiSWZT0eXGVgKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k/AJ600g; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k/AJ600g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVHSZ2KFBz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 03:12:14 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652ECD1B3013843;
	Tue, 2 Jun 2026 17:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YufuCS
	z70Yt9WriHh9ZEcr2U6703/0q6s7xt1awImM4=; b=k/AJ600gL5C5TG0nxuHRJ3
	69AFoDyWvZW33XTHcfflZaf7N0fsTmsQdm7w1Z5qrdkI+S25z5mGu8pdtWRB+J2w
	hi0F7d5WWR5kNzj+nu9ac4sGxSGfGUTNoGMwVT45KB3blr3I5yujDFopycV2JPy0
	RaWSABsMprcJx5u0qcHv0ORWqJtDIXFwmWpu56pruayWljy3KwXpFSHqJDyLgK2F
	qwPqrbWKnsAWlj6qZXYdPjKz20jo6ITxsyqaMF0AlvQ3QmTY8odUthKJ3Q2/MmYt
	UFFwHIYe/COrUxuGnQDznrIDxUKLmm2q+TBVgoEMgwMiKYNqzG+W/t1ZIu8wtScA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht6k62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:11:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652H99QH018646;
	Tue, 2 Jun 2026 17:11:56 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwybys2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:11:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HBsWH21562096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:11:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC2D258045;
	Tue,  2 Jun 2026 17:11:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA19458050;
	Tue,  2 Jun 2026 17:11:50 +0000 (GMT)
Received: from [9.39.22.192] (unknown [9.39.22.192])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:11:50 +0000 (GMT)
Message-ID: <24f1fa9b-0a7a-4ac7-92b8-beeffba0f2d9@linux.ibm.com>
Date: Tue, 2 Jun 2026 22:41:49 +0530
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
Subject: Re: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be
 used with KVM
Content-Language: en-GB
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
References: <20260602121706.8423-1-gautam@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260602121706.8423-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Rtv5OuCeLvjfobDFb5h17ywAR5MugAZ5
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1f0edd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=CVMXPQV5iiZ5r4vfs10A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2NSBTYWx0ZWRfX7gINC3/mLhqn
 QzrX215nBn7FHHVG/KIjeG13puvP95fO+nbtpmuRXA+io9ozEjwuNpCRPye58A+ezGGq01TToJF
 /YH+dH5I9PJxePOMcfeFO9Tlq6g4MlqUoYNEI2rx9lO4/3O4PSBaLOnigzD2LdlMjSfNtMVBCvn
 cVD6xyGDw1p5ao64r8BcOYigXTrptxPhEWcC6iLTBy9KGDlwpCgiTHg5XcZYMNc9ojnHyT0GHAr
 5gei/jN2SVOtFyuGjUon71sXMAnMK8QaUmirpQ/c4NER0FQjkqkbqBTuiHWqmZpjbI52nX/i3Yr
 eYBE3P++QPvOGBqsTbsUMRUnOcTFxhD9XTfBsLtQQ6RrfSc7S2tF9IDSEgIgvoPoPiahpaqUtF0
 9uSq9wwdcTit13u6HRB8uP8EdkQZJLeFlHED5wuhCxsXLt9uARguHaqnP89uN3Pii94x8ivnCoW
 t7BtKaoPW8mS7dSfl5A==
X-Proofpoint-ORIG-GUID: 121pq332B56rG7m0DzarHzZJWv2xT6oS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020165



On 02/06/26 5:47 pm, Gautam Menghani wrote:
> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
> 
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
> 
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> Cc: stable@vger.kernel.org # v6.13+
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v3 -> v4:
> 1. Reword the patch description (Harsh)
> 

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> v2 -> v3:
> 1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
> (Sean)
> 
> v1 -> v2:
> 1. Rebased on latest master
> 
>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index f7052b131a4c..74910ce3a541 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -154,6 +154,7 @@ config HV_PERF_CTRS
>   config VPA_PMU
>   	tristate "VPA PMU events"
>   	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
> +	default m
>   	help
>   	  Enable access to the VPA PMU counters via perf. This enables
>   	  code that support measurement for KVM on PowerVM(KoP) feature.


