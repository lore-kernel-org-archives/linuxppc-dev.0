Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25707606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmYmlJHq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTRRF66lWz2xmk;
	Wed, 18 Nov 2026 01:08:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794924521;
	cv=none; b=nc+QSCaoEu0I+eg7C201Af8nEMLI6IfHhHuvvEDMrZ2yMBKxrw/mai3f42J6dUCHju1oZk/S6LtnwrMFw3hkwEFeumLh+SQOBAK+U2cYZ8VIY8b+2xlcGq7Ieud9TMuT9PjfDWpRpQ3XSUAY0GjDqqQgBQFNltHtrX5/J0WTnqVN8yRlLeq/CEOvpuSXFnT3CAwvoa6eQpXuH+Wuk5Zlyl265mNE/E1sT8cP4BmLZmDm0yy8ZCXkUDYvAo7wqx97CJym/pUuVVZ62aI+4Isfoia2zh1bnd04rYMMqMy1jNjfDmrbUCfKD/c1Ppe2CxcmV581avYE9rpc+LqkFgZrCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794924521; c=relaxed/relaxed;
	bh=b0uTJrSDJvFzWRkmkFnAPcUtkJ4sMnKMKlQvmRcmj2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFOt97liy5pl+vLFghq8xI57eKgY0+w7OtosV4BH/Y9oC4OuVVF6BkFdvYdxdpsssZ0x+Ikxjyyt6a5+5x9qrfN1OSkUkSQ4cJ12g8Md0t1UEzDJutk88VeSe6OEA5klso8BfhcXzy6Z1SkD5x6voMNXVIW+21SC5NrIcqQsWh2DiQJSjlyfcTbAj5GfoZ6rTPPofOc31mSCGIvVDSg2Qqvb8gCyjzgcc6Pf7jBv52pvON4M0i242v8EZ9jfj528ILtMorMDYlST68mv8YxGSFqhdP/oTPJfpjAuZAZf7u2Vx56RYu9+rGWzfzo63Ojtuu8XADMZ/IqIKBTh4XLCFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmYmlJHq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmYmlJHq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTRRF137bz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 01:08:41 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 59B8A42A4C;
	Tue, 17 Nov 2026 14:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230181F000C4;
	Tue, 17 Nov 2026 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924519;
	bh=b0uTJrSDJvFzWRkmkFnAPcUtkJ4sMnKMKlQvmRcmj2o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nmYmlJHqpu/iBOtxaStsTIhL3ukuqd0xBqF+HtYgBN0k6zJKcD9OcNge0AEhWsu5k
	 1/LjUrAM859b0GhNx1Vxb0Z2ZOWwbkIAEmjm9ahKNckIJS+i32gyLM+GBA21IYTN25
	 /gunzASGRUn7MRF+V9zMHC32ofH28zku/Fru0crC3ML/MWnoYIUN8cAnmWK6aLCfIC
	 /H0QtPTOwJVHl0lsUCDGgR/7ONyAa4uqukShA36kuhG/xEapCzkwB6sIROz8TGWZ7p
	 PokCm1OL7RXuttF6bxFi86sPM+mSDQHYfLb5h8nmvqeGGlI037FYo86oJOM+TKmzm5
	 XaMaJb+2DQUlg==
Message-ID: <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org>
Date: Tue, 17 Nov 2026 15:08:34 +0100
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
> CHECK_WX default STRICT_KERNEL_RWX.
> 
> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
> we can see the following warning splat at boot:
> 
>      powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>      WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>      NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>      LR [c0000000000ac200] note_page+0x4d8/0x4fc
>      Call Trace:
>       note_page+0x4d8/0x4fc (unreliable)
>       ptdump_pte_entry+0x70/0x94
>       walk_pte_range_inner+0x15c/0x260
>       walk_pgd_range+0x6d8/0xd5c
>       walk_page_range_debug+0xa4/0xf0
>       ptdump_walk_pgd+0xec/0x304
>       ptdump_check_wx+0xd8/0x154
>       kernel_init+0x94/0x26c
>       ret_from_kernel_user_thread+0x14/0x1c
>      Checked W+X mappings: FAILED, 1 W+X pages found
> 
> This happens because CHECK_WX noted a writeable + executable mapping.
> 
> This happens because execmem_arch_setup(), checks for
> struct_modules_rwx_enabled(), while kprobes depenency on modules was
> earlier removed via commit:
>      7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
> Since the insn slots are only written with patch_instruction(), which
> does not need this mapping to be writable. This patch fixes it by
> checking for strict_kernel_rwx_enabled() instead.
> 
> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/mm/mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index b617b69452cd..77b63b52d8f2 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
>   
>   struct execmem_info __init *execmem_arch_setup(void)
>   {
> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;

Looking at this, I'd use PAGE_KERNEL_X instead of PAGE_KERNEL_EXEC.

Then we could get rid of PAGE_KERNEL_EXEC completely for powerpc.

>   	unsigned long fallback_start = 0, fallback_end = 0;
>   	unsigned long start, end;


