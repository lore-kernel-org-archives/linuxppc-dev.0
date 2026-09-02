Return-Path: <linuxppc-dev+bounces-26429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3F4C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZWYR3tWnz2xyh;
	Wed, 02 Sep 2026 15:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788327083;
	cv=none; b=RdsDEy/iSjbh4NBy7B+cwuo9NXzBB+0/VrLFr8CEBznWOZYVIp7Gj6/m5HdCfBUIVHv08yGMBv7/m19ItO9tUbzF2GBrjEd2TkPV+27q0daNi/NqGCoZP6QvAaowWLyBD7Cjl96VKo/GjxwcuStWEJC7TXvQjtbH66GGLIUcoenss8lFpYuxVtZ9ze9WRMUNqJ2XrzDC1/jZVB3DKh6an3au3ZgbUGIF6f/NIzUERNXw/Qp5cAx2xN+7AkgwWPKBRQVoYMgzqBqAVOdJFzGrgKHTUdpa0g2GOPebVersGBrEGX1gG5pd8orlMkovD0+JHtMAtg8u8mcfiBRaWDerrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788327083; c=relaxed/relaxed;
	bh=kU6RxwKiDhyQdRcFqAcmJYzkzhMZmlQGVOgZ8yrarwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+jF13hlN5VTM6ogs2fc+xknF8y4G4FV5Zww+7c5E7p8HhQHogcGB30eOJNMKMte2PewOiKO1/jJy2CAAM4ldC+c6hg/xNemuX7UHsfZK6ba4ZKIqtVUViLHu9jAFlBHK4nzElxCKJdbYJ6yVubt0KsWnhyQQDFRSR8BAR0dvgkhATVCwr+pR3V+52bC2BvJSUMKo4kZNJCAStCvpzm++0hHGUdAQZAl2Iy/cS8bNFLmnVKSj3kmelRdGxmhnFFF4pI0DwQSrY5kxLdz2S+LCRS/RRCo5w9wDa9TfnETSk9AVdySmGJ5QRp5fF9iE8zsEhuFqSEnbbOgmE07uu5Wkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DP1yprE4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DP1yprE4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZWYQ0Xlnz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 15:31:21 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-395cf2535acso666470a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788327079; x=1788931879; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kU6RxwKiDhyQdRcFqAcmJYzkzhMZmlQGVOgZ8yrarwI=;
        b=DP1yprE4wUEtd1lCOtEMVFuW8i3QmxgcJ6My795yHdO3RZC+nhzbt6RUJ01z44LHon
         EnfOBYn+87Kf9kV7XKCmR4dlEUQ4vYCi2wUTcPoAS+Zl3shrHWZjNhUfHIWUszoUDvCl
         EcSmRLEbVaFJ6I/0/6bQIdH4TG1G75RD4dnPwRG4HwQuA0vF214maICJ+9WM+ZQt1W12
         AfaOLL/xbAwMQfudo1XLi540I1nUvcW8n/Zu8dj6mimNXerKKsb32hTS0rvVtGTxo8X5
         4llFqgaJk6c4p4CSGLrsJkeBOviwxy3VDQBhD3aWxrvuNJUQhnrwLRSV0pQIMQfL0/uL
         5Ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788327079; x=1788931879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kU6RxwKiDhyQdRcFqAcmJYzkzhMZmlQGVOgZ8yrarwI=;
        b=ACtp/OOFK/5XVzJsDGdOIe9VrsrOYLtDnvXcQq0qFQcxaJMB2MRgBMLQgBgMfjWMRz
         HIqcxD+3VZugR35vmYwKLCYmnuiCQps499kYj9+WhJwQWO6APvCegh3ZZm1ruThnV7RB
         B14z84xtqjk/woILOmI1Q3RdWi0xDk8ma6mRCUnHjiQHXHc0u/QuiYPNH5kNkc6Pij71
         0N1TE4PZe5GIPo/Qfx9k1nLKdjOfm90lvvTQLQtojmOxKwxSo90/mmaFCDdYxARKdExq
         fhiHPeefZAfJuaiscjCq0AkNKBR5sUwK73K5nat94P3MhU6C6rEAaQe3tAcO5QBdqZx4
         OiBw==
