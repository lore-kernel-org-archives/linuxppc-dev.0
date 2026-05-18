Return-Path: <linuxppc-dev+bounces-21132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6067CD4F57
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 20:50:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK91Y3rF2z2xrC;
	Tue, 19 May 2026 06:50:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779137441;
	cv=none; b=m9g9dTE69bmK+8SFRbcqtwTqar1vmlZfMZ5/kZMAFvvIj9sYSOJsDpIcEQNy0LNoC7WTPmjRbSrIiDFgf33DHqTQNA1OZGFdLuMT1z61KK+4LjDhzfPj+oJl/XUjatdf3ctlpU2spyy/54KRS/LIbZSlVkWVDF3C089RhwMBoK0NwCG2wMCRzYdaafoq/L2N21WVwCdKwixcNUk1C71tuazRaTrAddjMS7+7KMaP8LRIdomC+F0kGHhjgdsMFNYbsFPES8DS2zAq9DYtJh9QkVAGsdRrxCSBjWnSr7qDcVfQOKkdk0ZeCLbFGcr/3iKXEnAY69xW5OBQUVer/HKldA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779137441; c=relaxed/relaxed;
	bh=aZNSRiDXdNQz/tad0D1XmKJG1e0NsSfjQsVpDvD0C2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S84qLkkdfJm1KPHd7EdykJFj6yAJJSJdmbhnCFMBTp6vyNNSWNw5soaDjZGGu2rTPqmT2z5Hr2KuPE3AM9edi2nfE9BgEwskNhnHntSxXPkdlQ4KHMmLnfUw65IqwxGzpLoSqx7mkaW8YhoPwjqHXlTZ3HSSRuMOmY13XRhjn+6N2nG7a0jr0FaVsENZzjcLfqWGnOD4rIA7Aj7RZdvGZ2aXra9vHEyJnLaB9noJUSzLpQJkDXrHRji+2Q4ySswLGDydrgM1i2NFhawborBK3A8aeZeMP87zawqIHr7QoNNiXm6Yht9+d3/kWGzjvTEvhNin0p76bH1Sn67wNXhuww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gk0707fU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Gk0707fU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK91X2hWJz2xlt
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 06:50:40 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91878445AB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7799DC2BD01
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779137438;
	bh=ypIdx4acKlGusOGofl1Rgy+13Usr/bMeabAYI7vNmVE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gk0707fUsk9yWgyWpyCE0usmgctr/2kAHAruO5+nioCbF3DwOXvh3XXJOYYbLkzh5
	 hJ2qI4xZH0TRSFfRaiQZm8jvvSk+DkKMuBR24TjklCVhNb8E02lgN0am+P2km4x9hl
	 l3nDU0T5UpVuJP450DPP64O/nI/FWXc9L0PtdXkLhmZvxkOogzxRVtHB3So0FEMwk9
	 HbI5Rpppz0/1ai5xW+yywawcmbLarPa3mDD/r8dZtjhp9DVlB9KD/EmgzDTH8BwZDU
	 +K9SIW2+RAVZM0fzFYPAz7ugIMm6YeBB/wVGB7FhjefXLk4pr0Zz3bb6JKqwuQ7FFH
	 u1yF44PQXOp+A==
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95d3492fb1eso1770953241.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 13:50:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97QRrG7C4Jt/rTvUlf6qPiOP1S4RFugmXGgxVK686dNXiixb+djUBXnBiG/UvDroKQiUsYK8fH6QPdz+A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxayPp6/JQPgfKaMNU1RML7caIHZkH4dwaG/ref4bfO0FXlPprn
	IsCOAH0FYrLk6ZJrtDc5VFHLXonWQQgQQ5lbsyBHvWYqs+H9EJQgOkPM8zPm+JsqLUtPu1iK/Ym
	5WMCAJzscdfiruBfuwEnVkIVbjVyJD/E=
X-Received: by 2002:a05:6102:1497:b0:632:eef7:4b7f with SMTP id
 ada2fe7eead31-63a3f38ed3dmr8946550137.22.1779137437454; Mon, 18 May 2026
 13:50:37 -0700 (PDT)
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
 <ags7mPK7Ong0ZsBf@casper.infradead.org>
In-Reply-To: <ags7mPK7Ong0ZsBf@casper.infradead.org>
From: Barry Song <baohua@kernel.org>
Date: Tue, 19 May 2026 04:50:25 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zBcx2OF20pE4r2FNUXuF_E_SkS2scFS4b=G6v-GCvXYw@mail.gmail.com>
X-Gm-Features: AVHnY4LxjbpsTxssULoY1o3L0OWdx82GerNYGpv8290_rAwvBTy9PmnU1AhgaaM
Message-ID: <CAGsJ_4zBcx2OF20pE4r2FNUXuF_E_SkS2scFS4b=G6v-GCvXYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, surenb@google.com, akpm@linux-foundation.org, 
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

On Tue, May 19, 2026 at 12:17=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, May 18, 2026 at 07:25:54PM +0800, Barry Song wrote:
> > We have clearly observed that the `fork()` operations of many
> > popular Android apps, such as iQiyi, Baidu Tieba, and 10086,
> > end up waiting on page-fault (PF) I/O when the VMA lock is
> > held during I/O operations. This has already become a
> > practical issue. I also believe this can lead to chained
> > waiting, since the global `mmap_lock` blocks all threads that
> > need to acquire it.
>
> It's always been a terrible idea to call fork() from a multithreaded
> application.  For example, this question:
>
> https://stackoverflow.com/questions/53601200/calling-fork-on-a-multithrea=
ded-process
>
> or this lwn thread: https://lwn.net/Articles/674660/
>
> Do we have any insight into why these applications are doing this
> horrible thing?

I swear I read the two links you shared. But the reality
is that as long as people use the Android framework,
even the simplest "Hello World" app already runs with
10+ threads :-)


main
RenderThread
ReferenceQueueDaemon
FinalizerDaemon
FinalizerWatchdogDaemon
HeapTaskDaemon
Binder:1234_1
Binder:1234_2
Signal Catcher
JDWP
...

Best Regards
Barry

