Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBDA606A32C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BrZugXWL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTD06td4z2xnZ;
	Wed, 18 Nov 2026 02:29:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794929344;
	cv=none; b=nCGIXnQBQRIIkIadkQaMNy1zYHg3DuwdIkkdHYKL549MWqYFKztIvA92bMBtRYIVQnXo5h/XSFCLwHp4H/KE6c1Ok7xcZEzQqLIIwf/a1nU63gfueJ4rsrzeUtiC+xzd4IiUNBCRW0HJvCg4T6PCozNiE8GhjG6qnY9W5Ip5p2JOEGa6BqjtjWYuPB/pqha25qhYNUgypsnaooHw2vgvA+/jqyOD/wZiCMYAqfdM+x6mQ1FQgL+TZOECieROjeqBmTX1jyeLQ1FK72cNFUjIF4sSZhPx3NXTQODeHLFZ75VyOT8znCH9qlG11Edy7qXzN0UkvHf3e1ytSkclCx5ZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794929344; c=relaxed/relaxed;
	bh=EB9+I5KUftdZLro0JCP3SKYaVdWDK9BQN9RrhiTqPM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HzCLLbg7jv/cZbbu1vfVy535F3FDk1btFbVaz3LrtsEg5vLUGZXlDnA8N8Rl4aIfqvbLm6v9SVKOc0UZz5ypv9WXzI+FX/dHdWcZcCa9LUAPrYOheyCFrE+y9CrKf3LZkrCIdWR2wNlQ+XqDJ9GVqx3u1VBiVMiO0Mlks+wtm22dHCVu3xYO7xOzKUWu/HQDzRZGir1+TnsoyNvhO3DvR1LpvMpIsqDwWV8clY7AtF/0EEjh2DHf3LbB9BXR2ILAWB5/3utnTrC+3pRRlV3gyYC1CRZADcJr+4nKVYRCKVkKqjw2rbdfjzSZ/4H1DcV3cFx4vUjRWS5G4D/G5nRHqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BrZugXWL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BrZugXWL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTCz6F2Cz2xmk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:29:03 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQY5R1096939;
	Tue, 17 Nov 2026 15:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EB9+I5
	KUftdZLro0JCP3SKYaVdWDK9BQN9RrhiTqPM8=; b=BrZugXWLnis40mMYtmHBtl
	Drpf8lruTglAHU1rH7iBRDedOsnmioa/1iS3tZ6Raxo/2u8G5DA5wbHE4g2Jq0lC
	6UifJgW/IM0pFeWIPAPamToFsoavvH6joPYXbvyD9yg7X6ruj6ygUCawYsCs7FvA
	Ol/hZkjKRZvunDx/BsFJgN9Ey/Dzsfi/jn/hQTjx/ejLBD0Z4+YCFjZk81SVOgTM
	o+CZPrZL3ZcgBDQHCo6s0JVPFffP4p/QDdawDbCp8VidTZrYk4rp77f7GwhW4d+r
	DwUBq6Iu56sTUMqGmXJVdGSdiVUwJD9Np6hB/AAp3UIfS+Fhs+aJm2MqZLA8+WHQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxfat4154-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:28:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4sqQ1803097;
	Tue, 17 Nov 2026 15:28:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt4umy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 15:28:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHFSpqd1180326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 15:28:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E9535803F;
	Tue, 17 Nov 2026 15:28:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA0758056;
	Tue, 17 Nov 2026 15:28:47 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 15:28:47 +0000 (GMT)
Message-ID: <84d7ad4c-6033-440c-b6d2-8b01aaf987bf@linux.ibm.com>
Date: Tue, 17 Nov 2026 20:58:45 +0530
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
Subject: Re: [PATCH 3/8] powerpc/perf: mpc7450: Remove the snoop retry
 alternatives
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
 <20261109-ppc32-perf-v1-3-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-3-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfX9E++8nuwzZuA
 w6Vz4mJu5I/p0S/J2n9+7nMx5DWdlV2n1K1BknW6mq/gug9AXYkwBZ4XbG6Apv0lB+EFs4+vwjN
 IsKLDtboYeR+SJVGXPMb675udz+oauM=
