Return-Path: <linuxppc-dev+bounces-26432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB29C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 07:07:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZYhr4n6nz2xpn;
	Wed, 02 Sep 2026 17:07:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788332876;
	cv=none; b=UErWU8XNtRpqWRK1hgKUkuMvPbrW5YDh2sHar429eMwl5sX7bPDfciSRi2idGwL46oXmeAsmzCivdswtYGERcP0yVPfS+9vHd/U7TPZXxmAaQb6yqb+cbicSJXOSrVBBvFbqmCajoYMFiiHweTvtpDCOR7AiHXHe0mnGbnxTUqKah7WS2v8mimTCP9uvyWSiCVEiwZgyI7aCz7d99O+8IwVSCd0Bpurk/rjTlZSY2ebMrqAi4Tb4XLzPjMjRXBwD9wPAFZSP2aXg5+BDDbck1CcSiirF1kVp7WhnhnAlRzC8GEaYGEtsfHYDp7wvPJhMwUq+telBU/mtdnxIBemG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788332876; c=relaxed/relaxed;
	bh=jqueDmlp8fVGFacTH4x/TdtvGeQ72hJzCbIm5n2gLLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ls286pOFnLQk0Yc8ns1DUoMCC4rew9nh+BiaxLJcjmVwAyb6zRzOvDZTJXCTC4v42PX+zv0+nNlqatj1YeklnP2XWqXz8eIYhVicXLnbkpBoxzLfm96KkEK9hdNPExtxHhhG2nmwW0rM1PgdaqMnHvmw25tHmTmABjcjTxAIkPZpqZG2LgoRXGsrcsr7xN9UoNFFpomEvShGKI6de+ERhVetGd71fHT+Kxg16zBjVKrKl0+Nt1U7FcyO+k44d0zSdrK1D4tXcQONmcxI6M8ziUqX9D/pMuKoPkVlSn1GkNMMqz8+UXmFpjmKfAbU7WzfIW4SGRtqsG3325ExPSi3tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UpURxqan; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UpURxqan;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZYhq2n0Lz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 17:07:55 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6826VcLJ3438291;
	Wed, 2 Sep 2026 07:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jqueDm
	lp8fVGFacTH4x/TdtvGeQ72hJzCbIm5n2gLLQ=; b=UpURxqan4JVDSXa7mRyaR6
	4iAx9QTE4Xfu0uoA4rISI/syCuQFRQ+HRhKtIdaRHR8uWQsHYCMVyVG0mUzu1Rk6
	u+1Mbpu21AgvxBijqcbnnHLQbrpUfCAc+wwQZBIaJiGxMIJAU0PGV6N/ZMdi2HfR
	o7YeiRPhH96uk0Uy1r/zot7wN6/E+LlQq0ME/FMrEwUFBl4xJk8lXvcKxG4iqRNi
	8ZQ/YVs582/flc/A6qT71Cb5Q8LPJUPsGQDEuMU29NBHKyHek2Sc/Bn4zat1xHrf
	Pw3uYWLA+AmdGgzWYc/yBPK9BppHDsWtzHRHZK9PxM6VcO5c3CO+onGh+HYWddWw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54vwb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 07:07:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6826uLuW016566;
	Wed, 2 Sep 2026 07:07:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark8a8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 07:07:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68277jnv40370622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 07:07:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4B152004B;
	Wed,  2 Sep 2026 07:07:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2488820043;
	Wed,  2 Sep 2026 07:07:44 +0000 (GMT)
