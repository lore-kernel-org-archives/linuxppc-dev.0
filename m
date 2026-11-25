Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABF7606A327
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENpgOhP3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZPhR1lWPz2xS6;
	Thu, 26 Nov 2026 03:07:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795622839;
	cv=none; b=IhpZJsHUjT+rX86+y/n6kPuVXxh6nZmkhrnEPYUnFyk9+W3xAeWS5tLCFNNu7B+nBHukBxDGZ834AnqskktdiyDmzTulRHNkRdmXsnE4Bvhh2jiG2GvEGvnUpDp7L3ezyG34FK0SSO4222fTnPovyZBQVR34B83WmsgvJ7yoInyj2/zuGP82d3v24CjrQHxHuEyfMLM4NOFl/5cmxxOvXALYGtk5id0caYbrQnxYxO4nTMGAomqepe6JAqngcp+GZ36lXXb3/yJjhnsDKV04oUWSqXou44DHV9UsiM21Jw0zCg86OTmJqK1uIOBulzCNuweNiVeLy5Bgr8RfrR4vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795622839; c=relaxed/relaxed;
	bh=V+c7efN+kejpOWutWyfpTAMXZ8OZ1LgKeXSCI+Lspfg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=GNzIipZ2HtZLiyYaBmxXaUPm6S1pFDyY51kPedEhn484OTF8KqU2aub39F4Vc7qTjHUMSraGdwg6cdEJFbSpUojS1Yq7VkI68IDEsENeol4jhLWWZFzOGmr1OwT0xs3ODNNicMoi8YYhp8Ql/0GvzBGMN58ER9KtA8J+UavkmwuMA7BP9drlLsB6Okz25nv5enYiwIJzVGBcGXrdZQthF5l2yDDFc4Mlb6r8GnZ9Y02e8yb7szoYQciWpUHBSSu5WC0s1pxHKEWSGFv+d6gVu9LODqZZG1mYd58ANe+Iro0f7RkrsdPctOgszcjb6Jwb1V3sKvemHJWHiMsiUVF0MQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENpgOhP3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ENpgOhP3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZPhP4w2Zz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 03:07:17 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-14394530ec6so8344483c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 08:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795622834; x=1796227634; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V+c7efN+kejpOWutWyfpTAMXZ8OZ1LgKeXSCI+Lspfg=;
        b=ENpgOhP3ZqiHOuvzU84UzJmsSUYWOKn8UqG5+bxhp7MKVJldt5EcfsZU6Iw86CakZV
         +7aDN2Aq/CaRbwPVsixL0yHkb9TpPN/CXhPr1yC3EWSsMI6CegRKD2DrwHZHZrcObA8V
         24v+a2+J114LxVY6ZX0N6vIca7g97zN1v2XkNPNETLZp/DrXwaE0PYQPF8wUauEPuJeC
         tEnD4D86BJUTeXmaoQSsqRk+qFhE4TjBKc17j83V/xvyInuceh9gbo3CbPbUa2AeP3aX
         q2ScdMfd957XVsjo9EQvyWZ0l3LgtCExZRbyhMWjaIxn81KJl3lIm5F95GwjOFm1/caD
         4hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795622834; x=1796227634;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+c7efN+kejpOWutWyfpTAMXZ8OZ1LgKeXSCI+Lspfg=;
        b=X3R/jfEfzwU4O541dWWIMMDUDhfkwPVXSjjxI+eCnSwA80EwGAkzldqfFPUVMGaOvB
         Sun7/LvtcaGXSGXwK/qKiUWKHNj6AEHFIzF4zwmdwKYcRPnnRetH255o9Kj5eAxmyHnd
         x+rtEFXEorjAvYnfvSx5Dq297mZlkw17EOO1+M2uhh8MU593Wf2A0U0ST8ZKDrf9e3h+
         5Gv0vV6072a7MtUVVNM8/SXxm+aULcCUWCfcI3ShpQ2KyZDbqU4cFcU07STU+q95/3KO
         wQH5fkv1S/n3FWG43qWyaGowkRjgy6RG2jgp3dG5mkaFEX8LN/lWNtli5humh6yPi+hk
         MBsA==
