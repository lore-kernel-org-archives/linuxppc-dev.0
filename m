Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2DD606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 10:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MP0Xmk6X
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKMYD5yjlz2xNC;
	Wed, 04 Nov 2026 21:45:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1333"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793789152;
	cv=none; b=kdgFltDf6taruutsPoJiKmOeUOetXHKgSfz/q7BgtHOlM+q5zgzV7QD7X31o9RhltBgUvXgaGohBj69SgD+KkNzIZt9QoXj+ZtO7Fbw7bMk/Vi/OuB5cKaNW+jK7THBw2DukbjoNP4yEoK6ushdWWm9KfxPc4VxPm4T7YmgAIijVDGAFnje/rmhJG6Pq3YnOzCuxsdd1YarGaPQhcnDcdPDXovPz2mMIV7Ga/7LzODiNMcPC8FfL4FPmg2H+kH+sqXMXa+cGemJsMGXoOsggxAuJXyL21h8jABOfGx71Rz8eKxqdj8139j4D4+wQ8dBLFavrn8NSr6Z7NYEqc4nE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793789152; c=relaxed/relaxed;
	bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=ZTRmZ+jdWRrfFH8Szce1WPrWWnOwwqmEnf/J/BaFZkciUtSGP1Duk43YXIG9ato91Ph3EvhPjJnVHgA7jvHEx6DA45tDNHH4w6BKxylQSPGBu1mvAlxlgcy5bttJvhjpEz4/RXRu0zGXjR+yb6pzUh9b1WKNeUeGGxSvqKiALEFReEA3jX+A1cxXKcGslXkOaHI84EQRVQnVReMKrSqoELrBgsUKzXa13ywG7shP7xgzuly78wqu6bePil7wbZV0AwrwA63lc2eb8CLgPaf9bcpdrCk4W5XlvWr+PKYUk7dagxMWelSOdyQVKWKlIWJx/TCs2nRkbWbW9zIgv4QCxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MP0Xmk6X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MP0Xmk6X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1333; helo=mail-dy1-x1333.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKMYC2VhFz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 21:45:50 +1100 (AEDT)
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35c76e9614aso669524eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 02:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789148; x=1794393948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
        b=MP0Xmk6X0d6ptI2iFkS1xyKH+FNsMALZNkUu0qCU2dYzl3/CnPYOotDmA9Pa1/jBlC
         vYI4YBy00xQZfEPLp/ojnJqOVqmhNxONQ1zzPYfjBxnjAKJVSGBsyguwgzO2pyrVHx5O
         Peoe3X4INRPO46HH9jbt7c+x1Jyoj7gSUDa7NHLhTzVpfVRPH9e9qVbU4rZKutO6sA4k
         VlcvFYrCpl0+DG0QO9APkMOuxWalbltrtqnwtOoaK17V/fyOcNq2L+vjMAH8IkNHNysz
         yiCGvFlAeQpCbM9UfuGkq6xZhEZTePVqh7UaxEqBVVNf0lddmEsMR8tUg9EG35x9f+Xi
         ULYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789148; x=1794393948;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
        b=cIiOTcPrcux7QU0H+0+zAPktkIHoWEfKQLAQhTihuYFXku55GeigkPjMb+3pG33gVA
         5oNEghtSWyI44621ExK5vXSTG0TIX88t84rtyXO2LJIpcA4Cg1Wf3H7bfNSMe0mg50qX
         z012ILTBLsioJBTZ3ytAcj/NLMrYt+0J/MHiEVajWxb/oKwzIhnGmtyO5YBP0boLnCN9
         WV60/MhetWQzqfTaUomurSyhngPpQqOOxhjD1JNdJVoytSg8xIgyGUkAvgVEjNTkHNwI
         KBttkUpvg1xMG483q+EI5cb06DPuBEnAQ+L+I4cq/M5ZXC+amZkJlsvnIaUNLXswPwZj
         CABw==
X-Forwarded-Encrypted: i=1; AKwUvBzChUP8SnGbv17c/E8yk/1iRFDX+2k2aDFKvfBqoi3kuFGp5QBU8xjUyRVYhGYvZFVOZ6NGc1z/NGbGOmI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8jTJuQt0sPoNZjPpUDyz0skK4I4y6X4/BHStCp3+Ro8gYjjo/o
	GMaMmKeMY/xA649mgQmY/29Yp7mob8rnhkAT9NJLKtiQaH41SvJO+5nY
