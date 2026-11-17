Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A13606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IzDLiAef
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTV9T23bVz2xNC;
	Wed, 18 Nov 2026 03:11:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794931917;
	cv=none; b=KkJU6l0kRB4KzcPWjVx79YE0dxx/Iaj3QEibY13GUhOx1u+Fces/FEcH0WkgQCLQrlrfIxwhYicIoJWDuqRrr2BLsW2IrS/ogGuTbHP6z6Ewfq7me7HkbSZ+WwmcUbgCZf2nbyGJBvZV7b34MpscTxhOFeNqhBLat4oYU4O1KqQupLmn7vmeas+Y5hzLtla/C9Uj1wevt7y0zwxNgwgSBJao2PyXuQI+pfDUWvhs7cndR9Q77OEdNc86MqiPD4gu/B19pdw5zT4r9VvXF68SDHhS3YcgldGZ5om2xB/Nx6QIE1E4NRKi51uzobDjeNGHrCOqj6l83IwK3lU2c91P9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794931917; c=relaxed/relaxed;
	bh=/T+V9VuJK47vxfoZ9qkABQahXL/mlkWoR6A/viVYIj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pk1jwXAvyVQJAXZk44/fDa5hs5BOcp4oJ5LbyLMrDW3RBcnNC+uMVqxXR2FJIesnWh5H++vaHg2aHHjNW3c50ZE1dw+RZ9ybutqf4taV7zVCHtMwxdh6rJW8tMD+ZKUoclivSzGoJ8kHUVvzeEcB1NK6U0zM+/EesncWKoD2NW2CS9uB5Jaxo5/cENjJOwzqyQeimPToWOlMJFcaODgR037G36Bc8PcwzTKsFYV3btoJk/yd614zvnImdd/gzc/oXL3wkUkN/jt+cFWwwkgF4+ufP/fVFj+cbwxaOL40Rjg30IHF+Pd8jkoHCX257Fji8SdSV8Lj5FmzcSRdsJocFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IzDLiAef; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IzDLiAef;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTV9R6wgzz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:11:55 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFQbtn2892636;
	Tue, 17 Nov 2026 16:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/T+V9V
	uJK47vxfoZ9qkABQahXL/mlkWoR6A/viVYIj4=; b=IzDLiAefztDpiA77q6hVSV
	5fwntlqIKV5bcM+rjm/RKJLdM+uvfYAq4Yc72RwsaTrAfM7W2Z6a0nAEfUgOjmxC
	USx7w2P6ZCNYxITDcEmwlHxu80FPzV4z/aWlHnmZABYo2IE9AOL5NxFfzrafI5YL
	WzcsRjQIessyOaBX8ZVHFETWKJK4mO2PPGR6pYiTEuXjZGiWNPMUtF1YKF5qyZt9
	cYnqSCNGA1oBD0XPEP+9wTwccUCEuufWmIiSgYzmEyLPsk5e+MoaSNi+5AtoJyHt
	Ar8jRJ2wcmRAlGgazhMRRWlOUxjengFmF7CJmIGOHdT58VjUX4AKmZ5XP0vc+nIQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf56c84w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:11:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHFZ2ch657734;
	Tue, 17 Nov 2026 16:11:45 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j00nse9w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 16:11:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHGBisH21168650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 16:11:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 700635805E;
	Tue, 17 Nov 2026 16:11:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2FD45805C;
	Tue, 17 Nov 2026 16:11:40 +0000 (GMT)
Received: from [9.39.20.228] (unknown [9.39.20.228])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 16:11:40 +0000 (GMT)
Message-ID: <3950cc84-93bf-4830-8a37-57f9739a84b0@linux.ibm.com>
Date: Tue, 17 Nov 2026 21:41:39 +0530
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
Subject: Re: [PATCH 7/8] powerpc/perf: Use SIAR for sample addresses on 32-bit
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
 <20261109-ppc32-perf-v1-7-a6e8a55b3b48@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261109-ppc32-perf-v1-7-a6e8a55b3b48@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX0lunCtT3eOri
 fdX8omIi+0rb4acEgKVm371pWud+wft9csAGW5pWUv4wQBVvdbuEuwHmaukk87VHf7oDbVYzVQ0
 GyEI5/G8XgXnfaYBMnumPuVULuh/O58=
