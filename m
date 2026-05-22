Return-Path: <linuxppc-dev+bounces-21388-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54E5CD5BB0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 11:12:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMN0v1C9xz2xc2;
	Fri, 22 May 2026 21:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779448367;
	cv=none; b=H75h8LutAg5IyRU07EEEgBJGNgh3Dw1NA5apqVbsmMaY+xg8HSEpleA/UYKE2/YsEr/TmYKpwvEtmTa33eQXzZKze9O/ixYj+hwaXQHANvMPejIXULzk8eZyz5nAOeGDGZ91lgXF9bqozwxZt0u09GAXL10NShgeW4OYSibzq48UkqB+HhD3FNqUmU8OiAxVbi2YLyS2pR8uqiSkmXRc/71gK2OvgsA422VnYB6wDAEmn58mZvMR14g6RxnewoCKHxI0lyX+7I6utcLydoslYCw8yTdBUv9bAvRnh8UKXPdfXNfko2vHkBNBcYuHWWl30xfYcoexL0GeogGEkHQeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779448367; c=relaxed/relaxed;
	bh=hxiCU8aDWzrapopsqW7zZ9IgDHHwDUg4WsiEl2eBhns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouspybnepcDeZR0M6uxQWTag+KhFQJIFFS3rlVKvUymyVml4EF/CkTwgVbcuQ+5pJJnSrw/SsGWLoCMGZnzxEvYIf1sChcthagqW6Fkzx39gzaV74axOkAvax2gPl762ZteQA0KHF3ZjWFvu3o5hUMVxCfJpnj2cLMFa1pxGvOnT6cLgvP93Y/Ck+YQr7OKAQUAz44ELQLuXX67/jLi8ou/UP8iC3kRtVIcmEJCWkEGEMkgXnsPcT2/L9+zi/hSeUdSNvuxTmpE9i0NgUTRhUEX8Dj+dB9Mrn7VUXA36HxfLJZvG57yLaCO5EjI7awM3Whlx1eL13iR2o7t2jigv7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfnAaOL9; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BfnAaOL9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMN0s4tWmz2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 21:12:44 +1000 (AEST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so17496125e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 04:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779448361; x=1780053161; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxiCU8aDWzrapopsqW7zZ9IgDHHwDUg4WsiEl2eBhns=;
        b=BfnAaOL9xf1gFB9/eLw9r+HUzFak6WKeuJvW3mGnr+RMO6DOe9Vc3fVPT44Jp14Y5W
         WWSfdII5ElGmkOAfPlB/QnnH6NGj2RmBRukrPb5Ocjio8DkrNCoPH6kKl7TUITsxpIJ+
         sC7ZPLfNjhqa6u8n+kvq4jzWqYuBmktkyCvif7j3kcfTU8NtLJp8Wl+qadh+XjPXDkoI
         YkewK7idC216d+WwHst3vyuuXedIVaWAySmusV+0gZUNx1gro98WvGtTtNC7MZUWw0dO
         lHr7lP8oW9VYsMzuF/voMt8zdEhswMWKKv7OhyUU9tJ8rpzsKgviX5b/+N1iWi4kEYH+
         nPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779448361; x=1780053161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hxiCU8aDWzrapopsqW7zZ9IgDHHwDUg4WsiEl2eBhns=;
        b=jL0OyZq/ubu0zyhJi6JEc2e26Fs33S5X2djsBCG2ljZYmFfzavh+FYi1TidGbc33GK
         NNQ4CbuzsboLXz3NQHDq4x2gRksR2MNqjwq+8G2GhPAljdE/Axh7lNA38WLGPrZC96Er
         /OWCwe3Gyg72eOQaMCbN36IvzF/8Evjeyk1GxJmunr+I8KHF2uwvxz+9YR0h052DwclC
         wo2S4FLDUr+1Xdqw3L2Ur+gnlsoE3KX21rhaOI0wcYeGJRlDxeoCEBcn4bDZ5hdV4g+m
         /uzZRrD9KIxs35ep3EEjJUJB7v3waU1PBfEnbmiFlodgxE2oZ3Ta3eAsDlQO2yHJKOGs
         j80g==
X-Forwarded-Encrypted: i=1; AFNElJ+ExP2KAPRPaihhVkIM6xKyDP1WJdBQq5MAGm1r0gcg12pKkv3nJPTkBRcgB+kJDF+8tz3IYP7p8zi8pqo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7X1gk3NJUljFcq038EfYnMCgO0eRd6G179YnqDdnAaCb+WYhh
	/vhfcrwWdqvhPZUae2GgvWkKBqQZGXZRQm8Mynob9ui6kJ04Vq26qQSo
X-Gm-Gg: Acq92OGAEGi6xtSkA35zST5tM/Y4kH4kmCKUG9ft0rIjkIKwplnvodHaabC2emP+LZG
	iE+xcb4ls5glFEhn2T3CeodEvyYEqNIvx6uJmWJqq9gJZtEDIuDAFxaS42Vapzl0uzNEgifMvq8
	haurhfxBx4nzcKhVXWAkuBqzZL9zH5sdCMLn7WgA01qA9khPaoHi/Q3fjwRNDVOSHLh41IYouLD
	oOZL3xG/l+YsHJ3XdoWhXVkJ1JzA64kh8Kp2e0FWZYZIUnNxx1N/NcQ5Ye9E2t/qVBDWpCKklJ1
	P+Jc2hXlvF7ikweXfUrvi7UINLADyM5cjNyf2pAAC2XYCjmc2fodeRt8WZx1z8l4+xgXdwiJNNf
	tBA8AmkNX7wFuZ7Z0Oh0E2c8GBF5+2GvBhDiEFRQ8sMqSICK8dNGQZAmSq0UBh+LTYId7wKburh
	QRSUhk/uoxcA2De30Lc2KN5OgstSdHcnImlsA6e4y0Yf9KmmTm87qFvQN0AWorHHH0
X-Received: by 2002:a05:600c:4510:b0:48f:e230:c3fa with SMTP id 5b1f17b1804b1-490428ddc9fmr40864605e9.32.1779448360558;
        Fri, 22 May 2026 04:12:40 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454dedd9sm30995645e9.6.2026.05.22.04.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 04:12:40 -0700 (PDT)
Date: Fri, 22 May 2026 12:12:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 2/8] powerpc/signal64: Untangle
 setup_tm_sigcontexts() and user_access_begin()