X-Gm-Gg: AYBFou2CXChW2HtpUB2jDjb819xnqtlZftvbgbCmgk9B9CiuXq2aLJ2QGVcVgDMtVUq
	qjaY9Ev4zCXI3YOC84FFpXFz/7WWmDXP0x7oVBfIOJrlaYRet0baa7S0uHnYST3PcNZdnHor4i+
	ukgVxTvwZ182/2TtIdr9sQI+75gmqWigDeZzCQjTHIHJPIj/A7FZ/rAP/Lf3p5c7zVK5qstj6AZ
	09yqbwpZn0iwfrIwufdkAuMnJA3peL6+nKOxtMUtUhIkgf5GYpQBts4rOTyyW4qcPvsxtPgIOyS
	rQrxhhBkh5QYPatBhpV/AiiImVg2dFVgIQ9pE69VryEeJyKBmcZ35DTGTlR7slwuNL+30K/BPUZ
	+AH33TVjY+A2LkJuJGK5ClrFNbKdh3RIzDSvwx7Gfe/MhFvg2I5JGsppDlhkTxxymxHDCow1Wbx
	jxtLriemqhbJxWV9nVCk68NA5P+7RJCFSE4FznIdN8dLxtE+WEr9J+4RnqtOiShzMaWi8HV15Wn
	2fHxxwxzu9MGa/nUUyxVyCH++ZslP6wSp6qK9lrl2fC979VMYQK1QAOWoMhceO586t+30xPDBbf
	wCWeOXKPm9g7/hG7sZkXQod3zTU=
X-Received: by 2002:a05:693c:4009:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-36a42331666mr23336378eec.7.1793789147820;
        Wed, 04 Nov 2026 02:45:47 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca362f38asm7670687eec.0.2026.11.04.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:45:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, stable@vger.kernel.org, Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: [PATCH] powerpc/code-patching: Flush the patch area TLB entry locally
