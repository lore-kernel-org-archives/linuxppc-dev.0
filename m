Return-Path: <linuxppc-dev+bounces-27568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CD1C982CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2026 12:29:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hlw7D5m4cz2y7Y;
	Thu, 17 Sep 2026 22:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789648184;
	cv=none; b=Dr46YNSZBi91BzOk2KRK3Fzkzm2x+qoj2ZS5y/MwlFtTRry/xdeVhCZPqUHMeLwF+mGHU75jQYRKHUmtmp+OHfZFEjU+oYfQc5VV51o2FZ2dDI2BuRl2v+aTkdB7hALJ5bgTAm7g2OvtbLLifbvMkv/WcsTUF3sV4jg+iZG3fCTXGTgkx04Ugn5uGIr/qRIn0vQO/6LaVJWiK/2fmwBykAw/9Sxujzgmc3D1eyMGRr5of99t2e3Bkz4JGNb71Or3kQNcuTPnc6KjpZ5pavT0u+sIiuUnWl3S6tpWZHrDmIVItQ/FkT6+LE7T+JZ6HYmd9WIVD2SVNgiRYCUV89NPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789648184; c=relaxed/relaxed;
	bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFLvb9dc3/zwBXPRYuX6Gu+/usjyNXbFkKV4NPwSxoZjurtNLw0TPC/Kz8nmsBMIKpWnlQta9h6jr/tMSgiJMg0VfVVOPbPPGOljK7kapbDYYDXJroAFxDz6G+gy1oQw75ERNyA0ZK663GXywcW+tG5e7FlKdZg/GlZ2XPFsu7O/2QC2KUdOvGeFEw5kziZAm6E+mxXfHOp0cNnSw7SVVVlhlHhNY5p7KATBCbCtmdHOvinO2CJOIHe17sdJNsp+ZTwudgfWvFAyxtc4H+hysf3AJJg6jDqPkQVXXz8RRkBio0+e0i3WsLpjnTR2du1HCCSVe9WCXTUDf1JQ4iDv0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aOBmcDXf; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aOBmcDXf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hlw7C5gPxz2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 22:29:42 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so4683605e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2026 05:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789648180; x=1790252980; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
        b=aOBmcDXfqe/i4RthwwvjfMiExqrcVeeblI9BRivXMeBujXf728BBuGlZPWS5E7bddz
         KnjOTzjrVii5QlrEcwje3u05kQ9eA51j2yMWDKURxUH/d1hb5hWtrJY1g3F8e/HnPzMc
         JS0mhmBtjSdhXq6higExW1YkE2DtExjCtAL55iWNHcHneUuOfgIKwxpwQ2kNxP3VrnAH
         6yHUHypr0qzR9H/57GDikzE/1gurDrXK9jgr0p4Xu+uRPk8zRUge8CQF+fMbwBZ8cPzK
         NatQamvS+15OOmFOt7bmn+QRqfEHvQifoC4HUlX3PC3D5hBLefO/LqviWbwFbou2LZsP
         1O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789648180; x=1790252980;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dtz+Uqi8FvhezfQGwgUreP+CufNocr9p+NqbDN0Xcok=;
        b=aQuJbSj7GTQueVrQ04H6UClwIkzdudYN5aSq73iCpJBf5lHy1MlSq52Ye3tMz1urkd
         81NcySO1OUHpvtfhfJCfCv0Zd6lH38ye1aeM6NgSYAL1yEXF83NhMFBzGQqmkVbVjfG4
         SMJXrgSxIdLLOIaTBFd/cE2ci2JGFbVQLVyeXTijcUmtTKKN5A2UpehwPbRervm9Um/N
         XxtiZp8PWAT8wpULJsfKt38XlJWwYTAFIPv88++9IOotGYopoIgVxafPH0DvM/PqgkH+
         bQC5ILzKBt1BIa6SyCx9Bh33HsUmv5n6ibOyN4lPRBlwrLjna5QtovcSxkxUMNxVdn3j
         W8Wg==