X-Forwarded-Encrypted: i=1; AL+hErFT1MWA2JNLhmlLoQx+vcqH/h0cAN1ql/BnoNQ4CkLEIjH8VenZ6gFpzjcDjaJZ6BEa613SRKgPXgcNnfY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8a2JSEzEyB11S/zSYnGnCKRpWtMYhGn952dx8486u6RFs9UrnE
	m1avtJfsZcW4M5dERUZfl0vJHWfjP+vXD3FgZHv2kFjLcu/kDJiCyIGj
X-Gm-Gg: AZFdTZekMWtah20rIt0iu6NAAAPDpQhNqLOTJJyfCwgMr0ysDAY6B6/OEmi5Nt5LjNx
	KGnhIKFWgAKQmtPK5Or2NPOxVS/0lTKXpBr9QnrV57yWVarlcfKNtLMBGnnVzGubExHfEC0s18X
	JrZA7qHp+1nAcpuzpRjWuX08q4Zqlvei1qXmBjSivIQ7bEp5tLkbYynH6gIc8yWS6vuhQR76brl
	qFUxhzvtoFES35QlKEmpVbJIF04OKgqzYXxSIvKerGKNvh4OpTFsNuLpgAkRY7RZVhkoyH58oUq
	4loDpXfHHGsUY97l/0GctHsDOWHoAEKIPqgGzzShDitRA+KsVzMdIVcp+8tmXrNa33XbApH5niN
	rI+WDL7t39q6voUpMUfp0QkfkGPFJgkS80tnxTl8HWveF8ziSaoJ2KEAXWmbyHfhGBfRKTRTQg1
	kZMrrbMJAdt3gnHATTxf0plgD8ELzS6l6c3vgvsLJD21XJQqkWAiIpy9oUGvOYthgPgPo4waI1T
	EUbxh6QpzYThAkh5hAXLNWNqdESbbeVRm8MS//77Hzk6XXopVMibK3Mc6b3ZeiFY4FAaOKPBjtd
	7d9JtzQxQXGSj8jDwy7QYnViwUA=
X-Received: by 2002:a05:7022:f109:b0:1b3:8814:8383 with SMTP id a92af1059eb24-1b55689fca6mr14160449c88.9.1795622833867;
        Wed, 25 Nov 2026 08:07:13 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm43726453c88.12.2026.11.25.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 08:07:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 1/3] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
