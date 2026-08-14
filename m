Return-Path: <linuxppc-dev+bounces-25836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F896C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 06:12:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLsMl1Hhbz2yRZ;
	Fri, 14 Aug 2026 16:12:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786687955;
	cv=none; b=AScl25f4xhllNAQgcLvT4dB8TnPbgYDUfE+B4/pmWEY4tldUd9DyVNNHKDeM+CHcDIOwZlUPfWwkcJKincMNsCuFoVwCvv/7/D5Kd8iDHV/1aeXJtH56tjc3X/r1vd6T8ibZV/J6hWgMIUfB8MqsFap/EOg558e8YNejUwoEc160wdIjllqekzRCNq9w+b7AO1AGyKo0MuZ2AgfelXNkqmdOyrb0hqB7tqGwM+mlbTA+ssw6hqO4aFI/nbJuuvuQBGp6/DlMqSt30o/zpL0DNQkcOCx6pOZRZnC1PzZaod6S9LgZTxWpXIPZqkQrN+p0Vec4u4LH3RmaewasfGIe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786687955; c=relaxed/relaxed;
	bh=8KfNsDPrx5teeQIKg3dQ+SWKjWgkl+1+QirJgouqTno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq2Sa6anUpV3dk8FVc2UYYZafKZ+LOw/K9Yy1Ir+djGaskT3cQrtj6t6YVIpjkUgWwWlvHcEVCCHK6z39iCKVFWNoApaVvd6sYVGrtylDSsYmO23wPhGWoEpyFQwG1bjp2NDCCeRhMJ3ljly+6+8QJcLDC9ejFY1k3Mnn2xQFO1LsYsKmoXQ6PNkkkV6UhHSkVTtxp0scpMtCtCpkt+zQKyApkN0eWiD1en7ZOD5v9U3izm1BFliRx2qaBQrwfU6AQe0Mxy4RdTVffjRHhrX+uw009VSm2ERjHn1GYjRWUOO4Ooj1S5u4s7IvOD2FNfB8eyPjDnLoL1O8R20/CFAYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WlmsPvGS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WlmsPvGS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLsMh64vZz2y8f
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 16:12:31 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so698539a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786687948; x=1787292748; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8KfNsDPrx5teeQIKg3dQ+SWKjWgkl+1+QirJgouqTno=;
        b=WlmsPvGSpQXSGK/uXRdCMEbJ7fgJAgMOdtGEFm7O3xbly0hGcGaSQ5ayo7xQgfBPE6
         KL6M0TFnMalFF0WLgXfCkZxAygjOhCjozz7M8gL0x/DhKbMb4GZOmO8+9IHVSOWCzzQG
         3IOOfnIDJv3mHp0RgAL3mLh7H3ORpNo8R4aEoMxzBha0gq47eNUA7+500rMyuMendFOq
         C+4DNawupvcbnu0KV6YvHBZLuPklxD98SxTiDksm5eRdkCjVYk6fLmsnb2N1MbssoVnL
         GzQBhYyCIvJJ3VbjcjP2aI6LYKIJbeOtxnY/6enJqBFPYZSo7Zi2aDIKRWsyW8EW3JMX
         nFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786687948; x=1787292748;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KfNsDPrx5teeQIKg3dQ+SWKjWgkl+1+QirJgouqTno=;
        b=gqOJYA5wXELqpwxKBSFnJ873qdpm6DCe1IiGGhcoVG9RxnofRuISk9PMYftPwPwTjQ
         zLlc+OfUyJiXqp8rw5UfCB4nQXTyGzCpTzVxcYpTwle8ctDe0ozvedzjU6vIMMyZy6Yr
         3xvOWAUkHdqPQ4nL4MpXigq72Em32i3A3S2JJYpFuEe5ikSTPKbIUylB36ErAy6CkYwR
         qkAkABGccu+Cucn44wGgre/ESeYtFIHNvNHpPP6pnJGh1z+jpLS1OzUu4DrCKGjiHEmH
         xNK91t7w9f3F3qkDpH4dKNFxpMh3lJR+v44yyvgS6wKeOCClob2Y2DoTe1qBpeiuwlzd
         4GSw==
X-Forwarded-Encrypted: i=1; AHgh+RrZYtzdiRyleLtBeXHLSYSPpgNIC6WfcLCQ3DmYx+VqV/5Hat421inxNSC5tUKw8lpUJh0o8C++RoSmuQE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIT8WEIsfar9h6Xesuh3mGXns/9mqxoasMRXscvyITua9Ksema
	lkrSUxRyyON7teUXOeWt1j5rMpziujZlOwZlP2yt/nFrS58WW9LW0Kkw
X-Gm-Gg: AR+sD13Ka/TjMNTvIbftrr5JuOginJeM2BRnxDHozjcv1YCHecEh9JHscP7tLB0iU5W
	5h3++4ehX9wrcpUbPPk6idBxlLyaQcDVAUetE8gd6dFNJlt7w1pYVQHcapDvnEwgAnMuHlWUH5z
	xwgv2oKjy5UEFhgoDZ5xt7zIWZgjP5Q2a9Qp5O/ECTzM3oflWoaWPyX/QOd6RupXhV2Czec/mOU
	X4gmwNCBTmyKUNmw3yjTCWX09iQgMJLKRGh8UMRWqdaeKFb5a+HTauNfXBrWA3mQwbgn7x+RLyt
	B3AXiy0fBZwQ24uw7+NFuzb9DkspmNSEPj+Y/hSRjdYqviii66BGu1pybTqxaFZWxHkDOMWlokO
	q9/vhytONhSZsoafQna1jwH+pwkYqY5Uiv0xxwzmp8RAl8IkHvmDKpa0eJqXia5XmKTXVT8/Zxv
	KSiyA7OmtbcPRcoF6Y3usVDJ7l/8M6NmdDQ3NHUcZ4Q0Vmo0tCZolDDH3TcBiNF9rw5OFKaXMl0
	I909jK2eMFJRb93ScM//md+1UOKPR3AmTuh
X-Received: by 2002:a17:90b:264d:b0:392:b509:b1a5 with SMTP id 98e67ed59e1d1-3933b93e1aamr3920613a91.14.1786687948414;
        Thu, 13 Aug 2026 23:12:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.165.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea996575sm1158434a91.8.2026.08.13.23.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 23:12:28 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:42:22 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, mchauras@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH] powerpc/entry: Use hard_irq_disable() in
 arch_interrupt_exit_prepare()
Message-ID: <an6w517sUDWwpVfZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260812152035.1661781-1-mkchauras@gmail.com>
 <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>
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
In-Reply-To: <e49d543e-80b2-4c8c-968d-0c8b68717cbb@linux.ibm.com>

On Fri, Aug 14, 2026 at 11:06:43AM +0530, Shrikanth Hegde wrote:
[...]
> This is good explanation, but what i not understanding is,
> 
> why pattern of setting PACA_IRQ_HARD_DIS changed?
> Previous code at interrupt_exit_kernel_prepare which did local_irq_disable too.
> 
> Please check where was PACA_IRQ_HARD_DIS set without GENERIC_ENTRY which was preventing
> this from happening?

That's an excellent point. I think we are looking at this incorrectly,
If this is related to the nested soft replay interrupt than this whole 
dynamics changes, local_irq_disable will work for the actual interrupt
but when we go nested something is telling that the nested interrupt
that interrupts are enabled. Let me look at this more deeply.

Regards,
Mukesh

