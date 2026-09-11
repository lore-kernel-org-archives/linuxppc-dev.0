Return-Path: <linuxppc-dev+bounces-27128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77417C88E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 13:32:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhFpG5jXNz2ypw;
	Fri, 11 Sep 2026 23:32:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789104290;
	cv=none; b=YkRAyV9KBqTJKCpFZUuRZl7ZunX3RjrPi9hfsxYWe8sCXdrEXdk6XM09BRSYA8gsMOosZgu76o70KPSRrzDRRJkl/rzMe6X/u646J6jhbJsYotvowHA/82BplT0R9J8InNjd/svV9lzTNR2vbiQPr2WNK77qm5L1ITzJy3gHO969df//40MEkHP5CFH1q7ymz1LbMWHRiSHMTPnCxBoCCuj0o6WiLqZpwARHS8OmioM8HmIZE3k9OTM+bGsP2MWfVgnGjASbXCkctdL3zQZa4EHpgPzD5meYK7K/ScQlzIaLzLTqYWl8XF2A/ngUwvt829uQHBgCGnlFKebUNTpMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789104290; c=relaxed/relaxed;
	bh=WPT5/AHY7+piJs39GlSgVXX0zmrz48MGY79/VqTO0Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYw9EpNpEB9JAEG0rWKsECpLjRSaI+QlYy9vUlGIbYKUrqYlswWZOu5y+q/GY5bdHN8M0wW6+NfGHPRMqfkk7ezRs8lBmvtzZmCfx9zzNW0PS3nHhVV4CdGEQo+ziljimGxLYh1OJeTq2BVinRLf9xbdhv1G8M9bIFa1BUlB/X2OC7kjLGJX1+7XcwS4bF0rID9WD6L056k5hcUZjW/MajQ7UTFg2GMBomQeoJrB5lCvxFMf8x5NLE1fDmmuyvN5S0mjAI2fQHWEe+FpPB1EOtbVtNqolKh1PoPRAA3HzTyf/hZ50uNJ8r5lO+GWkWMNKlZKMeUfrQIjVOBwjVYa0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TNmpP1Fn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TNmpP1Fn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hh2zj2p1vz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 15:24:49 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id 98e67ed59e1d1-396ccc02279so512090a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 22:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789104287; x=1789709087; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WPT5/AHY7+piJs39GlSgVXX0zmrz48MGY79/VqTO0Wo=;
        b=TNmpP1FnVZXRMdZ+1GQIXsMup+/86h/rBXfZyEAIOqnVxiWGA4rLP4UZVGOoo456Je
         lx4yNSyBVA7z5YyH679/ObNOXdCTBAM9RiLnTCGstiHeFp66vxUa+7xnGzvLX8jpiJxZ
         n2fuCQoTL1MC43nMJBJC17kc8X45f9EVE9SUF9F3b5FSB8xzNuAwLVf3r/tPwIf1R9vv
         +AdxM0gSxKgK/Sjp4wLhPtTCnQ7eo9kJ4Jb0m1pT+33+PsSCys3K6ZruOp6Uch68+984
         KbcnrnfToDATxnqMcDUGxreIrjHyWSpKXCD4RSrZTNeBOlFoTrvqskIsspN+wmTEl8xm
         ARiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789104287; x=1789709087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPT5/AHY7+piJs39GlSgVXX0zmrz48MGY79/VqTO0Wo=;
        b=Q+Ja22O7ryK10xq+PU52RVHjF5lgfLZUaQ6BS8/Hv0dCBkhXvSOwi9H9AUH6XKmBFd
         FJG2ZtjJGfFxdrnyYZsMRqfgSTGNnyFRHnhCo4Phx3GQhec0Ha9ntpKfa9VYQYj1KR7d
         Pza8oRo2SaQDXdLLHf24rWvNmlS6XgldN0ecrzR9D0Xz8tMmUiZ8jILN/+mPuYfxrhV5
         25uNz5bGvHR4g+zGllrxRgUaDQc4+nYHAtzfSdduAdLo71aYHjnhFuECk3Hlw0nTj1VD
         8tCEzHclT6++ctccgTj80N++f46/5dH8xn8ikwosOk299yCSA7DMO2rAA+2VOmcDF1FH
         aAFg==
