Return-Path: <linuxppc-dev+bounces-27294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34136C88E53
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 06:20:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkX284pmlz2yFW;
	Tue, 15 Sep 2026 16:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789453232;
	cv=none; b=lSk7RVEfl1qC99P4nhfdOHkGYb6xKEgBqDz+WShKQO1mlD8a83GjoyLgHTvQzimDFNZ+hwMsiu0irK8Vf+YzK1nBBAep9P32YWT+8dV8tU4I26j7v8ZF0gtjIiXXaMBzOFeeS9cKSmFUBeIWAbCrzhA5wprwAX9Ur/yw2eo7zWgU6uS2x+9i2Mw+gTNOCDmz+hTnmfEOSnJ3+x5f4FZCBlkmNJQXx8AiQtx+QjhwEkl5Frt2/6VeLCoV3FIvRV2aqxRvlLHlgWdoAa5QTtsIAp+4Jf3nprSGc/wyIBbFvpNUaHVT0SQ8SzTi1nz1smLHanm1yQOycP8EEHq//HrFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789453232; c=relaxed/relaxed;
	bh=lvj/QENaps3fa980Av3u1jYrzQua2MT1zXpRDbfcu0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS7v900X1S8bbAVBQPVCsxPzFGCIq8ppDAU20oXdWi0ifQttpfiCsXo9tpD0xbuzsAKcA7laKgY7f3Zk2wSDrcmpqIUDxy36OJAAx7jhEoNF/LgD9UksoHsiRUpmf1CrqArDlt/cjr4ihpXFvIFd4OFLpIwHbjPQgyx3G2CpxTHx7wJRnXy4uunAtCyBth8DJ6SteuzT0FXwLceORGvhxF4m0y6Q1jbTs0w7PCg4u+Fnc+lRusWgtQaI/h35prwACAVTM9wUAJ2PDGnMklSk9VKsOs98vgD7Z8+l63LrlCgHcQNki8z5bK5H18+5OQzs/4uARYAIWRg2X1cD/EB/ig==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DxzdrjR6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DxzdrjR6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkX274VhZz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 16:20:30 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so4014316a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789453228; x=1790058028; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lvj/QENaps3fa980Av3u1jYrzQua2MT1zXpRDbfcu0U=;
        b=DxzdrjR6gZeeyCoxBw15DRt79YSUedeJj1vfELNwCMo3Re2HjYdayMbsIKv2E92Gri
         aKzRbSsXhItL+h5mFgDfzgvBAc5IQVIU3NwEJoRu413lxuAbb69Px3WRD51MfVhKLd2U
         9riYEffxp7F2Hl/Ui6/FgHFJ+MaaA0q63zGRhYAKZz8+DDTGjXkwQKV6UGeEvuJf1xaq
         70ZDtHKwH6maiJQ7uHoPNdISi+wnHNA9F4QcSx+94G4C+uRy739/91fSkaTvGdpZd2DV
         ATZOMtgeVHoKDiKBOGjOlzkxdsFeIPEqTXkGoiIGYiLd2aGBFwaNDxpHROwVCBQFN3d0
         TS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789453228; x=1790058028;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvj/QENaps3fa980Av3u1jYrzQua2MT1zXpRDbfcu0U=;
        b=bOds/69qc85eZ0+s4RUZqDDZV8fZqPJN9tNLEUXT/DKGAwrfGSlc+7rAmGn4jcd+qh
         lRzhr7dxr6CcsE/Wvdy/6sP7apgQffTnkDv9r1tNXTdZCDsKFrs1JSGLK00bNTgPfdXV
         WUlcszcSkr1pyn0NObsft5vjOTI/31Ml5Zh6B/RZm5I7wkm0yoSxhauo+COwI6fgNN/Y
         tk2uxIOnBrN/fxCrs0FQq8v3MrgbwvkH8GX/umI6FqrVmYS+KIKhCabf82wM5O5ORwQE
         P3j/VeV93mCc+OHlf0CgQiAgu53XjWl3lTuSEhKIGRTmQTFO0zreO0DSdeojtAN1u74h
         fXSA==
