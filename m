Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D43606A336
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xq808Wmd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVVSZ2rz7z2xyh;
	Thu, 19 Nov 2026 18:28:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795073310;
	cv=none; b=Or0Vlu47nq3+JXOEFEIhh8vl2jyfYaIgnrcNOY30V7ylVbAAPXCrmrwyqxtk+dlzB4PnzWSzodGsv8G8mlfckrVRGKHZ6zhGqzi/qqNGsdqXCyFc0JhXlkAfmP9Hvem/qifYnRz/EdmWTpkYkQmhCpb95mPl3sP7rCqtQseSdGLFHOkDEk4dro9KZccu/Gepq2lelMs1rqEcIvnJNdIOjKuRDmF2/lzulKAN/iAv+MagIi6vvQizVRbyoE4r6b2M0S/oSNZThbgyGysa5oD3Q1Yk2tSskHtZxpHvox1UuH7pfhXMKfOe1VgJdIJP357YZtsO3c9xo9eXcsYxaJNAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795073310; c=relaxed/relaxed;
	bh=1eQdLEEoEhxxAqwfzJauPYKGz618f6Xpn6SIy0/9abc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9jtNoCPogEAac5bZRlbMTCqzL/98lTW/uchRzZQull4sPr3Veum7ECE+1vfnGlTI+3r9vNe6ftDWG6VchItcOMLN2zbn+e58/n9YCgxIwk6t1Uehcgo0i+gv4M17I2htJ8tjU1ZemQe1AMakhsAGiXMcfh8Rao/t+zU5z/+GEaUIHgLSr9hT04aphAwSF3M8Y1+ajnm2rWrBezH8iRgMCTJr8S5X2hw9FRO0EXD/ikZKPj2sgqL1oDi+3cTMPjSxQFtoby9pNJ3goyNJGMhWeaYqAX3efEO7VxSAnpM6aHgmlugJT1W9tUeiheRxWf1Bwj0U8mKY5sZ5epucuu0NQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xq808Wmd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xq808Wmd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVVSY1VRhz2xlk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 18:28:28 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uWfA3422494;
	Thu, 19 Nov 2026 07:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1eQdLE
	EoEhxxAqwfzJauPYKGz618f6Xpn6SIy0/9abc=; b=Xq808Wmd0U/93Zy9saY8f8
	OKtkfj0oMBnxYn5Esp0kV2+jIvbSzVZqlMhmdeQSrAcNtTqwrOu/bivJx1Mnw/Ep
	FP7V0VaCh+RBCBwNellXJz3tJKF6gx6ZxsAfgtCo1u3oCUPVEn9rP7qlrFEgkicG
	5q5tfpYI7BVfRwNMfGBgQESf/REOR+J0jqf1UQqJzeb2ls9MiqYXdsM6QJlQJsH1
	7eAX+DcRknoH+KszKkbKN0PzVNJM9hDK3cm4/5J2tIgLv1duQfFhfr6oTvuioA/A
	hQWOXwm9HFVHrOhPz9BtUIljQp0IYHM0L1RXd7+u5Jn4lxUsDhZdQCEKlcuq/gJw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wy2wd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:28:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ74vog3254812;
	Thu, 19 Nov 2026 07:28:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4vxfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:28:13 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ7SCHH24314602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 07:28:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 040A65803F;
	Thu, 19 Nov 2026 07:28:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AABAA58054;
	Thu, 19 Nov 2026 07:28:07 +0000 (GMT)
Received: from [9.124.216.199] (unknown [9.124.216.199])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 07:28:07 +0000 (GMT)
Message-ID: <cf0df071-7e06-4da4-bc08-d0781c5aebcb@linux.ibm.com>
Date: Thu, 19 Nov 2026 12:58:05 +0530
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
Subject: Re: [PATCH v3 7/8] powerpc/perf: Use SIAR for kernel sample addresses
 on 32-bit
To: Matt Turner <mattst88@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com>
 <20261118161706.2454031-1-mattst88@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20261118161706.2454031-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: srs1PA5SeWkvBhLH6x-sOcoj8RY539E7