X-Proofpoint-ORIG-GUID: uRVp9dupm4_s1fM8pJgjfZ6Per_HcvrU
X-Proofpoint-GUID: o5fjsj6sh3nKtwNp6R5SZUsl-3qhhwB8
X-Authority-Analysis: v=2.4 cv=IaESymqa c=1 sm=1 tr=0 ts=6afc72b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=8a-9WUpG2UvYHKQfOK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MSBTYWx0ZWRfXwJKvRpADrEdG
 XvJAMc9V9VZGdFZZyE2B2E5Mm+b512gd4zcli6xVH0R65ooCqqqy+Gmwfl4ICB7cJ1f5FZSU5Sj
 POvGnw2hIjQCZ9rouCZ0Dd9qrlSyhcNpCPDQ0qdUzo7CIToAbQGb25tcnjeqqdWwSOd3lfn+XVA
 QAZ/Nx+QRuCHUglV+Q1BNIHEZlKOrdBkW6YOxrV3LQywXceL88EY3DSQd8z+Y07KU+X3GjlIcqj
 mlSr5qs2yyInjefAIjCovr40TN9LWB51uOFCsq3Ym6hqFdbpHeQ1sZIM4wZsFFPyHe1zRv+lCVV
 SocCzdOKe0Ziobod5xOLJeOYAkR6HHYx0qYWje7dIVePc7WPJSEuI40/tVSljb+aCh2uOw9YJQ6
 mG0P6OHYiKWpWQfOZEFLfI6fydMc1/+H9gNQsxAD/Fh2Fvks2CXVapCMbri8WnpZh8B3cjI3doF
 5mplnRL0PRmI1zkFI9g==
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
> The alternatives table treats 0x418, 0x50f and 0x60f as one event, but
> the manual (MPC7450UM Rev. 5, Tables 11-12 to 11-14) describes three
> different events that share the name "snoop retries":
>
>    0x418  load/store snoops retried by the load/store unit
>    0x50f  internal requests that are internally retried
>    0x60f  snoop responses of "retry" to any access
>
> On a 7448, over the same workload, counting r418, r50f and r60f
> together, and then r418 in a group with r41c:
>
>    r418                 1793
>    r50f              1546267
>    r60f              2266850
>    r418 in {r41c,r418}  670562
>
> r418 and r41c both need PMC4, so in the group the scheduler moves r418
> to PMC5 or PMC6, which count other events, and reports 374 times the
> real count.  Remove the row.
>
> Fixes: 7325927e5a20 ("perf_counter: powerpc: Add processor back-end for MPC7450 family")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
Hi Matt,

I have checked the three "Snoop retries" entries in the manual:

   0x418  Table 11-12, PMC4 select 24: load-store snoops retried by the
          load-store unit, not counting MSS collisions

   0x50f  Table 11-13, PMC5 select 15: internal requests that are
          internally retried, including some MSS collision cases

   0x60f  Table 11-14, PMC6 select 15: times a snoop response to any
          access is "retry"

The descriptions differ in what they count, so they do not look like
the same event.

Fixing it by removing the row from the alternatives table makes sense.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah
> ---
>   arch/powerpc/perf/mpc7450-pmu.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
> index 5a882d934645..9890c87c58ef 100644
> --- a/arch/powerpc/perf/mpc7450-pmu.c
> +++ b/arch/powerpc/perf/mpc7450-pmu.c
> @@ -184,7 +184,6 @@ static int mpc7450_get_constraint(u64 event, unsigned long *maskp,
>   
>   static const unsigned int event_alternatives[][MAX_ALT] = {
>   	{ 0x217, 0x317 },		/* PM_L1_DCACHE_MISS */
> -	{ 0x418, 0x50f, 0x60f },	/* PM_SNOOP_RETRY */
>   	{ 0x502, 0x602 },		/* PM_L2_HIT */
>   	{ 0x503, 0x603 },		/* PM_L3_HIT */
>   	{ 0x504, 0x604 },		/* PM_L2_ICACHE_MISS */
>