X-Forwarded-Encrypted: i=1; AKwUvBwOE9KoCs95FlmXziQLdY8dR3VxxNKxWU/w8Q5sjEJzz9DSncbBI+Fm6QLEfvqQ0SeJvwDbTPJ2SUnH+w8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kAUS6WbIhWlZaolQvaKBpUunHA0KbuE7fCO8B510F1k6AIEylm
	dBzOURawZj4vV340o41X6LTNsOmD3+oLCJI8xAX3nA42BASQCy4wss8+
X-Gm-Gg: AYBFou1kXz1GDjdkz70vtG5nkU9FOVPUszQbzqZvDYlwxaurJqJymsDyUqrSKyiriO6
	lamIdyJ5fLJSe2JzSDNiDsZpkuZE8kbXac8/QEfwkSan2BTIaxZbf/UP1jvAWASpTv6Rb8zpGpY
	egU1Wb44f1MW2/7lic1GV7EC4oAFxn9kJBqFr2G/0frVvA2Is/cY2rrtcR81m2lGiZU+dN9SO50
	Jsy28XhaR0fcJDGXbojXS2On1V0gf09eG553i1eueo3/oUD1O3y/4FHA6Y0GWJy5BWuBTl6xwOj
	uC9X++HR88yL1d2E1qClnA9rnJGE/3nFVdiKKmQxeqwg0Rj9ImA8qlDNgVZKf7vqR0PhKCVfHCZ
	zc73hs7JsZfkn7grf1hwV7O7DKkKHsdOmk2yumaQQcR1gBlkDJySlpTsM+29RWgRHNxaGExvdoB
	hG7YllSJlLsVRpMdwp65/iQSFZxRRzdl84WKqWUN1rC5W6HrdL+/8qC5cZ21VPo7WRvJoXSZP3d
	8dWLEyZn55rTtOGUD7nvt+MCkbBrdu5Za7r
X-Received: by 2002:a7b:c35a:0:b0:49f:bcb7:8e9 with SMTP id 5b1f17b1804b1-49fbcb70a1bmr64001725e9.9.1789648179633;
        Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1ce79csm82621135e9.0.2026.09.17.05.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 05:29:39 -0700 (PDT)
Date: Thu, 17 Sep 2026 13:29:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, wine-devel@list.winehq.org,
 linux-xfs@vger.kernel.org, io-uring@vger.kernel.org, bpf@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] file: make struct fd_prepare const and kill its err
 field
Message-ID: <20260917132937.5a15904e@pumpkin>
In-Reply-To: <20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
References: <20260917-work-file-fd_prepare-v1-0-b87534ca49f3@kernel.org>
	<20260917-work-file-fd_prepare-v1-4-b87534ca49f3@kernel.org>
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

On Thu, 17 Sep 2026 11:09:45 +0200
Christian Brauner <brauner@kernel.org> wrote:

> FD_PREPARE() releases the fd as soon as the file expression fails. The
> fd either holds the descriptor or the error. The separate field is
> redundant. Make fd and file plain members and struct fd_prepare simpler.
> 
> Callers of FD_PREPARE() get a const pointer to the guard. Simplify all
> users as they can now easily access the trivial struct.
> 
...
> @@ -191,35 +175,39 @@ static __always_inline struct fd_prepare __fd_prepare(int fd, struct file *file)
>   * was allocated. If fd_publish() was called the fd and file are
>   * published and cleanup becomes a nop.
>   *
> - * @_fdf: name of struct fd_prepare variable to define
> + * @_fdf: name of the const struct fd_prepare pointer to define
>   * @_fd_flags: flags for get_unused_fd_flags()
>   * @_file_owned: struct file to take ownership of (can be expression)
>   */
> -#define FD_PREPARE(_fdf, _fd_flags, _file_owned)			\
> -	struct fd_prepare _fdf __cleanup(__fd_prepare_cleanup) = ({	\
> +#define __FD_PREPARE(_guard, _fdf, _fd_flags, _file_owned)		\
> +	struct fd_prepare _guard __cleanup(__fd_prepare_cleanup) = ({	\
>  		int __fd = get_unused_fd_flags(_fd_flags);		\
>  		__fd_prepare(__fd, __fd < 0 ? NULL : (_file_owned));	\
> -	})
> +	});								\
> +	const struct fd_prepare *const _fdf = &_guard

Since the struct is only written by its initialiser, can't it just
be 'const' ?

David

