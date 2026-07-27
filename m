Return-Path: <linuxppc-dev+bounces-24889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCB5C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:09:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7y7g6wjsz2yhY;
	Mon, 27 Jul 2026 22:09:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785154159;
	cv=none; b=AfuhvYW7FHyTEZko3U5FgxLSB24Ez9Gxk0uqKrdxYlW9L75IhglD8CE1yhhtYPP1Ab/zEDe5JbNkqqBtIojoGdR7MBxIaZSnjfbgX32jIS+eqLTC583h618YVMBkZ/CLXCczVZ3qDytKlNampaiHV+xklFkH7fI3HCHz77fQcfY0f18eSjRLiu0X9Xn3Ft8EZ3xxWaxLcmrQtMwlx4z/uwfFhOjQL1QMC2FNfKQg2z3BD1hkt6BpRU4TwI2W04+tTQZ4+AD261n7t1TKIUdMRFQJ0hqdN97rzgupf1SfjQfsmtUfanfC75UsuK2+8JdFJauUmDNwilfJFIGkuo6giQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785154159; c=relaxed/relaxed;
	bh=es9szWdyIlsG4q+xS0+CmM6PVBbF7s3g2iIfm68cxO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0udEVpGPqvGNi1936zCcwuzYJ4f/XsTbYHfR4yZYZDurSFKWUPROvHvp1dyuIJnYc5k+wtOL9EbVllGYsHub5KFwK+tmL7sZsplFL2iscF+JxxzCR1IXc0oNoqvOj3UiHc/5IxSitWB7txRR/1KAvc7Af97aiclRVcUteMQEc/KPbmXKk46kGxoyzDq/89X6aU8t9FNMdhsDijwyg1z16dC34eey8j0gykoojqqZ6W2UIVo9GFmt8FaOsipSWaPruhMXp0cSN0aT6UUPLvs6rdWdKiuJYSEl54xFTtmVShxYoL0Fwz8i3Ags97wbZdt+SL81JkW1aPkvejq36M/lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLOFOVUr; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLOFOVUr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7y7g145gz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 22:09:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 55CE9601EC;
	Mon, 27 Jul 2026 12:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B031F000E9;
	Mon, 27 Jul 2026 12:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154156;
	bh=es9szWdyIlsG4q+xS0+CmM6PVBbF7s3g2iIfm68cxO0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MLOFOVUrgZsCNGMNzBsEItbhkvABSU2ExXrWFgPl9lPvkOtSoETIjV1SR1SS9dWNH
	 2FPlVXGDxSiyJpPTNlfvR8lS2jP23yyI5pnucF21CirxcllLnThRYjfl6itqEi/BzF
	 3phhBjnEvKGtnp6RKqp2u4MuUE1KyDxNFL+MUKq0hKENt+2CTqzRbc075SNfUteqsz
	 qmWOrByQoLbDnCdEWjEd5ilsp2ZCqcqyVmeahk5og1HwFFJxW/cS3iomVLsTQ+I+bq
	 waNym11yaN6MLgiChjK6dp21vmvbod4R4UNo8u584GG+bfCEQaFXL4JcJ50ghDjIL4
	 Lg4seDXK5CfsA==
Message-ID: <63007c21-4783-4a98-9853-62b36b737df3@kernel.org>
Date: Mon, 27 Jul 2026 14:09:12 +0200
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
Subject: Re: [PATCH v2] powerpc/irq: Fix missing r2 clobber in PCREL inline
 assembly
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 segher@kernel.crashing.org, hbathini@linux.ibm.com, venkat88@linux.ibm.com,
 yeswanth@linux.ibm.com
References: <7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <7c84fa5e24263d8247b4723118e6130d63b40912.1785131859.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/07/2026 à 12:58, Saket Kumar Bhaskar a écrit :
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
> Fixes: 7e3a68be42e1 ("powerpc/64: vmlinux support building with PCREL addresing")
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
> Changes since v1:
> Addressed comments from Segher:
> * Modified comments to "clobber may happen"
> 
> v1: https://lore.kernel.org/all/dc021f42afa10396052499cbeda1772e30b7ca64.1784530547.git.skb99@linux.ibm.com/
> 
>   arch/powerpc/kernel/irq.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index a0e8b998c9b5..b5343cfd6c9f 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -218,7 +218,12 @@ static __always_inline void call_do_softirq(const void *sp)
>   		   [callee] "i" (__do_softirq)
>   		 : // Clobbers
>   		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "cr7", "r0",
> +		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */

Not sure the comment is correct. You get CONFIG_PPC64_ELF_ABI_V2 without 
CONFIG_PPC_KERNEL_PCREL.

Kconfig help presents CONFIG_PPC_KERNEL_PCREL as an ABI extension.

> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
>   		   "r11", "r12"

To minimise number of small lines I'd prefer something like:

		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6", "cr7", "r0",
#ifdef CONFIG_PPC_KERNEL_PCREL
		   "r2",
#endif
		   "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12"


>   	);
>   }
> @@ -276,7 +281,12 @@ static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
>   		   [callee] "i" (__do_irq)
>   		 : // Clobbers
>   		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
> -		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
> +		   "cr7", "r0",
> +		  /* r2 may be clobbered by the callee when using the ELFv2 ABI */
> +#ifdef CONFIG_PPC_KERNEL_PCREL
> +		   "r2",
> +#endif
> +		   "r4", "r5", "r6", "r7", "r8", "r9", "r10",

Same

>   		   "r11", "r12"
>   	);
>   }

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



