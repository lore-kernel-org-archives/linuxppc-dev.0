Return-Path: <linuxppc-dev+bounces-27444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED958C88E77
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 19:09:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hks5N20v8z2yDD;
	Wed, 16 Sep 2026 05:09:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789499368;
	cv=none; b=JlPdHse3jeR1cvH/zliYcDefkS0frl4dCU6bNit+LdYU0YRqHNVaaXp44LQMwoTHwZYz7MbR81cSwBGVydZk8hDGLbObA/FsLkPsmWHYRTCHeb+Gx5WR9atFLXP79POCC4FgEtLrLkyqhI/OJpdeV7VI31LVEIGZU3tg2kCWI4s/X5KRJV968F/yffVhvj1fmGNB4vY7BcMqNDQeXN08aklOuCPMJ4y8HJadaLycy1oLBzvJcv7/N18U4izIeMsUVOFJ9Imca+4chE99xKQeBMDvbQwmNOpG3LoTXPdUEWjsx3X7uGU9atEQ+61tSGPND6eSTV6OFg0+EqW5M1Uqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789499368; c=relaxed/relaxed;
	bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrjTNYHRJZbjFxmPvLVV7R2TVKFyfUlXd37DY0x4cMnH3JPBlk/Rl+l5n5y6Ys1PLNNltgX/xElCJdlYIzJFPZXYq11qAvaus3jSyGEooFPoZ6LOsnaARn8FGiK6B9qmapQev7iXG3M/nHhecLMuwM9zpH5EIFYRsX2CullbKNSgLKRSDpw30K+7LcyDZR651/uumGrLA89O86nKZXuEnzD+jT/QhUC2YnoqFanCGMfbwMT4E18LZ1mqub2aneWaUzwjcm1V5u80CFpCxWsFwulH4AJKumdE3Tqq7k+fkhYWVrrp40AWOqYnb4KorMzEmfBpY+DSP+d7ZWd1ER3a8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=bTUxZYcz; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=bTUxZYcz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com [IPv6:2a00:1450:4864:34::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hks5L2WZxz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 05:09:25 +1000 (AEST)
Received: by mail-ej2-x10.google.com with SMTP id a640c23a62f3a-c254fa663bfso33749666b.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789499357; x=1790104157; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=bTUxZYczIM5tJCwamL0BWFbsbgx9bVjO+geR5SxxlC0h7F06Ir3Ka5KD1zQncmu4h+
         8ZKD6JVkal8s5sLkpeX04QWlqhxtg/rHOSjojVeYwKEelvtMFD7DYDXfXfZddc2qdJBV
         qundUEPD8VjWCPsWhpaOlb/AYFbJ3xqzXLx1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499357; x=1790104157;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XFFk9jJtDswBQpA8QWIooO6lLG4HdlvPT/LqykRjG+U=;
        b=Oy9SJ24Fyj0sE1d3K0taVG9XbbSncUn3OK9Bwh5Fynv7DDtjTYSdcNpyVS8EVK0Tpg
         q5kRTG9Z2UA62toA6xKrRaY4L79893X0K9egBnhhgCXkeStyVSkmJTC2X8Pmm0/Psbyt
         j2xDEG5pmsVSLv0HYnqs0uQMjCp/P+s+3eIdx9Jf+vtxRHpSKdSFEl7cA+updRg/onpP
         Vjia6Ch3AHI6rveelHLVIBmIQkGS5lZJlUPidhFO0k1j/1PUIHWwKf2L54Yu9b1fxiiM
         kJmBEmbR5aL8JgJoZ/ejxyFxlhky3zWNjQyAATabDT9F/WxwuBQYZNwpsW5BOQ+HvtNy
         7n3g==
X-Forwarded-Encrypted: i=1; AKwUvBzT5r61cKe2VB7xAqret6J0GceN1zZaDHRhGVN3PQYDuYeBtUzKhbqxZYDt4SeowbKJSdZdpqFCSZfNUmE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kDmtpmRBmOnWKWHTLetHkRWf+47FgRjnt1NgfcpzJ7c04HF6xn
	uT/j/NU1l4DfRwgAhX0Rg/msvsIJJyscoj5yi6QOHPkyOdiPGioDDkievUBeAX/29CUJ+dPqZYR
	zEV1U5Ik=
X-Gm-Gg: AYBFou2onsuRfTWVJiW0vz0IVNLvkqSberY5krZVQ3cW4N8b8nNwv+uHlx+GXd05gdI
	CGC24ZgyZKJ4gca4YCwpMa43RSm5pfAmaZwWDS4+nNMpA7TGj73+ktkzRPDYj0Vs7v3U8hGUrSj
	VljQPHjp9Mdv7B6OqUdfP4SdOIpg8QZMlsjW5cVlIyx2TPvfzcWEtNsgUwwhZ2YmsmUbrIljO7V
	dfbmuJ5/I3474i3/SOeLzAnQxYf85P9asmleDEFkThTdvrZhNcZbJL4Le6Z8Uf3lpLxCXDgQew/
	cBgIGbc1Od0LGPjM+x5Xc79iRNurtC75Cl/ql6iUl2WBR9lI6ztp60a6WkIaVgu/f5mBToJ3MjD
	Rq+xSn/v7DbOKckWRoCyvpB8VJNe02tkU4aXnsuoKjdp3e51ecTbhRbyy8C+dXzT5fftCH6B1sz
	MlTh58oFU5/tHflF2eRQ+jnqDbTBxnZDaCofTinntSrM6HTmCOaHyjThU9d2szv2utAjhsk7YO6
	JjBTaLW1FXNx0rRN0YsjEAufnDlvNXuZAmS6i7enZGJQZT9PA==
X-Received: by 2002:a17:907:d2a:b0:c25:2e93:289e with SMTP id a640c23a62f3a-c29b86f0787mr1071907566b.16.1789499356953;
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com. [74.125.228.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de5f478dsm15595766b.46.2026.09.15.12.09.15
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 12:09:16 -0700 (PDT)
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa663c1so28573666b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 12:09:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxrQrY8AybuedoK+bvT3iKdyMmHFNPzG7KcZZJf+8eNQEQawo5It5Bt1CZewtVDS+po4VkM8zj55j3FLBI=@lists.ozlabs.org
X-Received: by 2002:a17:906:7309:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29b839a057mr1176039766b.2.1789499355710; Tue, 15 Sep 2026
 12:09:15 -0700 (PDT)
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
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
In-Reply-To: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 12:08:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCm0LMG7z3Jned014oJh6WBcf4uOx0OBk98_hrtHKbrhcQiMMJ_A-fmB0
Message-ID: <CAHk-=wi3Kkqgfg6zUTHpQoZNL2VOB4vYqpi6RX0WNO++29UtyQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 10:52, Jann Horn <jannh@google.com> wrote:
>
> Is this mainly about stuff like "we installed a file descriptor and
> then the following put_user() failed"? Because if so, I think a nicer
> fix would be to have a policy of "if userspace provides unwritable
> memory to a syscall, just keep going and pretend the access worked",
> and maybe have a sysctl that kills the process when this happens to
> emphasize that userspace should not be doing this.

We've done that before, where we just ignore put_user() errors and the
user gets whatever the user gets.

It is maybe not optimal, but it's fine. You can find quite a lot of
unchecked put_user() calls with a pattern like

        git grep '^[[:space:]]*put_user(.*);'

and some of them are in core code - see the two in kernel/fork.c, for example.

One of them says "if userspace has not set up a proper pointer then
tough luck". The other one doesn't even bother with a comment.

The scheduler has two cases too, although one of them is admittedly
for another error case.

So yes, saying "if you pass bogus arguments, you get what you get" is
a valid model. It's perhaps not the *preferred* model, but it's not
wrong.

It *would* be wrong to take code that already has error handling and
remove the error handling, though.

                  Linus

