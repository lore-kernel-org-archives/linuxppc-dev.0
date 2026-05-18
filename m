Return-Path: <linuxppc-dev+bounces-21136-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DDCD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 21:55:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKBSq1sNGz2xpn;
	Tue, 19 May 2026 07:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779141355;
	cv=none; b=DgYk13t76vOlnS1Pru+DUBzT9hxnoZJbeGRzFuHVpCdo9n+J4tc8HXsIk8ZRcPYKdkI1um4G5FWgKBxnGUG/KeMuuxII3mqAbDUGcgV1J9qeu8DJOP6GEehCrhMK3BY8IGrnd0Ztay8Bf9MY6zVrQ60ZmE5VAHA6CTfxarxMZDeIVUYHWSv3XXZ57cvzacTlYgocnxVWyZqoqdb77GbeDxNdkMSmKmT1CZ9BZaeWWC0J9UnoiPpay1skEzFL18NgA+5Kzgad7DlG2u9Yd+jVD7uxQJFsEe4IsCI5YmRp8zsMLQNnkM2TcuV5V0DYsdH8Gs9PYeN5qDsiToTvr3Rtfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779141355; c=relaxed/relaxed;
	bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwcfN9XevwEKRREJQPLx05NWJpkH55CT0SawtOA0K82rnMirx8o0yjwNATcAVV9sHCpeFR0CHgeo42ZXdiW29jFMyQSDvkTxgO0DTH6CZftGFOlibrtDbBM0NSwiqFtZuOslZMCLix0HXyIyMDbI+5Yd0p0dJx0mqGTCPljehNinGFY/7tM/RhTbgj/SR5nGS8dX7Lc0rz+Y5OeAKIY01ql4578D6VXIK0G0pAt+u3wNh5TqzIQZjsmQBdLtbSiuLKsjVazmXOwAaP9wKcmdgqLzzP6uYXxLQqZ27ndzVnhpqV22r6D0t78dbwAwWm7tDETiSnu6XDH64rl5FMm0Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N1tLz0rc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=samitolvanen@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=N1tLz0rc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=samitolvanen@google.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKBSn0FtDz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:55:52 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so845ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 14:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779141350; x=1779746150; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=N1tLz0rcuIUBk0oLIBRi82YZYJkKXqqyuU+qfoseHWAMZJRQ/TEUFdG1NQAMUVgHQY
         Mb/LurwB/heiOVeyxADq61w9kkbTqlnrXdJyejdSSTokCGtq83ms9J6LHBvo1JuBeLcN
         Gp9FqO3nXVFu1FiZmh7+yuVjy1rzY2OlKFdIcSaUiM0q1NlD+HJpK1NEM8dGrVcg3GEA
         YMc72STYLIwdtk9REjxjN6ciAN2B/i0dxs01ptvXrmYAQEml63Qo/1R0KfLLqHYee1h3
         r6g64MzwHmUuLsOEZPnFXb0PyJbkxiwuPsiJSSUq4f/2dyh5x0gxtEHwy+La7HFzQQna
         7DFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141350; x=1779746150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eATlafWR2CpUln9HSfV3CyzBd2Vyaqeh6UVZyYqlodE=;
        b=QZ22qA4EEERnFWwge2DHeecl0uNRZwcNXdOKPG8pUrN7QK3D0NkvFXusOYpc+V1Cl9
         XEOb4LIDXKyYQYwueo+gk0CvTHr1h0uXX99A+7Bc8JyZY7ha8RJQaLaSErtRnIGUxkFo
         dUnhBCAGIGeJE2TjI0pL4xre+td/iWllA+YWYtWjZ94DsBqwEIHUWa/ekWwWOKKDdNkk
         tAOlnWW7qt5vQmCxl+Jw8T+j7Eh+DQkQ0H+VBC8AqBkhbjzUsLYajvG5auuG7J9TRgrS
         GBUhhqdrV6UI6iL3URAfEwXXGhWaqsaJA4riEfLa7FLM/Rjfh0joMWD3ygWjbvuNtkYI
         8hLw==