X-Proofpoint-GUID: jn3L4S6PVGY7oNWqjq80fObrvk_-mpvH
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afc7cc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=aGFjUxq13BNP2VoxV7wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jWg993CcMFpxH0i6vvgTMO2A676UmzaE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA2MyBTYWx0ZWRfX+s6sDGolXBST
 cS/Kb7/tasX7r9DWIKx6MdlPlQ0jZaYrCyIqJe5GsVeEqXpfwdx+w0HMsVEum4o2grNA+qHk23L
 /M37uzvZwoxDQtrEgFNTthBGKcqUQnEPGkk1t/sIMuU0mIaIdc93mf/DX4w02XgxEHyeNqIYVp1
 eE3Rfz6rXn+GJRGlgY68rNoINGb6e88SyTU1rjPulqz1ewhgwdla/XEeLGNXq/7/aMw8qhmcZbI
 npQkr62Q7IkQ8jqQvoLRtB3RAqNavV4Q4Pp1iqBJLSKK2LRVGJyTPNbCk/hyO7bOJ33p5TpLQuk
 liVCV4CNv7nuKp6LWDcXytaIohXbIeLFPjZ2REmDQJcyczkqaXiHlxNALsv4FgoCYfMQu5ofdYX
 sQOnYBQMoklVsHoljEL9FIFNqipEuX9pnHbfoI6VRbK31ukYZWVYcT7Xr+guYfC+AuGXJxqEtda
 QSqnkWAIZ9p1r6V39gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170063
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 7:17 AM, Matt Turner wrote:
> On 32-bit, perf_read_regs() sets regs->result to 0, so regs_use_siar()
> is always false and every sample is attributed to the interrupted PC.
>
> The MPC7450 family's SIAR holds the address of the last instruction to
> complete before the performance monitor exception is generated
> (MPC7450UM Rev. 5, section 11.3.7).  The exception can be generated
> with MSR[EE] = 0 and is taken once EE is set again (section 11.2), so
> when interrupts are disabled the interrupted PC is wherever they are
> re-enabled, while SIAR still points into the disabled region.
>
> On a 7448, sampling cycles system-wide with --intr-regs=nip during dd,
> perf bench sched pipe and find, 46% of the kernel samples have SIAR and
> the interrupted PC in different functions.  13270 samples have their PC
> on the instruction after the mtmsr that restores interrupts in
> ata_scsi_queuecmd(), and 11661 of those have SIAR in udelay().
>
> With interrupts enabled SIAR helps less.  Sampling a 32-instruction
> loop with one store and one branch with -c 10007, 99.8% of the samples
> land at:
>
>    event             interrupted PC   SIAR
>    r122 (branches)   br + 13          br + 9
>    r014 (stores)     stw + 21         stw + 17
>
> siar_valid() already returns true on 32-bit.  Use SIAR for PMU
> exceptions, and take the user/kernel flags from it too.  Move
> regs_use_siar() above the 32-bit block so that perf_get_misc_flags()
> can call it.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Hi Matt,

I checked the manual references (11.3.7 for SIAR and 11.2 for the
exception being taken only once EE is set), and they match the commit
message.

Infrastructure-wise this looks good to me.

One question: the callchain still walks from regs (gpr[1], link), but
its first entry now comes from SIAR. Can SIAR and the interrupted PC
end up on opposite sides of user/kernel? If so, would the callchain
be affected? Something like perf record -g on a workload that switches
between user and kernel often might show it.

Thanks
Tanushree Shah

> ---
>   arch/powerpc/perf/core-book3s.c | 55 +++++++++++++++++++++++++++--------------
>   1 file changed, 36 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 10ded865583c..e4c8ecddccbd 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -75,6 +75,20 @@ static struct power_pmu *ppmu;
>    */
>   static unsigned int freeze_events_kernel = MMCR0_FCS;
>   
> +static bool regs_use_siar(struct pt_regs *regs)
> +{
> +	/*
> +	 * When we take a performance monitor exception the regs are setup
> +	 * using perf_read_regs() which overloads some fields, in particular
> +	 * regs->result to tell us whether to use SIAR.
> +	 *
> +	 * However if the regs are from another exception, eg. a syscall, then
> +	 * they have not been setup using perf_read_regs() and so regs->result
> +	 * is something random.
> +	 */
> +	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
> +}
> +
>   /*
>    * 32-bit doesn't have MMCRA but does have an MMCR2,
>    * and a few other names are different.
> @@ -108,13 +122,30 @@ static inline unsigned long perf_ip_adjust(struct pt_regs *regs)
>   	return 0;
>   }
>   static inline void perf_get_data_addr(struct perf_event *event, struct pt_regs *regs, u64 *addrp) { }
> -static inline u32 perf_get_misc_flags(struct pt_regs *regs)
> -{
> -	return 0;
> -}
> +
> +/*
> + * The MPC7450 family's SIAR holds the address of the last instruction to
> + * complete before the performance monitor exception was generated, so for
> + * a PMU exception it is closer to the event than the interrupted PC.
> + */
>   static inline void perf_read_regs(struct pt_regs *regs)
>   {
> -	regs->result = 0;
> +	regs->result = 1;
> +}
> +
> +static inline u32 perf_get_misc_flags(struct pt_regs *regs)
> +{
> +	unsigned long siar;
> +
> +	if (!regs_use_siar(regs))
> +		return 0;
> +
> +	siar = mfspr(SPRN_SIAR);
> +	if (!siar)
> +		return 0;
> +
> +	return is_kernel_addr(siar) ? PERF_RECORD_MISC_KERNEL :
> +				      PERF_RECORD_MISC_USER;
>   }
>   
>   static inline int siar_valid(struct pt_regs *regs)
> @@ -163,20 +194,6 @@ unsigned long get_pmcs_ext_regs(int idx)
>   	return cpuhw->pmcs[idx];
>   }
>   
> -static bool regs_use_siar(struct pt_regs *regs)
> -{
> -	/*
> -	 * When we take a performance monitor exception the regs are setup
> -	 * using perf_read_regs() which overloads some fields, in particular
> -	 * regs->result to tell us whether to use SIAR.
> -	 *
> -	 * However if the regs are from another exception, eg. a syscall, then
> -	 * they have not been setup using perf_read_regs() and so regs->result
> -	 * is something random.
> -	 */
> -	return ((TRAP(regs) == INTERRUPT_PERFMON) && regs->result);
> -}
> -
>   /*
>    * Things that are specific to 64-bit implementations.
>    */
>

