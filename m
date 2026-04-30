Return-Path: <linuxppc-dev+bounces-20348-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366E4CD13D2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 22:50:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g68Wx19JVz2xGc;
	Fri, 01 May 2026 08:50:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777589421;
	cv=none; b=Knp465nYvFJ5y8hYHhRwAv8zxsgTqck7VCqJgb7fk/S0hTA8e9D2R88rqxa/z+s1uQeK4HHpzBsCiUi4Ne5hfcKWn2+iqy2ZGFw6FmKxSBFpgCgyS6xEoJwxeqy7W4v+AplHr9dVckhZP+wuf9ncqv1EwMovRH1vjGa0oLAISB56SowN4YZVyxuhpVBbpu7YWuo4AORMdcmbDjDYH/SuZru5a8no7JD+Y60lcFvk4dZqI8jXrr3Pa8UfWnGtLkHHVX3BEfc9w0ZYg5QU13otM+xuN7JSIEacLY/cbt5QiDm3eYDgioSfgezt/F3NDNtPxEjwHBtw3j12zQrMuC4Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777589421; c=relaxed/relaxed;
	bh=nyIAHMCO2XSEKhIrNQWe82Ob3aOc1tSJG1laNn5OlYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qj6c5mkI4ptKgLBmX70V0yFb5ddvlaOw9ezJaU08ZdaUcWxtKu0HUNGv+EL0Lc3k4aBI6tSHy6vfZKZpJg6mKao9Wcnhu2ziqghVeWPhnUM+5AHakQnxPFOA4b+y2a25IJnPk0Eohemys7D0Rv+zLEEtmcIKYSZCWlyttBYphxhYKYjyKhiWWaE2xaXy/5HG9sc34A0c1SYhAhB33+TjfdRmBhnpf0poM+vDbrcU5Z1lSSA6ccZ8d8prWe4vkA+thafXKvKyQ3O0r8Kc7DZPVoJk6d04wc6z02cn0Qsz9YcCX81jUBXABgOksqO1RjC5Dkfxb8tZftdBDfD+Et3+Gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dBXZ2oY8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dBXZ2oY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g68Wt6F3Sz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 08:50:18 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 277C1444D4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 22:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFE2C2BCF5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777589412;
	bh=EwR29NH5HVcLbVvA5ViI57mAmHT3DBCHHsLg0gf7Cic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dBXZ2oY8bPD0T7Gd4Of7GUZOb84hKrxvQlNnKxyNarxinIUzFHyBM9s+qDR4U9LPp
	 +Hc8F8WFDCZQqqo+npT5fUj0txmJKGzK48NWf+a5HFI0nv9pWEpw/7Z7MiE/1dYHmC
	 B12UZdt6YCq68u/rqEbIGy9P6FZiNurFRNlp3PZg9yOU7Gob8iSTSCXSUBOt2JbkAC
	 Fwp47SUVHvHazO57YaIALODnh+Wg6M0vRWtAdK9btMOZWw3UF7+id1X74wqvWjE3jS
	 uK3gMgeJ00mb08GoZiRN6AIHhiPzdeZPoa0S7aYZkNoWzKQDPWrMHLEaBFdV5I1od5
	 XDQUtFcs0lleA==
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89f1e767f92so13294906d6.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 15:50:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+1d2pEQ/vMztEYz5iF46+biRKuQIRBzoBE5BsM7CF5Ie08f9PYqWuhYr3++E8OwZ52vicVqFu6ZiNx/Ks=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzw8+S5FGPLWFWSUc9fWzkvwSlja5W4mSei6c8PuhVldRSEoymA
	vrwTjT1wi9QegYToAnwCe8ONH5pcobjRvq3SAqRFObpMsetbd8KNt/lgpnBXwx3gdfW6CKCbdDH
	JZPhW0yNM4C4ZbdfNp1e0GXQcNtYLUOg=
X-Received: by 2002:a05:6214:3f81:b0:899:f092:9da with SMTP id
 6a1803df08f44-8b3fe7bd179mr81439146d6.28.1777589410935; Thu, 30 Apr 2026
 15:50:10 -0700 (PDT)
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
In-Reply-To: <afNM-gIqxpyJ6ro7@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Fri, 1 May 2026 06:49:58 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
X-Gm-Features: AVHnY4LNqeENq1Hu8yfE3Ha6l6qy4pcPzLhOvHSM0QbVepERNdbmRODWwcwvH-c
Message-ID: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, jack@suse.cz, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 8:37=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Apr 30, 2026 at 12:04:22PM +0800, Barry Song (Xiaomi) wrote:
> > (1) If we need to wait for I/O completion, we still drop the per-VMA lo=
ck, as
> > current page fault handling already does. Holding it for too long may i=
ntroduce
> > various priority inversion issues on mobile devices. After I/O complete=
s, we
> > retry the page fault with the per-VMA lock, rather than falling back to
> > mmap_lock.
>
> You're going to have to do better than that.  You know I hate the
> additional complexity you're adding.  You need to explain why my idea of
> ripping out all the complexity now that we have per-VMA locks doesn't
> work.

Yep, I know you don=E2=80=99t like the added complexity, but I would rather=
 prioritize
user experience over simplicity. Let me try to explain in more detail.

1. There is no deterministic latency for I/O completion. It depends on
both the hardware and the software stack (bio/request queues and the
block scheduler). Sometimes the latency is short; at other times it can
be quite long. In such cases, a high-priority thread performing operations
such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
for an unpredictable amount of time. For example, if low-priority tasks
trigger page faults and issue low-priority I/O, a high-priority task
requiring the write lock may end up waiting for an unknown amount of time,
depending on the block layer and filesystem behavior.

As a result, high-priority tasks are exposed to unpredictable I/O latency
introduced by many low-priority tasks that may generate a large number of
page faults.

On Android, latency in certain tasks can significantly affect user experien=
ce,
such as interactive threads. Priority inversion is particularly problematic=
 and
should be avoided, especially since we have no clear bound on how long we m=
ay
have to wait for I/O from other tasks.

Meanwhile, priority inversion can propagate through a long chain: a writer
waiting on I/O from multiple concurrent page faults may end up blocking oth=
er
writers and readers as well. A long-waiting writer can also amplify
mmap_lock contention, which we still rely on in many cases.

2. VMA sizes can be highly uneven: some VMAs may be very large while others=
 are
small. We used to have many reasons to release mmap_lock when we did not ha=
ve a
per-VMA lock. Since VMA sizes are not uniform, those same considerations ma=
y
still apply to the per-VMA lock when a small number of VMAs account for mos=
t
of a process=E2=80=99s address space. I recall that Suren also mentioned th=
is[1].

So I would prefer that we hold only the per-VMA lock and avoid retrying the
page fault when we are reasonably sure that I/O has already completed and w=
e
are only waiting for short-lived conditions. Uncertainties in the block lay=
er,
filesystem, and GC behavior, as well as latency-induced priority inversion
chains and potentially amplified mmap_lock contention, can significantly hu=
rt
Android user experience.

[1] https://lore.kernel.org/linux-mm/CAJuCfpFVQJtvbj5fV2fmm4APhNZDL1qPg-YEx=
w7gO1pmngC3Rw@mail.gmail.com/

Thanks
Barry

