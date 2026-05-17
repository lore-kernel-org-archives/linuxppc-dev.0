Return-Path: <linuxppc-dev+bounces-21004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CC8CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 08:45:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJDzJ36WYz2xfB;
	Sun, 17 May 2026 18:45:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779007532;
	cv=none; b=GLK18On2QlMN3HEXZuTMX8o1eBZKd8Q+yNdZVlbroEbCF8Ph++nP3psZrUaxlEs4/XTG8vS12F9bGSevchMOLuY012rNApjR2nTw3niclvhMjLvRHUWMxfXKZL4wklR1naz+ahs6oCMoDyIgTOZ/BnoYDfUVhV7DSfraqBRdK3eHs4XjdrMHhUu0rA2DpP7thqA5pJ/suodPUHA+BiCXDIq0DX69uur46kT3KUaJ9j6TLp4B3roVKF34EG6oOFkMV2kbndHYRDPt8ubLpUHDDGJ5IQAbhGc5eZqUfPPjnGSWcPRCgUsawurqv5xLsZiDh+Rw6dCMYUia0A3HsG/Ucg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779007532; c=relaxed/relaxed;
	bh=IwqWSnt1f+GtnaOqHAf4nnsKSW4Dkee99uCObNaViNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4S0KIW1QdXH9Phn7FOvStJOaASdD9m5AmveE1oTUXa1CCSyQDgcw8jojKv5SqecaH4tTatQeKLKO6n9Q6/5w30ldrdWMJ4rp0Qd317v+UVbikh0AYVeIWU4tnPP1AalfgFtvVYu1HbobrbG8LXA2BfOgMlp4uUyosL1jGpEAYrHLXMhxNs9wjr6hKXflCHI+uEJwzrh3/9ScXiv8xkdVo3ahdhIlDoYU6cInlfGtiw8zFJTDnalhMKrQGJGiIDr4Q3lkeJY72z7tzn9dzK2pAdjjQx3j87KfASPHvKlHppIT0GtEHjRhIQ2YLOF35ABc9c1kbpc5PcqTyADV2GP7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IcZT9tUo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IcZT9tUo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJDzG6GHpz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 18:45:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D7B0E445D5
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 08:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AB8C2BD05
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779007527;
	bh=p/9AJiwpH9htKz1qH1Sl1BuAo/sVquMqqj2hIHE2j60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IcZT9tUolcrkwWW0g0RY9HTDkbfvMUWKMC+4fxz9cOlxN5nLUbfxb37rlEv77K6Yz
	 91/W8a+pD9VIXpnwYL9jbGNNe64gmPI7/gmARH/LrsqxjAESIXXbB0hoqlAI/eOVyA
	 71yxBQAqlF7qQVourMYDTKkIlJOEhH+OOJG8NyQvxKt+Jkv+ZeuvJZZuT8Uv72hHKe
	 5Uy2D1EisdI1IXy6U24mBXVmBUDot+lzpFzHE4Dt6atMPLsp/jew4RZqdckHNc2wLr
	 FmqGPcBeg679dY+2flLU2OkyQdSmrf0RqKFym7/EfEyCQaoVLB61fYxtlxJ1BqzoTE
	 TcjhzGKbClSVA==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso14183166d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 May 2026 01:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/1pW628W1QKESp7jtkpiuNb2tS7FYEZXAsz0neK/VVDa4rpKJ2pdyG+9A31z2uN/pUUCNfw/KqiYnIDS0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzYQXd+mXhXQd3VEWCW1JY4l0Y/FMPuGEx28rtdYSWRi6N15t1b
	l2qMcpiAzukLh6hzGKeCjbXHCmu2kGC9iY/8589F6hc4jbMN05UiPJz+PvLdPlUsnlUGe271GYA
	lUcYy+i05315NMRe2HsgFQCQs00XwuPQ=
X-Received: by 2002:a05:6214:1c82:b0:8be:7ed5:477b with SMTP id
 6a1803df08f44-8ca0f6b95a0mr188510036d6.22.1779007526681; Sun, 17 May 2026
 01:45:26 -0700 (PDT)
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
 <afTpoL3FklpQZNMM@casper.infradead.org>
