Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CC8C00319
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517902147A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517902147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444qs72Ck1zDqKJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:07:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444qpw6ph3zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:05:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444qpw3yxNz9s7h;
 Thu, 21 Feb 2019 21:05:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/4] powerpc/64s: Fix HV NMI vs HV interrupt
 recoverability test
In-Reply-To: <1550672893.su6y10x0gg.astroid@bobo.none>
References: <20190122064618.1510-1-npiggin@gmail.com>
 <20190122064618.1510-2-npiggin@gmail.com>
 <1550672893.su6y10x0gg.astroid@bobo.none>
Date: Thu, 21 Feb 2019 21:05:27 +1100
Message-ID: <87bm35wj6g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Nicholas Piggin's on January 22, 2019 4:46 pm:
>> HV interrupts that use HSRR registers do not clear MSR[RI], but
>> NMI entry code is not recoverable early on due to both using HSPRG
>> for a scratch register.
>> 
>> This bug means that a system reset or machine check can cause silent
>> data corruption (due to loss of r13 register) if it hits in a small
>> window when taking an HV interrupt.
>> 
>> Fix this by marking NMIs non-recoverable if they land in HV interrupt
>> ranges.
>
> Hum, I had a v2 that I didn't send properly with a small compile fix,
> but I've also just noticed this:
>
>> +void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
>> +{
>> +#ifdef CONFIG_POWERNV
>> +	unsigned long kbase = (unsigned long)_stext;
>> +	unsigned long nip = regs->nip;
>> +
>> +	if (!(regs->msr & MSR_RI))
>> +		return;
>> +	if (!(regs->msr & MSR_HV))
>> +		return;
>> +	if (regs->msr & MSR_PR)
>> +		return;
>> +again:
>> +	if (nip >= 0x500 && nip < 0x600)
>> +		goto nonrecoverable;
>> +	if (nip >= 0x980 && nip < 0xa00)
>> +		goto nonrecoverable;
>> +	if (nip >= 0xe00 && nip < 0xec0)
>> +		goto nonrecoverable;
>> +	if (nip >= 0xf80 && nip < 0xfa0)
>> +		goto nonrecoverable;
>> +	/* Trampolines are not relocated. */
>> +	if (nip >= real_trampolines_start - kbase &&
>> +			nip < real_trampolines_end - kbase)
>> +		goto nonrecoverable;
>> +	if (nip >= virt_trampolines_start - kbase &&
>> +			nip < virt_trampolines_end - kbase)
>> +		goto nonrecoverable;
>> +	if (nip >= 0xc000000000000000ULL) {
>> +		nip -= 0xc000000000000000ULL;
>> +		goto again;
>
> Tried to be a bit too clever here. The 0xc... vectors also have a 
> +0x4000 offset so this won't catch them properly. I'll respin.

Thanks.

I'm seeing the same build error as the kbuild robot too.

cheers
