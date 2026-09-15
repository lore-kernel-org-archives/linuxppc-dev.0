Return-Path: <linuxppc-dev+bounces-27441-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C6C982C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 17:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkqND5bRTz2y8F;
	Wed, 16 Sep 2026 03:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:39::10" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789494732;
	cv=pass; b=LInlTty0ysqZgYkJ9wXXKoe/LoRW+hZ9Zbp4zxG0p+ITBoQtxo06MheKxXT+58zlBPURLgO4SDOaMTiRf4pyLx50O3lgjXZRyOPF9J9FbBBh9nTl6ygekozp/yf1YrtFwNGguHxQv6xBRsMYl5K5CgedlwbOkZ90+UdXzIpc7a/7G6Pg8Wce1mHyu9b41ZCP2pT5pdCwcDTWMA10jonq+WMuN2AhvZI1nGh13fXalUNFXtMaBNqXOKBqb1hWGWyxhp/MFlow+R5v2psJOMh7+awHRaittsynbKTOqxwGg3zVUoexWnl0vkdiklt/f/fIddUWe/+lrfjd7zur8aBn5g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789494732; c=relaxed/relaxed;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXjEfIZFuADPtUFRV/Pg8oerdXTpO6W7lj+NADFX/UWp2aHx8gXfaVSuiJOb+DTVahpMUgSU69PnuUI1Q3k/wP9rPz2asI2kCo9WVjiCWTwtDi/OOsSfZUCJ1/KqYnM5iIxPOUci9stPbp8u94Pyiow437qBgB00aFVagzXPeJWfKnFgVzwXzz1Injb7BNqbxx3hB1snAqyGiZGjDzwEbW+n2K+DYlE02Mq4Fr7TsOnMhCyEhe7gJMwvFIM1xkmJHeVyFlMZCTLhJ9Wx+4gb3zQwEluU2YvHPEtVWuqIWLTyJfJhREcbzG3uABCMQTEyowyZFQ0/MX1GEM0xlCgXwg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sP0e21C+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jannh@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=sP0e21C+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com; envelope-from=jannh@google.com; receiver=lists.ozlabs.org)
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com [IPv6:2607:f8b0:4864:39::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkqNC0bfBz2y2f
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 03:52:10 +1000 (AEST)
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2db425c9050so12205ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 10:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=XnC6ZJJ1cGpI+iIs9iSGLITOhDqRudvqCiSTt5fahh539yNL3F2iLAX6ROGxJnSMLB
         RxqBoRQsA1xV9BtXHyGBcJOR1VAT6qpGVH/c8QYwoM2aFy7oGPEqWph4uo4e6FaaaJvW
         vheYrucFEv2EBrXEYHzqJQIpzifQmZNidiFiDQo1TPG93SfHXCgdtG6dkmFcq69I1QvH
         1BdPKDW+FVqUxqqOGnrrwCG6CGyNeXZlJkZGEjXwJEb24vVhhxkNcormcc1q7hy8sPeN
         hhO37APXXLbQkT9vTJ8es9BK82DatsYUTEqHoJr4cgyOwtx74kSIHzoGvhzTHch6KEy3
         XLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=J+8y+KqIq6iaE5MpGYH2EXIEfqpuVrTO0nC8vOCgVPU=;
        b=eVtfmlHlo0rZDEZD5g/4uMUulojZjgmize/7xKFOemt2VHSj8RRyJe/bjTVbyoLNnB
         UclWrWorv6qXO60gPEXVltP/9BuxBX65aBGBOhDexQVvDFa59EWVm7OFpGKfvIMdMtWY
         +LwBzmmLiyEti859m4WnaL29Dzbuq2r1q1+TltIKunKydZ0VPKvQnWn3ELjvPyOL0WTN
         NGzLPI55+WiCX55UL2ivs/lw6raQ+xHfhM7uc+uUEWl/1m7jq26iMzTm/lYL5QVuUJM4
         yQI+Ek5k5IGK15pnXLaWVfWx85DHEQpZc3xsxKi8xoOU08mlWOo2p4MKiXpv01OHsnaj
         9+jg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=sP0e21C+kldjSrgAv0LLZD3NtjrG+MfsUBOHUCvurW1epllby0M1bolJ4Q99ZgTT3a
         92eCMiPV2w02ZwEqNjz5ocGg6hhaw1vAsEnqRNNxhrv1ioYUpxW5wSWNvpanapElBSBO
         xTFtWCcxR6dP5tjWCroFxC6py2kQD+20VchBu7B9gZBezCT3AasHFLjXKsq3dwJUbKl2
         iHjVMUILuwaGbfMCbuJxuZSewa9F4oy0UXS+yqRl5eQ/IgDO3GTdVAOleouKuWhfTbY8
         kRgxnI3nmzPmUIv7YZ6PMHFzn07F7P9Hszb1PwYoJcA+ISG5RBEgdLHhvLlhdJyqRX50
         mDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=dljKDQiNt7kceQ2QXXoDE7eny4tlmgEWulimtP6ON+dKWBAWQcpZjKiCeE3bAhoDfH
         7TrIy21j9RNCS//EYbI5KtV8RMly13k5zY3bv+v8emheB0H1421PdWTC6MkbG2rrnduB
         RHwnuT/6UxQF/SKc7UFRPQuUWNv5US6QgZP2vJP/NV6CTXFL1O94Bp1Jq0gX1tNkgjHY
         U8/qwS190joV0fgZXt78orxdWc9xtvjLYi23hTtyO9j8SvzXjaupfsvHUV0bA8canJZg
         cLnkQRGjyEwgPPKJGqaSs4HeCoDMGCsTf+NwzN4e0di1MwHK3KxbRACRwS50yDxbQMZA
         upMA==
X-Forwarded-Encrypted: i=1; AKwUvBwO6l5Yz2NTyUBTxrcfxoD1zUcnzclnDQ8ctX6gbJGLoolNy9LRE//Jc/1fegk4z756uZjXBiP5IhfLP34=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nRhFnIM6BBc+Fg974U7czjuHgYuXinDi39rkRiOmmInW2JOmIS
	j6TcrAQNhmfnvGg4yulEhh35eJkE+47HBCkM5lGzLFukwzLJCWcLztx6lezW66uB4r5tOSss4Ya
	hd19DlVeWEKr7HxqfGwFy9zsQcPgHUeLozycwI3A8
X-Gm-Gg: AYBFou1M0vuqHvorw2HNm1U5UWt6fXQM6m1je3d49LSZcXT15/vZ9gJCROg/coBOHfl
	NISSb32/NyFf+x1kW1ltp/1pzguL8cJRBFvYMpzzIDvDhM8E8O/aFe6sFQ31AaOzm4wGCpzcwTK
	4ooaqe9tlDkZ58XKcASgPy1VnTMbMVqtI6HInnKx+L9hkO7MKnT8LOFhCLG/aGZjcgp+80UvKVA
	89h1xsbTY4SzLIoZFzVrPflpHgBu7uztIaqadE4HQWo3gf49FLmYk2iJ/CqPvalBRPf6Jpo0UIy
	rqWc+MpyN4TfGnP7PE+2rFKgAJxke+6qOwwa9poFrmZoFjJrl/gzsg/aWJGDl+tRZp+IGDSQnBW
	D+qvGoNR2xHHTaDY9KVCql7cieSQOhfWbf3BEA/1W5iA1TaCvTio=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
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
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.

