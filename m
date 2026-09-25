Return-Path: <linuxppc-dev+bounces-28174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8ECC9830D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 06:39:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrgyx4rSFz2y8d;
	Fri, 25 Sep 2026 16:39:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:36::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790318345;
	cv=none; b=LGSFqmEb/BY/82HQG2l/ysoLlyzPhHAnS+LA+qvhZe2yXFJk1A2RgQjA9kCav5wiNsggAZ6zFWOzNnuhK3a5a6UITl2gvGDBEWpWhgVLVTv1qE+vJKGpawZbklgFMO6uCJdVWBcBhES0rxkj6Bm1CSjuZT/e0+BSHn7sV5HemiQkWTd8v6fToTe0dY/wnKSUDn0TcAO/IX9l23h1y/Tc6JzPuhlQ1/g5SFuJi2KJNGIV2yxq6qJymeQP68y4i+xcV+GqnjzJgLZyIgaBdyrShjVk5Wa49TRPNc7zgABfDmiyM5rh8caPZNG2ZLfPYkwOsc48QyOUBlvwWWGQmxBTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790318345; c=relaxed/relaxed;
	bh=+XCKYNMunQtwjsoXeGr7yLk4ydEdG3nbjO5mlaJXoXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZF/CYcnLyoSF6Je70/NWJwYstcouB5FNDbrnNGsfQQ5MSI852AnwISuW7hkKUnSzza/tOfe7S7nX4d6frLpHcEHcPJPdKSREzERM1AnB+Flusre5oQmenzVZXZPnuQ2rOeTJFSgun97ruKXFxyg9DCFCILHbkv+6P1IurSMAu8SMlChPKrG62yx+9faGxIM9tugYwFuFkAWSnmwBMZQoYaZ5KPUz8EUEI6Y0Jp/YzkKYN8939D4gsE0XmpW7QYpkzV6f8gmi00KiT2uY06cdj9SIDRsz+U930dLiz1NQxNbHbguNDUcDGJnHiv6J/YERZBAo41D62aJIx0DlZaKug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fZHHYoyW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fZHHYoyW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:36::f; helo=mail-dy2-x0f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy2-x0f.google.com (mail-dy2-x0f.google.com [IPv6:2607:f8b0:4864:36::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrgyw5YG7z2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 16:39:03 +1000 (AEST)
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-341027843a5so309138eec.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790318341; x=1790923141; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+XCKYNMunQtwjsoXeGr7yLk4ydEdG3nbjO5mlaJXoXQ=;
        b=fZHHYoyWimfocUOQZ2Wn94sRPHnMIhRnARezM6Fjclfp7SLs0IqH82d3MBDDiyWP8D
         CX1tiDTzDanq7PItbCT7eNF7pKmL30zJTFV/KKU/P6CiXOAB4bEUhL8pFMSkLTAvB2FN
         iSi+byke4HNguVcHyafMc6irLmsKtuZ/3dQYG7rV0hrNfpeSaDTV79Za3UlvhXKKxR/I
         Et3YOP0q2zdKvY9Av6xrEDpqE9MK81SFxknSzcZpdoft8lCAu3evjswkM3qfblaZEJ7Y
         P7gAIJeW4cyndu5g2ch1/G3t8+JNJDgJAs95zezX75ZVrRPGcfQRgedqC8ncxZXqCHcI
         ARvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318341; x=1790923141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+XCKYNMunQtwjsoXeGr7yLk4ydEdG3nbjO5mlaJXoXQ=;
        b=ffUVNQ/M8n9i5M98YTkQ0cHxY7tbpuYIMxsm61sJ4sD9ZlLerTgxUCjlhFKgtZuY+r
         rkBjZjRykIVGw5cIdrUaMypZpLUp42DnUC8YXESsA+10CzW+pEfIiZAK+vod1Q5D2a2K
         269FC6nyic2X4KqJDXnqSHoScV6LpMzLNQFubJMeKzHgEAkJQhbqKZuVgjGc9QrfVDq6
         SKkatq+C7+FFn+RyAOYoIP5acylWRiSQYyQfpN4yTbjf0x2YslscxpRiNL3ute4mrkBE
         xeihl+dZ7tmhXeljoeYPBczM3U3ZJDhPOzycbBS87AKntJTUHbNOTB4fT5UDMPfM+MTa
         blOg==
X-Forwarded-Encrypted: i=1; AKwUvBzigIIm216GXjWMpJ3c7cu/XX/0NDsorZEn7NA55rUNnaDk6CMDe8gtd0cEd7L0kiDglR9H81UM12uEiEQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++n6N842O6zrIHdgWvtZyXrCWm2yxtHDADbjoOnjagqEBOuYodWR
	oSjpzn6m8cHkAmQlWwODOBkYsAPH6svpJiORqv8FSuBE9UL3O0xfUSir
X-Gm-Gg: AYBFou3HSAJdse2EX8TBitYhqFFXcMR9ey81+8JsHj1sfw1o24i+6vMznAnIwGayQTZ
	VDkS4Yz5hmXToKaA1x/dtw8aCXu1h5ZDBN5IxDTu1Ls8RmdubBOT+af04+XBuM8Lw5kPP8MdVBV
	XOaq0ahLsv1NQrSR3wUYrQX39hDAj4GOMklgIVJjstNiqb9aEpM+eXZo2WgC5SOJ1eCiWpoIgWj
	LWzuskYNtDd/V6lnPwKaqlQlaO2bhsTkNOeLfBPJ3US1m4JzQkZjuudqSJ69wOOO9q9m1m0OReQ
	Jh64wE0pw/KoeLssE8dSldmlejMvxPULz0HbLswtWu8VAPbZTE9Egd+LQ5ZNqGDWS3H9g9I7iJ5
	Ns8tfusbwjNRKbuTiqZyYqzTwbSu45IO9vh1V7OX3zBHk7Yfzb20CXJkSGv4x0817ELnmBbg1ZK
	i+Fh7wdmnxabiZHKDlxyTuy66UpGIk9Iw7jpsmp2bzh6UzbWh1SDHbO1H6o7nImuZgyU9JyHiDY
	1qGV9tcLhfbSD2uoKmWMu2ogPItLv/N36ymuUNkiJn6
X-Received: by 2002:a05:7300:7315:b0:33b:e9a7:d81f with SMTP id 5a478bee46e88-340031cca3cmr5226961eec.11.1790318339666;
        Thu, 24 Sep 2026 23:38:59 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144757f31sm6418823eec.14.2026.09.24.23.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:38:58 -0700 (PDT)
Date: Fri, 25 Sep 2026 12:08:38 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, jszhang@kernel.org, japo@linux.ibm.com, 
	jpoimboe@kernel.org, seanjc@google.com, pmladek@suse.com, thuth@redhat.com, 
	ynorov@nvidia.com, joelagnelf@nvidia.com, david@davidgow.net, 
	fujita.tomonori@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
Message-ID: <arYWpnhia9icB-60@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260922054959.955093-2-mkchauras@gmail.com>
 <20260922064735.GS4121339@noisy.programming.kicks-ass.net>
 <arNxAn7I7NCVWmD1@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <20260924111557.GP1837346@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260924111557.GP1837346@noisy.programming.kicks-ass.net>

> Untested thingies for arm64 and s390x.
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 914282016069..3d8a969eab5f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -987,14 +987,13 @@ void do_serror(struct pt_regs *regs, unsigned long esr)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	/*
> -	 * bug_brk_handler() only called for BRK #BUG_BRK_IMM.
> -	 * So the answer is trivial -- any spurious instances with no
> -	 * bug table entry will be rejected by report_bug() and passed
> -	 * back to the debug-monitors code and handled as a fatal
> -	 * unexpected debug exception.
> -	 */
> -	return 1;
> +	u32 insn;
> +
> +	if (aarch64_insn_read((u32 *)addr, &insn))
> +		return 0;
> +
> +	/* Match ASM_BUG_FLAGS() / BUG() instructions. */
> +	return insn == (0xd4200000 | (BUG_BRK_IMM << 5));
>  }
>  #endif
>  
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index b6ba4465f59d..8bbb082fd5e3 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -26,6 +26,7 @@
>  #include <linux/entry-common.h>
>  #include <linux/kmsan.h>
>  #include <linux/bug.h>
> +#include <linux/uaccess.h>
>  #include <asm/entry-percpu.h>
>  #include <asm/asm-extable.h>
>  #include <asm/irqflags.h>
> @@ -55,7 +56,12 @@ static inline void __user *get_trap_ip(struct pt_regs *regs)
>  #ifdef CONFIG_GENERIC_BUG
>  int is_valid_bugaddr(unsigned long addr)
>  {
> -	return 1;
> +	u16 insn;
> +
> +	if (get_kernel_nofault(insn, (u16 *)addr))
> +		return 0;
> +
> +	return insn == 0x0001 || insn == 0x000e;
>  }
>  #endif
>  
Thanks for this.
lemme test these and i'll send it out after verifying.

Regards,
Mukesh


