Return-Path: <linuxppc-dev+bounces-21183-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422B5CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 18:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKkK84dx6z2xwH;
	Wed, 20 May 2026 04:51:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::62b" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779216668;
	cv=pass; b=bSR5owWswm/N9KyickKEFlmt8YcZlwntIgY7GgnUOvKj1W1a6jSYUZUX//Ksr3AhxK/ZQcyK6gQ22/W+KC+ZtmMyg8sjspejNM4aDfhmg14mOjZA9fI2TbmIJoFVDJNgQtxK4rla1Lgqaaa6x41MjCtdkM0EfQGlGrvKhOu2P+88uDoXaZKV8tSrmgm63KA9XAMlimXGa25LC0F1/5Em+bzwNo6iclNDYyB7lL7P5n2/f8q63tbvy85VmSoFn7V535fcTr7Ote/hERgZpQmB2ZxtU3Ob6PB7hksoRzpP3RLlNrJe4SOdY9Cetx2nVTLnzUYU2NmFAA4dAI5EAocS+g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779216668; c=relaxed/relaxed;
	bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmjIbOk8qCVcza6ec0HJdh3IvZ6WE+EHiHaABozZ7DYA+6gmstbguwrAa4L/Iytxq8jZH55fFqJ2+pqJQ/dNDygrmJpaov6NWrYS/6ihs78xm6U60WTbSKAHIxRsHlu3r+afZGNgYv/RT9JLUexa8q2SDpbN1yAz/UK4G8Hx/WmxKy5xC/lik3EOBZouWaNGI5Dv30f7YM7L9vmKh73CmcMYlMfBAt+x9fYVmo2lbCz2RPMWFI5OvCQWSCvwAnt4tA4k3A0NJUncfzYlzowsTxz3Ba79czGP2sMuZVAJPojM3WmtKua8pD6Vl5lxoAIlwd396uLjcjTcw+fbMsXsjw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kR6gX5Qu; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kR6gX5Qu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKkK743rPz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 04:51:06 +1000 (AEST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-bd8d0e4e341so424028466b.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 11:51:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216664; cv=none;
        d=google.com; s=arc-20240605;
        b=Ex9QHO0qWvg7nvOfO/JQfrfU4xx6TX1hO+nif8EZov67Jx3WTvPea768bMq5h+a9bJ
         9LqpXIvsbug92E5G4qpJt3zyqAd3QoaXXaPEbgI/LamU+Wn6+412niypwdPsAx9fIbJS
         bW+XyK3cdnEjLImmn/r8nwptJ00Wbi5jF/ajgyKyPNQwYJfmwJ4oqL5/f5ElfV4vnj/2
         dpP5UPXBIc0VDrOVz6VPumOn4rBSQWvkN91knNXhYldNtLIiKcPXHYLeqK1z9Znz6N7I
         qB2A9XsNC1YDHsAmU7eKp5sNukZpq/9L27DfQus+/D+LNBk70V7dvJY+LNc4iSOniZpq
         D2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        fh=tTi0CeltIYXXZWZYZ2YjPopjGey6FpdZxTM9d5QItXE=;
        b=XXBIJ6dhQbeg0oQls8PB9h5x0m36wyim+Zi9TqGDdfUdjsiARPfgPO+N8rUsEq07D9
         BXQ8dWuobi7nDQUE3tAkjHNIvPW0BjQGquIxBNAGoKN0DEOqZz8lI5awncvlAJIbWKTy
         63eyPs8Fagr4yGp1KXL+jknxNMoz7t6ObnLiYoExtdcCQnkTgTfLxn1OUDoCONn0TJQz
         tMaKfg9lhnK6BZ3rgARxz8xga+SIfE1no+pb9vkEiOs2X5S14kv+jQrBZGTaodydi/2G
         onTw+tra+M/pt1tlOcNpVD//IL6GBcnmEA0EtM+U4Q2dD6+ERg71T3QwXx6S4/8UjBIM
         5cpg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216664; x=1779821464; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        b=kR6gX5QuzMSZ/CnMf9Q87WucOmU9MlJP/jZ3rbhcOc6PxnsMvo4n1Em+QP4FMJzH5c
         qVGWZSQzoS+2U5XxRqkd6akhADjkMp7WfTAZUDMCTREx9DyHG9NiJpue9YkRapZ32Tx0
         MYYl9YjNkJYc4km/osUkLfry8DKmvTbsvcqsEmUrLQZz2TlNmc0HGocr3T+/DZRby777
         CmXRKDEas94l4tYS2D0a5PrdyjCCnY31/OwHECTfcIe7Pvie7nqZAURj15iWA1RM0EsM
         VPNfrhnrvkAqChKfKk36RPovq2muFSiS5QpXlB8dS5tkrgx3rzu+BGW4b5P8Zycn5y0T
         h41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216664; x=1779821464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auNMmPsKKmQDwMQx6p+X+IoKw+T0n0UlnhHmOoR8kKE=;
        b=GclJ69qsDDSKTXXCBsWaBsDjiyYkxmz7C3lVUccb7pRk2XV92oWsIckWfZaedEuPA1
         Gcyt3X4CXrnwFnPYlsZH5mDh72nu+mUZ/KVrWzPlrrwa07M5TMJuBGT+BTWmsNcwA/pk
         3ijnyMn4WEUeUjlbi+v85qTc9k+P5rP8fbkxVhTgL9eGXTpfa6gZgfTcpEjcsWN7lCU4
         s7rwJebNnNtMzneXAK6YCqr6SeXjWrpVXcfeKAG4iFeY4RT/utgXa2qdn/jn+eOIrXRs
         gp6cLM38D/81GqYeLRnId+TsWZOxLCkrTaM0pc8s5J37COlAeePhC7R+htZdLNEC8Ry0
         E6tg==
X-Forwarded-Encrypted: i=1; AFNElJ//+s30kaGagbm3Zijc4o59a2x+UHKcK3+R9qNkB2CzLW/Auupt+0b6x/rZjOWkYTb01GUV/yfch78KoOQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYUOkwurwP64pEuwn2HjM2yyZqQcBZCpQ5ecXw8dTEI9JHMOgS
	YkIwKvaVS9GFa9h4JA4Tx978WtEyjkDkP/5VWen/4ltPb8HQfG2BrCQJp0U+KJX2IsOoeQdLyHz
	pU0yBThYUWN1OBdqDl0Bn3MOMY/bBOIw=
X-Gm-Gg: Acq92OE1oPABNqLEvMdv6yaGHWJG/2mcklZFdOQS+PW98mfkYYSl42LyDjTAOQ1nD5S
	HfYnbO5YvO9R9VJb2mqcNHxXzyacbVofxfACIWCEpCBOcEjQXETPSlSt7zx/fD0c+o1tj9VN7QR
	psdScROCVsiLCbUjxMR0x/b0dM9HBNwBIIjukGUg7F4v2qvp99U5oFrIPqi2pKqE5yrzttHJa2V
	XZRe+ulpZE7Jy7JqqBaljdMlQF1+7e1X3eZE6290gmQnyYQK4t8bFN1EcyPr7eyaoI0T3xOddcP
	0YXOUGRQIw==
X-Received: by 2002:a17:907:a68b:b0:bda:2928:ff9a with SMTP id
 a640c23a62f3a-bda292920a3mr99249366b.39.1779216663733; Tue, 19 May 2026
 11:51:03 -0700 (PDT)
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
 <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com> <CAGsJ_4w_-Y8qNLDeLX9OWpLpK01YG2bF-N6_mGypgsauvfCvkA@mail.gmail.com>
In-Reply-To: <CAGsJ_4w_-Y8qNLDeLX9OWpLpK01YG2bF-N6_mGypgsauvfCvkA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 19 May 2026 11:50:51 -0700
X-Gm-Features: AVHnY4JjQJo4iM5wAoXXEGJ4OEpxos0PYW3wieiPnlRi6plEliJjiQongYt0ODQ
Message-ID: <CAHbLzkpbQ4Ca0xC74BJ6iJUVKdpH90qE+E=g7HkDXvcNH1+8+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Barry Song <baohua@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, david@kernel.org, ljs@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, jack@suse.cz, 
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, 
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:07=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 19, 2026 at 5:21=E2=80=AFAM Yang Shi <shy828301@gmail.com> wr=
ote:
> >
> > On Sun, May 17, 2026 at 1:45=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
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
> > >
> > > My gut feeling is that Suren's commit may be overshooting,
> > > so my rough idea is that we might want to do something like
> > > the following (we haven't tested it yet and it might be
> > > wrong):
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
> > > +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) =
&&
> > > +                                       (mpnt->vm_flags & VM_WRITE)))
> > > +                       retval =3D vma_start_write_killable(mpnt);
> > >                 if (retval < 0)
> > >                         goto loop_out;
> > >                 if (mpnt->vm_flags & VM_DONTCOPY) {
> >
> > Maybe a little bit off topic. This is an interesting idea. It seems
> > possible we don't have to take vma write lock unconditionally. IIUC
> > the write lock is mainly used to serialize against page fault and
> > madvise, right? I got a crazy idea off the top of my head. We may be
> > able to just take vma write lock iff vma->anon_vma is not NULL.
> >
> > First of all, write mmap_lock is held, so the vma can't go or be
> > changed under us.
> >
> > Secondly, if vma->anon_vma is NULL, it basically means either no page
> > fault happened or no cow happened, so there is no page table to copy,
> > this is also what copy_page_range() does currently. So we can shrink
> > the critical section to:
> >
> > if (vma->anon_vma) {
> >     vma_start_write_killable(src_vma);
> >     anon_vma_fork(dst_vma, src_vma);
> >     copy_page_range(dst_vma, src_vma);
> > }
> >
> > But page fault can happen before write mmap_lock is taken, when we
> > check vma->anon_vma, it is possible it has not been set up yet. But it
> > seems to be equivalent to page fault after fork and won't break the
> > semantic.
>
> Re-reading Suren's commit log for fb49c455323ff8
> ("fork: lock VMAs of the parent process when forking"),
> it seems that vm_start_write() is used to protect
> against a race where anon_vma changes from NULL to
> non-NULL during fork. In that scenario, we hold the
> mmap_lock write lock, but not vma_start_write(), so a
> concurrent anon_vma_prepare() could still install an
> anon_vma.
>
> "    A concurrent page fault on a page newly marked read-only by the page
>     copy might trigger wp_page_copy() and a anon_vma_prepare(vma) on the
>     source vma, defeating the anon_vma_clone() that wasn't done because t=
he
>     parent vma originally didn't have an anon_vma, but we now might end u=
p
>     copying a pte entry for a page that has one.
> "
>
> If that is the case, then your change does not work.
>
> Nowadays, nobody calls anon_vma_prepare(vma) directly.
> Instead, vmf_anon_prepare() is used, and we always
> require the mmap_lock read lock before calling
> __anon_vma_prepare(). As a result, anon_vma cannot
> transition from NULL to non-NULL during fork.
>
> So the original race condition has effectively
> disappeared.

anon_vma_prepare() has some usecases too, but it seems like it
requires taking read mmap_lock too if I read the code correctly.

>
> You also mentioned the madvise() case. If I understand
> correctly, madvise() should take mmap_lock before
> modifying anon_vma. Only some parts of madvise() can
> support per-VMA locking. Therefore, we probably do not
> need:
>
> if (vma->anon_vma) {
> vma_start_write_killable(src_vma);
> ...
> }

I think we still need write vma lock to serialize anon_vma fork
otherwise we may see:

        CPU 0                                                 CPU 1
fork                                                       page fault
   src vma has no anon_vma
       skip vma fork

allocate anon_vma for src vma
vma_needs_copy() sees anon_vma
copy page

Then we may end up being no anon_vma for dst vma, but with pages mapped in =
it.

Thanks,
Yang

>
> >
> > Anyway, just a crazy idea, I may miss some corner cases.
>
> To me, it seems that we could remove vma_start_write()
> entirely now. Or is that an even crazier idea?


>
> Thanks
> Barry

