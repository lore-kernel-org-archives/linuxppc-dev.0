Return-Path: <SRS0=SmZj=WM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA12C3A59D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 18:01:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FF920644
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 18:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0gBjg2V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FF920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 469B2z39NQzDr1C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Aug 2019 04:01:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="0gBjg2V1"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4699bc71GqzDsZx
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2019 03:41:16 +1000 (AEST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BA0C52173B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2019 17:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565977274;
 bh=aFI8TAvCX3mGqmCyOrNiViRTHQlXirAglLGjqpHruWA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0gBjg2V14ARcGqo5UtatDyyrKjytpOckH+hDzoQQkMrjJPC6lX1IsBIHdwj0XKPJd
 DR6ykHOX1+iypJVJZIVLGwRqNlu2w1c9CUmU176K4vmXvTHuCBxBk+loOxximauXem
 d9z1EaaXzc2PPV5jzw+E1iEQaHjsxsjKtiXhMcKE=
Received: by mail-wr1-f47.google.com with SMTP id q12so2271573wrj.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2019 10:41:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVW6d7nwOaCql6q2/HKHpuWpS7BACsZK3urAFDRUWAnmeuFH4rB
 H9fiP7Gfpyu1lsKKZbBI4/dFl3Cg2/sziLmAQUkS4Q==
X-Google-Smtp-Source: APXvYqzveG7PkQFV9wdf0zO8FmCpzV1MLl/+T5FsP9817WwPw6mkfLs8yd1jibQ/5VQjRtlN6sIawjfamdEbUy4XEz8=
X-Received: by 2002:a05:6000:4f:: with SMTP id
 k15mr11973553wrx.221.1565977272223; 
 Fri, 16 Aug 2019 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190815001636.12235-1-dja@axtens.net>
 <20190815001636.12235-2-dja@axtens.net>
 <15c6110a-9e6e-495c-122e-acbde6e698d9@c-s.fr>
 <20190816170813.GA7417@lakrids.cambridge.arm.com>
In-Reply-To: <20190816170813.GA7417@lakrids.cambridge.arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 16 Aug 2019 10:41:00 -0700
X-Gmail-Original-Message-ID: <CALCETrUn4FNjvRoJW77DNi5vdwO+EURUC_46tysjPQD0MM3THQ@mail.gmail.com>
Message-ID: <CALCETrUn4FNjvRoJW77DNi5vdwO+EURUC_46tysjPQD0MM3THQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kasan: support backing vmalloc space with real
 shadow memory
To: Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Vasily Gorbik <gor@linux.ibm.com>, X86 ML <x86@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Linux-MM <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>,
 Andrew Lutomirski <luto@kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Dmitry Vyukov <dvyukov@google.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Aug 16, 2019 at 10:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Christophe,
>
> On Fri, Aug 16, 2019 at 09:47:00AM +0200, Christophe Leroy wrote:
> > Le 15/08/2019 =C3=A0 02:16, Daniel Axtens a =C3=A9crit :
> > > Hook into vmalloc and vmap, and dynamically allocate real shadow
> > > memory to back the mappings.
> > >
> > > Most mappings in vmalloc space are small, requiring less than a full
> > > page of shadow space. Allocating a full shadow page per mapping would
> > > therefore be wasteful. Furthermore, to ensure that different mappings
> > > use different shadow pages, mappings would have to be aligned to
> > > KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.
> > >
> > > Instead, share backing space across multiple mappings. Allocate
> > > a backing page the first time a mapping in vmalloc space uses a
> > > particular page of the shadow region. Keep this page around
> > > regardless of whether the mapping is later freed - in the mean time
> > > the page could have become shared by another vmalloc mapping.
> > >
> > > This can in theory lead to unbounded memory growth, but the vmalloc
> > > allocator is pretty good at reusing addresses, so the practical memor=
y
> > > usage grows at first but then stays fairly stable.
> >
> > I guess people having gigabytes of memory don't mind, but I'm concerned
> > about tiny targets with very little amount of memory. I have boards wit=
h as
> > little as 32Mbytes of RAM. The shadow region for the linear space alrea=
dy
> > takes one eighth of the RAM. I'd rather avoid keeping unused shadow pag=
es
> > busy.
>
> I think this depends on how much shadow would be in constant use vs what
> would get left unused. If the amount in constant use is sufficiently
> large (or the residue is sufficiently small), then it may not be
> worthwhile to support KASAN_VMALLOC on such small systems.
>
> > Each page of shadow memory represent 8 pages of real memory. Could we u=
se
> > page_ref to count how many pieces of a shadow page are used so that we =
can
> > free it when the ref count decreases to 0.
> >
> > > This requires architecture support to actually use: arches must stop
> > > mapping the read-only zero page over portion of the shadow region tha=
t
> > > covers the vmalloc space and instead leave it unmapped.
> >
> > Why 'must' ? Couldn't we switch back and forth from the zero page to re=
al
> > page on demand ?
> >
> > If the zero page is not mapped for unused vmalloc space, bad memory acc=
esses
> > will Oops on the shadow memory access instead of Oopsing on the real ba=
d
> > access, making it more difficult to locate and identify the issue.
>
> I agree this isn't nice, though FWIW this can already happen today for
> bad addresses that fall outside of the usual kernel address space. We
> could make the !KASAN_INLINE checks resilient to this by using
> probe_kernel_read() to check the shadow, and treating unmapped shadow as
> poison.

Could we instead modify the page fault handlers to detect this case
and print a useful message?