Message-ID: <20260522121237.3089276f@pumpkin>
In-Reply-To: <7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
References: <cover.1779441786.git.chleroy@kernel.org>
	<7c83fe5a596514a02fde37da987a48d638d0d097.1779441786.git.chleroy@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 11:56:02 +0200
"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> wrote:

> Call setup_tm_sigcontexts() before opening user access to avoid
> having to close and open again.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>  arch/powerpc/kernel/signal_64.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
> index 86bb5bb4c143..3849af21e1d8 100644
> --- a/arch/powerpc/kernel/signal_64.c
> +++ b/arch/powerpc/kernel/signal_64.c
> @@ -873,6 +873,15 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  	if (!MSR_TM_ACTIVE(msr))
>  		prepare_setup_sigcontext(tsk);
>  
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	if (MSR_TM_ACTIVE(msr))

Can't that be done without the ugly #ifdef?
I assume MSR_TM_ACTIVE() will be zero - so it will all get optimised away.

-- David

> +		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
> +					    &frame->uc_transact.uc_mcontext,
> +					    tsk, ksig->sig, NULL,
> +					    (unsigned long)ksig->ka.sa.sa_handler,
> +					    msr);
> +
> +#endif
>  	if (!user_write_access_begin(frame, sizeof(*frame)))
>  		goto badframe;
>  
> @@ -889,19 +898,6 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>  		 * ucontext_t (for transactional state) with its uc_link ptr.
>  		 */
>  		unsafe_put_user(&frame->uc_transact, &frame->uc.uc_link, badframe_block);
> -
> -		user_write_access_end();
> -
> -		err |= setup_tm_sigcontexts(&frame->uc.uc_mcontext,
> -					    &frame->uc_transact.uc_mcontext,
> -					    tsk, ksig->sig, NULL,
> -					    (unsigned long)ksig->ka.sa.sa_handler,
> -					    msr);
> -
> -		if (!user_write_access_begin(&frame->uc.uc_sigmask,
> -					     sizeof(frame->uc.uc_sigmask)))
> -			goto badframe;
> -
>  #endif
>  	} else {
>  		unsafe_put_user(0, &frame->uc.uc_link, badframe_block);


