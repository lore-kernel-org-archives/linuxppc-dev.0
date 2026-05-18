Return-Path: <linuxppc-dev+bounces-21062-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E4ACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 06:13:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJnYJ1ttNz3cZb;
	Mon, 18 May 2026 16:13:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779084804;
	cv=none; b=J6/2wVXaTVM2tfgKn+4aFR3TAlHLwiAVSr9kqvDhe53i6udUI1nC3WafpTPnwJR49KjCAnyHQWShVjdfthT6k5KrD+CMmMQ5rUS/rwzC5Scts7G+4J7Ta8x99CCsSOveBFEjgkdATH/WyxwdZMEOIutbFEoJsO/SMBuBcBdIxjHnJ08tLhwugupzNdOo3DvKo2CmnIG1m/RB7FMuuqto8pDnETR0zqWfRcUquKQ5J5BRcfKwK406lQICecK+7skmfSK0Qg2Uk1Lc9e0TIB4hB2IcBLcfeKjGuFd8uMWtpDeTgVB3+/ZkZqWIazH0FX6oxqOlpKQ0+p57hB/K8rbilw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779084804; c=relaxed/relaxed;
	bh=HqQtexUsMJohTTu+WR22GVo3rQbHTKF71FZ9xBfC0Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr1jwxv1vSP9readGUcRGE28FJAAIISsCZEsmlL6ZgxHScNsUX0YusZhOvOlEQw4+roF2oNfIKN5nO5hbwzAzyN9y4vRrwpOFWydDI4We/9y+baV8iJEuiQe9NO0GK/P1QgneOWdO+kg6V4KbtZQgx67/eKhn40EN2dAKmlNmCPSiOzwIXmYpqqPy6IjJqrx6EjlNH0gN413S77OvBTQkNH0qcypnNVIQee1qxChTInTt5ETQArif3Ab8OXf6Lu6Vcre8Jt1TSDiGKbh1nzW69YEPOLbODs5ysKrHGBr2yN85AEPzPiKOm1A8Ickb/jDOzFZB2btcFKImK5J+LaUyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmAPR6/j; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MmAPR6/j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJnYH0W9wz3cY7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 16:13:22 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H7QbRX470901;
	Mon, 18 May 2026 06:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HqQtex
	UsMJohTTu+WR22GVo3rQbHTKF71FZ9xBfC0Cg=; b=MmAPR6/jUR+ERplmSEpzQJ
	b1GH5R02LVJ+ZoC+x58OXAGWlCCt4KbGLOXtYGKaoAaWyCq78Ls7Z+r4NaYSbXEp
	q0kVhCMttccoXuhBMPeu+fDUdSozGnfsa0nSI6QGJwrl8ML7hOy9czIgbTzV70rA
	EAVhGiDVIj1eFPZmucn+T2q+ZJ1rEe1KIb//YL1YuRZ9Cj6gym//rCdMAOfdX3gd
	D/91Ev7AhMDwdiq31KzTluA6hF2tM6xaiJ6zpAkSh+e/63xPNHWPFU28KOWUnsQH
	X37oNO/gVYNgXpxcfuNof7rqF6ryHiXRGgNfj+wN5RKfqaR1N0Qh3W2GKN+vY84g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8861v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:13:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I696BF006173;
	Mon, 18 May 2026 06:13:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjvfma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 06:13:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I6DDQt38076766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 06:13:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619072004B;
	Mon, 18 May 2026 06:13:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC7B220043;
	Mon, 18 May 2026 06:13:11 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 06:13:11 +0000 (GMT)
Message-ID: <1e31821a-2c9d-4394-83b4-e850f96ad662@linux.ibm.com>
Date: Mon, 18 May 2026 11:43:11 +0530
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
Subject: Re: [PATCH 1/3] powerpc/perf: fix preempt count underflow in
 fsl_emb_pmu_del
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
 <20260518050855.1147242-2-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260518050855.1147242-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3QaU4Ms63bUdZFAAcWmKBPOLkASZAsP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1NiBTYWx0ZWRfX6UXTAr2kM5eY
 SsIxqMHbAEjJGEkZlPad0lgcgWlal9/tdeM4N6lMhUhm2EkxwF2ObQc9MdxjdoT/dOfpCvrdMSI
 uNt2EkfiAOF8kNatAtg5eKaaq0MDbPV6lsBXB2iG2f+R6pwAvVrNn2N3ZHb4bBQ3o4nvAU9h4MZ
 jtFYqs2qhxNqKt0rz2CP1NFRYuhkC69z0eO63xvk/5cOB1yCVUXGiFaR0EUdKeUg89HZHM2t9XS
 jKtUGPhtFSC0eLllBSltv3cCYq3U0SiBnBtkl9wJPDqLoJSvFsWr3nkLZoYgQBg8+3NGEW6MnHX
 4lN9cQolYz9AN1Vcuexm0NVXqAi4CZ+54Usf3nVhF1CFv/6ImqFYx68U3GhKQA++1vCn2327B4w
 Fqm6u7yFLDp53cav9x4INbKOF5Ijg5xdmFb7mOtRRPNNtVmHKaEgTaWu5dFMjV13YBm+9KWP3Zg
 /fnjz3YkNAt1j46qRXA==
X-Proofpoint-GUID: Oq97JMNFrYmqM5DbywPoBHAylMV4lsqQ
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0aadfe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=BzsuWJ9IV0snJKnQtnoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180056



On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> fsl_emb_pmu_del() unconditionally calls put_cpu_var(cpu_hw_events) at
> the 'out:' label, but only calls the matching get_cpu_var() after the
> 'i < 0' early-return check. When event->hw.idx is negative the
> function jumps to 'out:' without having taken get_cpu_var(), and the
> trailing put_cpu_var() then issues an unmatched preempt_enable(),
> underflowing preempt_count.
> 
> On a CONFIG_PREEMPT=y kernel preempt_count would underflow and
> eventually present as a 'scheduling while atomic' BUG.
> 
> Move put_cpu_var() to pair with get_cpu_var() so the percpu access is
> correctly bracketed and the 'out:' label only handles perf_pmu_enable.
> 
> Fixes: a11106544f33c ("powerpc/perf: e500 support")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   arch/powerpc/perf/core-fsl-emb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
> index 7120ab20cbfec..02b5dd74c187a 100644
> --- a/arch/powerpc/perf/core-fsl-emb.c
> +++ b/arch/powerpc/perf/core-fsl-emb.c
> @@ -366,9 +366,10 @@ static void fsl_emb_pmu_del(struct perf_event *event, int flags)
>   
>   	cpuhw->n_events--;
>   
> +	put_cpu_var(cpu_hw_events);
> +
>    out:
>   	perf_pmu_enable(event->pmu);
> -	put_cpu_var(cpu_hw_events);
>   }
>   
>   static void fsl_emb_pmu_start(struct perf_event *event, int ef_flags)

Thanks for fixing this. Looks good to me.

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