In-Reply-To: <0a6fbbd8-6339-444d-bcb0-a74980fb77c8@kernel.org>
Date: Wed, 25 Nov 2026 18:35:47 +0530
Message-ID: <mrqxjc2c.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com> <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com> <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org> <v75v752e.ritesh.list@gmail.com> <0a6fbbd8-6339-444d-bcb0-a74980fb77c8@kernel.org>
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Hi Ritesh,
>
> Thanks for your patience,
>
> Le 17/11/2026 à 18:15, Ritesh Harjani a écrit :
>> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>> 
>>> Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
>>>> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
>>>> CHECK_WX default STRICT_KERNEL_RWX.
>>>>
>>>> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
>>>> we can see the following warning splat at boot:
>>>>
>>>>       powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>>>>       WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>>>>       NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>>>>       LR [c0000000000ac200] note_page+0x4d8/0x4fc
>>>>       Call Trace:
>>>>        note_page+0x4d8/0x4fc (unreliable)
>>>>        ptdump_pte_entry+0x70/0x94
>>>>        walk_pte_range_inner+0x15c/0x260
>>>>        walk_pgd_range+0x6d8/0xd5c
>>>>        walk_page_range_debug+0xa4/0xf0
>>>>        ptdump_walk_pgd+0xec/0x304
>>>>        ptdump_check_wx+0xd8/0x154
>>>>        kernel_init+0x94/0x26c
>>>>        ret_from_kernel_user_thread+0x14/0x1c
>>>>       Checked W+X mappings: FAILED, 1 W+X pages found
>>>>
>>>> This happens because CHECK_WX noted a writeable + executable mapping.
>>>>
>>>> This happens because execmem_arch_setup(), checks for
>>>> struct_modules_rwx_enabled(), while kprobes depenency on modules was
>>>> earlier removed via commit:
>>>>       7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>>> Since the insn slots are only written with patch_instruction(), which
>>>> does not need this mapping to be writable. This patch fixes it by
>>>> checking for strict_kernel_rwx_enabled() instead.
>>>>
>>>> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>    arch/powerpc/mm/mem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>>> index b617b69452cd..77b63b52d8f2 100644
>>>> --- a/arch/powerpc/mm/mem.c
>>>> +++ b/arch/powerpc/mm/mem.c
>>>> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
>>>>    
>>>>    struct execmem_info __init *execmem_arch_setup(void)
>>>>    {
>>>> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>>> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>>>    	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>>>
>>> Looking at this, I'd use PAGE_KERNEL_X instead of PAGE_KERNEL_EXEC.
>>>
>>> Then we could get rid of PAGE_KERNEL_EXEC completely for powerpc.
>>>
>> 
>> I think it's best if we keep the definition of PAGE_KERNEL_EXEC on
>> powerpc as PAGE_KERNEL_X, I think the core expects the arch to define
>> this, if not, then it defaults to PAGE_KERNEL e.g. see this:
>
> Yes, which is consistent with what powerpc does when strict modules rwx 
> is enabled.
>
> And indeed it doesn't matter, because module code does a rw allocation 
> at the begining then convert it to ROX or X later in 
> module_enable_text_rox(). See comment :
>
> /*
>   * Since some arches are moving towards PAGE_KERNEL module allocations 
> instead
>   * of PAGE_KERNEL_EXEC, keep module_enable_x() independent of
>   * CONFIG_STRICT_MODULE_RWX because they are needed regardless of 
> whether we
>   * are strict.
>   */
>
> So really PAGE_KERNEL is what is expected nowadays.
>

Thanks. Yes, I looked at the git history and I agree with you.

>> 
>> include/linux/pgtable.h:
>>    #ifndef PAGE_KERNEL_EXEC
>>    # define PAGE_KERNEL_EXEC PAGE_KERNEL
>>    #endif
>> 
>> Also mm/execmem references PAGE_KERNEL_EXEC in __execmem_init().
>> Although it references only when execmem_arch_setup() is not defined by
>> the arch (which is not true for powerpc).
>> 
>> 
>> However, even though nothing breaks today, but later if there are other
>> users of PAGE_KERNEL_EXEC, then PAGE_KERNEL does not have X (execute) bit
>> enabled, so it might break in future. Plus looking at above, I believe
>> there is no harm in keeping it - since core expects the platform to
>> define it's own definition - due to all the other references it has.
>> 
>> Thoughts?
>
> Yes but PAGE_KERNEL not having X is on purpose, module first allocates 
> non-X mem, sets up everything then converts to X or ROX. I don't think 
> there will be any more users of PAGE_KERNEL_EXEC in the future. It is 
> going in the other direction I think.
>
>> 
>> However, if you still think we should remove it (?) - then I feel let's
>> do that as a separate cleanup patch. Since this keeps the usage of EXEC
>> same between prot and kprobes_prot variables in patch-1, which we also
>> need to backport.
>
> At least we should stop using it in our own arch, it would help with 
> readability. And really I think we shoud drop it completely. But OK to 
> have it as a separate patch not to be back-ported.
>

Right. Agreed Christophe, thanks for sharing the pointers.

After looking at the history of changes in there, I see that since commit:
  4fcc636615b1 ("powerpc/modules: Make module_alloc() Strict Module RWX aware")
module text is allocated with PAGE_KERNEL, when STRICT_MODULE_RWX is
enabled and only made executable later, so there is no longer a reason
for a separate name there.

So, let me add a separate patch in this series, which will drop
PAGE_KERNEL_EXEC definition from powerpc and it's last remaining users
will be converted to it's alias PAGE_KERNEL_X.

> By the way I also see CONFIG_ARCH_HAS_EXECMEM_ROX, maybe we should 
> investigate in using it on powerpc.
>

Yes, while doing this work I came across it too. Surely, will take a
look at it from powerpc perspective.

> Christophe

Thanks for the reviews! Will soon spin up the next revision with all
comments addressed and add this cleanup patch at the end.

-ritesh


