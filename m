Return-Path: <linuxppc-dev+bounces-21204-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD15ECD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 05:51:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL0zH3nW6z2yDs;
	Wed, 20 May 2026 15:51:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::832" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779256299;
	cv=pass; b=UX/2gehfq0VoSpdbYMaO4vcmrpiZO9QEO30twngobi1H4g6vxcsDED//ssdkCIN8zFNTPfgDovz1TW/lJPiBG5OBoa6vU+BkplWtVwHPArmApVTJF9dQi3g0kCyXjyAFh/hPqLOD+CzHmLEVr1RvYuDkPV8rfAhQUlHNI2Z80JB32Hxu5UE9SpL5mw4lo5v9X9rbjDV2n79AujzuE+9oOFs/p9uSQWeMQrPIWohpotXraa9/qVlEqEqroDuylconlqPrxwZaXcaYPKdqqp1ixDixm5D9fUhiYKZVJJ11PluB2UngCI01/hVwsmvjNcSHzXgH1+xfTJCagvGuVA61IA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779256299; c=relaxed/relaxed;
	bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNZJ0Wn/CAwOYZVXQhnSXMXmXPOrC82oR7t0z8bInbA/WrvkmOh+OQzzEngoFqJ4/HGRoPtCitIz8ZP1ACnBFx1QEJxJpGMecpuchMmWeAFu7hT8q7NDnf9scQ6lSyr1egAIH8W3LjeNFDcjsKCpl009tM92SfzeDF+LFjsa7EMCeUcRXaEThNnqopkvmOYE8lBtLITA2JsRzksmHk7hBAaQCV8qRhXNEkI+HbVYZVQc7mBrUrwMvXKyvTFhW8/AOpWyMsHDug48LdmnxxLbScifzQd0M5zKUu8P3J52C4CArBT+ut2/al0WbDRQFyk/tdgyq1g+Rc1Y4jTebv+EkA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UEDQNB7f; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UEDQNB7f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::832; helo=mail-qt1-x832.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL0zG3hLxz2xy3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 15:51:38 +1000 (AEST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-50d864c23bdso15391cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 22:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779256296; cv=none;
        d=google.com; s=arc-20240605;
        b=AHI4GgQShQCWatnTAZRbsLT0Ksv6sY6CSNWbaKWwLSr4dz/Z1j5UHhjDuR+3nnwApe
         uq1wNuHiw2St7q9do7oxVqqThpjaHdWqq2+4Y2qbemJ97tCSbhpql41rfQx2nfUr7cgA
         w1eXVsIOLQl7jckXhOcDFb7gyZJd1Nx/eIg7sF5P8MEQhkiRALcOPaOP2EUBhUHwMKpQ
         szn/Zgd67Fh/TSDQS6kxnnt7kusYMdq2afsJ/Q6C8C1EjVTpBoEU1HQh7DdHOyUK7GvV
         TcyqA6pQuQz86ubsH0JT1ZemLT4OyD9k8eWFbQB2cpUPaWFE1+ykuRKbHE+voH2IYut+
         g/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        fh=iGlkQ4JDPdnXOKVzqdoBJeesWcTx5pVhHIi+GuvPa0A=;
        b=Zyg0jZTgVkM6MbXXDVbzGwMpaQHu2zV/oeX0O7CqPdhjwnqaCqs8hOoreRQTtUiAcN
         YEHTaNFXE7ygXx/ZxeJhTN02zRDZvRWdMRQ9/eD7aB7Of09gnJ18LvUkcaYTqOtstHt8
         pzbHqkcoThstPGhgGVJbK4FIAEm+aDbUaXdrfIVPuiJGh1EUwudRTVUzxt016nilJr9j
         mZ/Z9n42lGS8cADm4J634EoA2rphqNv/mayvvxv1aVZxESpyaLgKwzLRlrq2loljP5bY
         lnjPNy57PUrU8MsQp76coeqrTNeSbIAmpFfZZniQRgbU38mjRzXS9wCQ/B0k1zXQLTKr
         XeZg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779256296; x=1779861096; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        b=UEDQNB7fJfCzhoH7Ce4uJKkhBA5wkoFy15ceY130ePqDjCx2xH/+Rv3gzKlcRkn7y6
         +pxyvndzg0FDHJHn7+dky6UvkoW4XqsxVk7z1hK28bL74iP0DiHg4+zy1cVMrbr3zWAM
         nkQekij8xlGyoCX7LHL0cb16C0gDXlsYPS9oplnm56haFzwTmxJ3gFMyOLTZeImFly3k
         GwS1TbExN9dlGPFR7Me04jEd7tIdPk4mOuwZ7EqGQAY8arN7taXNgo7YTktIUT1absLb
         Nmhid5mcoDM1ydA40kp8u2sV3/+yP8ogxr66VkzT1ubQzK3B8g/uwwF1Q3gwZyffrCcu
         byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256296; x=1779861096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gt9LoBM9h0v+gvRnQ1bJjfV7wmkEM4+ijibPUWac/Iw=;
        b=Ewjy/zwJ1D0QtT4ckuKXBvIAgIgRUyCu7fhhP3FlvaeiDhKGAfEvkRCDLLHupx34B8
         jClwfg22/ecuwwT87dho7xurOEDxbsGY/v+WYRtqUt8IMCe8JvEOWbDRMZQao3FghQ8q
         uJ3pZM22vE2GugXVqNYVICVucGaUgqMjYlaz0Ju2fSRyde5rgZpfs4EWytCRtF/yPhMJ
         lFe+WI3ATbIsTj71W8y8gexpiSUfxRGPCjL19dzKVMoyzD4GbaTHUP5yjcqOOs7ziw9m
         EjxnZaCBa5Ry/s4bvQuYTQPweX1LbZhMSx8oHPWFpziZ3l5nobxM3IkltX51JictM3/W
         QtFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6vcwSfQoZepfEFL3ArUllEyni1dCIU8E+o/js7cyVzf9TXYJjsLrTHnv6f2IvhyIPtjPru5F9dcm7Dfc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxNLCICQzQ186YzCLwumrG1TJMo52ej1TDoQwSsHke72hGsCm/T
	eQiXg/J64FZ+bN1hVIRAZNq1YeNBQarxgkUhz2HeGrXvcV6gE57vF41NZYRvwukuXTHlnu5Y/mz
	++Ze0/MaWX68TPnSF/UHnqazrYmv314LOyBgJK74T
X-Gm-Gg: Acq92OGF8tNxBqHm3TuDDVa/lVQ2QpvzMQ07Ri/r9NNMXWcAtxZZxFXt037brYTq2AO
	zR8PMBPq+uwOjiX7CdNxToaX8tCAntv69w3FTOSOg5QU1ywQSkluknqVshD/Vi71Pj724/Fs4/S
	eluyJhHG/VaexUktTIILHsezjtUC5Am6jJFAhB0rN/NfjLjjFXzXdcR4RA/F4dLQydmop5AGijX
	oLpACS0MhkiRk6r2Q4uFMI4aL1W1Kt6d4u7VXQQ8JrjhapKilq+/5A6CgitI5Mxg+0IDOgCV9Ew
	ZOIw13LtC3Kx11axGz3P9uvFaR1jrWwvF2JXAo+u/xDQHg==
X-Received: by 2002:a05:622a:1920:b0:514:b17e:86f3 with SMTP id
 d75a77b69052e-51679461795mr15633081cf.12.1779256295164; Tue, 19 May 2026
 22:51:35 -0700 (PDT)
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
References: <20260430040427.4672-1-baohua@kernel.org> <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org> <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org> <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer> <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com> <agxbq1TxJdniMQT3@lucifer>
In-Reply-To: <agxbq1TxJdniMQT3@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 May 2026 05:51:23 +0000
X-Gm-Features: AVHnY4KMccW5pUeVLxDyTF9Gnh50gzRE3EOZpgiKFqqXipSU5KPE9rQdYzJrFBQ
Message-ID: <CAJuCfpG2Zmpf5N_ejB6ZDv8LDjpVtTfA_tYQ6sW+Noc9Y+XhdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
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

On Tue, May 19, 2026 at 12:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> w=
rote:
>
> On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
>
> > >
> > > I think we either need to fix `fork()`, or keep the current
> > > behavior of dropping the VMA lock before performing I/O.
> >
> > I see. So, this problem arises from the fact that we are changing the
> > pagefaults requiring I/O operation to hold VMA lock...
> > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > any VMA modification. On the surface, that looks ok to me but I might
> > be missing some corner cases. If nobody sees any obvious issues, I
> > think it's worth a try.
>
> Not sure if you noticed but I did raise concerns ;)

