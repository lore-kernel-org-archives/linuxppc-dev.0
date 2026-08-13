Return-Path: <linuxppc-dev+bounces-25796-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A542C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:42:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLG5C3gYnz2ySS;
	Thu, 13 Aug 2026 16:42:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786603375;
	cv=none; b=D8Q3bqYxKIut1Zo1/QcgtTnEQAdn0Ju54FGIGQ5338y+zIF/KK99UtxCqI+cG4p1cV4+jbMY6rZ05Ln1ujEo/xUrBbvxziJmfjtEHOKath3tPhipuX5VSOei0qDKOVGp3Sl58OWtRznxLPAhd7HbKhTEcPhNIAzpKfRPm+mhgj2VUhmI6WzB2T3Tod3/wjlJo0HuaUomKQqmAOU1LLhQE/j+0rFWP1E10O3KBBy6p8dAzksurtzJIBJlXXQz//dWKLVie8afAq2N65A/mQwM2zAYUteCHLTYnEdsECihcRY5c4PQQQGckEoOG+O8yh9JVHioZF6bNG3PF0yFUoLdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786603375; c=relaxed/relaxed;
	bh=uaSzHWaOFN72EaZfiE1M78+a2f7rwDazuDou8bxYOf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZDxMY7oVu+f8JbwFlwG9B3ATDDw/vYTL5MV6Rpb0SPDDoCWxwjjWXlCJZESe0aZ5hjj5rJGEBA0mTfjTOIOCqWRqzsk7f7Tve41iRqD87FD4dmwfIioXpWBfhong6dFT/F/NcND9Ck4i0eNjHyNV9ehpSRGy34y4IXm6sAceVgpbOsgOF4vhVT0J3HrOxiiFQPQC8qD1K9VAFsbEtAZ7L1RXjIuKc6pxeM6/ErKN4FWRxy7Z2N3AnbinvgB2O65uhDcQku0XZ7pfkJ2bqPtIAcusLwPXbNJZliilVKpQXDwS0DyNs9Kn6GCTSs4YBLF1x1ekvWjN7cK+1Ajqv3wZVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm7XyDHp; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fm7XyDHp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLG5B3QJVz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:42:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3FAEE41B3D;
	Thu, 13 Aug 2026 06:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78651F00A3E;
	Thu, 13 Aug 2026 06:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786603369;
	bh=uaSzHWaOFN72EaZfiE1M78+a2f7rwDazuDou8bxYOf4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Fm7XyDHp2m+zUWtDRROYbmG87+u4zgdweTEKGAH1K85yvgRQMyMxo4QaVfF9mkFQZ
	 MDN7QS83XSckq7+cVR/1DHoYDH7BEg68+ikFk5FGHg+cczKscJAZ9oycWhhInYY1Y+
	 CDd+Mj1mJCdjTT4e8fD9djNKcbyCnOYDmuHbNYeyDhEtBNGhzLyq4WDfVB6P1jXPn1
	 X1QssyhHKZ6A4HNp7LSd3PO7BsOKo+zOYlSpzF3M9mNBI7+2beh3wCeAB3Yoz4cr5t
	 IjPBckTWA+SQNsWHWdQLJf2vaDgX51c4ej60yixuM+dDDEAohBufvhGt7g/oMUBKxf
	 r6/PmsDudV/fw==
Message-ID: <4e0d3ccc-04b2-41a7-b498-a7f55c18d596@kernel.org>
Date: Thu, 13 Aug 2026 08:42:42 +0200
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
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, sshegde@linux.ibm.com,
 mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <4882a3cc-30f4-477e-8126-0c244b4a5072@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <4882a3cc-30f4-477e-8126-0c244b4a5072@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 13/08/2026 à 08:36, Venkat Rao Bagalkote a écrit :
> 
> On 12/08/26 8:50 pm, Mukesh Kumar Chaurasiya (IBM) wrote:
>> commit 334f3f6d7a16 ("powerpc/entry: Disable interrupts before 
>> irqentry_exit")
>> fixed a BUG in preempt_schedule_irq() by calling local_irq_disable()
>> unconditionally in arch_interrupt_exit_prepare() before irqentry_exit().
>> The fix is correct in intent but uses the wrong primitive for PPC64.
>>
>> On PPC64, local_irq_disable() only sets the soft-mask
>> (irq_soft_mask = IRQS_DISABLED). It does not set PACA_IRQ_HARD_DIS in
>> irq_happened and does not clear MSR[EE].
>>
>> This causes a continuous WARN_ON boot hang on Power11 pSeries LPARs
>> using the dedicated-cede cpuidle path. When the CPU wakes from H_CEDE,
>> interrupt_exit_kernel_prepare() calls replay_soft_interrupts(), which
>> dispatches pending async handlers (timer_interrupt, do_IRQ) using the
>> DEFINE_INTERRUPT_HANDLER_ASYNC macro. That macro calls
>> arch_interrupt_async_exit_prepare() -> arch_interrupt_exit_prepare()
>> before irqentry_exit(). With local_irq_disable(), PACA_IRQ_HARD_DIS
>> is not set, but next_interrupt() unconditionally asserts it:
>>
>>    WARN_ON(!(local_paca->irq_happened & PACA_IRQ_HARD_DIS));
>>
>> This fires on every replayed interrupt, looping indefinitely and
>> preventing boot completion.
>>
>> Fix this by replacing local_irq_disable() with hard_irq_disable().
>> On PPC64, hard_irq_disable() sets irq_soft_mask to IRQS_ALL_DISABLED,
>> sets PACA_IRQ_HARD_DIS in irq_happened, and clears MSR[EE] — satisfying
>> all of:
>>
>>    - lockdep_assert_irqs_disabled() in irqentry_exit_to_kernel_mode()
>>    - next_interrupt()'s WARN_ON(!(irq_happened & PACA_IRQ_HARD_DIS))
>>    - preempt_schedule_irq()'s BUG_ON(!irqs_disabled())
>>
>> On PPC32/non-64, hard_irq_disable() is equivalent to local_irq_disable(),
>> so there is no regression on those platforms.
>>
>> Fixes: 334f3f6d7a16 ("powerpc/entry: Disable interrupts before 
>> irqentry_exit")
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://eur01.safelinks.protection.outlook.com/? 
>> url=https%3A%2F%2Flore.kernel.org%2Fall%2F6f9bfb0f-b14c-468e-bb9f- 
>> c157d120d0dc%40linux.ibm.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Cf780f6a2abcf425c875808def90533e4%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639221997929524168%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kOer%2B610LkQs0ZKBn%2FutIB6j1bMoFasK4DmX4AEWOXA%3D&reserved=0
>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>> ---
> 
> 
> Tested this, and it fixes the reported issue.
> 
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Didn't you say yesterday [1] that the change doesn't fix the issue ? Did 
I miss something ?

[1] 
https://lore.kernel.org/all/2f7e6c34-7258-4b20-a38e-cedebccb835f@linux.ibm.com/


> 
> 
> Regards,
> 
> Venkat.
> 
> 
>>   arch/powerpc/include/asm/entry-common.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/ 
>> include/asm/entry-common.h
>> index c5adb5006361..de64389b0815 100644
>> --- a/arch/powerpc/include/asm/entry-common.h
>> +++ b/arch/powerpc/include/asm/entry-common.h
>> @@ -270,7 +270,7 @@ static inline void 
>> arch_interrupt_exit_prepare(struct pt_regs *regs)
>>       }
>>       /* irqentry_exit expects to be called with interrupts disabled */
>> -    local_irq_disable();
>> +    hard_irq_disable();
>>   }
>>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs 
>> *regs)


