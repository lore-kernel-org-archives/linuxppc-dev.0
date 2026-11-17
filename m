Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B44606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcKF3Cgz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTNP0DSfz2xmk;
	Wed, 18 Nov 2026 02:36:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794929780;
	cv=none; b=ev8ViAOhgFhYxuyiIfFQlgphscnkGpLaNmbIH5aQ+ynkLgqAJW9c27N4CfvH5WzguAnhjOwUs+m91ZaPf+c0dBOjxssyXWMj5c8Iw1dvt95i9AlNnYE0r1opMQGGH3gtU+5dCkUacVzhGGGuQiSDyCFe2ICfctErGbXTlIJkz70TAImzpTikokyNYIMILG6UW0vKu8I84H5UwirkTlsTFaufdgAvraM6chr5AjHksamExX89rFWoOwS2e5JJ9cgq7m6AuuaEmzMeZxDjXLdW0ky5kcsqQi/wtdYPZ3frTyyH3CBSl8JdtKMWj9ty3C7AVOARK1W0BO8RYo+E1x5lXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794929780; c=relaxed/relaxed;
	bh=2npSNYVs8QqeFnCbwh7kSwq92z+qQL0m3NQfZzbwv2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJ4WOWGzexacZhNEAp8lfePRfE2PumVwEKCKaQ8gli2OqjmosrPSfxEWq7OTJYAUg6+1DHwWJAuAJIsmzcyfLtkL7IpqymRa6p7gmsbkzR8g38hRjCoXbJDNL0T9FGEs7+Z77DKYkpUixOSQKWqGfyJsa7Ch+hqeZxXnAoVeTBDW1zjZHd/nItZ7MFmOJk2fg6ycg1DJXSJrWvK6AYhMBdGAVyFT8CwzVtuSxG3K7lm4AFks8MUsJS51pzFQ5Vxw2nuIt6JtPY60RkCrwQG8PiaM9BIRdWmvEXBtJDr+8/TH27olQGXxIr1cUTcdDcJUlEYLsIJ4xkVuuKPYX6kpGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcKF3Cgz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FcKF3Cgz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTNN1gg4z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:36:19 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQcrC1097020;
	Tue, 17 Nov 2026 15:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2npSNY
	Vs8QqeFnCbwh7kSwq92z+qQL0m3NQfZzbwv2o=; b=FcKF3Cgz2I382VpheGQkSF
	ENxudKLBGWxivdUcndIV1+Ye6mmQiJwdUUC6F+MWTtdhVv/AO3mILfBiseox2gqm
	sie/Xu7GtCWHl5CFMAhsQiPl4rUB+5+3LYzu8xLPS70+VPNeVwGs6wvREA+mvPDw
	/StSGpiFggfeEZ5rVKx54v0gUUwHbVfZJT9PRIgTDHblZwbXtqSvgxEhQ/Iq6DRo
	SDN1k9QljsAncN0W2HzMcJz1EcjxmrgOo2E3ukmzE6otqAormM01XqDEFT5YT2Kf
	uBVPfvqCKqnZXni8vogcDiHaomT34aTeJz4k0nhW/dXyOVuVZkLmKxm6x48z3wvA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfat42ac-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:36:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFYwGZ3749399;
	Tue, 17 Nov 2026 15:36:10 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067nc91g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:36:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFa8RE16319064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:36:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72A3358064;
	Tue, 17 Nov 2026 15:36:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F45F58062;
	Tue, 17 Nov 2026 15:36:04 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:36:03 +0000 (GMT)
Message-ID: <6d067199-3077-48a2-80cc-e21352f5c837@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:06:02 +0530
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
Subject: Re: [PATCH 4/8] powerpc/perf: mpc7450: Fill in the L1 data cache
 events
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
 <20261109-ppc32-perf-v1-4-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-4-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX6l0RonZy5bsN
 Tof4GVEoRwywe54JYDXk2qwLemoaroHz1Zqt/eFxThYMzeEH+4IJGKfTrwi1g4T8mfIBhqWnGuA
 wMMiwvyjCdDAUKJE7QUH9Mt8xOlS1e0=
