Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ro60GQ2d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV2Kb0FzPz2xSl;
	Thu, 19 Nov 2026 00:20:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795008050;
	cv=none; b=bVh7IjP6Dip2jtGtiBL6qTT6D+ozovqkmCgxhbzPmGRypX/21z8PnBTLkAatNA4kjXNp26cyyHoIR/+XB0FzDJWxc65AR3rbuHdgWuPIr4qLQnY5NTKyyFBqQTlhmohWk9GhpwaobafBDrBBn/dPNyw2ScmuqpCBI+0FTqx1+T4eOchE/UVl1T2X6/j2re0/c2+gnCFjhl6GMfF5llRVEUy4r0AoPVczr14ldFVxjRCko9bEUJz/fWuxn+a4QPvyVanTbAliNGB9vhRTgWH0KVcwgO0ElBvCYdxsAaQV+vefhX4vkkOVu7iNLe0gPOa/MD1AVzpi05jqaIuSE7y/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795008050; c=relaxed/relaxed;
	bh=0VXIPHRIgn0LdLoXwF8Z7TRdBHgp7K6Mgrfw5or/XCw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=WjIkjSmMaDAgN8xYRTGmtDE8xozACknAkvEVBPgOge/WfGG1AFKf5/LffNu0zt6zbr8tQtwfIWUNJ+0KM99yJ9X1tqpRvt3rGfGfknzj1T2DiJnpTFkOA7Vqv8NRGZg4jc9GzOfX+V4Tv1eBey5TQmf1vMiB2PzDUNhtrdagdReXZ2PZJpTLb9ZhPaJduLgpkuvQihBxl6oYpK/JhQejQ3Gv51L8BS1Aq30f+CrzloFk6ae5dMlUR0hPXesYZNITDGSPC3ul6RAVvligwu3UPx9Inxsudo2UfsJbGU2o1PlK/rzcl0fDm8OSl7m10dBHjtOl6o+kRymCu/pQLJ3WHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ro60GQ2d; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ro60GQ2d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV2KY5Zr4z2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 00:20:49 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBQ76I968815;
	Wed, 18 Nov 2026 13:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=0VXIPHRIgn0LdLoXwF8Z7TRdBHgp7K
	6Mgrfw5or/XCw=; b=Ro60GQ2dAX7kUYGRbS8k4K1mfAKRz94pPyukzexR1IC8Kl
	NGlHKJfpwoTH8crKZgNINQve5iOeKwuaXntgrJJyemLHtTV4Mvhft3Zl+zep2wdE
	Ur0GDztemmH2cjz+UBm4e1RH7p95qc+A8yJRDa0loobOV680QwlhAnbs6pjXtNTQ
	mwCKKtSukZbew0YABGHUNvfZe2jVJpokPzJL3STckbjE1qv99tqYgrStZauoAUGQ
	LgG4CGQ7MD67DGULpNsm5sF/3aHPjZU9KFJOEcuWRN1/ntmu9WMcEhHSlicQuTdi
	CORGwk8ajcg6s5lSc2Xr+L86P5gbpN42UjotJRmQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t2jp6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 13:20:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBK2hm3324600;
	Wed, 18 Nov 2026 13:20:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt8hn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 13:20:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIDKTPo59638158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 13:20:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D70A85805D;
	Wed, 18 Nov 2026 13:20:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C959258052;
	Wed, 18 Nov 2026 13:20:24 +0000 (GMT)
Received: from [9.39.20.95] (unknown [9.39.20.95])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 13:20:24 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------48QNBQi89u1Ke73kOiW8LZXK"
Message-ID: <53a68daf-e694-4c88-b99e-fb8a4c17c1a7@linux.ibm.com>
Date: Wed, 18 Nov 2026 18:50:22 +0530
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
Subject: Re: [PATCH v2 7/8] powerpc/perf: Use SIAR for sample addresses on
 32-bit
To: Matt Turner <mattst88@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261117-ppc32-perf-v2-0-2072e9b90009@gmail.com>
 <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afda61f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=r77TgQKjGQsHNAKrUKIA:9 a=pGLkceISAAAA:8
 a=mwyl9ErVLGDQFkc4_RcA:9 a=QEXdDO2ut3YA:10 a=c3kXXwlcQeCTfzCFSucA:9
 a=nUcT3lNexb1k7Wf8:21 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-ORIG-GUID: YF2nCAfTTn_9bhA_VunlH8kL2gZqfZbj
