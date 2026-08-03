Return-Path: <linuxppc-dev+bounces-25230-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851E8C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:04:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD5j83y5Cz2yY1;
	Mon, 03 Aug 2026 16:04:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785737052;
	cv=none; b=js7e/skDvRIoikwoFhGrXnJoUtkZBfgA0zpHV27QWqA5GjXRXQVkv84XTWL+vPm2XaQcAg3sMNxR0m/LiFiz6ciEH1dqaVQHR/hmZIxpE55+3AyzOeFczpCHUxbdpuFnBFeBqrpuKx0maQCIY0E6ERJNEAnCipoHLXrn1dfVW13+C6UkpcgW/fzhsFfJbP9fPj1F2SGvAwXOF3gMf/Tezaga+YpIDTPrIB7cj2AmIB/oI3c6bLz9tLYiFlmF8TRaC1a9Tu5xpufgdhjkSjh+6DqHex/7Ss3s1aA/rVtXDakPZ6hNkDvhHNxAwKwdXmNCHYg446i6q7BiapR7Ne9nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785737052; c=relaxed/relaxed;
	bh=TnkxWQhr+O6vAIbs5Cz/BLsUyIp21/DpauaLzfSwqXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yun5b9url1GQqj88VaOzyVoQnjFvqSdVYId+KcznBmi6rjlfeR84MeKFDFQVUbzIb+MrSiz2reWjdP6InJxn0Mow/ljX22TZwcCLFsNrQFIvtgXuSihlZUux1gRAKnSnJO92sG61Z0U56f5V36yq4yFIO0UaVBNA4Kp705FbSgcTGRiAJQ34ixynQipp7k9fR5wb0fthQVbHtNv2jbPSD2QgrWrwwr9neXDOTFxYCIr0erRrb0qhuHoEiuZE6ClDmkLt07YbSp3SZ/ETfYbzczvL9KOvN08VzsfQl1LI8G1uEtC8NlA0N6Dtslr2BH5kRLP2OIgSNQc8VAA/wVhoWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NwKRFIUY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NwKRFIUY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD5j70vKsz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:04:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672NooHY2800956;
	Mon, 3 Aug 2026 06:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TnkxWQ
	hr+O6vAIbs5Cz/BLsUyIp21/DpauaLzfSwqXE=; b=NwKRFIUYOA8OGfyq8Y3Ne5
	NuDQgf0AK+rDAyIjh7c0WUFH7Kj8rwNpNRLJG81aL7U+IlwfFWKhhVm8Eehal2yB
	KgtaSX7FNFvfKrubUe7nOQNEDZ+r6ET2evUxpO8COGlge3tlm0ArNfY3PFsA3ZBd
	EhIRDIDbwqHHyCT/Kt5e3/UpncXMy1B++0IIhLBnV6SOD9IsdPEbQDr3Eiy7mXhm
	fIoYA5DXdhzyK1SC4ENqNrjKnXIITL5gdujffNlkwOmJaYfvgZYm9p0mEvnOH4OT
	cxOrTYWuWtecSMPPkgnG2BJxeCOpe/melYVX/rLLhEdmhf/eXjcmElD4px3BNf9A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqf33f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:03:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6735uImL015048;
	Mon, 3 Aug 2026 06:03:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4jv026-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:03:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67363qnW42140082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:03:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91E8D20040;
	Mon,  3 Aug 2026 06:03:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC4720043;
	Mon,  3 Aug 2026 06:03:50 +0000 (GMT)
Received: from [9.89.243.204] (unknown [9.89.243.204])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:03:50 +0000 (GMT)
Message-ID: <841f9d03-06bb-4141-9bc5-a974f7cf9301@linux.ibm.com>
Date: Mon, 3 Aug 2026 11:33:48 +0530
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
Subject: Re: [PATCH v3] powerpc/irq: Fix missing r2 clobber in PCREL inline
 assembly
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, segher@kernel.crashing.org, venkat88@linux.ibm.com,
        yeswanth@linux.ibm.com
