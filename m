Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB2606A334
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flCBnIDd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jYdl619d1z2xL5;
	Tue, 24 Nov 2026 21:06:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795514818;
	cv=none; b=gPxHkXVBO/JPxkM1xz6iPPNgrc5LRQfLGixX1m+WB2I5jTK6bAh6CAfJXAEIx+UsDGf9aokvhqJ2C45Bdvyg/GaNqDUiJJw6ZEuq8vjezTGBOR5tGq6hMeyJcrjY9uAjNds6qsTtKyfz+n1T2e8pSdD1w8qq9iP5FvYi1KZOCc4/ShNHzd3qqyaIi4MqbMKUf7XhpMTEubTeY7WzJB/ikD7adfEwljPUd8fgvWlZxZVqotPUAtfs7/Jc8DNINMKo/SuO5+iBOlK6Y0wTiMabcUgvKaME8DYwWT50dZg++ok1X1aF1iDm1ObTyeXPPfH0WtmPcis/5fmuP6xtI7ba1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795514818; c=relaxed/relaxed;
	bh=SXEF56RrG5y5FAdKWjS4+NoaPcHn0Sj4aJ75nFCxeYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heUyb7fDmGxRDj6w8qXKBrIAXvFgbUGlGOko7TewUDPHigF+iePglt/ZIglPEPD6KM/kMnsvn+sB+tJnrjLqLDJdgHdmpb+k+fMsh4SU/6jHpgSi33Q8K021pmErVr9t7PrK9/+QnAm2nC3Bmo+DLIg0Lxr4iz4I//J/49sGYnLSnzQGtEKaFdD7DmmK+xjkb7U/Y6tyIl8tBzcXm5+IuXFTIPYu/3n6k6D7KeyqNV9L1NLQKaKEpg1q57CQ7BEIgLsmJzLkTgtMenHd93P0luYrwC7xnoz3RSdSdmD06tYof3VTRTtQBPfd8MUuVbIuuRSwbBNHqmBuHxf4wJiypQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flCBnIDd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=flCBnIDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jYdl50vy7z2xK4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 21:06:56 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8019840FDD;
	Tue, 24 Nov 2026 10:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1481F000C4;
	Tue, 24 Nov 2026 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795514813;
	bh=SXEF56RrG5y5FAdKWjS4+NoaPcHn0Sj4aJ75nFCxeYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=flCBnIDdaewb+skQc1KO+Zef0Qf1B9wCc2dAgiever4x7MW5nx9zb/+o4sW1y0BxP
	 H+IOx5Xu65qNlumufAS1gkDIpdCSgTbtLOpDv8tw1OOoe6sRtQUhl1VkzLwcJaER3j
	 md4cj3iCazQGmmzT1pC9W4eHz46jAvTCt5kXrutsUJNG9Hn6yl+H93EbOFLtLKCB0t
	 OpWPUQuqHCCtHYm0v+p0KZP71uiro0wOGOEd01kh4kRj+pxmoaSCrDg5ktTjqQc7KJ
	 xcYJ6y4kVJ2/YQsZcE8pS2hwRrk+OqSFVdQabFF3FIuXMEmv7AI8WviQ9Ug/FIUJxz
	 ZklrsoCYmQ7DQ==
Message-ID: <0a6fbbd8-6339-444d-bcb0-a74980fb77c8@kernel.org>
Date: Tue, 24 Nov 2026 11:06:47 +0100
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
Subject: Re: [PATCHv2 1/3] powerpc/execmem: Don't leave kprobes insn pages W+X
 when CONFIG_MODULES=n
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <cover.1794572365.git.ritesh.list@gmail.com>
 <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com>
 <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org>
 <v75v752e.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <v75v752e.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ritesh,

Thanks for your patience,

