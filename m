Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF89606E224
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C073yJYy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jR4J26rKzz2xjQ;
	Sat, 14 Nov 2026 04:39:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794591554;
	cv=none; b=KkdeqHjLPVd6WwTiI30snJtporYg1YYh1rEaNboC2tx4F73FaTxUuR/R/kHmeXUek/kYpGyERpZVLpAUxvcs6nqCz0BAmSdZdDI/EJn/ryscHc04iGvzDT33b5VV6qaWWXOlt8EFEotYhHT0Z4m7SXC3Bg41QztHUO5LMLzLJhCrzgp8Y6GfldShi5EIf0Qc24zORC/1VSOGStp108jRQdMYyIJWFJz1ITd33HZeZesXBBarKc7aRqsTZhx0Cq8ePJkBUJaH6ncLpbJg09HuboPCpsjMevqhTGhAw5J6u4c5WICypc5dQI27ZfU1FDPgCQig7ZatMmL+KdniYQkBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794591554; c=relaxed/relaxed;
	bh=DgYC/Shj+AnWGDzWfubZGcb4ncX/t5B6/82xucLJWBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbKDyG0MgPggZyESBz5J4JTtaMQVH2tq6cdU1GNk21G8MyZdceHCzf9qb6IYErlLFG6S3PRjygv7P5rcuzOySzUa0uJ4HrKgWb37zgIsrcBOm8bMbKNVitqCy+a7XG+wOW5yO7sqjS+wau7H/3diaUmIBWh1JwUwUiMQalyaw1ZpDy3D7mN7XyAV8I6H3SjrGIbq9TqvGcjbsra8EKA0tY9b1OvHbVJw9PfTaS/jv3u2h0oZCaX/w3v3lrlvMfBuH+8AxfauW9ICV7aHPxp7wlQ6H05BbAjZE9tb+dchYHPkH8XIy91jd1bpOpBbdYpqR5Nqf92dMWVKzfe7zgw6xw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C073yJYy; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C073yJYy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jR4J14FVmz2xjP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 04:39:12 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFiFKT3453491;
	Fri, 13 Nov 2026 17:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DgYC/S
	hj+AnWGDzWfubZGcb4ncX/t5B6/82xucLJWBo=; b=C073yJYyGrqEQLUD1T0R9Y
	v4Hsr7PJX9rPQR7ZF5x0GTyfUtMuGYtS4aGroYHRRA1xSmLRVQAFAUZqsFtDasqX
	q+TVpGGxtpSWvoo5oXgZ6/XSINQVkAW7dDq/xmzzp/Pz2/Bk36JNBY+34v6yRmFw
	Gr+fMG34nB31JgQBmIKnEXZzQE6opoBT2AeeoL56K+Q7nX+6sUNnGFSgQCZ6TByi
	sNwV6sS5B+hnNfXSDO0L6BlA86HrlA7Sx3xxPlTADogbOStUXPMivdYRRteQ3PX0
	Qd69ZlV3NWr+8ARYZwb6Q+h9itxlge4bA0ltsh0YGiXrBWSy5gYyyud1xnwjvpuQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvbk70-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 17:38:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFZ9qx2591951;
	Fri, 13 Nov 2026 17:38:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0tdb4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 17:38:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADHcCMC18743816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 17:38:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7419D58056;
	Fri, 13 Nov 2026 17:38:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73BD558052;
	Fri, 13 Nov 2026 17:38:08 +0000 (GMT)
Received: from [9.39.19.12] (unknown [9.39.19.12])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 17:38:08 +0000 (GMT)
Message-ID: <1044b867-fa18-4654-baf7-dd1e3a5562ef@linux.ibm.com>
Date: Fri, 13 Nov 2026 23:08:06 +0530
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
Subject: Re: [PATCH 1/8] powerpc/perf: mpc7450: Event 0x30d does not use the
 threshold
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
 <20261109-ppc32-perf-v1-1-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-1-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX1WjqdzGMhl+d
 dsLjorh3n9jYyPPd8+qGbreHjQlHg/ne6hVo0OK5mH72CNAOQnC8E5LgYYwwbxE+AQiepOMhGqD
 8lEkSCzy8iqpHlWD3yCZk3RZz414XYE=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af74b27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=hDsOEGxpxML-9HYuKHQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zRp01WlEldbXA00EmhnGquY-fwOzkQXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2OSBTYWx0ZWRfX9g79SpQM13CW
 dPW2fnRetwPCTplQan3x2yw2hnKUfy7D/8joJG750/1W8eMc4+xjixEjrOoAQa6dqFJmKkGWPd1
 8qea7FeO7lX5y163+fF5+RnDIgAvghT5TXA5bNoHqFURM22ZMmbN6I6sIoOn6GM+/IYkurZqiPI
 bEy3rl/ohZ6Teocy0EGEGwX9wYV0xpwloem/4Ud3toF6FVJf5P5dWppuKS8epgtbRODOk9brcKd
 CuAez2MljpKib0UnVxkXRTnVaA2wedOPi2Rd7RjoqhbtKgWAXU6YaZ8XgdPQjwLuwTVDm42vkOr
 SrTb7hDB+qmmlsKGBmyuHtoO1m8vVdbJFNKpLZQlLIN6I7/pZtyt0XhztIKBLKywWAHiozrS5Cp
 UJqwaceDfdHQGksCXDI9aIFSM8ZAQQwGB0PLyZcsm4YsypX/Ot3GxVcLzu6CbOxIg7l9CcZv4Ax
 aJaMX+au8BFMWiudnYA==
X-Proofpoint-ORIG-GUID: 6OtaJej2DiWzj4lLA2YIq5wssIsFOIqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130069
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 7:17 AM, Matt Turner wrote:
> mpc7450_threshold_use() reports event 0x30d (PMC3 select 13, FPR issue
> queue entries) as using MMCR0[THRESHOLD], and the comment above it marks
> the event with a question mark.  The manual (MPC7450UM Rev. 5, Table
> 11-11) says the event counts the valid FPR issue queue entries each
> cycle, with no threshold.  PMC3 select 12, the GPR rename buffer event
> next to it, is the one that uses the threshold.
>
> The only effect is that r30d cannot be counted together with a threshold
> event that uses a different threshold.  Drop it from the list.
>
> Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
Hi Matt,

I checked Table 11-11 in the manual: PMC3 select 13 (0x30d) counts valid
FPR issue queue entries every cycle and has no threshold. On PMC3 only
select 12 (0x30c) and select 17 (0x311) use MMCR0[THRESHOLD]. That
matches with the code change.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah
> ---
>   arch/powerpc/perf/mpc7450-pmu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index db451b9aac35..564f6dac3a00 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -65,7 +65,6 @@ static int mpc7450_classify_event(u32 event)
>    *	12b	Y	PM_LD_MISS_EXCEED_L1_CYC
>    *	220	N	PM_CQ_EXCEED_CYC
>    *	30c	N	PM_GPR_RB_EXCEED_CYC
> - *	30d	?	PM_FPR_IQ_EXCEED_CYC ?
>    *	311	Y	PM_ITLB_SEARCH_EXCEED
>    *	410	N	PM_GPR_IQ_EXCEED_CYC
>    */
> @@ -92,7 +91,7 @@ static int mpc7450_threshold_use(u32 event)
>   			return 1;
>   		break;
>   	case 3:
> -		if (sel == 0xc || sel == 0xd)
> +		if (sel == 0xc)
>   			return 1;
>   		if (sel == 0x11)
>   			return 2;
>