X-Forwarded-Encrypted: i=1; AKwUvBzEd5FvX0b/oQHCGQvJmSVCe+KBaqYBeptUsgDUCzNVMZ6tk2mLQPscPY+2+J2cVrgJ4GEuP9UmGUqGUjU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lu3UdXIuPdzLck2I4ExznD7OXQx+/B0b5NWemgf3ki/2Uw00Jz
	WYCYJsiQaWVJY7f21aVZBRIC6qPxc6whIQqwGsTINweJMnuD6ZhgQzLR
X-Gm-Gg: AYBFou0FtFsLMizfWnbmkCE6gzDOwU4owylJNVMsRD9/ei99TrfEbxD6FiDPZxv/u7L
	PheGP90mwq5jCO/VYBOxen5D9kfut7of4cj0+c0Mie/4dKRC4ARcquzG2g4p8vMXD27UlNKqEQP
	fGzYZdaj3DqjeNFX9aNBkJIKgGlhDCOFDOiajQTdY2mgJ4lVHK/Ehqu4TKE41OhZXQM6yPMbzBG
	5I4j7M+Xkpkiy4lh0A1F89QYOhS5hKoguDz3qDFwsy/aRcJY8GBA8/J/CTN1LT9v52oTxLhCMuJ
	DO6nwDxfA8AFGPuqx+nrXQFlS2daTZRoD3uKZS7EuHJDEVI+PH2r9F7dnBOkjhBRtxodd6grr1A
	/SEcspyr2J36UVVk1TDI9eFMn9LGSIOpswIrE9F1EfUYRrhJhWtfCbjq0D8ihGfpP+ioS5KqOIi
	SzDhLtp/xSyg2+wuaiHG/OOfO87S9E9bXi4wjATHjKC2WSMFaHYpI+HI+pfCBWXIiQDFg0vYcFN
	yvpqN0o08qQEnF0KOg7BKgSRmqWi6YSwf0+79N30xc=
X-Received: by 2002:a17:90b:17d0:b0:39d:c3bb:98e7 with SMTP id 98e67ed59e1d1-39debfa60f6mr11787559a91.6.1789453227707;
        Mon, 14 Sep 2026 23:20:27 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm3169047a91.10.2026.09.14.23.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 23:20:26 -0700 (PDT)
Date: Tue, 15 Sep 2026 11:50:15 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamird@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, ynorov@nvidia.com, ecourtney@nvidia.com, 
	joelagnelf@nvidia.com, fujita.tomonori@gmail.com, linkmauve@linkmauve.fr, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev, FUJITA Tomonori <tomo@flapping.org>
Subject: Re: [PATCH v4 1/2] powerpc/bug: Add ARCH_WARN_ASM and refactor
 _EMIT_BUG_ENTRY for Rust support
Message-ID: <aqji0ILj4gkDnkry@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260912065902.24017-1-mkchauras@gmail.com>
 <20260912065902.24017-2-mkchauras@gmail.com>
 <DLDJ7TNEH9MS.2I386V2SZ5QDR@garyguo.net>
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
In-Reply-To: <DLDJ7TNEH9MS.2I386V2SZ5QDR@garyguo.net>

[...]
> From the current implementation it looks like making "1b" a parameter doesn't
> really help anything. The fact that it internally rely on `2:` as label is still
> hardcoded.
> 
> I think you should either make the label custom too, so you write
> 
>     "1:	twi 31, 0, 0\n"	\
>     _EMIT_BUG_ENTRY(2, 1b, file, line, flags) \
>     ".org 2b+" size "\n" \
> 
> Or you should just hardcode "2" and "1b" and document them.
> 
> This stucks in mid-way and is arguably worse than either option.
> 
> Best,
> Gary
> 
Hey Gary,

Yeah makes sense. Lemme refactor this with labels as an argument and
test it out. Thanks.

Regards,
Mukesh
[...]

