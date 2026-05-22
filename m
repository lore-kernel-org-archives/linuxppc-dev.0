Return-Path: <linuxppc-dev+bounces-21400-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14E7CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 13:48:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMRT01Zfpz2xc2;
	Fri, 22 May 2026 23:48:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779457732;
	cv=none; b=XT841vWqJ9gSQRoicLS4txVeQdaY7bwJSsOxkNoO6cNtvr51s2nZ0AHPu4c+Whoqcs/YHcXYWoJDpuyaUDGOloRVTpOxHnTWbKidhrcA0RemHaefY4a5zQvTrAiEMRoelPb4XrD+kubGUU55OK/kZUux28QuUTIhIxePId+luTNUas/f/O/AS13k+NoOZLToVNhM2ARVGWJX2d6Qks7Mltk5x8uLUNsVoW8ZZIYGBcIGRcgmmauxOeXs+ZRPyS495z1uJ5ihAl5C9kPsIvyRei0CmGtjR2vEx82w7v5AXOfFix1H0NGgyTQER9IyHxKdVAT226HLFv7c1/JoX0Wdgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779457732; c=relaxed/relaxed;
	bh=XAdkVdHYlcySFUBOB9d60INI0VTqn7iPCNrUckiEfSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3fxqyjYXyFPKUgDsXJLEsTVIFGz6N6xcNPqGbKn5Cdl0IqoILsQnaGBcTGR9lgXuwK6Z5SyY334IeTcUWWQfGcehq+gNukKGHCp45t6AyEPQ9cQ4+tSioccYj09jAKDvUukWzddBO5JhnKETg16Hd+HQ/MUoG0BTSJiDTal5sVEntVWrGCb60gxrxLAskWyVFqNPBjiFWGEixyChtK979iT4E7HHLlk9m99QBX8eT4T2ngTupwEEoEg/sB+LYxP9BMpwtf2e5gZjsP5NgmJR8JK1z7A/ES88+wix19vou6DmOR5o8QlEmgckWV8Q7/6kJ2cG/g/iagprSPLT34vfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fssRPY20; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fssRPY20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMRSy2j6Zz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 23:48:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D8512409B2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 13:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB1F1F00A3F
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 13:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457727;
	bh=XAdkVdHYlcySFUBOB9d60INI0VTqn7iPCNrUckiEfSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fssRPY20Dyxz/cYAZdo1qxjF95zNf6DPwfqO4+J6MWEGH93cmB3q0+MsnYtIf4mOu
	 yb2F/LO4bgXDVVZtWJM+4ct2qMqAk527UXL9PHuTUlPYGw8oHZlNwVpv2sEzAnkcrW
	 rYoPk72XF8cMrkAdvU+bjT79H8QBrkkrFnU3POv8SQ9y83JqXAiA2qGn+LwaCE7CbH
	 mydY4KMHGknk/wbzPm/k4VXT2aMv/tt5hKvMmQYuGoY0PrpI9XAnuVQcyxvRoLuNWj
	 8uaBe6X3EksWrohYip6eKCS7TiRDlXSyUEYD1+I0+oxJ/3PXuXltrCZPf7+nmrAZEo
	 4IW9Ggc3VmhZA==
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso2062212241.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 06:48:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mkxkNS6u7h8SuXshxdgRgQEeu0uCmUQQy/OhQdmrSgqc6qutM0073fhWULqhQjOHiaJf9oPd9kJAjnA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyz6DIA8tPsKzI2TeQYKJispk72YZxIcM+ZtYDXhVSr3A4v0Lpg
	NT5S4yjNls8YoHm2QG5yCwUCQXmaExt4/jZa8KCmBRtJUmsnedVfT4DNANQaVXsOREKGhPI3ky0
	LCztZLfjKtCVPgOYwm75oyF4aMsFLaVM=
X-Received: by 2002:a05:6102:3f8e:b0:607:97b7:c283 with SMTP id
 ada2fe7eead31-67c7fff0701mr1602325137.14.1779457727053; Fri, 22 May 2026
 06:48:47 -0700 (PDT)
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
References: <ag4kj84EcKqamdB-@casper.infradead.org> <20260522023305.98223-1-baohua@kernel.org>
 <ahBVh4NM2uoyhPNm@casper.infradead.org> <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zQuJx1reJxgV387Gh0AqWF0KdoFn9KahQ1BNLPRm57TQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 22 May 2026 21:48:35 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
X-Gm-Features: AVHnY4Kzckk2STAPsRlCTXxCXlI9-5Kzu1EhehIrviADTgZ0pSseIwikwC-HrOY
Message-ID: <CAGsJ_4zrm3sCp8Uz0Gh+sAwRcdtNF8rDLqX250sFVG3rZy9HNw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, chentao@kylinos.cn, 
	chrisl@kernel.org, david@kernel.org, jack@suse.cz, kasong@tencent.com, 
	kunwu.chan@gmail.com, liam@infradead.org, lianux.mm@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	liyangouwen1@oppo.com, ljs@kernel.org, loongarch@lists.linux.dev, 
	mhocko@suse.com, nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de, 
	rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com, 
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:36=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Fri, May 22, 2026 at 9:09=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> > > need to touch `filemap.c` at all (probably because you are already
> > > maintaining `filemap.c` perfectly):
> >
> > I'm going to give you one chance to apologise for that.
>
> Apologies if my wording caused any misunderstanding.
> That was not my intention at all.
>
> What I meant is that filemap.c already has a very
> solid design.
>
> For memory.c, I had to touch several places for the
> blacklist; otherwise, the kernel would hang.
>
> But for filemap.c, I basically didn't need to touch
> anything, and preliminary testing shows no issues after
> moving it from the whitelist to the blacklist. This is

Sorry, I feel I may be causing some misunderstanding
again.

By "whitelist", I mean I used to allow certain cases
to use per-vma retry.

By "blacklist", I mean I am now moving to disallow
certain cases from using per-vma retry.

Right now, I have to add several cases in memory.c
to the blacklist; otherwise, the kernel would hang.

But it seems that everything in filemap.c is fine so
far based on testing.

I'm not sure if I've explained things clearly. Please
let me know if anything is still unclear or insufficient.

