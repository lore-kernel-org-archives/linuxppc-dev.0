Return-Path: <linuxppc-dev+bounces-21129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764F6CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 19:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK7qx4bL4z2xpn;
	Tue, 19 May 2026 05:57:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::831" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779134237;
	cv=pass; b=YIY2CKTe1mA16Zpaofp91a3xzvmftYVs/Ynt173dfpKUV6gFWNvz++PzthBdKsv/gG84zW1Or0aHkHnhZo3JFBDVAjqml7glSnH5U3fTXt/ToCb+N72iiCN6OsULwIbvvXsp/pbd4S22bB++9KKvTAcOxbcQt5GWLJ1mj0u1//e5qMuM7GB5oG+fieNfm+06MF5sq6mOmbMsSnXBr+KjbXxX9RjAa2SQ3o+SnIAAEdl3mQvh+S3AoDJbX32zD/u5Kt4nvlLDyQglm4/tG128VNlNaBlKw1J123sG5aMqZaWi//aoyfD1XUOQnUAFqwGdbjpS1OGQyEt4aFIhHagJ9A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779134237; c=relaxed/relaxed;
	bh=u/+TIJ7IgUqjV0Bv46HdaV7jQIvLaf/1u3zzskYDkTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjCgdNjs19ocbzG0bTGqtQ37yDz75BE9OFFZ/AgOighOulSP/8zkF1JCfmvyQVVsORdS0YJ5827fcoxTS2eh/999cu9gl1/LjsuhyOmIftJVCjRiXoHrFMvYtEXMq8LOnLpY3OSdEQY3hsde+O3Z6Nlp3H6EFUgcBEYU5GiPlZyK8mqXNGTrGq6VZ6rRDVb/qcJjW1AwvEpEQoHkop2IoYd/KU01+yUeymYBlU47rcwVIG4W1FKuFMAhuq2+EtcO2wgzLS369sMwQmvL9VBHNtkkh64kBZMImtiR27vVpx4DNV7qkd4GF2v5nmvfD5WVFB5Mewaa1nZ1IxY7d4Z+/g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MTGUCfn8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MTGUCfn8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::831; helo=mail-qt1-x831.google.com; envelope-from=surenb@google.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK7qv6yRrz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 05:57:15 +1000 (AEST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-50e61648f10so5871cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 12:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779134232; cv=none;
        d=google.com; s=arc-20240605;
        b=hFRE5yKazihjG8tFY2mBJCtsRzpFozwy+v446tFXxEzwdfNSiwgM+LoTUMAy4we6LC
         UeqO1gmF9P3sc/D/9Fbrv9JlQ84XtJyjCy7CFoZX2uND9nDl07W5ShDl4kLqYn9NB4I0
         egsi1OjooNeSOMxAnylLILt3/0xuraZwhpe3Iu65miy7u3hzUA+cbDeJkVvDLGhbe4sX
         VUDcC7dSB1eLdrOe3GFeQWjl7rvuye917aQhBN3QQZZ+WpiFuWkMddEy42i4L6/NkT7x
         rQrXGCTFx9HThWPKpy6MnjHmj00gbscIt1rDrPCWam7j9AfEseKs9cHSzEzRC+xrdiXX
         /Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u/+TIJ7IgUqjV0Bv46HdaV7jQIvLaf/1u3zzskYDkTs=;
        fh=ap34ln+RcQuKOO2TZaCGlAY7EOd4+78tGNrU4I0uwUg=;
        b=U58gCrxQ8UjTw/11bsGQUYKG6w/pvUt3javE2RzAyYe88vPx/AT/F7dIiPI/gytUtP
         7EEAgGn3D/QNJ5GHpIjxpjvYiJVOL8nI5eeLxlDij2rXO0rh8pcq6fAiboSoPWQaYBtd
         2Q/def/vm97HRVRMiVSdcItdwID5ZaX1Lb+w8AeKWb++KuycXoSOGsSM0oD0mWJUsRYy
         wOqIDXEPppn32dg9bFvPNznXhWsPpxZvGts93mqLrDHaGY9FXmMPshiw+9eM5qxaiwBY
         xx3i+m3a+9IqPoM4US8sIBLbKIfXsPiUNPRyYmT4KjMX2yIILRX0kKvvNJZQBOI6Nj+A
         6KHw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779134232; x=1779739032; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/+TIJ7IgUqjV0Bv46HdaV7jQIvLaf/1u3zzskYDkTs=;
        b=MTGUCfn8eatlLoytIXBCVoh2aHBcvA0+A7il19vAbGzUXz/AZRam7VOa9i4pfa3CWt
         /UKU0W4E/Nep+7ltdonhhDXDaGn23dvBiXX6vZSfSvybbq/2e7A4W1b1DXqvaSbkcKDv
         PwP+56opE0j9crjHEeaUI+tuX2FeujLEvPnUcluxOqiiG5LtpM1gaa25yf9G79vhXovH
         gHQMNwCYITGINfkGOwgTdir+ArKoFpRjJLzzf0ls2xunbiiQf7jEZswNI4rknpyQ/AN5
         m6j52gzaoBYFNHjYEyDu0088EubIY3kAN8LUxYmmOeiCjf2S9WUZ0iPM59RaMe6eXz0G
         cSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779134232; x=1779739032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u/+TIJ7IgUqjV0Bv46HdaV7jQIvLaf/1u3zzskYDkTs=;
        b=DZWQzrJ9Dp74B8c9F4J76AVyLGTg1N544ALL6G/McUROOgW+CJJ6V/pgrx6KrYHcrb
         lLkgLmjLobKNfmDiLycd/0opgBoioE8QUJbWVw5Gt+XljeEHdSwvZjP1vmhMXc8C+U1o
         PIOAGNaRFCm4B0ufb9QfWTQa6L6NQ/wH6M3G+DCxUDFhrT6oMzra1SMHcIJJk9EhSYew
         E4TwH6tzQEYEohhZzKaJYouUwru/zG0voYKqZ8yqVhzi+XilOTH28Rn2bD5NOZhVX2q+
         WQwrKGkagMx4isY/LEq1P7Ix+aHOcWT9zhMcn9CJ1b/mDHgLJqcYFltD5nJS9g28o60P
         FfSQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m5NJSLtYc3IccJ4aDvOK3KR1T0Flm8M8rieO0Nkx9Ex1XM3OyHAzI4iLpOC2YQ8tSqU+UtpqnxRGNtH4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzI7BWO26SUGAQHTnf8lpecz8d/nFM58iAHL+ENPJ0Tu1snlgfP
	9cp8kTOzevXgAonU3ckdo1WREBIR4ZkEhcSDZDYy5jz/QB8aEEFahVMYCsX2tw+Mj0RF0XDpgd5
	Ca5SCaZ5k20tO1irN0y+uXHvaNlFLBMnqoCccjXRt
X-Gm-Gg: Acq92OHkwLTdhJYExy/4UxiDaK778ZIB/HJb/ibwGgSR2pu80NWB4Xz51A75qsIAyjI
	TjVcA2DS83DUU4Bjzu91uSZbFvdoK4re9dAVdRoQEBHlCiGVyr65Z8aEemV8mVs0SFE4axMvIZ7
	IbL5+v7R6Okwnu842UBpctUOMJY2Qpn3T08BnGWUCBU/s1x8OxDTWTOETk9x6hfJwnoj//Uz8NL
	KyNlo89vNDTK8DS6XAZ5ZtxZudriwQJbgvQNnE2pUMnztmHYEkX4L+4eYtPpaCluYdFwRUWbR9r
	xQXMMnG7pqKvCkMI
X-Received: by 2002:ac8:5907:0:b0:510:f9b:fb5f with SMTP id
 d75a77b69052e-51679440a95mr20949301cf.16.1779134231137; Mon, 18 May 2026
 12:57:11 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 18 May 2026 12:56:59 -0700
X-Gm-Features: AVHnY4LKURvCbX_IJPUmfCTmwYP6SL9RXK1r_86Qf4VKBQdD4r83VbCvOh5ZGPk
Message-ID: <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
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

On Mon, May 18, 2026 at 4:26=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Mon, May 18, 2026 at 5:47=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> =
wrote:
> >
> > On Sun, May 17, 2026 at 04:45:15PM +0800, Barry Song wrote:
> > > On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > > >
> > > > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@inf=
radead.org> wrote:
> > > > > >
> > > > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > > > 1. There is no deterministic latency for I/O completion. It d=
epends on
> > > > > > > both the hardware and the software stack (bio/request queues =
and the
> > > > > > > block scheduler). Sometimes the latency is short; at other ti=
mes it can
> > > > > > > be quite long. In such cases, a high-priority thread performi=
ng operations
> > > > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be for=
ced to wait
> > > > > > > for an unpredictable amount of time.
> > > > > >
> > > > > > But does that actually happen?  I find it hard to believe that =
thread A
> > > > > > unmaps a VMA while thread B is in the middle of taking a page f=
ault in
> > > > > > that same VMA.  mprotect() and madvise() are more likely to hap=
pen, but
> > > > > > it still seems really unlikely to me.
> > > > >
> > > > > It doesn=E2=80=99t have to involve unmapping or applying mprotect=
 to
> > > > > the entire VMA=E2=80=94just a portion of it is sufficient.
> > > >
> > > > Yes, but that still fails to answer "does this actually happen".  H=
ow much
> > > > performance is all this complexity in the page fault handler buying=
 us?
> > > > If you don't answer this question, I'm just going to go in and rip =
it
> > > > all out.
> > > >
> > >
> > > Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> > > waiting for answers),
> > >
> > > As promised during LSF/MM/BPF, we conducted thorough
> > > testing on Android phones to determine whether performing
> > > I/O in `filemap_fault()` can block `vma_start_write()`.
> > > I wanted to give a quick update on this question.
> > >
> > > Nanzhe at Xiaomi created tracing scripts and ran various
> > > applications on Android devices with I/O performed under
> > > the VMA lock in `filemap_fault()`. We found that:
> > >
> > > 1. There are very few cases where unmap() is blocked by
> > >    page faults. I assume this is due to buggy user code
> > >    or poor synchronization between reads and unmap().
> > > So I assume it is not a problem.
> > >
> > > 2. We observed many cases where `vma_start_write()`
> > >    is blocked by page-fault I/O in some applications.
> > >    The blocking occurs in the `dup_mmap()` path during
> > >    fork().
> > >
> > > With Suren's commit fb49c455323ff ("fork: lock VMAs of
> > > the parent process when forking"), we now always hold
> > > `vma_write_lock()` for each VMA. Note that the
> > > `mmap_lock` write lock is also held, which could lead to
> > > chained waiting if page-fault I/O is performed without
> > > releasing the VMA lock.
> >
> > Hm but did you observe this 'chained waiting'? And what were the latenc=
ies?
>
> We have clearly observed that the `fork()` operations of many
> popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> end up waiting on page-fault (PF) I/O when the VMA lock is
> held during I/O operations. This has already become a
> practical issue. I also believe this can lead to chained
> waiting, since the global `mmap_lock` blocks all threads that
> need to acquire it.
>
>
> >
> > >
> > > My gut feeling is that Suren's commit may be overshooting,
> > > so my rough idea is that we might want to do something like
> > > the following (we haven't tested it yet and it might be
> > > wrong):
> >
> > Yeah I'm really not sure about that.
> >
> > Prior to the VMA locks, the mmap write lock would have guaranteed no co=
ncurrent
> > page faults, which is really what fb49c455323ff is about.
> >
> > So Suren's patch was essentially restoring the _existing_ forking behav=
iour, and
> > now you're saying 'let's change the forking behaviour that's been like =
that for
> > forever'.
>
>
> I am afraid not. Before we introduced the per-VMA lock, we
> were not performing I/O while holding `mmap_lock`. A page fault
> that needed I/O would drop the `mmap_lock` read lock and allow
> `fork()` to proceed.
>
> Now, you are suggesting performing I/O while holding the VMA
> lock, which changes the requirements and introduces this
> problem.
>
> >
> > I think you would _really_ have to be sure that's safe. And forking is =
a very
> > dangerous time in terms of complexity and sensitivity and 'weird stuff'
> > happening so I'd tread _very_ carefully here.
>
> Yep. I think my original proposal did not require any changes
> to `fork()`, since it simply preserved the current behavior of
> dropping the VMA lock before performing I/O. In that model,
> `fork()` would not end up waiting on I/O at all.
>
> What you are suggesting now appears to be performing I/O while
> holding the VMA lock, which in turn introduces the need to
> change `fork()`.
>
> >
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 2311ae7c2ff4..5ddaf297f31a 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> > > *mm, struct mm_struct *oldmm)
> > >         for_each_vma(vmi, mpnt) {
> > >                 struct file *file;
> > >
> > > -               retval =3D vma_start_write_killable(mpnt);
> > > +               /*
> > > +                * For anonymous or writable private VMAs, prevent
> > > +                * concurrent CoW faults.
> > > +                */
> >
> > To nit pick I think the comment's confusing but also tells you you don'=
t need to
> > specific anon check - writable private is sufficient. And it's not real=
ly just
> > CoW that's the issue, it's anon_vma population _at all_ as well as CoW.
> >
> > > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) =
&&
> > > +                                       (mpnt->vm_flags & VM_WRITE)))
> > > +                       retval =3D vma_start_write_killable(mpnt);
> >
> > I think this has to be VM_MAYWRITE, because somebody could otherwise mp=
rotect()
> > it R/W.
> >
> > I also don't understand why !mpnt->vm_file for a read-only anon mapping=
 (more
> > likely PROT_NONE) is here, just do the second check?
> >
> > (Also please use the new interface, so !vma_test(mpnt, VMA_SHARED_BIT) =
&&
> > vma_test(mpnt, VMA_MAYWRITE_BIT))
>
> Yep, I can definitely refine the check further. But before
> doing that, I'd first like to confirm that we are aligned on
> the direction.
>
> If you still intend to hold the VMA lock while performing I/O,
> then I think we should fix `fork()` to avoid taking
> `vma_start_write()`.
>
> >
> > >                 if (retval < 0)
> > >                         goto loop_out;
> > >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> > >
> > > Based on the above, we may want to re-check whether fork()
> > > can be blocked by page faults. At the same time, if Suren,
> > > you, or anyone else has any comments, please feel free to
> > > share them.
> > >
> > > Best Regards
> > > Barry
> >
> > Technical commentary above is sort of 'just cos' :) because I really qu=
estion
> > doing this honestly.
>
> I think we either need to fix `fork()`, or keep the current
> behavior of dropping the VMA lock before performing I/O.

I see. So, this problem arises from the fact that we are changing the
pagefaults requiring I/O operation to hold VMA lock...
And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
anonymous and COW VMAs only while holding mmap_write_lock, preventing
any VMA modification. On the surface, that looks ok to me but I might
be missing some corner cases. If nobody sees any obvious issues, I
think it's worth a try.




>
> >
> > I'd also like to get Suren's input, however.
>
> Yes. of course.
>
> >
> > Thanks, Lorenzo
>
> Best Regards
> Barry