References: <10fc2cda485cd22e209a31d786bed1984bdf3982.1785732393.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <10fc2cda485cd22e209a31d786bed1984bdf3982.1785732393.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: D5SBga4ECtjx10v6NkStWc_dNjfmwnMe
X-Proofpoint-ORIG-GUID: 1gwa4IE-OvyZKfRiYiASABK50I6KHo8o
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfX0QRqPv1KHOkN
 DVXMhsRKceIRbsUT536mnFCcNcEGjIkq+mGG83nwS9a4u7Hy8SeojKt/sg4jir3wQ7J3xzL4A/V
 lOVEAG7R+zjHy0BYzwW8e6SKHg3EEXA=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a702f4e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Vt2AcnKqAAAA:8
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5yP404LuCDGpg1bcGhIA:9
 a=QEXdDO2ut3YA:10 a=v10HlyRyNeVhbzM4Lqgd:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfX5aLpg8SVFbB0
 kWUEgfo6E4ZD8gxQS4uC1tMISRuLKa5BMcphHCb0LhsjdDRDFrCDYC0PmMTidbmGXGM1H+35FbA
 yGYyL0labI6NMRNi0hOPyzaLXOV/vAIbO71QkANylJOt1p5Lk1P3D2hlr1h0rebHi2BCgWrZGjy
 U/kiDwtYrrDOJyl16J3mWg2zAdLXHaKCiAMPYu9Q+xL6PajjI3gotn1/wB7YUJnU5JgZeYHPWdK
 bjqFWlnVtFQxTg3qIKjK5DXT9SctvGMaeofbjOm8mFigoD724ihd1w+Rd11PHd3JfTFThmJu1K8
 rt+kEscQlXCDj03fS0jRrYiQSUSUil+Sx1OK3WJ7+CmWmWadjlLPO4XuOpwqelnVqLtDNkqkk14
 sDqi+oCAMqCLChHntkJsC0utcRZ1uftQfhoHhUM5XmAoqfK2+bjTsiC6Lw+TW54Cl8JqRzL1lWw
 q8nVOayhPU78BJLYBaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030049



On 03/08/26 10:58 am, Saket Kumar Bhaskar wrote:
> In CONFIG_PPC_KERNEL_PCREL mode, r2 is no longer reserved for the TOC
> pointer and is available as a caller-saved register [0].
> 
> Both call_do_irq() and call_do_softirq() use inline assembly to call
> functions with stack switching, but fail to list r2 in their clobber
> lists. This causes the compiler to assume r2 is preserved across these
> calls, leading to register corruption when the called functions
> (__do_irq and __do_softirq) clobber r2.
> 
> As a result of this kernel crash during interrupt handling is seen and
> the kernel fails to boot:
> 
> BUG: Unable to handle kernel data access on write at 0xc000000404697638
> Faulting instruction address: 0xc0000000000181ec
> Oops: Kernel access of bad area, sig: 11 [#1]
> NIP [c0000000000181ec] __do_IRQ+0x6c/0xc0
> 
> With older GCC, the compiler would conservatively allocate
> callee-saved registers (like r31) for values spanning function calls,
> accidentally avoiding the bug:
> 
> <__do_IRQ>:
> 00 00 00 60 	nop
> a6 02 08 7c 	mflr    r0
> f8 ff e1 fb 	std     r31,-8(r1)
> f0 ff c1 fb 	std     r30,-16(r1)
> 2d 03 10 06 	pla     r31,53297316
> 
> ...
> 
> 3d e8 ff 4b 	bl      c0000000000165ac <__do_irq>
> 00 00 21 e8 	ld      r1,0(r1)
> 28 00 4d e9 	ld      r10,40(r13)
> 40 00 21 38 	addi    r1,r1,64
> 2a f9 aa 7f 	stdx    r29,r10,r31
> 
> With newer GCC 14, the compiler uses r2 for such values, exposing the
> missing clobber specification:
> 
> <__do_IRQ>:
> 00 00 00 60     nop
> a6 02 08 7c     mflr    r0
> f0 ff c1 fb     std     r30,-16(r1)
> f8 ff e1 fb     std     r31,-8(r1)
> 29 02 10 06     pla     r2,36252592     # c0000000022aadc0 <__irq_regs>
> 
> ...
> 
> 85 dc ff 4b 	bl      c000000000015ee0 <__do_irq>
> 00 00 21 e8 	ld      r1,0(r1)
> 28 00 2d e9 	ld      r9,40(r13)
> 30 00 21 38 	addi    r1,r1,48
> 2a 11 c9 7f 	stdx    r30,r9,r2
> 
> Fix this by adding r2 to the clobber list for both call_do_irq() and
> call_do_softirq() when CONFIG_PPC_KERNEL_PCREL is enabled.
> 
> [0]: https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg313226.html
> 

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>

> Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
> 
> Changes since v1:
> Addressed comments from Segher:
> * Modified comments to "clobber may happen"
> 
> v1: https://lore.kernel.org/all/dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com/
> 
> Changes since v2:
> Addressed comments from Christophe:
> * Modified comments.
> * Adjusted the clobber list change to minimize number of small lines.
> 
> v2: https://lore.kernel.org/all/7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com/
> 
>   arch/powerpc/kernel/irq.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a0e8b998c9b5..cb010830c1c4 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -217,8 +217,12 @@ static __always_inline void call_do_softirq(const void *sp)
>   		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_MIN_SIZE),
>   		   [callee] "i" (__do_softirq)
>   		 : // Clobbers
> -		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
> +		  /* r2 may be clobbered by the callee when using PCREL mode in the ELFv2 ABI. */
> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
>   		   "r11", "r12"
>   	);
>   }
> @@ -275,8 +279,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
>   		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_MIN_SIZE),
>   		   [callee] "i" (__do_irq)
>   		 : // Clobbers
> -		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
> +		  /* r2 may be clobbered by the callee when using PCREL mode in the ELFv2 ABI. */
> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",
>   		   "r11", "r12"
>   	);
>   }


