Return-Path: <linuxppc-dev+bounces-29160-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014EFCA601E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 20:14:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1dNr0lMyz2y8d;
	Sat, 10 Oct 2026 07:14:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::535" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791576844;
	cv=pass; b=Dy7nTgUfXuc+ttJ2qNDwsDsQz+BhdOjyBpP03bYQLG5NtMzU5PPRFvoGGis69AqcNS9lXcdA1FP4YQ/hX2QyYz+1e42iZsLKcNKhFPlzzV9VRLN5WWLga5+s3utR8NqAgytjdTCgljdGwtnoCLwkFLkXhoZXEJLjc1U3D/bLd9+VyFoAsbnytZrHB72WX/BQxhPeZDojqh6Ylt4JVc9bYAxVRV7Wr0dQhqUj0jN+VynYheKkv51HaUdD1v8BzxTkHnYfRjXtBeAKdHD/0BR5Iwm2hzlMWQKKmB7XVjshgXzb8hEPJ5RbecdcFF3BRt0cGJZ8rDFNgaqrZ6JpzHSNlA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791576844; c=relaxed/relaxed;
	bh=37iAUH46ivMwbbP3cqApmF9zPEOxJj2Y8UlMHyZYn1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3q9GfeRl3g+gvegZxT6MLpPJ2h+kTepn+nKOQuFPf6ljV/W8RukwwC4o2eBd+XggBN0mM8Z8rRNaYv+8j+dBJRueaFc1vS7dgiAQK4v7YERQyY2zo9oljaFDhcUdKcbVIeA5i/qqABD0gIwBLP0fRZNvUQA9qQc+PW7/VIjHVQVQ8LyH9v/32Vyvr4sVzG1ds5EwKzlsP6m0ydAf7uUGMzAHX6pK90xB9TParU3IZeobfB+mSE9CbRwgh+jIZh1y2dDyxG6UpFii7771U5Wq0c6TFF3gtsMGKT6y80Jn5dRhsAlwhmqMRsmxeXsPr191PucAS97w2D8+PSAAPvx3w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tN0OegnF; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tN0OegnF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::535; helo=mail-ed1-x535.google.com; envelope-from=rosenp@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1dNp2sBkz2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 07:14:01 +1100 (AEDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-6b1755b8c10so115336a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 13:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791576837; cv=none;
        d=google.com; s=arc-20260327;
        b=KMIIxy5OJha21MrdHuj97eBFlLMp9OXCQgMDoK6wpY91HAnUY7ZPYtFccQLDVI73rM
         tdCsr6Mo606cVPY0IK77v0Ck00Fp8E8zEN22/6a/hvAy4YbCx+wFqxgRXMCrmhnV/lNX
         4PHXcKZWw1lbp6XEHsHIhHrkViio/c0OAHdQBAlPU7LZTmsDUbS7UGPOh5ehEQyldT9a
         Evg6keE/0yx1OGy+uiBgu9Zc50hkhJmCXp0PGRpgrx9VZpX7WH4JVJ86I3eSxs7nWOwF
         81ovEJfoCUTKqH9fMZfYyNP1WPNJKFAKNlfK0kAdpt+6BXZqkhvtVLbUz6zngWoQ/3H8
         qrnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=37iAUH46ivMwbbP3cqApmF9zPEOxJj2Y8UlMHyZYn1Y=;
        fh=JTZ9cu29awM4EnLP6O2sUrrlQSUYp0sUyGKz5kVoD/w=;
        b=WQCBLe3u9J23GMFj24oKAo3U68b54ofN3fFNYSrmIVAdPfQ6QmqBFVqvVVwb+zazGq
         LKWEl6FHntwwUsmeyh4WAr6vw7HnYjPJf0U04PjD3K8XpoW/HPOR9WDDPDFVvOpCCYHH
         UHCMB9UEggg2B90fQsmYYPFp2PUxEYOM8Xw29zb3EitVdHiX2DydYzWtsdd2wcP+3pOU
         xrfvxvhOM8wAHfHbwBpBTwQgqR8KUy/EUlSbutYY+ihzX+RK7DqMLlHE1j7S4bQjOBf2
         EnsxdkHOAJgo/dlIMvMbK+WOexHzTv1YjEzEvRuSg2pFvAbtudaXLiK/gjSvrtKnEbAR
         DF3Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791576837; x=1792181637; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=37iAUH46ivMwbbP3cqApmF9zPEOxJj2Y8UlMHyZYn1Y=;
        b=tN0OegnF79atJiVuc+n2BVDz3sx2E+KHK2d3oTu3dkWKifBH543nnGGp5paJ0KDT58
         +qnfM4s/4fq9qfUol6EULKBeIHSLnsN09qdMmzndW58oSNTEdPsEY58qwt6ip6bAj47H
         x3j5ZzjbsRH84tirpV6TKnG7c1evCuDdluf00R6BTdK1G1hH/u9oqIxo+Wezm0GxHbcf
         xwzUVO6FrIWerLLqB+pENrZy4XtNqpT7XHjrnJeTUAkLD/V8lRn693SBnTL7zBY+9nFg
         24H5RQPqj3igN6FB4nVdl7i5lpTgRHTeKkdkpvef/smvcT6vIoCu0ESDfqCQhyqS8DKx
         yYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791576837; x=1792181637;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37iAUH46ivMwbbP3cqApmF9zPEOxJj2Y8UlMHyZYn1Y=;
        b=kZUbmugCaBCDLE/apZfVyyxNvJV43Rldi+nYni8WmEbUnyeR/b1Vw+mYOTsHf1HqGT
         gjBuedMOqIZfmDrPi6+KWH7vV7K+jRFGEUiE3w8ff5rFgWw9sAh3W6r2fgxXnQUqZEti
         nN/rWedDU1xaFaA5iEnQlKbMgYYaPLpJyx9waczKxS3grxd6IFvc/wCIAZQlgGgzkxHl
         k8s2V0eS9De2VXHQ+Rxhz65wo/7snwcIdVNIEsTGQ5TZGcWhs3r3l9B2TInB02W3bR1o
         O/czB29TkEabG0i2cXEVlFsat36u7DvOOhBhXtdqXA8U/Q4AO+4l/KOg2mzw5N5CHIhk
         ID4A==
X-Gm-Message-State: AFq9FYKeViFXVotZRWP3cIkiw892bV2JLMOBou3Kc/C9cD4siXmHu8Se
	u9tpl8BorqEswcFesEWvYC2yi8G5DohbXNKARdJNSSvW87mpI/kqvrG4tcivRaL6uNSzuTy0hC6
	BlJXqXySc5WIPWZLz8KFZhk844Agz+wY=
X-Gm-Gg: AYBFou3q3r0SpQWrA3jyrFbbaaCElKmQwWK15O+x34UmpVbvaz08Rl8vXl2E0l25tPn
	VJrprtAlabat/ZlnJAXRJbK7eGDzYbwOwyLYn1+MtGcuO7AOQgJSCPOkLLgSQjnG7RAGQPaTqlS
	we49YuoSWDS/bXjh2/+JvLyrZ+TVcmB/JoOCGSy0/mu9tpJCVt96rAhgyDAXkytaI4qbwtZUUn0
	DDe1W6cksFlCa2AR00qjymlwd1n3/WSTVAnH++1B06/nYbblj7jSr6r+1v+qREVlTUy2ZiGpf+x
	mU6g6y8EXNkx/k2fV3eKSVAqsTMVCjrJWfFDhpAzGZILI8SIeIjJMAM7MFS4GyAaqIyIfaYbp62
	5o9nOiCLrRG7bXxTSODd7e5deg8tOqK/KSqUB/d4RJkFjzKQhPRK3l1mepUpJ2mbyAStk/cALcV
	T+DMyU3EohXjrVsM31t/i1xLSPRrpbOZUoNM3DC9pMrUvMmX+AjXZfHy5Zt7/PHHTDVw==
X-Received: by 2002:a05:6402:46d8:b0:6ac:af5e:9eab with SMTP id
 4fb4d7f45d1cf-6b17c2759eamr2173604a12.12.1791576836532; Fri, 09 Oct 2026
 13:13:56 -0700 (PDT)
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
References: <20261008034932.3180490-1-rosenp@gmail.com> <509cac24-1b3b-4b85-8ad2-ef90da521dd6@kernel.org>
In-Reply-To: <509cac24-1b3b-4b85-8ad2-ef90da521dd6@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Oct 2026 13:13:45 -0700
X-Gm-Features: AclHuK80VbBXjIBXRmNpq3ZRyc7y8m_5w3Vf_2niwksi6yCvSUDQGCqrAbOhMrs
Message-ID: <CAKxU2N9imBpPHmJSefACvSR1FJofF9JY=ziRatmnQyKK9084gw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/lib: prefetch ahead in __csum_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 9:23=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> Hi Rosen,
>
> Le 08/10/2026 =C3=A0 05:49, Rosen Penev a =C3=A9crit :
> > __csum_partial() reads every byte of the buffer once and never touches
> > it again, so on cores without a hardware prefetcher every cache line is
> > a demand miss. After a non-coherent DMA the received data is never in
> > the cache, which makes the GRO checksum validation of forwarded TCP
> > traffic the top entry in the profile on a 464FP (APM82181): 22% of all
> > cycles were spent in __csum_partial() when routing with GRO enabled.
>
> Very nice patch. What is the new % after the change ?
22.2% -> 13.4% of cycles, but the second profile also had a larger RX
ring (RXB 256) and was forwarding ~20% more traffic, so it understates
the reduction per byte. I can redo a clean A/B profile if useful.
>
> How do you test that ? I'd like to do some performance test on 8xx and 83=
xx.
Single-stream iperf3 TCP routed through the board (LAN and WAN in
separate netns on the host), GRO on, median of 3 runs, A/B in the same
boot. On the MX60 the TAH can't verify the checksum because of the
qca8k tag in front of the EtherType, so every forwarded packet is
checksummed by GRO in software. Any setup where GRO has to checksum
in software should show it; "perf record -a" during the run shows
the __csum_partial share.

- The 8xx distance. On 8xx, 3x is only 48 bytes, shorter than the
shortest distance tested on the 464 (64 bytes). The reviewer's 8xx
results may argue for a fixed distance in bytes instead of a multiple
of L1_CACHE_BYTES.
>
>
> When you say "never touches it again", do you mean the data is not used
> again after that ? In that case would it help to do a 'dcbi' after using
> the data in order to make the cache line available again and avoid
> possible writeback to free a new cache line ?
"Never touches it again" was poorly worded. I meant the loop reads each
byte once, so there is no reuse within the function. The caller may
well use the data (local receive followed by a copy to user space), and
csum_partial() is also called on buffers the CPU just wrote, where dcbi
would throw away dirty data. For the DMA'd RX case the lines are clean,
so evicting them costs no writeback anyway. I'll reword it in v2.
>
> >
> > Issue a dcbt four cache lines ahead in the main loop. dcbt is a hint an=
d
> > never faults, so prefetching past the end of the buffer is harmless.
> >
> > On a Meraki MX60 (APM82181 at 800 MHz, single TCP stream routed through
> > a qca8k DSA switch, iperf3 median of 3, A/B in the same boot):
> >
> >    prefetch distance   LAN->WAN   WAN->LAN  (Mbit/s)
> >    none                370        341
> >    64 bytes            430        381
> >    96 bytes            438        397
> >    128 bytes           438        385
> >    160 bytes           434        386
> >    256 bytes           423        383
>
> 3x CACHE_SIZE distance seems the most efficient, why did you choose to
> implement 4x CACHE_SIZE ?
AI answer:

Why 4x

There wasn't a measured reason. In the original session's reasoning,
96 to 160 bytes were treated as the same within noise, and 128 was
picked from the middle of that range. The full log is less one-sided
than the table in the commit message:

dist=3D96  head=3D0  up=3D438(375-443) down=3D397(392-398)   <- run once, o=
ne bad up run
dist=3D96  head=3D3  up=3D425(422-443) down=3D391(386-392)
dist=3D128 head=3D0  up=3D438(433-439) down=3D385(385-389)
dist=3D128 head=3D4  up=3D444(437-444) down=3D387(386-392)
dist=3D128 head=3D4  up=3D440(420-446) down=3D380(380-389)
pf128 small_rx=3D0 up=3D436(426-439) down=3D389(384-393)
pf128 small_rx=3D0 up=3D431(422-438) down=3D387(380-389)
dist=3D160 head=3D0  up=3D434(425-435) down=3D386(385-391)

128 was run five times, with WAN->LAN between 380 and 393. 96 was run
once with a clean configuration, and that run had an outlier upstream
sample of 375. The 397 vs 385 gap is about 3%, which is close to the
spread between 128 runs. So 96 may be slightly better, but the data
can't separate the two. The honest answer is "no strong reason, happy
to switch to 3x."
>
> >
> > Prefetching the first lines before the loop made no measurable
> > difference and is not done.
> >
> > Assisted-by: LLM
>
> In what way did LLM help ?
All of it. I set up a serial console to my Meraki MX60, sudo chmod 666
/dev/ttyUSB0, and hooked up two ethernet cables to my desktop and its
WAN and one of its LAN ports so it could test routing performance.

The task I gave it was to speed up ethernet performance. I expected a
fair amount of work on its dated ethernet driver (IBM EMAC) but
because GRO (software checksumming actually) was unavoidable, it made
this change. It was using perf to find out where the bottlenecks were.
This is one place. I probably should have constrained it further.

All responses before the above were generated. I'll fix the patch up
once I get the MX60 set up again.  I currently have a bcm47xx device
hooked up which codewise is in a really bad shape.
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   arch/powerpc/lib/checksum_32.S | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum=
_32.S
> > index cd00b9bdd772..5a14d45c7b9d 100644
> > --- a/arch/powerpc/lib/checksum_32.S
> > +++ b/arch/powerpc/lib/checksum_32.S
> > @@ -43,6 +43,7 @@ _GLOBAL(__csum_partial)
> >       bdnz    2b
> >   21: srwi.   r6,r4,4         /* # blocks of 4 words to do */
> >       beq     3f
> > +     li      r9,4*L1_CACHE_BYTES     /* prefetch distance */
> >       lwz     r0,4(r3)
> >       mtctr   r6
> >       lwz     r6,8(r3)
> > @@ -52,7 +53,8 @@ _GLOBAL(__csum_partial)
> >       lwzu    r8,16(r3)
> >       adde    r5,r5,r7
> >       bdz     23f
> > -22:  lwz     r0,4(r3)
> > +22:  dcbt    r3,r9
> > +     lwz     r0,4(r3)
> >       adde    r5,r5,r8
> >       lwz     r6,8(r3)
> >       adde    r5,r5,r0
>

