Return-Path: <linuxppc-dev+bounces-28263-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6621BC98318
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 07:47:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsKR42Z1Sz2y24;
	Sat, 26 Sep 2026 17:47:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790408832;
	cv=none; b=E5lSwu7AgT558R7OocJhOxQQGRSgJF5uH4tr3KOTt505A/SnBXEWU/cPstauWNsYZa/NQA7egopeAOZ6CyBBuWfHo09XEn32YbYbSGRTCPpgGpgPXHCRzxbBcFDGc9LrmGS0I7cJaDgMoPqLu1SWqoqjIcMD31kWNzgxhsZNI/NmPXhb8Ar1PBanfouMsOYzT9lBN1Hy1qedsTDuA/0wACN/nDcrPdq9z3LdFp5DF09LOoh6sIVkfWzZGi91OOdYJ+1Av+LoUZAplsi4PWflPDi9mbUxdaG7EZ1IOM1VIsAohont/ED+rWB3OSqjZkOYyqVOnbVWFRlKBQ/2bYe/gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790408832; c=relaxed/relaxed;
	bh=wrw6MYauCv8ojbkVGE0/DH1V6nBqh+BVfWF8V89VP1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+IrL4KOP7uT8RLqzzPj++R00SbIXRwP0q/kiDhpk4b+pm7m0+GDHQn6y1Am3SlSdqrKPRU5Z88NrqppS4fqqRCBhb9VkiFn/xArCtbVc5O2GZhCoZYWimNwHsYJWY8iKREcUvttosSkF6AlcLnCeqLtb9OO2Vp37LKzouLe4HK6HnMkuAjxZ+ssK0cLqNiegVZ1I+wv4WVgKoD6mspsrEqbLErRtrH5/8F50aUbMnLm7bVFMYbSRGYFTlkYDyHidQtOodvb1uZhY0AU5Ewy7bEa37BrugbdbbyDDDtPYGG0iKMTQPsDJUsLFvHVXKLXnMs43ygVnHaIAJnB6jymWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLfMscGB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLfMscGB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsKR24J9Lz2xwd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 17:47:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 788B943C06;
	Sat, 26 Sep 2026 07:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F58A1F000FF;
	Sat, 26 Sep 2026 07:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790408827;
	bh=wrw6MYauCv8ojbkVGE0/DH1V6nBqh+BVfWF8V89VP1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OLfMscGBr6BX8Yna19+gsaP22UJ+VC6W76Sm1UE/FlcJ15iqFYFvbP8d90Igg0AX1
	 etwZZWvdBFqYZ7NSvihHp+SwEwBuk701GAxfmSO6piNYjNYiaHlu046T9GjwlMO2xf
	 4c1bAB9kwCau4RjnCCKk9fIPdqnFDhybBXluZ4npAQ+/Qvix5ljL2AzBzj8Usd+RJB
	 alu3Ul+qNVip0JJyq+c0VPs71CaO7MwDN5xY42FOblZ0wy/sGg+Vkn4Rt8NPoSJNVK
	 MPrtXSD7KUf/JpSLiGjV6OU4NBwSkGGFUelmNzH6itp7ArEwWPKw0np5F/RZkSk9Pv
	 v3y9vQMfZ/lsg==
Date: Sat, 26 Sep 2026 10:46:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] arch, mm: promote DEBUG_WX to CHECK_WX
Message-ID: <ard4bg-fJZUwlZav@kernel.org>
References: <20260925-direct-map-verify-wx-v1-1-7fd2f7d6d23b@kernel.org>
 <c8bd5eb2-d411-4b11-8f51-1309374bd466@kernel.org>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8bd5eb2-d411-4b11-8f51-1309374bd466@kernel.org>

On Sat, Sep 26, 2026 at 08:47:50AM +0200, Christophe Leroy (CS GROUP) wrote:
> Hi Mike,
> 
> Le 25/09/2026 à 11:53, Mike Rapoport (Microsoft) a écrit :
> > Verification that the kernel does not have writable + executable
> > mappings is about detecting security risks rather than a pure debug
> > feature.
> > 
> > Major distribution configurations enable it in their kernels as well as
> > defconfigs of most architectures that have ARCH_HAS_DEBUG_WX.
> > 
> > Rename relevant generic configuration options to use CHECK_WX and move
> > their definitions from mm/Kconfig.debug to mm/Kconfig.
> > 
> > For arm that does not widely enable it, only rename its variants of the
> > config options.
> > 
> > Enabling CHECK_WX adds a few kilobytes to the kernel binary and while
> > the added size can be slightly reduced with churny updates of
> > architecture implementations of ptdump, the core functionality takes
> > most of the added size. It cannot be moved to .init.text because the
> > verification has to happen after init sections are freed.
> > 
> > With this, make generic CHECK_WX default to STRICT_KERNEL_RWX while
> > still leaving users targeting small kernels the possibility to opt-out.
> 
> Looking at how it is done in powerpc I have some doubt with your reasoning.
> 
> ptdump_check_wx() will report regardless of CONFIG_DEBUG_WX:
> 
> 	if (st.wx_pages) {
> 		pr_warn("Checked W+X mappings: FAILED, %lu W+X pages found\n",
> 			st.wx_pages);
> 
> 		return false;
> 	} else {
> 		pr_info("Checked W+X mappings: passed, no W+X pages found\n");
> 
> 		return true;
> 	}
> 
> The only difference is we won't get the WARN_ONCE():
> 
> 	WARN_ONCE(IS_ENABLED(CONFIG_DEBUG_WX),
> 		  "powerpc/mm: Found insecure W+X mapping at address %p/%pS\n",
> 		  (void *)st->start_address, (void *)st->start_address);
> 
> 
> And I believe a big fat warning like this is a debug option not to be
> enabled on production kernels.

It's arguable that this indicates a security risk and you want to see it in
production as well. And on many major distros DEBUG_WX is on, so you do
have it in production.
 
> So I think we should instead do:
> 
> diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
> index 240bd3bff18dd..714f63fb604a0 100644
> --- a/include/linux/ptdump.h
> +++ b/include/linux/ptdump.h
> @@ -33,7 +33,7 @@ bool ptdump_check_wx(void);
> 
>  static inline void debug_checkwx(void)
>  {
> -	if (IS_ENABLED(CONFIG_DEBUG_WX))
> +	if (IS_ENABLED(CONFIG_PTDUMP))

I don't think we should change that.
It's up to the architecture how they want to report it. If an architecture
wants to keep the warning only for debug it should convert WARN_ to
VM_WARN_.

What we actually should change is debug_checkwx name :)

>  		ptdump_check_wx();
>  }
> 
> 
> That way you should get (untested) the following warning but not the big fat
> debug WARN():
> 
>   Checked W+X mappings: FAILED, %lu W+X pages found
> 
> Christophe
> 

-- 
Sincerely yours,
Mike.