In-Reply-To: <afTpoL3FklpQZNMM@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Sun, 17 May 2026 16:45:15 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
X-Gm-Features: AVHnY4ICHad0vRrEOEwJ7DjNSE1jL9epFkBx0OBK2sLJbi9Nv2hHU65J8Z0HpVM
Message-ID: <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>, surenb@google.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, 
	chentao@kylinos.cn, lianux.mm@gmail.com, kunwu.chan@gmail.com, 
	liyangouwen1@oppo.com, chrisl@kernel.org, kasong@tencent.com, 
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 2, 2026 at 1:58=E2=80=AFAM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Sat, May 02, 2026 at 01:44:34AM +0800, Barry Song wrote:
> > On Fri, May 1, 2026 at 10:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> > > > 1. There is no deterministic latency for I/O completion. It depends=
 on
> > > > both the hardware and the software stack (bio/request queues and th=
e
> > > > block scheduler). Sometimes the latency is short; at other times it=
 can
> > > > be quite long. In such cases, a high-priority thread performing ope=
rations
> > > > such as mprotect, unmap, prctl_set_vma, or madvise may be forced to=
 wait
> > > > for an unpredictable amount of time.
> > >
> > > But does that actually happen?  I find it hard to believe that thread=
 A
> > > unmaps a VMA while thread B is in the middle of taking a page fault i=
n
> > > that same VMA.  mprotect() and madvise() are more likely to happen, b=
ut
> > > it still seems really unlikely to me.
> >
> > It doesn=E2=80=99t have to involve unmapping or applying mprotect to
> > the entire VMA=E2=80=94just a portion of it is sufficient.
>
> Yes, but that still fails to answer "does this actually happen".  How muc=
h
> performance is all this complexity in the page fault handler buying us?
> If you don't answer this question, I'm just going to go in and rip it
> all out.
>

Hi Matthew (and Lorenzo, Jan, and anyone else who may be
waiting for answers),

As promised during LSF/MM/BPF, we conducted thorough
testing on Android phones to determine whether performing
I/O in `filemap_fault()` can block `vma_start_write()`.
I wanted to give a quick update on this question.

Nanzhe at Xiaomi created tracing scripts and ran various
applications on Android devices with I/O performed under
the VMA lock in `filemap_fault()`. We found that:

1. There are very few cases where unmap() is blocked by
   page faults. I assume this is due to buggy user code
   or poor synchronization between reads and unmap().
So I assume it is not a problem.

2. We observed many cases where `vma_start_write()`
   is blocked by page-fault I/O in some applications.
   The blocking occurs in the `dup_mmap()` path during
   fork().

With Suren's commit fb49c455323ff ("fork: lock VMAs of
the parent process when forking"), we now always hold
`vma_write_lock()` for each VMA. Note that the
`mmap_lock` write lock is also held, which could lead to
chained waiting if page-fault I/O is performed without
releasing the VMA lock.

My gut feeling is that Suren's commit may be overshooting,
so my rough idea is that we might want to do something like
the following (we haven't tested it yet and it might be
wrong):

diff --git a/mm/mmap.c b/mm/mmap.c
index 2311ae7c2ff4..5ddaf297f31a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1762,7 +1762,13 @@ __latent_entropy int dup_mmap(struct mm_struct
*mm, struct mm_struct *oldmm)
        for_each_vma(vmi, mpnt) {
                struct file *file;

-               retval =3D vma_start_write_killable(mpnt);
+               /*
+                * For anonymous or writable private VMAs, prevent
+                * concurrent CoW faults.
+                */
+               if (!mpnt->vm_file || (!(mpnt->vm_flags & VM_SHARED) &&
+                                       (mpnt->vm_flags & VM_WRITE)))
+                       retval =3D vma_start_write_killable(mpnt);
                if (retval < 0)
                        goto loop_out;
                if (mpnt->vm_flags & VM_DONTCOPY) {

Based on the above, we may want to re-check whether fork()
can be blocked by page faults. At the same time, if Suren,
you, or anyone else has any comments, please feel free to
share them.

Best Regards
Barry

