Return-Path: <linuxppc-dev+bounces-21254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608A2CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 21:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLPSG0dlXz2yLB;
	Thu, 21 May 2026 07:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779311678;
	cv=none; b=nqaMMzLYzfBc0YkltZSdy1Ktje5UmGnAf+Iu6AIU6nNLgJOqPVgOPd1C/goT598fQugneiSrdIWioUND2XTD/GwC5fwQaHTlWo8Vvpfn/QxV9FyQ7PEzbKOvgYOHB6ZLRaqPvEeqZfBLht8kCCPcC6VzGm3fb4UahtbpOkYYV0ZX+c7FJptf78PAk07pGeccmIVi2Cp3rVqgyjLF5MnuWgwaymeMHAqgMsbmJPvKzPpIRMXQNkRa7PX0WsON+8TgbKeFamtS/TN29pfrfKtXekMGkI2mHfrHx3Oilxcv9OaEe2I7V2xVt/9LvOEQwHAO36Zh89zb1Zsp/Yd108C0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779311678; c=relaxed/relaxed;
	bh=1rF6qiFpXobWU7JpkXbQs61u2QeAi7J+W2nUaLHy7Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K82x5dRfyhsI3B8tOU1VLMHYTELtFiqmaRP6ZjhBTv9j1yzagFqIHOFHOsUF8wkfe5xRxpWN/yBsqbmfTClJFUpMzeXUCJ9afmh55296W41yNPoF9q+RAouPfqoCcJq67IYJbRBMZDCn4OxlFGuqT/RnvPv4lF9AxjhywI//LqQlj4AMrg35x0Ad6R8kBWh1P5we79qSI/qmWPeKg3Y8pxQ5wtm/OZmt9+j8yXB4aMyh3G8F4DdhdBso22bKupYui1U69r21dahG9011+2fajIa7Fi8BjFsd/EnMmptFeNYhELjxey8kVv5Js+fDI1NIkwTT41L+qzwHBXAeGadM/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HK/SOOl8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HK/SOOl8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLPSD6pqwz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 07:14:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 957C24457D
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 21:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6651F00ACF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779311673;
	bh=1rF6qiFpXobWU7JpkXbQs61u2QeAi7J+W2nUaLHy7Vk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HK/SOOl8prV9nDfcU4qR27QfrnPfAvRTe04dADtuUvM/vASUzu7erWdJn65vHYk4W
	 bMjAyFw8jd0koqYYTqCWL5jLHS8XcZFVM+/LyEnGwj77SGWYvRR04rXQOmGrntAgcn
	 0P/iTap4ezpBnCuekLA0xkC6MDE6oDtTMC7MLcKWd/AHmn0N/aeOu750e/e/80nhol
	 UKg7K7q6AP+27tw/U71YnXT8I1+gEP1D3flmj1O9i3F0KUf5DZiwCbVzoonnS4SGIV
	 gpLlyKaLa63QwhGox5IAoKUkCp0H+ALsCmUihp3rverakPWUN/meBF+cjvZIYH/FPp
	 NFKqXA8ZQ8jVw==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-913cc4d7c71so541601485a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 14:14:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8GJXxn0h06kcci8J+OJcc2vNKV9CY586HSuXSv3kcz5iqyUQy/O7sVkLw5S4UNYBJ3OJrspYITwhGyRNs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YznpfpikMceBapjMjvcyZi1m4eyzjS+a2D5XYjVjfQoIaMZNe5U
	0BWD74LK+h7fB/jj6H3WTmKDYI+d8sfm/GfTzT6dEkWX5fQNokERck6GumlIP7OBfLgEkmikhcS
	6LBl5eoxRX8bd+TckxhMLdPCJ663HijQ=
X-Received: by 2002:a05:620a:4083:b0:911:1a2c:f953 with SMTP id
 af79cd13be357-911cd75d3e6mr3875314385a.20.1779311672425; Wed, 20 May 2026
 14:14:32 -0700 (PDT)
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
References: <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <CAGsJ_4zgeE3ebEJ+j7GJFzWVoVYHeiOn4dOoOsmWCLA6s=oECQ@mail.gmail.com>
 <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com> <ag4h87CBd-gph9zX@casper.infradead.org>
In-Reply-To: <ag4h87CBd-gph9zX@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Thu, 21 May 2026 05:14:20 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ipz6n3Spqx2zj00QGF2vF70GrKqLnsMaayM8MuFibnvRKE25oqOs1hwAE
Message-ID: <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:05=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, May 20, 2026 at 06:01:56AM +0800, Barry Song wrote:
> > > implied is that the per-vma locking may stall mmap_lock writes for
> > > longer than if the mmap_lock was taken in read mode?  Barry, is that
> > > correct?
> >
> > Not the case =E2=80=94 the actual situation is (if we modify the
> > current kernel to perform I/O without releasing VMA read locks):
> >
> > thread 1 PF: lock vma1 read ----  IO ----- ;
> > thread 2 PF: lock vma2 read ----- IO ----- ;
> > thread 3 PF:  lock vma3 read ---- IO ----- ;
> > thread 4 fork:  mmap_lock_write ---- lock vma1, vma2, vma3 write ;
> > thread 5 :  take mmap_lock for any read/write reason
> >
> > Now you can see that thread 4 has to wait for the I/O of
> > VMA1, VMA2, and VMA3 to complete, and thread 5 then has to
> > wait for thread 4 to release mmap_lock. Both thread 4 and
> > thread 5 can become extremely slow, because I/O may be stuck
> > anywhere in the bio/request queue or filesystem GC.
> >
> > So now we have two choices:
> >
> > 1. Change fork() to avoid taking the vma write lock for vma1/2/3 where =
possible;
> > 2. Keep the current kernel behavior and drop the VMA lock before I/O:
>
> Option 3: Say that this is a very silly thing to optimise for.  I have a
> hard time believing that any application will care about the latency of
> fork(), or the latency of page faults while it's in the middle of fork().
> Multithreaded applications just don't fork that often!

My understanding is that we should not blame applications here. This is 202=
6:
there are basically only two kinds of applications =E2=80=94 single-threade=
d and
multi-threaded =E2=80=94 and single-threaded applications are nearly extinc=
t.

