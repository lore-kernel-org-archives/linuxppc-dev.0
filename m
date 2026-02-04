Return-Path: <linuxppc-dev+bounces-16598-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1042E9D41E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 17:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5p2l4WmVz2xm3;
	Thu, 05 Feb 2026 04:57:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770227823;
	cv=none; b=OQoiXTbc8TL96e03Yagi/SpYlnhpJ4+bj5Q6U/fglzb8ycWID+d33soyk3Xrfx7iSb2rVtq6exZkuZ6NaO72vshlwFgSm96OKF7IRGFix1jy5q1YNRXjv8qiCDiXICJzSsV5HxP2xixGPrqCtKZYI9qTi1R7n+7QdlLgisV4/HyvhRIMezE0GfpHwlXHepHcILxXdcRXU11jbLhKxqU2bGNWYCtI4pp3drgkgVuFxWjY4v/DwRsBjnN6WiBmI5KD+0ixCsZezb0HsR8C/vlOOL/fiehwbyhMFZWH3e4R7I2OIWkzYE26gVXODSIW/+qXWOtsyvAPlLO7QV4tHfi+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770227823; c=relaxed/relaxed;
	bh=YsaxEo1afPg+Rotp0Xp7sr+H2iiL8qecJpuRH+ktCAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wznrbr+cm+VTqtn0h9tCikphEPvAGZ8hahu5Hq/hxql4qJ6A5fjcpXLfoElbAx42YQ3jjvkJpq1km2YkxD6p+b8L2VG2xZglSXfn95Px//fa0F77s9pEfMJHmFtoVBDBX9muuW4ACdUCpSPVg2NTinXNAPztrRJHmf3A4x1GbuNbfpobPEAQlRBj/pu+UdjWKSl/ldty6MtfbWdp7NLg9YXV/r9033wpLYQx6Wm+s2xoewG5ppx1se3QR1qGLAd7fLkVLN1HeJ76oi2RGYfWtp7ghklQhjB6gd1kq7lTbAgxwcf3Om4SXfLKChhQPjFumxZDnXE7yiABQtxz8aO2eg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K30GwwlY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K30GwwlY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5p2k6R0Pz2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 04:57:01 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2a743050256so700115ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770227819; x=1770832619; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YsaxEo1afPg+Rotp0Xp7sr+H2iiL8qecJpuRH+ktCAU=;
        b=K30GwwlYbFzZnyYyVFsdXU/tOSIJk3g449d4nD3RWcvNftPQCQCE3h8XoBRug+z+20
         PVZBPvxofYvMJoa0gGb9ODbdAXqqTHMRvcMLcF9iW+oKQXf6acQgkw+2GqHEeoZ6RG1A
         df65t6APnhBxy2EmtoN/NDgqgWVfGvHyAz34VVXsLZiDbJLHPW8GlYKwzz08YB1punef
         +18X8Rac07bpyEGxHLdvia75CyFOTZ0IZWb7BV1GULu44VOGtZNBw2r/YCHL4XfI9QnF
         D9fjNFjZNmhSbSWd24ddkZhEQg9kUdsz5U0kWUonTT42hT2YMZFTywHL6DG02YANk/bJ
         voww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770227819; x=1770832619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsaxEo1afPg+Rotp0Xp7sr+H2iiL8qecJpuRH+ktCAU=;
        b=u0Xynbs7ogy8iI5OaMlKQJuWFh8NGebz7GDzZHEP9LrdMI/eYZhRcOdTXG4RROsab6
         Xg+TVBZmVnkLBdNZ5J3DtbROymm5T84sBjfLt7y4Yz9ohCYQOhIWKuLuLRlBizBGcFc8
         3Og47+cM92JVgjBvA9I3cQNBplN6Ql4MgOdvOmYli2kQO5MKp7DesKfrZYNK3GwrZ6U/
         r6+L/4pvHEPgUKzYXZ/xzuh2aUevo+MGTRUxZ2Il1lAEFdACn5NdUw4zTU72yaKyEHCH
         Ef7W0uABQzrZmgkPOWSznsj87TbbMnsiKxc0OrAP2FDa4S38Dsp6GjcGp4Ci2zI27Zll
         l4RA==
X-Forwarded-Encrypted: i=1; AJvYcCUgjiFVu8+BTCxjqRbCDZkMKp6XXuTUxSiO8LyXN2J+xjh1WvbHFE5ffAFSTcV58LE6dH2NGQJdSEKxeWM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzcmftoPmREQ1zseiEckQV3Jh8N57unBPIFwAUZT6Vt0HTI0FK6
	tQ8Qpadm/qrjjPm0Q5xAqy2tW6ovsgxl9oFwz3Vrv8crUoXAmZO8ySc9
X-Gm-Gg: AZuq6aJ7uJtj60DHC6oB8dbCrbveY4RBM8X0iMpPKa2J1F+bePGggbR3XQUuJL9Mkax
	8VhJ0AeMQLKfFlBK0T/02Eka2LBTh9S4vaHlFjB6fR+S4/az9j3A4JuS6Ahrg8UFDeZFW7usOPK
	6Xpic/bbOJ5PwG+jROwtTqBSZVzoRMgWgECDggTDfYUKXdVPUYzrRQUsx+Gw22Uc+A3HGMe/0UC
	WUVdDSIcy6wFpxgxHzKFyt70SDNykZ4SzR8MvhW0Apu8AQxj9wur+afq7s6YZ++zxjCcNy8E2Ca
	XWxpyn8H5cOqZQTF90qLGAy8l72Q+vbWhRqWCHt37A7EpcBFhisKNklxYoV8lOlamBR9ckHOdfr
	Y5Dtb3eVQCxDcgjBNirXFSuSi2KnPmIny8OQZRBUbTLd3y8A3zgut8IaKkY6BFIR17WMT4lFRY5
	bJVrPybvq1etnEb5ixF6esJ78tkAL0sjdsIhdNbgIDhYK52NKrKtCgmq+qIMw=
X-Received: by 2002:a17:903:faf:b0:2a0:d692:5681 with SMTP id d9443c01a7336-2a933d1f2b1mr33270555ad.24.1770227819453;
        Wed, 04 Feb 2026 09:56:59 -0800 (PST)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.164.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397c472sm29066135ad.89.2026.02.04.09.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:56:59 -0800 (PST)
Date: Wed, 4 Feb 2026 23:26:48 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] powerpc: Enable Rust for ppc64le
Message-ID: <aYOIG0HSunq6-Vii@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260204042417.83903-1-mkchauras@gmail.com>
 <CANiq72k41tCq7-LccTz2NNpUF-0sOqPvbj-z+Qz0msud3O-3AQ@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72k41tCq7-LccTz2NNpUF-0sOqPvbj-z+Qz0msud3O-3AQ@mail.gmail.com>

On Wed, Feb 04, 2026 at 06:49:23PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 4, 2026 at 6:54 AM Mukesh Kumar Chaurasiya (IBM)
> <mkchauras@gmail.com> wrote:
> >
> > +    } else if cfg.has("PPC64") {
> 
> Can this be done via flags, i.e. avoiding the `target.json`?
> 
yeah sure. I'll do that.
> We are trying to avoid adding new custom targets, since the idea is to
> remove our reliance on `target.json`.
> 
> If it is not possible to do it via flags only, then we should talk to
> upstream to add the needed flags or perhaps a new built-in target.
> 
> Thanks!
> 
> (By the way, Michael back in 2021 did the original integration of
> ppc64le before Rust was merged into mainline -- he may want to take a
> look at this :) I see he is in Cc).
> 
> Cheers,
> Miguel