X-Proofpoint-ORIG-GUID: 4O-OD-z1XMFSsWnZWo_snrJIvTs2xrgT
X-Proofpoint-GUID: eC4FSpXgKRjUWDF16RBJjd7Yu8jweYoL
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afc746b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=GCOtrVCJrbrT3k62i-gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX0H3tEUhB0dyl
 jRNyMfCSxEiH3bIup+HrMO9JFjyIu9pK38qHqvDuu8DXIiFJAfkF1UoLm3/Pq7n1rAxtDuvA9Eu
 8Bsr7n0dTQYbSdlcUGhXtgSKYaW4ryNSmXXzBSPqWHpZYjnKnWiVmbmEB1FChZ0ob2jEAb858Ex
 6Jt4/elOO1sqtEl2TrOFGVu4r0K9iECG8EsyznR4VOrSiEUMvCDdTV6eGGobdVSKSb+pPhcNeBo
 ENewOvT2HuQI5jbfy8rkzpRMxm/QS3aSV27GHGpDoflpeRZSVjAnPbzDbkQOsZKn2qg2dKV0RYb
 dWzLNpX/uNzby7UrKui1NOVnUZHpgKnf+SKGFrY22vI0JoCKnwqeqYSH3/L4rAITjGVAiYSlDNY
 SOhghlkTGV+mHatOhGs/HGMc9OoiFOHTx0WNrrqBxgu9Ec/lTZpZCKILoNSGFTu+6v/s2DfVxTP
 77vAOR78Zn5GT11dMKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611170061
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 7:17 AM, Matt Turner wrote:
> The L1D row of the cache event table has load and store misses but no
> accesses, and nothing for prefetches, so L1-dcache-loads,
> L1-dcache-stores and L1-dcache-prefetch-misses are not supported.
>
> The MPC7450 has no L1 data cache access event, so approximate the
> accesses with PMC2 select 26 (load instructions completed) and select
> 20 (store instructions completed, PMC1 or PMC2).  These also count
> cache-inhibited accesses.  PMC2 select 38 counts dcbt, dcbtst and dst
> line fetches that miss in the L1 data cache.
>
> On a 7448, a loop with one store in every 32 instructions counted
> 645840841 instructions and 19773839 L1-dcache-stores, about one store
> per 33 instructions.
>
> Loads and load misses are both PMC2-only events, so perf multiplexes
> L1-dcache-loads and L1-dcache-load-misses when both are requested, and
> refuses them in one group.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
Hi Matt,

I checked the new L1D entries against MPC7450UM Rev. 5:

   0x21a  PMC2 select 26 (Table 11-10), "Load instructions completed"
   0x014  select 20 (Tables 11-9 and 11-10), "Store instructions
          completed", valid on PMC1 or PMC2
   0x226  PMC2 select 38 (Table 11-10), "L1 data touch miss"

The codes match the descriptions in the commit message. 0x014 falls
in the "PMC1 or PMC2" class in mpc7450_classify_event(), and 0x21a and
0x226 are PMC2-only, which agrees with your note that perf can't put
L1-dcache-loads and L1-dcache-load-misses in one group.

Using completed load/store instructions for the L1D access slots is an
approximation, but I think it's reasonable given there is no L1D access
event, and x86 does something similar. I'll leave it to the maintainers
if they feel differently.

If you have a quick load-only run for 0x21a,
it would be nice to see the numbers, but that's not a blocker.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah
> ---
>   arch/powerpc/perf/mpc7450-pmu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index 9890c87c58ef..27337a03ebde 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -362,9 +362,9 @@ static int mpc7450_generic_events[] = {
>    */
>   static u64 mpc7450_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
>   	[C(L1D)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
> -		[C(OP_READ)] = {	0,		0x225	},
> -		[C(OP_WRITE)] = {	0,		0x227	},
> -		[C(OP_PREFETCH)] = {	0,		0	},
> +		[C(OP_READ)] = {	0x21a,		0x225	},
> +		[C(OP_WRITE)] = {	0x014,		0x227	},
> +		[C(OP_PREFETCH)] = {	0,		0x226	},
>   	},
>   	[C(L1I)] = {		/* 	RESULT_ACCESS	RESULT_MISS */
>   		[C(OP_READ)] = {	0x129,		0x115	},
>