Sorry, I didn't realize your first comment was a conceptual objection
to this approach of allowing page faults to race with the fork.


>
> I wonder if you've confused the fault path and fork here, as I think Barr=
y has
> been a little unclear on that.
>
> What's being suggested in this thread is to fundamentally change fork beh=
aviour
> so it's different from the entire history of the kernel (or - presumably =
- at
> least recent history :) and permit concurrent page faults to occur on a f=
orking
> process.
>
> I absolutely object to this for being pretty crazy. I mean I'm not sure w=
e
> really want to be simultaneously modifying page tables while invoking
> copy_page_range()? No?
>
> OK you cover anon and MAP_PRIVATE file-backed but hang on there's
> VM_COPY_ON_FORK too.. so PFN mapped, mixed map and (the accursed) UFFD W/=
P as
> well as possibly-guard region containing VMAs now can have page tables ra=
ced.

Ugh, yeah, I realize now this is a minefield. Resolving all possible
races there would not be trivial and might introduce other performance
issues.

>
> That's not to mention anything else that relies on serialisation here (th=
is
> would be changing how forking has been done in general) that we may or ma=
y not
> know about.
>
> The risk level is high, for what amounts to a hack to work around the fau=
lt
> issue.
>
> I suggest that if we have a problem with the fault path, let's look at th=
e fault
> path :)
>
> So yeah I'm very opposed to this unless I'm somehow horribly mistaken her=
e or a
> very convincing argument is made.

So, current approach of dropping locks during I/O sounds like still
the best solution.

>
>
> >
> >
> >
> >
> > >
> > > >
> > > > I'd also like to get Suren's input, however.
> > >
> > > Yes. of course.
> > >
> > > >
> > > > Thanks, Lorenzo
> > >
> > > Best Regards
> > > Barry
>
> Cheers, Lorenzo

