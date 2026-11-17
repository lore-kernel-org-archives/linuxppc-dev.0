Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD6606A333
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GcgbybeZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTT814nflz2xmk;
	Wed, 18 Nov 2026 02:25:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794929137;
	cv=none; b=O9SE348dQzumht8vRumDOEnUcmsOSQQyYyaO5vtRB/5JHKK52i8D/ofQCL+B7x5mz+FMYj8EG7GSl0cHYN+IYwv0QQv0q5bOpWe0tqXGM24hExdS5wkdpIQ6MQeKU0pJbLpjglAYGSf6bP4uIy8AhiUWyNDDGtGrkdihkHeLDII9ODOonP7ebpZYlNOvJzMlR2RT8Lt3C7z0NAn+n3d3ZDNHQ06Gu81ecTJ/IiY6GcYc/3z7hV15H4th9zlrVEPESRe+gGWjzjsXiBh27KWLijiG5IW0XkQ2uwtuioCUNqp+SV+nH0mMC4J8O5qIPd17T+qdioF7UAgxOGh2etid+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794929137; c=relaxed/relaxed;
	bh=5gp1408bxxK/xuLwuHlpqzE34hm/cbySRiY0hc0hxic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nArBu7XunJxELapTiJTcYt7BKiHo8vyThBFd7DpdoXZFpFhX/Oxl6trUybkcSxBB32onDjrYiiZm9bkAFkG173HfewjRG/8BGZr9EXlsjUgWzx0Mc++muLxK4HVIheohQkgdhl/VJ2UdMmu4KZ32a/xSMc3L0y0bnOHDnvM08XqkcSlOlsAumM5IjxKX8LPw+7iIaunpJzKNF66WdZXAATULQjIUuMt+EXc9b8/tkhGKYGPpEvfplMGdfeMVgqpAjWNh0Smkr5uBFG8rWYDXi98w73UEqbfGW1BSf9fVP9Ov8xAph14vo5QSLwd/Rht2ngOn3xf420z4GHsOshlwiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GcgbybeZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GcgbybeZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTT802MMlz2xL1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:25:35 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBw2a71088622;
	Tue, 17 Nov 2026 15:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5gp140
	8bxxK/xuLwuHlpqzE34hm/cbySRiY0hc0hxic=; b=GcgbybeZ8UtMbm4goyodQS
	h530RGo8q80drnk86UkRHUJWrlHn12WIOJhBrrbuTkmg7/3QfPTr52SVge/f3Qjb
	BTX6De5tuiHQ3vDBhViTxkAPnOwhCuIaQ8sYI8vwXokFnep8s1dyFhnteeqRiYaT
	lCQ5QmtfRW01e+xS74XQPON1bYbFV+OM0RSQpZnQ/UmJGLgJHLvISjRSW80qdI9j
	YbJiR4NWgwV0Q7BF8SRi/zqSMl9zBz5L9ycnX5g9lcYRlZ0tv/0cWmve3NtTgIrK
	yuT1sMzaz0i35LWFNoem6zoYQLVcfEpeH1oUcLQKeNR1Uf3PFmBumx3VLNbDQouQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2dbcbm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:25:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4sp81803097;
	Tue, 17 Nov 2026 15:25:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt4u51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:25:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFPMnP28508806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:25:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8935806A;
	Tue, 17 Nov 2026 15:25:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEFD658060;
	Tue, 17 Nov 2026 15:25:18 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:25:18 +0000 (GMT)
Message-ID: <0cba99b3-a70e-47d4-8907-a2766e96e5e9@linux.ibm.com>
Date: Tue, 17 Nov 2026 20:55:16 +0530
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
Subject: Re: [PATCH 2/8] powerpc/perf: mpc7450: Event 0x634 counts L2
 prefetches, not L1I