X-Forwarded-Encrypted: i=1; AKwUvBxoqJvXgsKHBS/6xQ+IA5EFzcm6T9OaUTeCy/o/AG2ZEGPVfK13HHB2qxChjJvQg5cpv8T+yPCF7xRLgkE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lL7CQB3L+jc7VY/7ZHbzdRP5OF10RIP6OCD8usiq54jZfR+tLF
	HtsFOvd3jWXKERz+9hplHWnE50sTwqDTTg9do/tMMm1IzHBzsh334o6w
X-Gm-Gg: AYBFou1sOuS0oiUSF9oiIF2Da/Ku1VZBTt0gR6HwuHFV9kwGhY5EG/9ANvHznI1AImF
	D9vNCxucpmo1mzDIBssAkOm5IVnI4NopCpC+UtUG5OdwaYq70OEOg4qogRlG+MOoyE4qIEPfKSn
	FIC+SaKUxK3g9hVtxAtVy2gDABbBnCNCa/KrbW0HKRnRg3HyiPXaZCYg5TOhL+VsY09v8cDlMm4
	94a81nYgnysH7EWzskt8jZ6R7uDABBTPcSUNkDKljvlBri0ccYr1P62XGrMqUmTxWPpGLWVlDub
	cTSzEn6plE0jgsQv4Vmhp0iEfSmy9KA63hRkoVx+GMGXKws8UW7mQdrDJ7H8/Dw4xNL6p4MrJ2B
	x27S+sj5XkV8r+joSKdrBcLhd7IOkBeWo0vaLTHjpOv7MBFDGoIZiLL1oBL0prfEZvHt0y0vqmQ
	8NOrImK6sgBgVMEgxgNIXQkgAAHIP/QxTTXH2f0CbxviB5QJgYwJGJadzEJD6B39+Nhgaadgk3D
	69tZkbGtQ9KSVefVNlhFZhTkk0vtbUJ0/yhczvCVNpM/g==
X-Received: by 2002:a17:90b:3906:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39d9c3727b3mr3899237a91.17.1789104287013;
        Thu, 10 Sep 2026 22:24:47 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365ba71cesm3416735c88.13.2026.09.10.22.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:24:46 -0700 (PDT)
Date: Fri, 11 Sep 2026 10:54:35 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH V3] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aqOP8C7ahcxCng7L@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260910100801.2159785-2-mkchauras@gmail.com>
 <ffd8e0c3-0d78-46ee-9ab1-59dbfe0b6d27@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd8e0c3-0d78-46ee-9ab1-59dbfe0b6d27@kernel.org>

On Thu, Sep 10, 2026 at 05:08:48PM +0200, Christophe Leroy (CS GROUP) wrote:
> 
[...]
> > -/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
> > -   sizeof(struct bug_entry), respectively */
> >   #ifdef CONFIG_DEBUG_BUGVERBOSE
> > -#define _EMIT_BUG_ENTRY				\
> > -	".section __bug_table,\"aw\"\n"		\
> > -	"2:	.4byte 1b - .\n"		\
> > -	"	.4byte %0 - .\n"		\
> > -	"	.short %1, %2\n"		\
> > -	".org 2b+%3\n"				\
> > -	".previous\n"
> > +#define _EMIT_BUG_ENTRY(label, file, line, flags)	\
> > +	".section __bug_table,\"aw\"\n"			\
> > +	"2:	.4byte " label "b - .\n"		\
> 
> Ah, you left the b here. The label is 1b which mean "the first 1: you find
> going backward". Could as well be "1f" instead meaning "the first 1: you
> find going forward".
> 
> So I think you should use 1b or 1f as the label, not just 1.
Hey Christophe,

Thanks for the clear explanation, this helps a lot.
> 
> I would also try to use #label to stringigy the label in order to avoid
> having to put the arguments into quotes (untested), same for other ones.
> 
Ohk, letme try that.

> Cdlt
> Christophe
> 

Regards,
Mukesh
[...]

