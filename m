Return-Path: <linuxppc-dev+bounces-21249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E0CD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 16:20:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLGwp4Gpwz2xqv;
	Thu, 21 May 2026 02:20:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::833" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779294026;
	cv=pass; b=T8boEK33VoThUgE+F3aQm4bc3euNlIZDfFPIvK7fvhwZzQdLpxozZcJyXotE/QYowx8W08miLXdfaBs0s1wwCBOzBJdiJgybllHARKr6aT2qjnT1cP7aTWOiQbbdQNvTvIbr7LOhxRRqDxFW31IlC2chUTK+BHfQw/Nji4MpJzFlOfqWsNV46p9ji/fZQ/iMjHHjdHYMWnNp85UtdlJo+8X3eNEe+vI4jTBKgslU61e7Apc/zhOqZZjEwS7AjFdHElM7hKZaosF7iRPittR8Isx6ngre/dlxRTLQByqK4yqlt1OWYnLsfEspDnP49/2TQ1nbIzUPgtUjPRVSCVrIyw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779294026; c=relaxed/relaxed;
	bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c98N27VpAEbSZq5rIUttRWCdnqoa7SP0bpPhq9/8lJwjDWhuIS762RMtUVOAQOXJlUXuMjPufPBr07XHnZNuOvyUIbWT91PkWTprSGsmSl6VGJuskedVkEu/F2t0TME5LxJyfIFOBY2xlkkmXKJ5o7BqczI1gBcd8PnDASH2QKu/P2CBqR9c6eoafBgcwhCsOY2B+PnWH692t+eFTPCOrhP5534SZovvLNenZMwkil9jR5tJm4EYFXwffs94X8iWTkxjHaShidRYaKVIqYS+6ou6UONepSZK/0OiBusb0Odk0j91bONi4HUIJgAAYeHKcDzCjqQ3Q6v0apdh/uuITA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=czjPYNk2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=czjPYNk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::833; helo=mail-qt1-x833.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLGwn2lL5z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 02:20:25 +1000 (AEST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-515548f390fso4381cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 09:20:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779294022; cv=none;
        d=google.com; s=arc-20240605;
        b=SgL+w0TtuQIMbsSc7UZ3KpUvSWKeFlIyWkbsQC2tfozbu8LRm6K9x680QaVQJeYV3R
         6uAIXoexGipFI7cH7rt41SNq/AaE+cNAJSnWFpHbAeD3bUhLcFBQeJnvic2qxUw+4I3B
         bupFkyvd+e+HYkBPFdkC/w/HQnJNfZ2GBEp3+1Fe82B4ort17c9b+HIH43TIv0W6TG2e
         KhCa5K/yPrr2KalZ+SzfTTOxfIFnNPPL8f2WfeaydHFViXchtVSN6/N9lSYb6GHF5vNd
         jVto+KPamEBqYoBTJE03ENwkkq/cMFSkXo3KDvcLrnz5S/WilcjibdUryi0c9pMts0sY
         Fe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        fh=/GmcIz9aBILaaBsK6628g/NaIIQpMhn8yqSVJN8Ufy4=;
        b=JQPrI8PLjWkQY5LzlRfE3caU8x5M86/W9H/ogngORymX6K9UU4lvWANsmEAqkdEYlQ
         2NyBtjtPcHOnocFTkugou09N0Kf+5T/tGyFcGcJAMR9athFsBC3x4dHEtlmGNIsNFG6L
         zjhG6pzOuKl3MHlD8/PWAByJg0ljYVjpEvqnlTdvRfmnV7YDSKI/chS5NEqEbsjWd6xZ
         caAMsBoE29QN9k5pCGq0x58q1wM3c2v6lrKdiMPU/Xqq8t9aManAiFXHpgcdqTsJveC+
         UTgqndmW1O0QcYSPHJDcV6XcYxNHSFNGr5b/mM230Joyp9AzeQIQrg2DHts33o3t2Lx1
         Sf7A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779294022; x=1779898822; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        b=czjPYNk2kTC4cdRkrp0AWt/XIfoEZjte4cVPks7461hUyzDKkhJo7r68ClA0SSKZsQ
         SCDrZQ7Pu9lkV4xyoCjSTvHVDpW2+nbX1VxCArd9AcLMUFTw2VAgwthuqVMMKqoZZyrX
         NUmaUEdET9cqfr+oL3FEEv3wnzKuEKAs9Gk8YrNV0UQTBZLRr7mQadQ5c5lOjBr5fakw
         1Vu2owZrVAm6Nj1CJ82Tce2rcjjxX4buxphriP2Mzb3G+hsYB2WG4ownMr4QU/h0InyB
         kBxf8S7T7+3BqLFgtJLZ5DjRJQTBFjoZTbIs6Egs5TyCp8yNmZewZnJRWT2MHiHxn2gr
         CSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294022; x=1779898822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=336SA/GYT1P2VucG2saRmHJSICv9pfFSfhTN5OgEmxw=;
        b=P412CekH2onOlVKCiVmKlt8eRxIAZHdgt7JSmlfOoZFcOK+oh9XsEfGVcd/XhLTvN/
         ZO3+4CpVs4DVn7iEZrwUrxEzWWSpMFrRQYn3EhR1w954te3DiidljNEdR//BENm84amu
         kJcq/zlMT/xytWDMVTowgZIUFiMfdQBoohYz1xRPc6B0O6dhZDSic9B85aECe41wJi1a
         atxxsXfdcGAgAW3um4FzBWRXDm03xV/kPh6Zl20+57ZEzuOkHbdsSAkGQCpdDA3EbGmi
         kpzobt+tgzFEu8lMtrcsiWwMUmCYZ/wxGzWQi0RtUT7rP12ne+r7Q57N2CBVaQuSRjDm
         zcFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y0qW776qJMuHDkt+FOxo5rwepnUuHd5rfw6YBfiqnXZ/Q71wuCJh+3hC+9qvCgpxKhDnjKHCPbg3VYD0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQNdJ+3XbEgCf9flt3Sr++ayz/ESnFUiiEjwu0hJJC6y0cAYJf
	RgKm86b24OWM0/xiUxK8O8ZKJOMSWRjBxJ95xLE6N/e54ELz9ka6mRNHdwKdDXtPyGueFe+0HnO
	BiA/E8hvF/TBNN3EuYCa7ekVc7y3av9VK6iK6l5kB
X-Gm-Gg: Acq92OF/GeBp2nmk9QQF6dJIG2N4shpabWj9/31hvT4J62pgVuPCMpp6r38tkhAMfew
	q4eaLTymD8WppDr5m/dB9Luhz0W4mLLwiel94LFSuVDMAmhSI13HBsINwwVCxhBqoRbnwuladEe
	qJYN8r6VENSjng6+79zJOIppVhqTZZ53GsMH9wVt4BWPUrTTHahWMvPfAqwOIcD5kV1rxq4tLWK
	hoEcMVQC4fIU6UB03VjeVwiHEYnRFz7HFC2u2eJFjKP8VmVzwrmOoetP7FD2cDwMSpS3sk2PIXu
	V/JVlvDfma1lyVfy8XyU9QHVrNE=
X-Received: by 2002:a05:622a:1ba1:b0:514:c25e:c164 with SMTP id
 d75a77b69052e-5167937f1bemr20762781cf.10.1779294021124; Wed, 20 May 2026
 09:20:21 -0700 (PDT)
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
 <ag1mk2DSJsiORaxK@lucifer> <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zN5ezh9vvvQDQdMF2KuuDGvkhNjTZWc0y0Lsa-P4Aahw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 20 May 2026 09:20:09 -0700
X-Gm-Features: AVHnY4LoOxiQoJQwfyBuM7QQXQEEIIq-qCobTd7La33Msde42KTqBRrMiQ1PsG0
Message-ID: <CAJuCfpHbKHjktnucBNAuRDSasHiZfFDP6xgz2dX86dX1VaJYzA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
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

On Wed, May 20, 2026 at 2:07=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, May 20, 2026 at 3:50=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> =
wrote:
> >
> > On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> > > On Tue, May 19, 2026 at 8:53=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> > > >
> > > > > >
> > > > > > I think we either need to fix `fork()`, or keep the current
> > > > > > behavior of dropping the VMA lock before performing I/O.
> > > > >
> > > > > I see. So, this problem arises from the fact that we are changing=
 the
> > > > > pagefaults requiring I/O operation to hold VMA lock...
> > > > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > > > is_cow_mapping(vma->vm_flags). So, we will be blocking page fault=
s for
> > > > > anonymous and COW VMAs only while holding mmap_write_lock, preven=
ting
> > > > > any VMA modification. On the surface, that looks ok to me but I m=
ight
> > > > > be missing some corner cases. If nobody sees any obvious issues, =
I
> > > > > think it's worth a try.
> > > >
> > > > Not sure if you noticed but I did raise concerns ;)
> > > >
> > > > I wonder if you've confused the fault path and fork here, as I thin=
k Barry has
> > > > been a little unclear on that.
> > >
> > > I think I=E2=80=99ve been absolutely clear :-)
> >
> > On this point sure, I would argue less so around the fork stuff but I r=
esponded
> > on that specifically elsewhere so let's keep things moving :>)
> >
> > > We should either stick to the current behavior - drop
> > > the VMA lock before doing I/O, or change fork() so that it
> > > does not wait on vma_start_write().
> >
> > Again, as I said elsewhere, I think there might be a 3rd way possibly. =
It's a
> > big mistake to assume that there are only specific solutions to problem=
s in the
> > kernel then to present a false dichotomy.
>
> I recalled that when we discussed this part in my slides:
>
> =E2=80=98For simplicity, rather than using a whitelist mechanism for
> per-VMA retry, we could use a blacklist instead: default to
> always retry via the VMA lock, and only allow mmap_lock-based
> page-fault retry for specific cases such as
> __vmf_anon_prepare().=E2=80=99
>
> Suren mentioned introducing a FALLBACK flag. With the
> FALLBACK flag, we would retry via mmap_lock; with the RETRY
> flag, we would retry via the VMA lock.
>
> Not sure whether this could really be called a =E2=80=98third way,=E2=80=
=99
> but it seems more like a shift from a whitelist model to a
> blacklist model, without changing the fundamental design, but
> it does change where we would need to touch the source code.

I thought the conclusion of the LSFMM discussion was that this is the
direction we would take. Maybe there were followup discussions which I
missed?
This approach still drops the lock before I/O but after I/O completion
it reacquires the same per-VMA lock instead of falling back to
mmap_lock. IMO it's the simplest fix for the issue you brought up.

>
> >
> > We absolutely hear you on this being a problem and it WILL be addressed=
 one way
> > or another.
>
> Thanks. This is a bit of light in what has felt like a fairly
> dark situation. I really appreciate your thoughtful and
> responsible approach.
>
> >
> > Of the two approaches, as I said elsewhere, I prefer what you've done i=
n this
> > series to anything touching fork.
> >
> > But give me time to look through the series please (I'd also suggest RF=
C'ing
> > when it's something kinda fundamental that might generate converastion,=
 makes
> > life a bit easier on the review side :)
>
> Thanks! Sure, I=E2=80=99m happy to wait and there=E2=80=99s no urgency.
>
> Last year you made quite a significant contribution to the work
> when I tried to remove mmap_lock in madvise. I really
> appreciated it. Now we=E2=80=99re back to the same lock again, just in
> different places.
>
> Best Regards
> Barry