Le 17/11/2026 à 18:15, Ritesh Harjani a écrit :
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
> 
>> Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
>>> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
>>> CHECK_WX default STRICT_KERNEL_RWX.
>>>
>>> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
>>> we can see the following warning splat at boot:
>>>
>>>       powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>>>       WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>>>       NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>>>       LR [c0000000000ac200] note_page+0x4d8/0x4fc
>>>       Call Trace:
>>>        note_page+0x4d8/0x4fc (unreliable)
>>>        ptdump_pte_entry+0x70/0x94
>>>        walk_pte_range_inner+0x15c/0x260
>>>        walk_pgd_range+0x6d8/0xd5c
>>>        walk_page_range_debug+0xa4/0xf0
>>>        ptdump_walk_pgd+0xec/0x304
>>>        ptdump_check_wx+0xd8/0x154
>>>        kernel_init+0x94/0x26c
>>>        ret_from_kernel_user_thread+0x14/0x1c
>>>       Checked W+X mappings: FAILED, 1 W+X pages found
>>>
>>> This happens because CHECK_WX noted a writeable + executable mapping.
>>>
>>> This happens because execmem_arch_setup(), checks for
>>> struct_modules_rwx_enabled(), while kprobes depenency on modules was
>>> earlier removed via commit:
>>>       7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>> Since the insn slots are only written with patch_instruction(), which
>>> does not need this mapping to be writable. This patch fixes it by
>>> checking for strict_kernel_rwx_enabled() instead.
>>>
>>> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>    arch/powerpc/mm/mem.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>> index b617b69452cd..77b63b52d8f2 100644
>>> --- a/arch/powerpc/mm/mem.c
>>> +++ b/arch/powerpc/mm/mem.c
>>> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
>>>    
>>>    struct execmem_info __init *execmem_arch_setup(void)
>>>    {
>>> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>>    	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>>
>> Looking at this, I'd use PAGE_KERNEL_X instead of PAGE_KERNEL_EXEC.
>>
>> Then we could get rid of PAGE_KERNEL_EXEC completely for powerpc.
>>
> 
> I think it's best if we keep the definition of PAGE_KERNEL_EXEC on
> powerpc as PAGE_KERNEL_X, I think the core expects the arch to define
> this, if not, then it defaults to PAGE_KERNEL e.g. see this:

Yes, which is consistent with what powerpc does when strict modules rwx 
is enabled.

And indeed it doesn't matter, because module code does a rw allocation 
at the begining then convert it to ROX or X later in 
module_enable_text_rox(). See comment :

/*
  * Since some arches are moving towards PAGE_KERNEL module allocations 
instead
  * of PAGE_KERNEL_EXEC, keep module_enable_x() independent of
  * CONFIG_STRICT_MODULE_RWX because they are needed regardless of 
whether we
  * are strict.
  */

So really PAGE_KERNEL is what is expected nowadays.

> 
> include/linux/pgtable.h:
>    #ifndef PAGE_KERNEL_EXEC
>    # define PAGE_KERNEL_EXEC PAGE_KERNEL
>    #endif
> 
> Also mm/execmem references PAGE_KERNEL_EXEC in __execmem_init().
> Although it references only when execmem_arch_setup() is not defined by
> the arch (which is not true for powerpc).
> 
> 
> However, even though nothing breaks today, but later if there are other
> users of PAGE_KERNEL_EXEC, then PAGE_KERNEL does not have X (execute) bit
> enabled, so it might break in future. Plus looking at above, I believe
> there is no harm in keeping it - since core expects the platform to
> define it's own definition - due to all the other references it has.
> 
> Thoughts?

Yes but PAGE_KERNEL not having X is on purpose, module first allocates 
non-X mem, sets up everything then converts to X or ROX. I don't think 
there will be any more users of PAGE_KERNEL_EXEC in the future. It is 
going in the other direction I think.

> 
> However, if you still think we should remove it (?) - then I feel let's
> do that as a separate cleanup patch. Since this keeps the usage of EXEC
> same between prot and kprobes_prot variables in patch-1, which we also
> need to backport.

At least we should stop using it in our own arch, it would help with 
readability. And really I think we shoud drop it completely. But OK to 
have it as a separate patch not to be back-ported.

By the way I also see CONFIG_ARCH_HAS_EXECMEM_ROX, maybe we should 
investigate in using it on powerpc.

Christophe

