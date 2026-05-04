Return-Path: <linuxppc-dev+bounces-20419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CED3CD3430
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 13:35:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8N2L6gLtz2yZ3;
	Mon, 04 May 2026 23:35:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777901754;
	cv=none; b=nr4BMtYIYRrSlz9D0vNwek0hsB6bhzlTBX9F5mRBxJvpTvvv8WjyJ4dNJjpjXW5IhBp/CoDTvBRQVTNZWD2i5DhMJJYG6DgXEt1rPG+PJq0WcOm3scx6DD5fwehgTZCwi06HO/EUXyBCGbWFw8X4Mwm2PgSWiEhcUrS69R5luRodivPnnxABipdD7J0p8hsHLg2DAqbipaqb4djDDSr7OG19kayUpqGUl4krBVZaFTiEJRT66Fs2Qqhjj1XD17BXV8rTwCh/LfqtN1JNmLHQEczLn+YN0iZVS1IA+MawlkI2rqkXOUXNklMKJ0z8ZizsV8lr30xMhmWwKItegWxlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777901754; c=relaxed/relaxed;
	bh=anAXTn2WVNJfQBijdvlVjx89L+KjLxZQUrMBMBAvn58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oQD6Anm3K4ML8V1s7PNAv6lLwCmdzqFgbzb8B0zw/MfaHfJOYd/42h6TfxAvlsp7S0YhAmMqbxVClWBc4UK/flOrHszaba6zXOJQqjpAjT5X3uaj7c1PwVvKhV6l9mWQnUZWjV3zVF3SwnR9Ycxko+6VZnI5kntsbaPKpWxnuQe7ynk1UxCgP5QTVuxhesaMG0oNLyvpmYI+1uU4jSAIPqryeBEDoUMPHEVj4DIf2O4UXOn2cp3gg1BnmFIug07a/dlz5IOzEM8t4K56tYr5FjU78Fx35HXk8KJcXHle9N6S2udiDo8P6sVcnQKh5AEWO/X2Py76pRI9ytxBbsjg7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lm8czak3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=lm8czak3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8N2K75Lwz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 23:35:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DB5044122
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2026 13:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79593C2BCFF
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2026 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777901751;
	bh=anAXTn2WVNJfQBijdvlVjx89L+KjLxZQUrMBMBAvn58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lm8czak3ojKL/iSeFyCXKqI7NTDydVsOyB2+Hmt8nIK2EusB+d4Z4frGvii94dCYM
	 jWu0DSEVVN+bGYmtnqjUZ613RrBl279QTX5Q4GXGY/7uhrANxd69oXqVhg4v9RhlDr
	 j0Bf6ACKU0YROCTpFS5awmkcjdKqVuM+Cdbkq4OknL3HDQb1DpvjyXBC7KufyhvzqD
	 7zI8a4XUxzPdXMbnVIlJrXSGL14ML23Gg2KG7zpTnsaZSKWHibluTUhcKe4kIIwY+6
	 YESTlho5Ct6TbII6iOg1nmDm+rg+TnF6JT9MWtZidEiRLMooEyQHzB5HaaV3YK9SH9
	 zy3fy169eVGyw==
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8b8e98fd885so8862476d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 06:35:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8JrPq9WH+xBCWVkkTKBlNVF3YjCLRyCi1sAqulJ9orDWwmJl6G3YCjLUHytVuCQVSNn54KOrQaSXOZr0w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz66al/Pkkm8NjIOfLsAETzjIg6WOTkeI+5HMpuHOhyckxLg16r
	IAk2Oe4P9tjykWXNkfTxTseMOPKPY+ytamn+hAHVdhMjrN+zUSKA87tqbSdfHlRscZroubdPvNe
	lu2CUDC+UumqC2eYmTbOPROTDoGt1CkM=
X-Received: by 2002:a05:6214:260a:b0:8ac:4fd1:2d4a with SMTP id
 6a1803df08f44-8b668a259e6mr167277966d6.33.1777901750649; Mon, 04 May 2026
 06:35:50 -0700 (PDT)
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
 <afTpoL3FklpQZNMM@casper.infradead.org> <yezmezj26xntushmylductlmytfgvwsnbnzlhffkfwugfxkt6m@gleq22spziyk>
 <CAGsJ_4y8JtCxEy9hVxVd8eaf8D9WC8BcRQp9afUVu=FJA1-awA@mail.gmail.com> <n5vsmp6ingbhfztl6wzcwmrz56gkkfbpzardk43scr7rcgqsw5@evtnov34c5bt>
In-Reply-To: <n5vsmp6ingbhfztl6wzcwmrz56gkkfbpzardk43scr7rcgqsw5@evtnov34c5bt>
From: Barry Song <baohua@kernel.org>
Date: Mon, 4 May 2026 21:35:38 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zBiRTttf1nR0Ni9BRT3Cv5XFZhyYP8oipFodpS7saGwQ@mail.gmail.com>
X-Gm-Features: AVHnY4I0u-Qbkg0vrggpRHSUVs_cQpUa3gydJwrEbvTBOzz3MxeuFlaWucVZXHg
Message-ID: <CAGsJ_4zBiRTttf1nR0Ni9BRT3Cv5XFZhyYP8oipFodpS7saGwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, pfalcato@suse.de, 
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com, 
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
[...]
>
> > > BTW I'm not sure I quite understand Barry's priority inversion proble=
m
> > > since I'd expect all threads of a task to generally be treated with t=
he
> > > same priority...
> >
> > Exactly not. Maybe these slides[2] and this project[3] can give
> > you a hint=E2=80=94they aim to standardize things on Linux by
> > learning from Apple OS. Basically, tasks are classified
> > into five types:
> >
> > USER_INTERACTIVE: Requires immediate response.
> > USER_INITIATED: Tolerates a short delay, but must respond quickly still=
.
> > UTILITY: Tolerates long delays, but not prolonged ones.
> > BACKGROUND: Doesn=E2=80=99t mind prolonged delays.
> > DEFAULT: System default behavior.
>
> Again, this is a clasification of tasks but not really of threads in a ta=
sk
> so at least for VMA lock there's no inversion so have?

I=E2=80=99m specifically referring to a task (i.e., a thread) when
discussing scheduler context. It may be clearer to use the
terms process and thread explicitly.

In a typical process sharing an mm_struct, each thread can
have a different priority.

In an Android app, some threads handle the UI and require
higher priority, such as the main thread and RenderThread;
otherwise, frame drops may occur.

The Linux scheduler can control scheduling policy and
priority for each thread.

Thanks
Barry

