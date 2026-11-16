Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9ED606A880
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPgY3ZKm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSpqh1PF5z2xf8;
	Tue, 17 Nov 2026 00:39:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794836352;
	cv=none; b=HRANTKufPGb9MYF58ZOExCX4eq30FpOQ+/QLCzjDEvyMkJKy7hddt08zZKAl8ENuy4xrVdvJFCtfTSZGYEkkJ3gmH4EKwbsJNBQTa5ZC50FbOTsf38Z97tJPKriJMVteduc9DZqxX2Z19IsmgDcd5q/JSoI50IVYSuuhn1X/1cfU98PDMrRTCubm50q9AXrJW3XtuZEDM6rZxO9VHQJCH15eEL3OXRPnGmwBI9C51hVoGC4A1OxEZ4onFRb03egO8A2kuLAn0lsLXUSxYksGhC/uM8udYxsicp/mBvX/b3X4efdiFsn5YWrAysWwj2VK8PxMAJjxhL8JomxtpK43Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794836352; c=relaxed/relaxed;
	bh=v+u8WOi6enSXf9p1uj17AxTmnZ64Z9UB12nhM5b0wBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNJO9chRNrUp0MsWNINscrwy/IRxPFB9dIxJLTbZWXCvaBseqsTwlTR/ILONMKf6339hnU5oxziNodcDrhwLl8hKWqx5FZeP1wPYHdbr7zgUpn0i49WmsQ3gU2ntlOoxKVB9rUy3ArMNB3T1/gJUXRx6VvdtaCbefScemieuQI7p2l0PBWtl0ESB7Omh/qRUFL/wvWqSqzvQsmUtIJSMKROiix14VyMG4pzloejQfDYWEk/ROO2Nc2XcAl5DFyf1g6aBHnyWwIApW5XZ4d7H3tPXAEkObo5Fn/E7doqrqyuBV+khcMs5xgV4oE3Fwy/qwIGM3eDfTwqYaSaCJS9lRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPgY3ZKm; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPgY3ZKm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSpqg19ZRz2xSZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 00:39:11 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AE8A961D1F;
	Mon, 16 Nov 2026 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809881F000C9;
	Mon, 16 Nov 2026 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794836348;
	bh=v+u8WOi6enSXf9p1uj17AxTmnZ64Z9UB12nhM5b0wBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lPgY3ZKmD+AWK6OsqmvR2cCzK6j6u/WxfP3iaSyX9l+sr/3pxKSwrPdAxFUmB9xHS
	 Te4LG33kqlHxat/w0CkHdvZDbte0OMXN6muIL0x7x/arXg19Oq+TkrYgugukT86AIP
	 fBQDoHj+srBScbYERGJVtYGkySVWbQmNxiPyppwSnff8r1Gg1X48YTJ0M5spgri9sZ
	 cgtJFF25gMSdEn28dVFmDAaN0XSm5PAYY5CqRCitHfF55dnu7PV8zepEY0Q/zX8K79
	 MrjkPdaIuSw/y1vNQhJjd47gBkODFnoQwepsvQQyFNRel7sOC5ngZ+n7SoMLX7mQHl
	 QgBPPOdHcj0UQ==
Message-ID: <afebfaf5-f3ee-4234-875d-e5ebf1ee64fd@kernel.org>
Date: Mon, 16 Nov 2026 14:38:58 +0100
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
Subject: Re: [PATCH v3 04/10] powerpc: kvm: allow flexible PAGE_OFFSET
To: Arnd Bergmann <arnd@kernel.org>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linusw@kernel.org>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Malin Jonsson <malin.jonsson@est.tech>, Matthew Wilcox
 <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Nishanth Menon <nm@ti.com>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20261116124832.662455-1-arnd@kernel.org>
 <20261116124832.662455-5-arnd@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20261116124832.662455-5-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Arnd,

Le 16/11/2026 à 13:48, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As described by the Sashiko bot, the KVM code on powerpc has multiple
> hardcoded PAGE_OFFSET values. In order to change the default, make these
> compute the correct register values from configuration symbols.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   arch/powerpc/kvm/book3s_32_sr.S     | 4 ++--
>   arch/powerpc/kvm/booke_interrupts.S | 4 ++--
>   arch/powerpc/kvm/e500_mmu_host.c    | 3 ++-
>   3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_32_sr.S b/arch/powerpc/kvm/book3s_32_sr.S
> index 6cfcd20d4668..0d8a7857f2bd 100644
> --- a/arch/powerpc/kvm/book3s_32_sr.S
> +++ b/arch/powerpc/kvm/book3s_32_sr.S
> @@ -113,8 +113,8 @@
>   
>           li      r0, 4
>           mtctr   r0
> -	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * 0xc))
> -        lis     r4, 0xc000
> +	LOAD_REG_IMMEDIATE(r3, 0x20000000 | (0x111 * (PAGE_OFFSET >> 28)))
> +        lis     r4, (PAGE_OFFSET >> 16)

This is not enough I think. You need to load ctr with the number of 
segments you want to populate. Here above it is hardcoded to 4.

>   3:      mtsrin  r3, r4
>           addi    r3, r3, 0x111     /* increment VSID */
>           addis   r4, r4, 0x1000    /* address of next segment */
> diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_interrupts.S
> index 205545d820a1..ede394f3f63f 100644
> --- a/arch/powerpc/kvm/booke_interrupts.S
> +++ b/arch/powerpc/kvm/booke_interrupts.S
> @@ -230,8 +230,8 @@ _GLOBAL(kvmppc_resume_host)
>   #endif
>   
>   	/* Restore host IVPR before re-enabling interrupts. We cheat and know
> -	 * that Linux IVPR is always 0xc0000000. */
> -	lis	r3, 0xc000
> +	 * that Linux IVPR is always PAGE_OFFSET. */
> +	lis	r3, PAGE_OFFSET >> 16

Maybe use PAGE_OFFSET@h instead of PAGE_OFFSET >> 16.

>   	mtspr	SPRN_IVPR, r3

That's probably valid but wouldn't it be more correct to use 
interrupt_base@h as in head_44x.S and head_85xx.S :

	lis	r4,interrupt_base@h	/* IVPR only uses the high 16-bits */
	mtspr	SPRN_IVPR,r4

>   
>   	/* Switch to kernel stack and jump to handler. */
> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
> index fa6128119874..9edad9bed589 100644
> --- a/arch/powerpc/kvm/e500_mmu_host.c
> +++ b/arch/powerpc/kvm/e500_mmu_host.c
> @@ -115,7 +115,8 @@ static u32 get_host_mas0(unsigned long eaddr)
>   	mtspr(SPRN_MAS6, 0);
>   	mas4 = mfspr(SPRN_MAS4);
>   	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
> -	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
> +	asm volatile("tlbsx 0, %0" :
> +		: "b" (eaddr & (rounddown_pow_of_two(PAGE_OFFSET)-1)));

I think this is not valid.

With PAGE_OFFSET equal to 0xc0000000,

Before:

eaddr & 0x3fffffff

Now:

eaddr & (0x80000000 - 1) = eaddr & 0x7fffffff

>   	mas0 = mfspr(SPRN_MAS0);
>   	mtspr(SPRN_MAS4, mas4);
>   	local_irq_restore(flags);

Christophe