X-Proofpoint-GUID: WkJIEpdHZB0weZQGSaXwrG-WVqhqPOHY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfXw9cgXUxMG9yu
 HGztP4LkAWlRKaH4QF1sYouymd6p0twRDWiB07fmVVHDcaPJleoOxLsYKSAf2WZvjQesMPaIKqQ
 ceET7v3n9FLVYB7f7AqiJjQ95u7fpn/0m/07zUpLeZQa6a2yNOrAWBnVyMfI3b+KupkOOHnhQoB
 dHiMUrfIHfha6fwSbGnZpEq/fCvMFDbk5Y6m2uzvlygERGwca5BI33Tg4rnMEs64mlGQUieyQp6
 QyW3mzYkb79yS+6QbN/Ut0PVlAdgoxaTidW6MSkBITk0O4eEx6OkwtT50KTqCljBIuc4RLBnqZ0
 AxowxwvFD0CHEqn6twcH1DG2zz3TGVzCM7Ht+JXEoaUm8Bw3rYjYZ72W44R51aruC16ipJTQ1xa
 vL7FkE3PEq11S27Fi2YjTpkSBnWpAd1IPaGpZD7ZW0I1Dy7zlbgEtkUrJWINtHdnl6Rli3Qg9Bw
 JXaaZ0APV/Ng1C333EQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1MSBTYWx0ZWRfX0ExwmnJoHvgC
 /EHSOP41uriItl1nMUSWw+qDWg9rufGSLPIDwsbtHvZ/36CnAnHECx1WLoR3VBUCbuZ/wkHSPrs
 x8QbUhsmrCmMlG9KhqROkLR3xVQ+y6w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180051
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------48QNBQi89u1Ke73kOiW8LZXK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/17/26 11:13 PM, Matt Turner wrote:
> On 32-bit, perf_read_regs() sets regs->result to 0, so regs_use_siar()
> is always false and every sample is attributed to the interrupted PC.
>
> The MPC7450 family's SIAR holds the address of the last instruction to
> complete before the performance monitor exception is generated
> (MPC7450UM Rev. 5, section 11.3.7). The exception can be generated
> with MSR[EE] = 0 and is taken once EE is set again (section 11.2), so
> when interrupts are disabled the interrupted PC is wherever they are
> re-enabled, while SIAR still points into the disabled region.
>
> On a 7448, sampling cycles system-wide with --intr-regs=nip during dd,
> perf bench sched pipe and find, 46% of the kernel samples have SIAR and
> the interrupted PC in different functions. 13270 samples have their PC
> on the instruction after the mtmsr that restores interrupts in
> ata_scsi_queuecmd(), and 11661 of those have SIAR in udelay().
>
> With interrupts enabled SIAR helps less. Sampling a 32-instruction
> loop with one store and one branch with -c 10007, 99.8% of the samples
> land at:
>
>    event             interrupted PC   SIAR
>    r122 (branches)   br + 13          br + 9
>    r014 (stores)     stw + 21         stw + 17
>
> Because the exception is held off, it can also be taken on the other
> side of a user/kernel transition from the instruction in SIAR, e.g.
> just after the rfi at the end of a system call. SIAR also holds a real
> address while translation is off, such as 0xc00 in the system call
> vector. Recording a loop that alternates user work with getppid() with
> perf record -g -c 1000000, 3022 of 16953 samples had SIAR in a
> different mode from the interrupted PC. The callchain is walked from
> regs, so taking its first entry from SIAR there starts a user
> callchain with a kernel address, or reports a kernel sample as a user
> sample at 0xc00.
>
> siar_valid() already returns true on 32-bit. Use SIAR for PMU
> exceptions when it is in the same mode as the interrupted context, and
> the interrupted PC otherwise. With that, the same test has no samples
> with mixed modes.
>
> Signed-off-by: Matt Turner<mattst88@gmail.com>

Hi Matt,


Thanks, v2 looks right. One concern: the rule infers user vs kernel
from SIAR's address, but a real-mode address (translation off) is also
low, so it can look like a user address. The 0xc00 samples in the 
results come out
right only because the regs are kernel there. If a real-mode SIAR ever
pairs with user regs, the rule would trust a bogus address.


This rule avoids it and still fixes the interrupts-off case:
regs->result = siar && !user_mode(regs) && is_kernel_addr(siar);
User samples then use regs->nip, which loses little (SIAR was only ~4
instructions closer in your table).



Thanks,
Tanushree Shah
> ---
>   arch/powerpc/perf/core-book3s.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 10ded865583c..4c9c9ff1073e 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -112,9 +112,25 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>   {
>   	return 0;
>   }
> +
> +/*
> + * The MPC7450 family's SIAR holds the address of the last instruction to
> + * complete before the performance monitor exception was generated, so for
> + * a PMU exception it is closer to the event than the interrupted PC.
> + *
> + * The exception is held off while MSR[EE] is clear, so it can be taken on
> + * the other side of a user/kernel transition from the instruction in SIAR,
> + * e.g. just after the rfi at the end of a system call. SIAR also holds a
> + * real address for code running with translation off, such as the start
> + * of an exception vector. Use SIAR only when it is in the same mode as
> + * the interrupted context, so the sample's mode and the callchain built
> + * from regs stay consistent with it.
> + */
>   static inline void perf_read_regs(struct pt_regs *regs)
>   {
> -	regs->result = 0;
> +	unsigned long siar = mfspr(SPRN_SIAR);
> +
> +	regs->result = siar && is_kernel_addr(siar) == !user_mode(regs);
>   }
>   
>   static inline int siar_valid(struct pt_regs *regs)
>
--------------48QNBQi89u1Ke73kOiW8LZXK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/17/26 11:13 PM, Matt Turner
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com">
      <pre wrap="" class="moz-quote-pre">On 32-bit, perf_read_regs() sets regs-&gt;result to 0, so regs_use_siar()