In-Reply-To: <bf838fa6-a175-4514-a496-c6ec9b03ac7c@kernel.org>
Date: Wed, 04 Nov 2026 16:07:08 +0530
Message-ID: <qzh06fxn.ritesh.list@gmail.com>
References: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com> <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org> <wlqu5lej.ritesh.list@gmail.com> <bf838fa6-a175-4514-a496-c6ec9b03ac7c@kernel.org>
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
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 03/11/2026 à 10:12, Ritesh Harjani a écrit :
>> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>> 
>>> Le 03/11/2026 à 03:54, Ritesh Harjani (IBM) a écrit :
>>>> patching functions like patch_mem() and patch_instructions(), maps the
>>>> target page at the per-cpu text_poke_area, write it, clear the PTE and
>>>> then flushes the tlb using flush_tlb_kernel_range(), with interrupts
>>>> disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
>>>> based TLB invalidation i.e -
>>>>
>>>> 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
>>>>
>>>> ...which will wait for other CPUs but with interrupts off. This can be
>>>> caught by lockdep with the following warning:
>>>>
>>>>     WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>>>>     CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>>>>     Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>>>>     Call Trace:
>>>>     [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>>>>     [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>>>>     [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>>>>     [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>>>>     [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>>>>     ...
>>>>     [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>>>>     [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>>>>     ...
>>>>     hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
>>>>
>>>> Josef confirmed that this was causing a hang (deadlock):
>>>>       I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
>>>>       CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
>>>>       fine 9 of 9 times with jump labels off. The hang comes while static
>>>>       keys are patched and modules are loaded, nothing is printed and the
>>>>       watchdog resets the board. OpenWrt keeps jump labels off on these
>>>>       boards for now.
>>>>
>>>> ...which is possible if both cpus are doing similar operations with interrupts
>>>> off and doing TLB invalidation using IPI.
>>>>
>>>> Broadcast TLB invalidation is not needed here since text_poke_area is
>>>> a per-cpu area. It is mapped and unmapped with interrupts disabled by
>>>> it's own cpu. The only reason I think, if we would need a broadcast tlb
>>>> invalidate is, when we want to prevent a stray or malicious write to
>>>> this cpu text_poke_area by another CPU. This generally gets solved with
>>>> temporary-mm path like how Radix and even x86 implements. However, booke
>>>> doesn't implement that, so for now let's ensure we use local tlb
>>>> flushing for correctness.
>>>
>>> This problem was already discussed one year ago, see
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FPA3P192MB2865C07D634E3B775D003C7F8CD7A%40PA3P192MB2865.EURP192.PROD.OUTLOOK.COM%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305489629%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=RgVxRJOlFSWgNsFSKwLDRinx3kaF4LpSiCaTey8xtic%3D&reserved=0
>>>
>>> See response from Arnd, a stop_machine() should be done for completeness.
>>>
>> 
>> I will have to take sometime to go over what ARM does here with
>> stop_machine(). However, either ways I think, we still need this fix,
>> since otherwise P2020 boards gets hung during boot. Thoughts?
>
> That's right, it must be fixed. The global TLB flush must likely be 
> changed to a local TLB flush, but that's not enough to get a safe system.
>

Ok then, will spend sometime looking at how other archs handles this.

Although IIUC - even with TLB invalidation using IPI there is a window
where the remote cpu could use a stale tlb. But the window is too small,
however, with only local tlb invalidate, if in case the remote cpu has a
stale TLB, it will never get flushed.

>> 
>> 
>>>>
>>>> Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20261026195644.16384-1-pepe.schlehofer%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305519321%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A50lEHBZBaX70jGTu38GylmnQvlxVzLalMVXYj2kti0%3D&reserved=0
>>>> Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>    arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
>>>>    1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>>> index 44ff9f684bef..6351342fa5c3 100644
>>>> --- a/arch/powerpc/lib/code-patching.c
>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>> @@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>>>>    	return err;
>>>>    }
>>>>
>>>> +/*
>>>> + * The patch area is per-CPU and only used by its own CPU, with IRQs
>>>> + * disabled, so only the local TLB can hold an entry for it.
>>>> + *
>>>> + * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
>>>> + * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
>>>> + * flush just the local kernel (PID 0) entry.
>>>> + * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
>>>> + */
>>>> +static void flush_patch_area(unsigned long addr)
>>>> +{
>>>> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
>>>
>>> CONFIG_PPC_BOOK3S not consistant with commit message. Are you adressing
>>> a problem on e500 only ? on all not book3s ? What about book3s/32 ? What
>>> about 8xx ? Even for book3s/64, is it correct at all when
>>> mm_patch_enabled() returns false ?
>>>
>> 
>> No we are addressing the problem on all NOHASH platforms. IIUC, all
>> !BOOK3S are "nohash". Although some of them maybe UP, so it doesn't
>> matter whether a flush_tlb_kernel_range() is called or
>> local_flush_tlb_page() - it wouldn't matter. And on others which are SMP
>> but do not have STRICT_KERNEL_RWX enabled, they will anyway not go
>> through this path - but if they ever do - then we should ensure they too
>> do a local_flush_tlb_range() to avoid the same deadlock.
>> 
>> However, I think, maybe we could use CONFIG_PPC_MMU_NOHASH instead of using
>> CONFIG_PPC_BOOK3S, thoughts?
>
> Well they are equivalent, so it doesn't solve the issue I think:
>
> config PPC_MMU_NOHASH
> 	def_bool y
> 	depends on !PPC_BOOK3S
>
> What about book3s/64 in hash mode ? What about book3s/32 ? None of them 
> implement temporary_mm, so are they covered ?
>

They both use TLBIE (global/broadcast TLB invalidation). With that we
don't need to use IPI for TLB invalidation.

> Christophe
>

Thanks for the review comments. Let me check on the stop_machine() or
other alternative to fix the security gap as well. At the moment, I have
my hands full with couple of other things, but hopefully I can come back
on this once they are somewhat taken care of.

-ritesh

>> 
>> 
>> -ritesh
>> 
>>>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>> +	else
>>>> +		local_flush_tlb_page(NULL, addr);
>>>> +}
>>>> +
>>>>    static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>>    {
>>>>    	int err;
>>>> @@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>>    	err = __patch_mem(addr, val, patch_addr, is_dword);
>>>>
>>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>>> +	flush_patch_area(text_poke_addr);
>>>>
>>>>    	return err;
>>>>    }
>>>> @@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
>>>>    	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>>>>
>>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>>> +	flush_patch_area(text_poke_addr);
>>>>
>>>>    	return err;
>>>>    }
>>>> --
>>>> 2.39.5
>>>>

