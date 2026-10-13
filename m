Return-Path: <linuxppc-dev+bounces-29368-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1656BCA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:13:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3vt94T2Fz3brM;
	Wed, 14 Oct 2026 00:13:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791897233;
	cv=none; b=VAuIwHAn5912XLDFiENEYOykmgnQQx60FGxAteuKyS8r3BBaavCgjwPaPLsiRQlCyn79rShdtdqcWoBPzpbI9cCxqTsERckLK5I0xDtjUSjLfgrnNjJTh4+snw2ZhrWBcSsPHuY6o6r0RoIqI0pvZyIGDupweQ9+ZP0n9b4cvSZ004mI/F3xrKAQG9r5uzeNKslYvsQBk/+5yu7WRjjBHQZNvqO5rtYcTTJsGS3YiG+ZyS3HBu9eN9PacDOrEtx1RlIH8G6aLm0v02gw7ZAz341PjZc00EkpT/drfzxX6LjasBKkRsypB0H3aR81EEuJCaj68v4EqXMjdVMwpHfONA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791897233; c=relaxed/relaxed;
	bh=I/tAlO2Ru2n+9OCc1aJaId+5L7PReTvcGlCIUg5MWD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxUZwTAVt5QnwlU53bcMVxlgRjLhbrqiBa/CL860HFz17h0FlTUYYd9eizj3vDO8ceX1thDX5SYzOVKMHVJOZga3xK3qQ9vltRxgWgo3sB5iX1S5un3HORjGP2ByP1M5RoxRwDdNsBiYN49L1fCrPTkIxhngWn6XJkr2972IPy1UBAp9o3zL3Piy6blXWgpzDRzbs/joUZ7dTR5Df7PCEgQudY+huxemFL4CXVLaCl7DlRGUECd11+3qK5yMdVppm1aHnVlwDbAd3nRlfDyEAaq9MhoQf4s5PRZknxyc8B3EWsvDh7PmTJfJO2aSGFNoe/ci0O4Lru4Nc5BonTTA4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NhB2lEIJ; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NhB2lEIJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3vt8063rz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 00:13:51 +1100 (AEDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-8ab38a051aaso22462497b3.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791897228; x=1792502028; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I/tAlO2Ru2n+9OCc1aJaId+5L7PReTvcGlCIUg5MWD8=;
        b=NhB2lEIJC0nycPI7JHFu3zWWxGUDjwBunQmh2Z3M8EdQ+M4siHKwUiyzso/iLajwc3
         KtLEcsb6gS+FfFZD1isLxkejnJEymxVLJRbig1urKZ6flsjGHEyVbv98oHQcoMQudN6P
         8YvpLP13e+pxfyTi39T0r/cL5IdP4CW7PKkiIbQCVmm6AGvlgk3oHCfR+NoMeFcR5U1R
         /wj5SYZkjdCc5jM4G97ZzWtRaAJzxs+8s3atWCYAYCLb1jo+ZpdafRcCARpWJzRJnY5j
         ++SxRZ5qe9nc944rjjtAxTnPDewYFjXcdRBQUfz/6YtythzK78DZ4qorWGHsyzsfDvax
         wHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791897228; x=1792502028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I/tAlO2Ru2n+9OCc1aJaId+5L7PReTvcGlCIUg5MWD8=;
        b=pbxHRM4pc8d6dIIQ5Jq6SyRUEr1LbG9BzXQLmOYA3Hq9ChlKdfyCQSD/ugeks2+8W7
         GKE5ujU88MrNsfh9oCPse/XgKLEKU7wYd4XiLdVhEczu1IMx2E0Rtzx8JDxA8dhwsjZu
         HPwH15StihRlxQTKt0TNx7Q5zJRoPZlMOQDzMmUH+AUi9DRTGxlAaQ3mIFOxxFFfEN3u
         kLIpiguUp5CT2j1tq0AjJmx8JLw3deMj5X0+QIqErNJ7E/5DyWdUtY9mnZBbi2+RTWom
         IiNGj2sjkqK0QDuDwWR7HIDCX4/hUXolbWt269rYof5va4iOSJZ5eNL1sYQu3dOjerlJ
         5v0w==
X-Gm-Message-State: AFq9FYJfMi3I5vpC3zEw7svZc7IyqSEFb/4c5VdhmFGT5Q2mM7U7NBvZ
	mBw9WDOUGfONDQMiQfAqtaOGzOTq+U7pN5+YeSn4ed3lPEuAmq/yr3e4
X-Gm-Gg: AYBFou28GziulHNFtq/YklpgpwmkuI/5B6eEM4hF35nsq0VL+K7r4Kke4qdHJFLl3T6
	cni/sr1LpPck1LExEfE1/MGsnMRZ43bNgQ0UK51N2npGluHU7vAQhvobK5mrwa7IzSiW3+gkCBi
	mtcrh5iiFmvD0xpxAwYXB38CjXGvSQzHHTd+YdFOo63VsdMRBwvhMJgPHoeckNZ2uFWTXfpyLzc
	p7p7zhM6jQ8SLFp6WbIhJkeQttuk7fAtFOfbpg26PfMYu2VakM/5fQht74O/Uaz+hb+7LPvWk7F
	1fzuBDJxkwsV10oqoupjDWt5n3Y9LPe/+5gGy2dEyycAxZ+a9dUCe59lYpMDk1OZYFIxm24bSM8
	1OZHRuOSVYLP6pTxONwXJKctxVX+QN1j6Pl6TDOXZ5WeMBBWbtmFoMYx+YAreT6DHTUqrYqelsJ
	Cum3v6sl2DTe8i4OrRlkaf2XAHq9DIkNsBG5JlkLgkZG0FQRhe60DgHfzlGQMnQ6LQC8RhSd8sG
	NTwYKyV3ipWPYysF7aJ+SjVgdBjVxF7htejoyzJSS37
X-Received: by 2002:a05:690c:a4d8:b0:873:5c7b:c102 with SMTP id 00721157ae682-8b07ee83c2dmr39395797b3.58.1791897228016;
        Tue, 13 Oct 2026 06:13:48 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1b8ab5sm44012217b3.17.2026.10.13.06.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:13:47 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:43:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, 
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc: Restore all registers after a traced
 syscall again
Message-ID: <as4rwq7OXutW3Wa6@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
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
In-Reply-To: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>

On Mon, Oct 12, 2026 at 07:38:28PM +0200, Michal Suchanek wrote:
> From: Bernhard M. Wiedemann <bwiedemann@suse.de>
> 
[...]
> +/*
> + * Syscall work after which the exit must reload all registers from
> + * pt_regs: a tracer may have changed any of them at a syscall or seccomp
> + * stop, or under PTRACE_SYSEMU. Audit and the tracepoint are included to
> + * keep the pre-GENERIC_ENTRY behaviour.
> + */
> +#define PPC_SYSCALL_WORK_RESTOREALL	(SYSCALL_WORK_SECCOMP |		\
> +					 SYSCALL_WORK_SYSCALL_TRACEPOINT | \
> +					 SYSCALL_WORK_SYSCALL_TRACE |	\
> +					 SYSCALL_WORK_SYSCALL_EMU |	\
> +					 SYSCALL_WORK_SYSCALL_AUDIT)
> +
Hey Michal,

Thanks for this.
I would prefer this to be in thread_info.h if it's not creating any
cyclic dependency or any other issue.

Regards,
Mukesh
>  /*
>   * This should be called after a syscall returns, with r3 the return value
>   * from the syscall. If this function returns non-zero, the system call
> @@ -117,9 +129,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>  		regs->gpr[3] = r3;
>  	}
>  
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(READ_ONCE(current_thread_info()->syscall_work) &
> +		     PPC_SYSCALL_WORK_RESTOREALL))
>  		ret |= _TIF_RESTOREALL;
> -	}
>  
>  	syscall_exit_to_user_mode(regs);
>  
> -- 
> 2.51.0
> 