X-Forwarded-Encrypted: i=1; AKwUvBwNUWSbnovutssThqmprMrkSsEw+ZR+c8Zlrq9v/5o7g1gnaFhVG3yf/BimoIac1qz4iStEgIGfMnMjdvU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nyPPcarmVjFaUPLOj635qividutzbZNs285yGocvi8GBCb+JmQ
	ZpzwqwhVgknocXSF2xOBPLeB5fNVI2XTFGv/ZqhKAlSi0XMUvkxDibHe
X-Gm-Gg: AYBFou0xjed1WjKH9KndHIMji16C9hVzV46hC8sMLN1H3mww2wlH3gzKwFvpTRKZQQN
	ww4xDfbwtTHXGKoXqn/s5LS404ln4kn/ecMZE2c72Std6Ebx2Mud5g/hzR21RjcB4LN2a7B+JHQ
	R8l5ta7HKdHRRI+j/HcU8KCSQJCwz0+k7ciKg1TVP5ZUQFXGhqYI+oKnp2cCSpH/PO/zrnW6NQB
	191bx7IqQIxRTwwq2vYD/h25xZfmSMug69ZRstngP8mYH9Lr80pSgMzcZzHXEAQtnsFO7hFivU2
	ssAFTT18UuAnCbWBrsQ0d3dczVEHAYcm9PTAcTzg/1KWxy0NJ/vjP1T2z/2PhEU3Ji0qARiX4Xp
	HDQCf9BdQTtAPunA2U83WnI42XyZPql/y9UYkbBSV9QggV3jKB5nwvPSfDcRPGePVW0XvvmuNrh
	520guTFyRbe5Np46/jD7SJ43NisXIKl/X26kyTUm4souSX4/5PiJPAsmtjUE7DmyfBQ9L2+Pz6L
	K9MoCPA4aHnh7JJQEOv92ydzUd5yLdDKQ==
X-Received: by 2002:a17:90b:28ce:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39af6486187mr819028a91.19.1788327078632;
        Tue, 01 Sep 2026 22:31:18 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([49.43.112.37])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07beb704sm3120736eec.30.2026.09.01.22.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 22:31:18 -0700 (PDT)
Date: Wed, 2 Sep 2026 11:01:12 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, 
	Christophe Leroy <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
Message-ID: <ape0GY5__P-_DdxF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
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
In-Reply-To: <20260902050628.2553909-1-aboorvad@linux.ibm.com>

On Wed, Sep 02, 2026 at 10:36:28AM +0530, Aboorva Devarajan wrote:
> Since the switch to generic entry, an interrupt taken from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare() and
> again in arch_enter_from_user_mode(), which irqentry_enter() invokes
> for the same interrupt:
> 
>   arch_interrupt_enter_prepare()
>       account_cpu_user_entry()
>   irqentry_enter()
>     arch_enter_from_user_mode()
>       account_cpu_user_entry()
> 
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space, so the second call charges the
> same interval again.
> 
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. On a
> pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
> loop, and time(1) reports user time about twice the elapsed time.
> 
> Remove the accounting from arch_interrupt_enter_prepare() and rely on
> arch_enter_from_user_mode(), which runs for both syscalls and
> interrupts. The duplicate account_stolen_time() call is removed the
> same way.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y),
> 7.3.0-rc1, single-threaded CPU-bound loop:
> 
> Before:
> 
>   $ python3 -c 'while True: pass' &
>   $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>       PID     ELAPSED     TIME %CPU
>      4980       00:03 00:00:06  210
> 
> After:
> 
>   $ python3 -c 'while True: pass' &
>   $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>       PID     ELAPSED     TIME %CPU
>      4951       00:03 00:00:03  105
> 
>  arch/powerpc/include/asm/entry-common.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..984294e62568 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>  
>  	if (user_mode(regs)) {
>  		kuap_lock();
> -		account_cpu_user_entry();
> -		account_stolen_time();
Yeah, that's dual accounting the time.

Thanks for the fix.
>  	} else {
>  		kuap_save_and_lock(regs);
>  		/*
> @@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
>  #endif
>  	kuap_assert_locked();
>  	booke_restore_dbcr0();
> +	/*
> +	 * User and stolen time is accounted here for every entry from
> +	 * user mode. The interrupt prepare hooks must not account again.
> +	 */
I think this comment is very specific to the current problem. We already
have a commit history to explain this, I guess we can remove this
comment.

With that,

Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Thanks,
Mukesh
>  	account_cpu_user_entry();
>  	account_stolen_time();
>  
> 
> base-commit: fb442a6673ff1046bf67754957d95880fdb394b5
> -- 
> 2.54.0
> 