Received: from [9.39.25.199] (unknown [9.39.25.199])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 07:07:43 +0000 (GMT)
Message-ID: <95913fca-5631-40ff-abed-4afad99722e6@linux.ibm.com>
Date: Wed, 2 Sep 2026 12:37:43 +0530
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
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA2MSBTYWx0ZWRfX2Fda2uFh0mNG
 Dx7s6ISwy9TyVB0kzxIc67JganGID/Ng0dslNR86GsV9P/tUWs79XrES6ptWIh7Y5BMPcn7ZX70
 V6P6yFRK1NAFFWeO0coHBjz12765J3TaOR6Bbz93wilXaloyZiqjCYmODwn7/A7q2MiMfkbLTV8
 eJONL1nFbKEwQMKW3Eve7bL4kjhHGXnRBwW/jPIKVxkBto1bjFHA5B6/P5aDUPp+aMSjSYnuPnm
 ZO01ha0oy+vJDBXN2dp7zk/WwQD93cuW9fypyAEhQkEOClyV/kBZ5lhG1xLjovJ+KYuoK40BHDj
 PPmLoyx71sBTJoAU6CXjiyMbfoVJvucYfc6UM+7TmE4DAjJTzBC41ff1z6ANzY7eX9C3NfhMzgF
 ASv8/RXCErHbbI47RgD7OgeZ6YzltQ3XKbXXAp+ZhZ6138esVeGeitIKXtXaYQm4lN2aAoEWjhu
 72WvTQJj5/ZUXGTK2kg==
X-Proofpoint-ORIG-GUID: LQW84XvbQ_PUEs1dWVIOnTFBkar7WEEq
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a97cb47 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=bNR6VrasG_76KyUd1lwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8GkaAx_EtORrXSo561M-B6fTQh91EG14
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA2MSBTYWx0ZWRfX2UHp73/8tJcV
 HpYBDvSzAxoF/ArzfHscHq1fu0P/qDeDQu4G4/TxPO/3lq3F6FH59KFyNPjvHCtDgWy9GyyFd1C
 cgJnXJpV0AXv1Lzab7ugiGUSEzHL7TM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020061

Hi Aboorva.

On 9/2/26 10:36 AM, Aboorva Devarajan wrote:
> Since the switch to generic entry, an interrupt taken from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare() and
> again in arch_enter_from_user_mode(), which irqentry_enter() invokes
> for the same interrupt:
> 
>    arch_interrupt_enter_prepare()
>        account_cpu_user_entry()
>    irqentry_enter()
>      arch_enter_from_user_mode()
>        account_cpu_user_entry()
> 
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space, so the second call charges the
> same interval again.
> 
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. On a
> pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
> loop, and time(1) reports user time about twice the elapsed time.
> 

Could you please run mpstat with 50% or less loading workload like stress-ng
and document the difference in changelog.

> Remove the accounting from arch_interrupt_enter_prepare() and rely on
> arch_enter_from_user_mode(), which runs for both syscalls and
> interrupts. The duplicate account_stolen_time() call is removed the
> same way.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y),

Usual default is VIRT_CPU_ACCOUNTING_GEN, selected by NO_HZ_FULL.
Most distros usually enable NO_HZ_FULL=y.

At hindsight, I don't see the issue dependency on it. But better to be sure.
> 7.3.0-rc1, single-threaded CPU-bound loop:
> 
> Before:
> 
>    $ python3 -c 'while True: pass' &
>    $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>        PID     ELAPSED     TIME %CPU
>       4980       00:03 00:00:06  210
> 
> After:
> 
>    $ python3 -c 'while True: pass' &
>    $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>        PID     ELAPSED     TIME %CPU
>       4951       00:03 00:00:03  105
> 
>   arch/powerpc/include/asm/entry-common.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..984294e62568 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>   
>   	if (user_mode(regs)) {
>   		kuap_lock();
> -		account_cpu_user_entry();
> -		account_stolen_time();
>   	} else {
>   		kuap_save_and_lock(regs);
>   		/*
> @@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
>   #endif
>   	kuap_assert_locked();
>   	booke_restore_dbcr0();
> +	/*
> +	 * User and stolen time is accounted here for every entry from
> +	 * user mode. The interrupt prepare hooks must not account again.
> +	 */
>   	account_cpu_user_entry();
>   	account_stolen_time();
>   
> 
> base-commit: fb442a6673ff1046bf67754957d95880fdb394b5


