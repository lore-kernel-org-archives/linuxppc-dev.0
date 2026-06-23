Return-Path: <linuxppc-dev+bounces-22920-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E362ACDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 08:39:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkz5F1yZvz2y71;
	Tue, 23 Jun 2026 18:39:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782203969;
	cv=none; b=FnJF727IQZSTNZwpR+Tp/Oi8ako8pPcxeyAAqtr5v/+5X5iKSCJyK846iUVtlNGeFaNaFg926LOAM/NeKxVvCwAVAlL7wJh7NDlrgXttCx1wssieiHAYk4w6kPtXz0jishhjZA98xROyTQ8zMgUiMgSu0ubxKbR9vYwvOoxrd7taxXmGkE8y7yhmyLF8lb9Usl4byFajgovV9WAvsH45i901udvQHtN8Xi3q4oLMCTOgtZ3ZQUsET5jm+52CI2iHAYA7wxabOeKtWjdtYXzvjUT/tXu/PJS0HLksZ0Ui8LyZfETEOngazuLK+0MgV6fH5XJMkMPaYjUsD6zbg9++tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782203969; c=relaxed/relaxed;
	bh=g19TbfS9RzQGFHPiPSlQ3EkgUSFQDJrLrVSig7447/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7wjKJASLLjDFXAu4sS3+PrJqeteqyU1IjD/sTc5wWFzOqtjdiM2JOWclG0vnu/JfgMUF/eYs0H4tgsczDsydY5f3S7W1hLQXStSIK42NSOiQ3LtpDxFouxZnkVCUm60R9F8YQDLfg0opW8XgpXsn/v8kXjeZZ3rhGX8YRmYDloRe3Wri3+P7N92Owm6EM6jCMGZVuYgkEQRPW4OGZ9VTmfccOrcTIGJJooiBcVCE0oFv+0RVj0Txi20hD4bqnlOBPgLLBdSZQuwza1tSzXA5NcKuif4SNl8WxZEaN1N4vcbSkOS7lIUi1aaieLSxuhL6XzcyfNbXWLsa3OaUdC4Tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMPaLzo5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMPaLzo5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkz5D3VgGz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 18:39:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B153943C5A
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF261F01558
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 08:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782203966;
	bh=g19TbfS9RzQGFHPiPSlQ3EkgUSFQDJrLrVSig7447/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DMPaLzo5ZQ1DQOxG2NNbZimBVOltVkjq8/ySqnPDQUlpLPkazHuOfMeBPKXseNKy3
	 3BdWGqzeEYRzPVsBhkjyG5w+ckQtm7QxnaZR8TN+z3HlcOeVFqtWchxbEuC3qgLzJU
	 30FZFA7K+KllLg80025wXmJQFQ6zkihDOsh0zuVYRIlcrHF7ZdYfDk6ajoJKXdKDEU
	 KhPODXpXIDUlQlhsBTqRDo3gZzF4XmHvMPa7/yTvITRvByMmdDVI1AZk7laClxnsa7
	 3hPwVD7AjohwfcKVXmKBpWkRDs2obLJEIxxRKEMJuk9dOy1tafT2GeVJGeNILDNgnv
	 nHnU8cqnP4jzQ==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso43829446d6.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2026 01:39:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Nyyh1aWgnJ/hyTLO9VPL9VddyFOGX2/B9CvjUXmpf87/yTOXQB/Ypd6PnI6jH6bVxlIcoi8eP8iJjc3E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwsS0zo1DVDcHsQX1qwa02kSUmrobIItd3Kn+8tslLe149ATdzl
	1QYjhUrJaibM1g9JhmktAfZQFIvj2Y0v+ljXV8QkHQz9+WFPlt7XxqeL0kzn6jTloLQA8jzdJrv
	FA0viRm3UARe3OzKaSENbfOvn6uv3rLQ=
X-Received: by 2002:a05:620a:4714:b0:915:9aa6:8e3d with SMTP id
 af79cd13be357-920913952a7mr3044826585a.33.1782203965754; Tue, 23 Jun 2026
 01:39:25 -0700 (PDT)
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
References: <cover.1781843449.git.ritesh.list@gmail.com> <ecbca3be3fa8bd7e213d013a2ec6ff9a11c6e0d1.1781843449.git.ritesh.list@gmail.com>
 <CAGsJ_4zxcp-jdnRTn09b8ZfxT0P7suFq3BEpyiUzA2C_iRRUGw@mail.gmail.com> <1pdxybv5.ritesh.list@gmail.com>
In-Reply-To: <1pdxybv5.ritesh.list@gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 23 Jun 2026 16:39:14 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wFVcNi2h_=wjycYGf2eHBPY-oc8aN=-3Z4wsXnT0+LYA@mail.gmail.com>
X-Gm-Features: AVVi8CeWSeuAX2KI166xjMwcifx0Mh0MFzcaEdEraCJxEokE4HeYDOzf9_tycxY
Message-ID: <CAGsJ_4wFVcNi2h_=wjycYGf2eHBPY-oc8aN=-3Z4wsXnT0+LYA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] powerpc: Kconfig: Enable THP_SWAP on Book3S64
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:12=E2=80=AFPM Ritesh Harjani <ritesh.list@gmail.c=
om> wrote:
>
> Barry Song <baohua@kernel.org> writes:
>
> > On Fri, Jun 19, 2026 at 12:41=E2=80=AFPM Ritesh Harjani (IBM)
> > <ritesh.list@gmail.com> wrote:
> >>
> >> THP_SWAP avoids splitting of a transparent huge folio into 32 smaller
> >> 64K folios (Radix-64K pagesize / 2M PMD) or into 256 smaller 64K folio=
s
> >> (Hash-64K pagesize / 16M PMD), during swapout. This improves the
> >> swapping performance since all the bookking & I/O submission happens
> >> once per large folio. More details at [1].
> >>
> >> PowerPC Book3S64 could not enable this before because PMD_ORDER is
> >> selected at runtime depending upon the chosen MMU. The earlier patches
> >> in this series turn SWAPFILE_CLUSTER into a runtime value and introduc=
e
> >> an ARCH_MAX_PMD_ORDER upperbound override for SWAP_NR_ORDERS. With tho=
se
> >> changes, we can now enable THP SWAP for Book3S64.
> >>
> >> This increases bandwidth throughput with zram backend for swapout by
> >> 40-50% with Radix and 100-130% with Hash (Tested by Sayali)
> >
> > Thanks!
> >
> > I am curious about the contents of the anonymous memory being tested
> > and the compression algorithm used by zram.
> >
>
> I am sure it was derived from your microbenchmark itself which you had
> shared here (so repetitive pattern) with default zram compression
> algorithm. Thanks for that :)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd0637c505f
>
> I think I got your point - I can mention that it was a microbenchmark
> similar to yours and not a real world workload test. Is this what you
> meant here?

Yep. Please make it clear in the changelog what kind of workload was
used, as different data can result in completely different compression
ratios and compression/decompression costs. Consequently, the reported
swap-out and swap-in performance improvements can vary significantly as
well.

w/ that, please feel free to add:

Reviewed-by: Barry Song <baohua@kernel.org>