X-Proofpoint-GUID: Gcv_Jb5alWLTTFwpnRh87ss_om9d_x35
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyOSBTYWx0ZWRfX7/vvVt2nsGAY
 9a2CTGAccrdBRjg+OoPMQn9G9FhorDSKHF+fLNU8MCkw1Np1x8vFa+f5I6GbljrC6EjnKnF+9/F
 fI2XaeYjmkvB3yxvyzjfIyuivy4osaJEer0Qsw1Leu4sZVJB8/MTZcfMBtpTjn4kXv9OBKwwksq
 sRxKrq3MOIMv2qRIGTfYgRFBlIVj8wsUuCFAoWIDyW/0Q5r8EFp/fJh6JLwRVKv/wYs++xURMUm
 EqCeJ6vRYky9SYqHAKBvBMmjP1kwAwj53xpgQwdN22rsYOE2Ah7pylsEv5ynjQQoE8+eEyz/huR
 hWRwb7njBwV7HD5wmeuTrAWjuOKmtTeXTz1Bw2AzkPRev9pISfaNs7P1CRhFBTih02PwU6iNtPm
 I+yk8HkaKGJfq65N0ycoigH8QQUamwKUfE6FtFGwC//ZrRwamQQ05GGiyIryPrWUmHpgUs8CMbu
 U0XE/oV2cw2rvnKnDUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyOSBTYWx0ZWRfX6UQ6SsOnJZG9
 jCL1ngdv9ocT2FIbTMygI4pIa4PRsTQs5MhBdvlFb8OO2FE/yT4D1/wPdu6ioFXMgRmqMBnZBMD
 lhn+1uqiNCm5K66Bx3iD1xXPenAPRWQ=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afea50e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bC-a23v3AAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=AdktrCXqYhePwNBqLiIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190029
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/18/26 9:47 PM, Matt Turner wrote:
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
> just after the rfi at the end of a system call. Recording a loop that
> alternates user work with getppid() with perf record -g -c 1000000,
> 3022 of 16953 samples had SIAR in a different mode from the
> interrupted PC. The callchain is walked from regs, so taking its first
> entry from SIAR there starts a user callchain with a kernel address.
>
> SIAR also holds a real address while translation is off, and a real
> address looks like a user address. The hash_page() fast path on
> CONFIG_PPC_BOOK3S_604 runs with translation off and EE clear and
> returns straight to user space, so an exception generated there is
> taken at a user PC with SIAR holding a kernel real address. Reading
> one word from each of 2048 pages after an mprotect() round trip has
> flushed their hash PTEs, with -c 10007, 1674 of 2659 user samples land
> on the real addresses of DataAccess, hash_page() and
> fast_hash_page_return when SIAR is used whenever its address matches
> the mode of the interrupted context.
>
> A user SIAR cannot be told apart from a kernel real address, and the
> table above shows user samples gain little from SIAR. Use SIAR for PMU
> exceptions only when the interrupted context is the kernel and SIAR is
> a kernel address, and the interrupted PC otherwise. With that, neither
> test has user samples at kernel addresses or callchains with mixed
> modes, and 99.9% of the kernel samples in the mprotect() test still
> take their address from SIAR.
>
> Suggested-by: Tanushree Shah <tshah@linux.ibm.com>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
Hi Matt, v3 looks good for this patch, and the hash_page() explanation 
in the message and comment is clear.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>

Thanks
Tanushree Shah
> ---
> Changes in v3:
> - Use SIAR only for kernel samples, and only when it is a kernel
>    address. A real-mode SIAR from the hash_page() fast path looks like a
>    user address and was used for user samples taken after its rfi
>    (Tanushree Shah).
> - Retitled from "Use SIAR for sample addresses on 32-bit".
> - Link to v2: https://patch.msgid.link/20261117-ppc32-perf-v2-7-2072e9b90009@gmail.com
>
>   arch/powerpc/perf/core-book3s.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 10ded865583c..aab18f4dda94 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -112,9 +112,28 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
>   {
>   	return 0;
>   }
> +
> +/*
> + * The MPC7450 family's SIAR holds the address of the last instruction to
> + * complete before the performance monitor exception was generated, so for
> + * a PMU exception it is closer to the event than the interrupted PC. The
> + * exception is held off while MSR[EE] is clear, so with interrupts
> + * disabled the interrupted PC is wherever they are re-enabled.
> + *
> + * Because it is held off, the exception can also be taken on the other
> + * side of a user/kernel transition from the instruction in SIAR, e.g.
> + * just after the rfi at the end of a system call. SIAR also holds a real
> + * address for code running with translation off, and a real address
> + * looks like a user address. The hash_page() fast path runs with
> + * translation off and returns straight to user space, so a user SIAR
> + * cannot be trusted. Use SIAR only for kernel samples, and only when it
> + * is a kernel address.
> + */
>   static inline void perf_read_regs(struct pt_regs *regs)
>   {
> -	regs->result = 0;
> +	unsigned long siar = mfspr(SPRN_SIAR);
> +
> +	regs->result = siar && !user_mode(regs) && is_kernel_addr(siar);
>   }
>   
>   static inline int siar_valid(struct pt_regs *regs)

