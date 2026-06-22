Return-Path: <linuxppc-dev+bounces-22863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FECCD98F0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 00:16:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gk7z42RfZz2xyj;
	Mon, 22 Jun 2026 10:16:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782087376;
	cv=none; b=Chj2Tmx5cLcC/vFkrLZAect8P1clvqH7QRGMuUpFBIqNosQc4K4MxzA8kY4YhvJZggHYc6klyI5gojH8ftsl2nYZt/iWSyzFOf7prDREV0QINGZXrPLXU8QH5ICN5WSRjjN9yQkUrN0587Kr6ph1KHMrGv/Acdiu/xqOEvz5+gfTobAQvFUV6s1RYtOh8+K6I4qRjcCASnC9xEtx5v8REUeBMcKy2LytvRKj1Zh38pQ1SpWgDdi6cTqLjcrgN+CEPUtjYEYqHxY/Gtw6/dfsZSaQqvMcqTsM0IUk9Zs5wgxM0BGeHP81W/+32CT1PxA99Txry479TIJzcTP2pRP+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782087376; c=relaxed/relaxed;
	bh=IHIwIiKiSPJeb13YpcTgfxJcsK09+PRa0/JU1j/CnWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc0/wegbbxmJ4EcZ5COIh07EQ11vUofJ8DlidTQY8GdwZfBTPYMOabsQ47WKm7r9plyUcIVVTj+YSqNrtyw9jU9/mFNNpXFlgV0tJCPJrEhaIBg6zPyybJOM+yIMRO4oLxKVQmpTZdcKnzPez7aINbWn+qR8DKzE/JYOhYRQ3SNk7ehE70hByF/S8bVXIDdzm+SfBZCKMla7aCF8Z+VmhsVgWExnWluMc+ZLecGY14zXsJEhsqFxaoRDtNeXZYwBxYpwZgfBLIvdhtCUvb6J5VnBr3oE8QIQLsFLvh3ygtpTGVcjRCfq+9zsJ5aaB+A5zLGorZElzd+w0VIMRLMViA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMLhsAtt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMLhsAtt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gk7z323Hxz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 10:16:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9E91C6008A
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 00:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467741F00A3E
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 00:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782087367;
	bh=IHIwIiKiSPJeb13YpcTgfxJcsK09+PRa0/JU1j/CnWg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cMLhsAttTe8dyYAVQ5ButgRPTCNVZUjJ+rFUJS/Nb+BEGqhTUydcs0LU3Lix/Z3ek
	 KD0MCI/yAPBWlN6wb7sqDiwlAttozmfCiUFWz9O3jE4hYXuyhq8p1QaOAF9Rxm+bPp
	 zboU9r+goMAm9xbYv8LFtKEEZ5j6ZLteAPSQZ6OcSh5MIs/62zPpZIj5oiIaFmvUDR
	 QC6ZRHtySEUkXZIEInSyph82+HpL4LpnJ7gqwRc/Aciq0eNZH9YLMUThL9XzXyeqjI
	 Rm0VjsR1+yxuogHe+HIFTcJ5KRUzQnReJU7/nUzkEoFcP0eQK2LX+MLHdOMaRBfjL5
	 BYH2jN1C6LQGQ==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51a019e9ea9so22155841cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2026 17:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ZX4RY90a4+Naupq8MCf573F2rMmegv/wzPzIuho/9KjXzDsyAIZcoxjpnWVHCwXzCSJ8J8doOpS6FmNw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyPu3056ZEcMJxO2VHkkILiB3b4CzOCArkIHQMxDk/PRWrFu9mL
	TXMhcr2tW2e4W91VxtPWtMKZjgaZjOmOkIlt9OVWrclEUEVa5t1ao5sg0dGMEW3DVr4iX5iWJaw
	a0ZYyf7ENQxcX+Mr+Z36/cfpCX97ujzA=
X-Received: by 2002:a05:620a:2991:b0:920:bc4a:6d9f with SMTP id
 af79cd13be357-921d185ff31mr1291391485a.25.1782087366553; Sun, 21 Jun 2026
 17:16:06 -0700 (PDT)
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
References: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org> <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org> <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer> <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com> <ajhOUdbWsswgQyl2@casper.infradead.org>
In-Reply-To: <ajhOUdbWsswgQyl2@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Mon, 22 Jun 2026 08:15:55 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
X-Gm-Features: AVVi8CfKzSAPaNgcIJCxOHQBAHV_wanqXUmTigM-8i98Bk0ci-4XCgmSQNzZol4
Message-ID: <CAGsJ_4ybg5LGYopTUJTh5R2rN6X3uR9xoJSL+RdTYVtm1-xqLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
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

On Mon, Jun 22, 2026 at 4:49=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> > Just checking in on the followup plans. IIUC the RFC mentioned will
> > try to implement the solution we discussed at LSFMM: splitting
> > VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> > and another one to fallback to mmap_lock.
>
> I continue to hate this idea.  I don't believe that those who were
> pushing for it have ever tried to understand the whole fault path.
> It's utterly byzantine.
>
> I defy anyone to make sense of this:
>
>         /*
>          * NOTE! This will make us return with VM_FAULT_RETRY, but with
>          * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
>          * is supposed to work. We have way too many special cases..
>          */
>         if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
>                 return 0;
>
>         *fpin =3D maybe_unlock_mmap_for_io(vmf, *fpin);
>         if (vmf->flags & FAULT_FLAG_KILLABLE) {
>                 if (__folio_lock_killable(folio)) {
>                         /*
>                          * We didn't have the right flags to drop the
>                          * fault lock, but all fault_handlers only check
>                          * for fatal signals if we return VM_FAULT_RETRY,
>                          * so we need to drop the fault lock here and
>                          * return 0 if we don't have a fpin.
>                          */
>                         if (*fpin =3D=3D NULL)
>                                 release_fault_lock(vmf);
>                         return 0;
>                 }
>
> Wed need to simplify the fault path, not add additional complexity.
> Josef has said he wouldn't've done the lock dropping had we had per-VMA
> locks.  We should rip it out.

I think you have agreed that, at least for anon vma, we can
keep the current policy, since anon vma is much more volatile
than file vma.
Concurrent page faults and VMA modifications can happen more
often than with file VMAs.

For file vmas, how much code can we actually remove, given that
the first page fault might already be holding mmap_lock?
It could be the case that lock_vma_under_rcu() fails, and then
on the first page fault we end up holding mmap_lock before
retrying. So are we also going to rip out the lock release,
even if it risks holding mmap_lock for a long time?

        vma =3D lock_vma_under_rcu(mm, addr);
        if (!vma)
                goto lock_mmap;
       ...
lock_mmap:

        vma =3D lock_mm_and_find_vma(mm, addr, regs);
        if (unlikely(!vma)) {
                fault =3D 0;
                si_code =3D SEGV_MAPERR;
                goto bad_area;
        }

If we still need to keep the page fault retry code there, it
doesn't seem like "ripping out" really reduces complexity in
the page fault code?

Best Regards
Barry