is always false and every sample is attributed to the interrupted PC.

The MPC7450 family's SIAR holds the address of the last instruction to
complete before the performance monitor exception is generated
(MPC7450UM Rev. 5, section 11.3.7). The exception can be generated
with MSR[EE] = 0 and is taken once EE is set again (section 11.2), so
when interrupts are disabled the interrupted PC is wherever they are
re-enabled, while SIAR still points into the disabled region.

On a 7448, sampling cycles system-wide with --intr-regs=nip during dd,
perf bench sched pipe and find, 46% of the kernel samples have SIAR and
the interrupted PC in different functions. 13270 samples have their PC
on the instruction after the mtmsr that restores interrupts in
ata_scsi_queuecmd(), and 11661 of those have SIAR in udelay().

With interrupts enabled SIAR helps less. Sampling a 32-instruction
loop with one store and one branch with -c 10007, 99.8% of the samples
land at:

  event             interrupted PC   SIAR
  r122 (branches)   br + 13          br + 9
  r014 (stores)     stw + 21         stw + 17

Because the exception is held off, it can also be taken on the other
side of a user/kernel transition from the instruction in SIAR, e.g.
just after the rfi at the end of a system call. SIAR also holds a real
address while translation is off, such as 0xc00 in the system call
vector. Recording a loop that alternates user work with getppid() with
perf record -g -c 1000000, 3022 of 16953 samples had SIAR in a
different mode from the interrupted PC. The callchain is walked from
regs, so taking its first entry from SIAR there starts a user
callchain with a kernel address, or reports a kernel sample as a user
sample at 0xc00.

siar_valid() already returns true on 32-bit. Use SIAR for PMU
exceptions when it is in the same mode as the interrupted context, and
the interrupted PC otherwise. With that, the same test has no samples
with mixed modes.

Signed-off-by: Matt Turner <a class="moz-txt-link-rfc2396E" href="mailto:mattst88@gmail.com">&lt;mattst88@gmail.com&gt;</a></pre>
    </blockquote>
    <br>
    <font face="monospace">Hi Matt,<br>
      <br>
    </font><br>
    <font face="monospace">Thanks, v2 looks right. One concern: the rule
      infers user vs kernel<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      from SIAR's address, but a real-mode address (translation off) is
      also<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      low, so it can look like a user address. The 0xc00 samples in the
      results come out<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      right only because the regs are kernel there. If a real-mode SIAR
      ever<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      pairs with user regs, the rule would trust a bogus address.<br>
      <br>
    </font><br>
    <font face="monospace">This rule avoids it and still fixes the
      interrupts-off case:</font><br>
    <font face="monospace">regs-&gt;result = siar &amp;&amp;
      !user_mode(regs) &amp;&amp; is_kernel_addr(siar);<br>
    </font><font face="monospace">User samples then use regs-&gt;nip,
      which loses little (SIAR was only ~4<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      instructions closer in your table).<br>
      <br>
    </font><font face="monospace"><br>
    </font><br>
    <font face="monospace">Thanks,<br
style="box-sizing: border-box; border: 0px solid rgba(0, 0, 0, 0.08); margin: 0px; padding: 0px; outline-color: rgb(35, 112, 205); scrollbar-width: thin; app-region: initial;">
      Tanushree Shah</font>
    <blockquote type="cite"
      cite="mid:20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com">
      <pre wrap="" class="moz-quote-pre">
---
 arch/powerpc/perf/core-book3s.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 10ded865583c..4c9c9ff1073e 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -112,9 +112,25 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	return 0;
 }
+
+/*
+ * The MPC7450 family's SIAR holds the address of the last instruction to
+ * complete before the performance monitor exception was generated, so for
+ * a PMU exception it is closer to the event than the interrupted PC.
+ *
+ * The exception is held off while MSR[EE] is clear, so it can be taken on
+ * the other side of a user/kernel transition from the instruction in SIAR,
+ * e.g. just after the rfi at the end of a system call. SIAR also holds a
+ * real address for code running with translation off, such as the start
+ * of an exception vector. Use SIAR only when it is in the same mode as
+ * the interrupted context, so the sample's mode and the callchain built
+ * from regs stay consistent with it.
+ */
 static inline void perf_read_regs(struct pt_regs *regs)
 {
-	regs-&gt;result = 0;
+	unsigned long siar = mfspr(SPRN_SIAR);
+
+	regs-&gt;result = siar &amp;&amp; is_kernel_addr(siar) == !user_mode(regs);
 }
 
 static inline int siar_valid(struct pt_regs *regs)

</pre>
    </blockquote>
  </body>
</html>

--------------48QNBQi89u1Ke73kOiW8LZXK--


