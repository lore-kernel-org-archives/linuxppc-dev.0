Return-Path: <linuxppc-dev+bounces-21221-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C4CCD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:07:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL5KM2JJFz2xqv;
	Wed, 20 May 2026 19:07:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779268055;
	cv=none; b=nwNAyK45s+QJCNEv2Bco68whyM4FAYGOjk4MmE0EA8yPQKPQE5BePh/J0YA6209MsJxOFjIxGXpIz9pF+kVFIIKy2rtCEgcIN1PnaeBcv0OG+6PJEsfE017IFmRl4rV4cqiwi3fP55gHMoRCSDwhFwgrdb8muztWBdHdWBb0RyN22/EeIkQsxV1pLyAG4CVG/yX387m/0pyu2RrJ+snGyZ0jhkk+TR4viPN7OR0WmGgGjaJOJp2r8HX2Ly0ukPqhrvu5YNkqOKZz7L1P29cF2IX6sPvlfR/bXcAfCqf+4TFLt42ceWBr3dBNxNr1Lcqt2UcITpqH1Senks9mVT2SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779268055; c=relaxed/relaxed;
	bh=v4NWBagxYzHasGGEcU79T5ijVXX4z2pUOQ5qYXZ7jJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEBFZ4cfbmYfZWXs08m7arKa+3FA9Uq/A5/AXV2A3jiyYh5UKaw+l27g6bWAoWcwK9yv7UHPCJyA9yrr4bGF5yis1UV6/SXkp5Ap7TSpEYsfSq6UHgNVpChQwDzLhouiCs3f+TaGWHVUZlh6epHJ+JP/A2FppUT3HCnNvvSEMqb96bs9zEqZB+WPF0880KRv6Zz0qBirXq9JOA89V8mVuUXU/YgG89TSITgSkqRco9FigUVffaZMIACFy3SmiIyxUQ9IzqPRVKsdv3NdyoHqe580oJ6sKYY5RuQCFlpmTmBVZhwk2LgcuR77e2MO/1JLZJcEnbyVIV/G+439EGM+vA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBpj2TO2; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HBpj2TO2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL5KL1WsRz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:07:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E77C343CC9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 09:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6FA1F00899
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 09:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779268051;
	bh=v4NWBagxYzHasGGEcU79T5ijVXX4z2pUOQ5qYXZ7jJc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HBpj2TO2qA5Oor7OHt5Ye/pMrVKsAa+tgR47UAhIhwI3yvvVE0YC6Uki3M1ZSwg9X
	 asyERscZ397Lo+0XizKdIs72Miu1IMnt3PRJZo3ougkZdBCWhlygkHaiUNzohh15IR
	 vAhXqfXC3iF2RbQvfZPdWAgx6KAPH7jkop0CvuXrEWN21u49pHn8RQZD1BwA27fuvq
	 Bt1H1Lj4ObEpuYoP93W/mda/nuhZ48Up1nhVyCOwnVaQZ1CLCPdw5a+spdcD5TWEp6
	 0QGlED+uyIsjRv5jN30SuEcKCOlN+lu8whLsgH/GtAV5SFLkN7eCCxHzB79FTYk8Yj
	 HlaNDYyigSwqA==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899a5db525cso27961616d6.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:07:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9nz6iWl6Tv8JGlr4bwxENJBy7lwN9YUhY49T7gpfx7qSlkcyG0Kqc2QSlHWZ529PZOINGHHPaZIdMWPog=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzxD0xh0AVSnbERvh3lqJ+NqEBjnSGUBB3v+1iiWq1sSYAOkryq
	ZDs8VrLT0LDmWtOP2ghWqqnvNwRFzNRwHNnxRji2tJSG1oZMIIuywTbPSCQVxSZ6R1lLJ+I3B+/
	swyyQsSvU82TBGZ2VDsjawSgFLEfkVEM=
X-Received: by 2002:a05:6214:29e1:b0:8cb:fd76:e904 with SMTP id
 6a1803df08f44-8cbfd76eac8mr35985186d6.17.1779268050694; Wed, 20 May 2026
 02:07:30 -0700 (PDT)
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
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer> <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
 <ag1mk2DSJsiORaxK@lucifer>
In-Reply-To: <ag1mk2DSJsiORaxK@lucifer>
From: Barry Song <baohua@kernel.org>
Date: Wed, 20 May 2026 17:07:16 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
X-Gm-Features: AVHnY4JPJjfMfRWu5irKuds8oTQCJquviUDQwK-7Iye_Xeif_N9I88YUISr9aq8
Message-ID: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:50=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> > On Tue, May 19, 2026 at 8:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org=
> wrote:
> > >
> > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > >
> > > > >
> > > > > I think we either need to fix `fork()`, or keep the current
> > > > > behavior of dropping the VMA lock before performing I/O.
> > > >
> > > > I see. So, this problem arises from the fact that we are changing t=
he
> > > > pagefaults requiring I/O operation to hold VMA lock...
> > > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults =
for
> > > > anonymous and COW VMAs only while holding mmap_write_lock, preventi=
ng
> > > > any VMA modification. On the surface, that looks ok to me but I mig=
ht
> > > > be missing some corner cases. If nobody sees any obvious issues, I
> > > > think it's worth a try.
> > >
> > > Not sure if you noticed but I did raise concerns ;)
> > >
> > > I wonder if you've confused the fault path and fork here, as I think =
Barry has
> > > been a little unclear on that.
> >
> > I think I=E2=80=99ve been absolutely clear :-)
>
> On this point sure, I would argue less so around the fork stuff but I res=
ponded
> on that specifically elsewhere so let's keep things moving :>)
>
> > We should either stick to the current behavior - drop
> > the VMA lock before doing I/O, or change fork() so that it
> > does not wait on vma_start_write().
>
> Again, as I said elsewhere, I think there might be a 3rd way possibly. It=
's a
> big mistake to assume that there are only specific solutions to problems =
in the
> kernel then to present a false dichotomy.

I recalled that when we discussed this part in my slides:

=E2=80=98For simplicity, rather than using a whitelist mechanism for
per-VMA retry, we could use a blacklist instead: default to
always retry via the VMA lock, and only allow mmap_lock-based
page-fault retry for specific cases such as
__vmf_anon_prepare().=E2=80=99

Suren mentioned introducing a FALLBACK flag. With the
FALLBACK flag, we would retry via mmap_lock; with the RETRY
flag, we would retry via the VMA lock.

Not sure whether this could really be called a =E2=80=98third way,=E2=80=99
but it seems more like a shift from a whitelist model to a
blacklist model, without changing the fundamental design, but
it does change where we would need to touch the source code.

>
> We absolutely hear you on this being a problem and it WILL be addressed o=
ne way
> or another.

Thanks. This is a bit of light in what has felt like a fairly
dark situation. I really appreciate your thoughtful and
responsible approach.

>
> Of the two approaches, as I said elsewhere, I prefer what you've done in =
this
> series to anything touching fork.
>
> But give me time to look through the series please (I'd also suggest RFC'=
ing
> when it's something kinda fundamental that might generate converastion, m=
akes
> life a bit easier on the review side :)

Thanks! Sure, I=E2=80=99m happy to wait and there=E2=80=99s no urgency.

Last year you made quite a significant contribution to the work
when I tried to remove mmap_lock in madvise. I really
appreciated it. Now we=E2=80=99re back to the same lock again, just in
different places.

Best Regards
Barry