To: Matt Turner <mattst88@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261109-ppc32-perf-v1-0-a6e8a55b3b48@gmail.com>
 <20261109-ppc32-perf-v1-2-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-2-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1OSBTYWx0ZWRfX7STq22HhTX7m
 wu9gRBeAh04r5LBSfO4FQoRfPOwL1STvQs7L5FURTAF1bnuYdkOxzJpIq6HXrZ6+PifXG9hTFg4
 VkOZ9J+VbfTJQ3bgVyf71iAfwFWoB04=
X-Proofpoint-GUID: C-Q5H_-RlKY4yPUfHKw0A1yl9h-uw0E8
X-Proofpoint-ORIG-GUID: QgTXJS450rqw20sJOYYgvFBHDbNR4S2h
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afc71e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=-9cAmcrYhhUisKysBq8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1OSBTYWx0ZWRfX4F2AXKs8zf/u
 FQcOpgrd3ctCCF1/XFc+qKMFvgevJchoscN4/VxC6w+xSEyCy2Mg+Au/WJwlRom02bQELfGBnQ9
 xLQNel3uxQt77KNw4HljTfqkjAs703ksSktYI4LR41iTXqDFJNXb6dCTdC6w6aV2sVC6PWi15kr
 gEN1wNSRtwt6zH0ICccBVwo9TS9Bu6atQ0osWrZXsrDSwpD8MAfL3WdTxq7cf6NdX8HRN7UL4c+
 BMGKEugtH4hD25WvFafkJwX48O7xL54M9rFiDpj3undnPi/xVPubhRAsT+rbOgnga5wBN0TSqJS
 MrLB+X28NMGXJTGlw8m0aoZC4vbzeZSKut1FEboMoKzQJiqaU4ZHLT5DFw7Uw5bOT5enmlzLXiF
 o/HLnjM0hCoB4wjPckZnMTeiBeOZ7v/ylD4ionOXBv29KK2t9AoMhK4xKC0ldf1R4af2ays81oX
 Rq4dEOkbKiKNVlJOPmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170059
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 7:17 AM, Matt Turner wrote:
> The cache event table maps L1-icache-prefetches to 0x634, PMC6 select
> 52.  The manual (MPC7450UM Rev. 5, Table 11-14) calls that event
> "Prefetch engine request" and says it "counts new prefetches allocated
> in the prefetch unit".  It is the first of six events about the L2
> prefetch engine (selects 52-57), and the MPC7450 has no instruction
> cache prefetch event.
>
> On a 7448, a pointer chase over 64-byte nodes counts r634 at 0.00 per
> load when the working set fits in the 1 MB L2, and at 1.00 per load,
> one per L2 demand miss, at 4 MB.
>
> The engine starts a prefetch only when an access misses in every cache,
> fetches from the bus, and also fills the L3 if there is one (section
> 3.6.3.2), so it is a last-level prefetch with or without an L3.  Report
> it as LL-prefetches, and L1-icache-prefetches as not supported.
>
> Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
Hi Matt,

I have checked Table 11-14 in the manual: PMC6 select 52 (0x634) is
"Prefetch engine request", the first of the prefetch engine events,
and there is no instruction cache prefetch event in the tables. Moving
0x634 from L1-icache-prefetches to LL-prefetches matches that.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah

> ---
>   arch/powerpc/perf/mpc7450-pmu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index 564f6dac3a00..5a882d934645 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -370,12 +370,12 @@ static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>   	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
>   		[C(OP_READ)] = {	0x129,		0x115	},
>   		[C(OP_WRITE)] = {	-1,		-1	},
> -		[C(OP_PREFETCH)] = {	0x634,		0	},
> +		[C(OP_PREFETCH)] = {	0,		0	},
>   	},
>   	[C(LL)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
>   		[C(OP_READ)] = {	0,		0	},
>   		[C(OP_WRITE)] = {	0,		0	},
> -		[C(OP_PREFETCH)] = {	0,		0	},
> +		[C(OP_PREFETCH)] = {	0x634,		0	},
>   	},
>   	[C(DTLB)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
>   		[C(OP_READ)] = {	0,		0x312	},
>

