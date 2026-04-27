Return-Path: <linuxppc-dev+bounces-20197-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358C4FF8864
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 21:52:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4HNX6lBPz2ypW;
	Tue, 28 Apr 2026 07:52:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777326748;
	cv=none; b=XAFqfwv5KoVJ6WRWWBv9mAkHoHi4iBAa5w3Ay68Cma5YezcMa5ADsm8QklerSsB2bAtKDzPKZz3zxSCU37kTYML8uYgzR7dJzpoxetk6pPEkvoWslRlM6oM4Mp6JJazT8r6LqCSh6er/3UWpGv5smM56ajlobhQ0dLITgQ/jl/i8FaEfxB/drPjyFe6YQ/ObVscgM69Ej8dPkdpna9phk146GlfSxIxJtsUhGZKuin97P5D3gLpUFau9LL2Pr6ASfcKUOqbdaI5MpKCoRZx4H+XGZ6GEYJhN/TyFRTVvZmjw8wWNKzss4DkB6moQFudeXaYhTCpE3tCR5I4JdorvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777326748; c=relaxed/relaxed;
	bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9mBW5usN+g1GOZ1SCwTccBqkix0yoMrHuqRRDc3whjUOU/Hx676XcqcMCGGLDUKl2yowlz+RARDFOaNhpEy5xwwOCqk+Se1MgOQtRaEfzGrwFb6K8MY0Ds8NZcQMoWCAWEip/o+41NyPP3xYZIY/jTxzF5yFbWtn3uuTqs/yoNeMcXRZIeRL1Lv/PQb5D70eXoFqtVGagNjpl05lz6yFaSPw/uJoaWB0UNjo2tc8dwXcHiooz4CP/+fAfNWwRFJH8E/iWbVvRX2nXj45INnxHUrFt+QU8w62LpAsYp5D5uhdBisD7AdtuOX1w+E9SKu8QqEGiLKb/2gRUMPWNlXpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WU8PKBa0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=WU8PKBa0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4HNW1kVBz2yZ5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 07:52:26 +1000 (AEST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-b8f9568e074so1772544166b.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326743; x=1777931543; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=WU8PKBa0c36FCu8jjNBgYjZ4u15xQWShjVQm9Sl8c5tHkcOlDFW9ykRJqLupivVSp7
         yVq1YLOPEYuGGj0mgOFOk30Lv69tNNsNzLoYGf5eQscyqlPzJaXpUO+3YZMK/kEQSeU5
         DwJ95xA8A9St8/HWaSiwpQslXgGM+K0U9zVQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326743; x=1777931543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=B7xKvH3W0+0EpkDzZieSBu98wcnQLIv+S1EutkgF/3ba5tHTEJSqBccxpWOprDjtnv
         wSxQjAuYvz14gqdVy2ZBsvi/Dk8Y7zerJQCniNNROqpnVSEG25wLCy6EGbLAhCrOEL65
         5mxqDO4BD3Ssyq4m2ucJdbiWdwE3YbcN2mQ48aD3q4Y9e/NhVwaUh4muF8+msvhdzM5T
         VLEdCgLD7QnVpjaVHp5guyvLB6sHyG2VHTeLGup8H034a/NhEbKmpHbuhRjjWXBGQSfv
         pJ0VYLEN/FsES5Px/DLkZ32B4ksxcFW2herT2VxdrENW8dYpqXom1UyaHoypGaz3aVTw
         FBxg==
X-Forwarded-Encrypted: i=1; AFNElJ8bUN9nNu1B3hVYOvyVxBcFrNDgTJrlDt0wLzJKhusNJizSzDFaaY0rz6/iVUD3Kco8dDEA4Wo6KdBt4Y0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxqGTLkhE4bR3ZS9lN92WmiloHpPOCO826Q63cvIZSoJXeoJ1LW
	j79+clxu4/ky2yj44kDqtHkD7N6eZllTSt0H3mUMEBmqTC0lOwZ+WCXxEeayfabZGv6KVtTp5hH
	y6n2dIPjq9Q==
X-Gm-Gg: AeBDiet1GXo2PgxRsWKTi3OZYl5xLaPNciHIYUliUCRln1R3a++I566MHfwippF+Wt+
	YVaWhCMYmTWQwPpcyI5x1ZxDCVA/0cQ4zVWf4Yz6rIHoclhN6sCo0y6Ayucg6HiLB4mnYQnIW/O
	rs13rWACB6V28K4qdg+itAlxzGRZ+IDWYvU7/P00bvD2215Ph0ZIVlLI5KFk6dzbLB4vyCAUDkD
	FB+kOcFYqZwKgdtK7nhqGRQCETWAY8ip4BNvFvX04zfMeH6UpE/3oKiCbByaqnToFlA7tv4Yuyn
	orCWFcZpR+0Ls7ihSphEpM2jSotWM9YYC8ugbYL/sbTldFInXdIdn3rTBcrN3KL6Q6RXPDJ9e4/
	fiGByEB05jUrL9hR4aN+UNy3lD91gS4L+t7yKCrHCvBF5/JABBDcJbbH/NLoJjJkI71JAcczGIV
	UVajS8vLEpdFMYxA+9Njrm69DdMFIOdZU2pkhx32ZSOfd7lGydiktL+SxaEVtb714tV74hQQQZ1
	dhzNBPYaI4=
X-Received: by 2002:a17:907:928d:b0:ba9:2611:31e6 with SMTP id a640c23a62f3a-bb80100e760mr33102266b.6.1777326743509;
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853cb55sm10768266b.9.2026.04.27.14.52.22
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so9392460a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ826ymdkbr8Z79eUeOWzhGnMnQcI+Kv3JN5a5GHQgqG5SVy/GlebricT37C8otFMqJl5h2SMac+LtG16ow=@lists.ozlabs.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
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
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