X-Forwarded-Encrypted: i=1; AFNElJ8o8oCtMW2LW5h8imgr9LNoHAdVuZT811J+zE7ri7/Ooq8sAA9Ku6Ud8NBAq5iKtRtmLccWIoIJeq8+oWY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz1TKBfir8iNXSgH+lYFVXh8u2OOzlEbkl3/ckFRTFmX+FRphax
	pS1HuDWcG41gezuxIx+i6Kr1vDrcjw7nUT+31rloa/uRZV17IHRWQKoTpg0bJDj1Nw==
X-Gm-Gg: Acq92OFxPrfGhUbX1H6U5D0yiNev3BDBDCVhJiJhwltwr7PkoQtOcW9xHPDk9wxm+Ot
	bYsI+frRX1nNcdDxB3IFmltHVBYA9ZN6QzoGznqA9eBcdIOeC8f0JABzwA98SDDEq577IQp6N00
	ZxDxjMNC7+yC6eFT0j+PHhforg/gMjK6fVo8fJkZjiWykQFKJZPIfPw4xwX1hkIs9nKJhYlH83D
	1w2Oe1KbLWztcClcR1XOZTyyTTRao8rSmJMIaKza/myHxWRxyMW8kt0hKg+9ieZnVZ6fTbTEOX+
	dYbUuuYl/K6YqurEGznR2jyRzDN+IlDhdfpocwUtP1TGrQgCngvNUPZMniLzjJlvbjKDkydjQ9K
	HooHxlEfod+98q1ktXXam91T7ues67GSBxAGoS87X8ZCxQPO6wyt7haLwMtPpJ11Odls1/MeAcH
	mdhB3ZnbRYSNf5hx18eCmFQBWjp7vCSg8QImXw/MTpwwpZMaTlabY1kH7eJSNH1N3863hS7qljW
	OGrsREGg9GFNxyQ
X-Received: by 2002:a17:902:d512:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bdb0109472mr3880435ad.0.1779141349445;
        Mon, 18 May 2026 14:55:49 -0700 (PDT)
Received: from google.com (171.46.125.34.bc.googleusercontent.com. [34.125.46.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe498asm164380125ad.39.2026.05.18.14.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:55:48 -0700 (PDT)
Date: Mon, 18 May 2026 21:55:43 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Daniel Gomez <da.gomez@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>,
	Arnout Engelen <arnout@bzzt.net>,
	Mattia Rizzolo <mattia@mapreri.org>, kpcyrd <kpcyrd@archlinux.org>,
	Christian Heusel <christian@heusel.eu>,
	=?iso-8859-1?Q?C=E2ju?= Mihai-Drosi <mcaju95@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
	debian-kernel@lists.debian.org
Subject: Re: [PATCH v5 00/14] module: Introduce hash-based integrity checking
Message-ID: <20260518215543.GA1878854@google.com>
References: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>
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
In-Reply-To: <20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net>

Hi Thomas,

On Tue, May 05, 2026 at 11:05:04AM +0200, Thomas Weißschuh wrote:
> The current signature-based module integrity checking has some drawbacks
> in combination with reproducible builds. Either the module signing key
> is generated at build time, which makes the build unreproducible, or a
> static signing key is used, which precludes rebuilds by third parties
> and makes the whole build and packaging process much more complicated.
> 
> The goal is to reach bit-for-bit reproducibility. Excluding certain
> parts of the build output from the reproducibility analysis would be
> error-prone and force each downstream consumer to introduce new tooling.
> 
> Introduce a new mechanism to ensure only well-known modules are loaded
> by embedding a merkle tree root of all modules built as part of the full
> kernel build into vmlinux.

I noticed Sashiko had a few concerns about the build changes. Would you
mind taking a look to see if they're valid?

https://sashiko.dev/#/patchset/20260505-module-hashes-v5-0-e174a5a49fce%40weissschuh.net

Sami

