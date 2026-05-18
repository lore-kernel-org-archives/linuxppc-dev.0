Return-Path: <linuxppc-dev+bounces-21135-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E5ECD4F56
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 21:21:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK9j84yQKz2xpn;
	Tue, 19 May 2026 07:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779139292;
	cv=pass; b=FRiCFWKEGJPcs1D/KUZVYSbu2O2RjfMG31lhSqzHiyhVOEx6UXzI7nkMHNlba6INj+UQdGdy8WJWtnb1lTUMDmzP8fZCKiI1uEQxMSeSQpjmWQW7q0SqqylEgG+pD4PNUfiM8xCGNtunir1DVi2NwtD49sponOp/1LwI4wQnQua9Ds6xU2zTJ4hHc7UKsHnQjec21SEQM3Iu/OC3GEhB5XVrfUeV6zUZGubSKs4g7B3NGhPQ7P+ARwCjvX6PJ0ZyIIogOh6Pnxm5//lFNpxrJ6Nhho8NSALBsrDAq329lr0Ama+TepvqP66RsgRP3Q98+DEJ419vpfTBj0ehIkBSiA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779139292; c=relaxed/relaxed;
	bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR/dRnN0+PYJH4cpi5MWWO14gpox3+TTSNuMCKdbj/bn3wnoiT0UCXLbmbwk48D8kLcgeefuhtOyo1CpkDFugQSwxVcOE8YveUEm0Xs3FOAM39N6iSNB08dyhteH8ocZjxM1g5oPhl9R1YHZ7qvzxsCf0WCu3yPt4c6x7Syp+Nruz0Q3ONiiMfYJXJqJoXLG5M41pwf4fgiZX9JvB62HXyZceX2QESGZteN4vLMD90yxx4b5WVovpABCn+GcHzrSBF1C4C/XsVotnIi1+kb9y/douu22me+oMQd+YqzQM5qYdT98VrvQ3pJI4Qx+tOFX/ml9weJDM9P+YqKK2yKWdQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZR+5Wjbj; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZR+5Wjbj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com; envelope-from=shy828301@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK9j71h84z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 07:21:30 +1000 (AEST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-67bc6098640so5580536a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 14:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779139287; cv=none;
        d=google.com; s=arc-20240605;
        b=FGAh/dqVkufE/DDCnY+5rBAJpX3hIgizCLTBP/HvwxbeE5OeJfC3/KbjuuO1G0NPgP
         rx9haM2W/ts58ZdJ/oW6HHlivmqVckKz0OZO2cIW+WtlkJ4YU6IPvaZwctJ7tetTyL8V
         68jEWtVQrjGhRcHjci+6mBj/07WaKHFLpIukZ9Yc6VJ98DCkbaWyhJlZ3RaIc9uGsYWw
         9vQbMCDMErF97LSrIldZgMX0beg3jRnJMDT3ugTCqGHQUiZcwrKiSPfC7AMmTedl+iDB
         ru2umXDoLLru3GL4es5Y4ahY4fTpwPxwRCEdhNjYREBZt0TRONWM9Lc7jqgvCioLRa7h
         tAVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        fh=cSseI+TiSIS3t4pXoQSoBVbDVk1Iz1Y1NXZ7dTk1LBM=;
        b=X0Oczjj0FJ5hX8spcYBtlyX3/GgIB+neud8dL2vozfkVBUFJQAfPuVEYXd0ZZqhTkH
         1JYHljKZzLocoJugCH4bNUpQXHD1OA5f7581+BcSnNz3aPPliCaI1/KXNXAPqWYv++Kx
         oZT7K5HvHnqPK52uSZaVk+pPtItVgnD3QZ6FtSBNuVaJvX7agF6qU8ZVr3Jl5LMd24yw
         QeKsuxKOF71XmJczmrMGj6HgniU/lcG0ydJL/moLIuQM7UTDrtthP5VjRBDVI/F83Ta3
         vy/pSBSlC4g/3y2tUsPdCIatqUf1GtrKNnlnpVGWuVT/txKupbGNLnzGaBBiy/iVImSq
         8iTA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139287; x=1779744087; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        b=ZR+5WjbjV5ksgla3s1walO7CDaBVen4bL38c4WW6vaEntwP0JVVvj1saanEUQZWU7C
         C5IHnJ4N3ZZ0vFj/MBUZzvE2k59Ix0KMb4Ja6pSGN0coQ86xscChR1Yp2D1XNfRfFrTL
         eLHR77hdMv1KbayM5CfMMe62Evi371ZahGp/5a/Z1fgyADmSZiHpiydjUQwIqY7m/bJ7
         VauUUlb2QAwYI1jdzIj6H5cIIUfdn4x1famsRSylvWKCCFvteU1HdzrBYYrXA9kisy2D
         Qg3Xl2tEstZdUsFSIL4zudCVE++FgEQT+pPJuilT6KuFKbxS4J+/F3/QTs7rOTZ8e+RA
         /7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139287; x=1779744087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EsFks/IQaK5zPrUgVquMlDUWIMq4vDiBKG2waN9CznQ=;
        b=ZBIZTS9nBB0rYOCvjQysdhKNz0h+hK/Cvxgj8awCDMURZ71F/FOU3hGgewKaoOAN/W
         lWBsZBHzSfo7BYJsrG8+o5XwQWzfNNl8QRpb6GVdDbnQFLXRsvvhElwuoF3xDwQYQuwv
         UYus3t0iBLHukHHZIUVF5ZmSaFrvjXs7HaxdDHIRJlWvH035eobIFkuAG9tAxgaLiw3a
         LWz6s8olHNSPpuKkE0sb6EFE3bgHrRtPHrkHdHEsgo5LwVr6cv6BaWrb2uYaGDgFwMda
         Hqcjh2Mg4vETLxtHO6osKYC+KtFpX2759KHec0IY+VW9FcHgokuhSD9Uex2Wzka1X0Zi
         gThg==
X-Forwarded-Encrypted: i=1; AFNElJ90TcUouJWIpk3x0qAtjrTe/UQjlsBKmmv9ecgC5dEFErWzqbgUxQfgykMgrxDxY9xnXqlPW3xk6hR1zR0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzyuV2Y+pCgAOCC7ieKHkokbcs8IPyOKp41FMRtVV6azEUFhG8T
	GE1iYY75Rw8AUgsptF5abynZ7moB2YlwzIcLtvs1yk4qsYolkEL/Ht9MOyv8T8RSC+VkCtQi0fA
	qDjeDL03XxyAPltmpmoX3yfHGlNwcA+E=
X-Gm-Gg: Acq92OG5P/qGAjNvKwUoX6/3ek4MeQ7pHXeGknj6WqmAug0jiG3qgUYrSZJ5T2q695v
	T8WvCFRFlL+TQ/9eM5y9RL5EfRGkJw9nMIWQM5V2U8BT6xlW3c40kz9JgaVJAtLmBaW2y3UEr9o
	cYeXdKvjKtBj20q78YH/i/5/Rgll+jPN94iEH4y1cfjPSDlQPtZFmEFufhqVXWmypNsrNhg7zZ5
	jjAqIXKmC4yYR1/pfGH1vRugd33GYtkmU7y3x3WhCtM6ab3zMUG5Cv6Pjl7ohAaz/W0eWsFBjNW
	Ye0bwoc=
X-Received: by 2002:aa7:d315:0:b0:683:6705:6e09 with SMTP id
 4fb4d7f45d1cf-683bd38d823mr5757913a12.13.1779139286945; Mon, 18 May 2026
 14:21:26 -0700 (PDT)
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
In-Reply-To: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 18 May 2026 14:21:14 -0700
X-Gm-Features: AVHnY4JdohddXKx4c8RBQ6M1uUtTSitdJHlU74cl49fvebK4jjJ2w6iuf3X83y8
Message-ID: <CAHbLzkrOSoh-jmR=uaNvx73n_wn+vExoKY0UzH5zGcfdAiDbNg@mail.gmail.com>
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

On Sun, May 17, 2026 at 1:45=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> > > >
> > > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > > 1. There is no deterministic latency for I/O completion. It depen=
ds on
> > > > > both the hardware and the software stack (bio/request queues and =
the
> > > > > block scheduler). Sometimes the latency is short; at other times =
it can
> > > > > be quite long. In such cases, a high-priority thread performing o=
perations
> > > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced =
to wait
> > > > > for an unpredictable amount of time.
> > > >
> > > > But does that actually happen?  I find it hard to believe that thre=
ad A
> > > > unmaps a VMA while thread B is in the middle of taking a page fault=
 in
> > > > that same VMA.  mprotect() and madvise() are more likely to happen,=
 but
> > > > it still seems really unlikely to me.
> > >
> > > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > > the entire VMA=E2=80=94just a portion of it is sufficient.
> >
> > Yes, but that still fails to answer "does this actually happen".  How m=
uch
> > performance is all this complexity in the page fault handler buying us?
> > If you don't answer this question, I'm just going to go in and rip it
> > all out.
> >
>
> Hi Matthew (and Lorenzo, Jan, and anyone else who may be
> waiting for answers),
>
> As promised during LSF/MM/BPF, we conducted thorough
> testing on Android phones to determine whether performing
> I/O in `filemap_fault()` can block `vma_start_write()`.
> I wanted to give a quick update on this question.
>
> Nanzhe at Xiaomi created tracing scripts and ran various
> applications on Android devices with I/O performed under
> the VMA lock in `filemap_fault()`. We found that:
>
> 1. There are very few cases where unmap() is blocked by
>    page faults. I assume this is due to buggy user code
>    or poor synchronization between reads and unmap().
> So I assume it is not a problem.
>
> 2. We observed many cases where `vma_start_write()`
>    is blocked by page-fault I/O in some applications.
>    The blocking occurs in the `dup_mmap()` path during
>    fork().
>
> With Suren's commit fb49c455323ff ("fork: lock VMAs of
> the parent process when forking"), we now always hold
> `vma_write_lock()` for each VMA. Note that the
> `mmap_lock` write lock is also held, which could lead to
> chained waiting if page-fault I/O is performed without
> releasing the VMA lock.
>
> My gut feeling is that Suren's commit may be overshooting,
> so my rough idea is that we might want to do something like
> the following (we haven't tested it yet and it might be
> wrong):
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2311ae7c2ff4..5ddaf297f31a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
> *mm, struct mm_struct *oldmm)
>         for_each_vma(vmi, mpnt) {
>                 struct file *file;
>
> -               retval =3D vma_start_write_killable(mpnt);
> +               /*
> +                * For anonymous or writable private VMAs, prevent
> +                * concurrent CoW faults.
> +                */
> +               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
> +                                       (mpnt->vm_flags & VM_WRITE)))
> +                       retval =3D vma_start_write_killable(mpnt);
>                 if (retval < 0)
>                         goto loop_out;
>                 if (mpnt->vm_flags & VM_DONTCOPY) {

Maybe a little bit off topic. This is an interesting idea. It seems
possible we don't have to take vma write lock unconditionally. IIUC
the write lock is mainly used to serialize against page fault and
madvise, right? I got a crazy idea off the top of my head. We may be
able to just take vma write lock iff vma->anon_vma is not NULL.

First of all, write mmap_lock is held, so the vma can't go or be
changed under us.

Secondly, if vma->anon_vma is NULL, it basically means either no page
fault happened or no cow happened, so there is no page table to copy,
this is also what copy_page_range() does currently. So we can shrink
the critical section to:

if (vma->anon_vma) {
    vma_start_write_killable(src_vma);
    anon_vma_fork(dst_vma, src_vma);
    copy_page_range(dst_vma, src_vma);
}

But page fault can happen before write mmap_lock is taken, when we
check vma->anon_vma, it is possible it has not been set up yet. But it
seems to be equivalent to page fault after fork and won't break the
semantic.

Anyway, just a crazy idea, I may miss some corner cases.

Thanks,
Yang

}

>
> Based on the above, we may want to re-check whether fork()
> can be blocked by page faults. At the same time, if Suren,
> you, or anyone else has any comments, please feel free to
> share them.
>
> Best Regards
> Barry
>

