Return-Path: <linuxppc-dev+bounces-22431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D95D5CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2026 21:12:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbJPz6F9sz2ysW;
	Thu, 11 Jun 2026 07:12:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781125943;
	cv=none; b=ctlGPZV78Zl1IQdy32xZFKsQWl/cIIQ7CIjeRXMW4g2lHaj3c43l1umsf7AEmxOVWVvuBzx8yfr9+Ecr6zB/MK6mVNTgNPm69QCtLcl6u/eTmrXllqgVPmjXKdWkKdJPEyI5OCM5YmtSFUZIT3vuLKc2MXf8u35/qWG3qKMD+e9c+21Q+3g2VgWpv8+4SFSTYjOamqS1NROU7cGKMJVuXsWcOgdVIGOgqos/VE99ebLkXpFyXoXHIKKxN2EoP+wonv9ebPgC4lvrE3PDLhXw1D8FOe7I2iUGdB5qrgscclugLV0M65qYZ03Z1y8FNEtl7rArS7e8/NiuWMi6YWyrww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781125943; c=relaxed/relaxed;
	bh=WmtOOZoa39cljsiuXiJJhknC3iyZnCTNqU8ztufU8ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcLM/O/LUJUhHoKsesit+ovR4baDzCLR1E2Z2PDZGIXc/zMswpGonBsz7tvpc/y4z2PvPKrAzu0exr39KejwafSk3ChbRVO9k9I3giuzSfDaXdiOHF6u1J55LFNjCqLXSCcVoLm0sJ0ReAU8HYZqbef9CsFOHrzqqYo7+QeYz3yCPXRFK+oFs4nqTY+KCfbDuFp405EjVQ+M1vrDCtIfzU6EaejtcpJrhynR2lUjdc0VHnHlCeQckJwaWR958/tKzq3gOUziWOJ4neNPmKgqorOO9qjDvEiplt2xrSEfVmlI4f/P/rZCqtLkts9nEOaPXAKqoLA1xzHiYIfcRcUl8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+mfkNLX; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+mfkNLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=baohua@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbJPz0777z2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 07:12:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9462243462
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 21:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382B21F008A4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 21:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781125940;
	bh=WmtOOZoa39cljsiuXiJJhknC3iyZnCTNqU8ztufU8ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U+mfkNLXUspW9aH9ETn55CcVq7WrA2+yedRZa3ktc+HsypOHZvn+ejFFvKB+75x0U
	 f3UoWcmSXNl5I9zF/gIdP5ljmwUZlI0BIlMpfXchxhLoI4VR6LXmbot7zOS2l2ZjR+
	 C2q0NPKtEbEsTAFJmaRsId1oBK10e0GFXNjrTHN0xsUkFIMvBzpoRA9kmRBtTxPvU/
	 JUKGwSqjDI/EY4BlceoUAyVzMAOG1tfW6ZBqyVMTAiLSXAVaJsHxpRsnUQQGCQhuGt
	 JxAVT2PHfGOsjm9NlX7cIk8cehR6/uqFk7QMnVsY7mO+wEdsX2wc3LtlqE67aKsOjV
	 6stuGZ1x1d3EA==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91588056619so505806085a.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2026 14:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9WZIKzutEjzkofyUHYIiComDwpyPF+6L1HmwQhiNgDWQoIpk7dZ1Ehn/EhP+bChWNi38FecFmqHNKqvi4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwJszwTUjmxGBt5i3E4lkykrEjjKYP63ovQrlEcLZBLnBeG/sza
	xGL73CEP2JUvNDGYCSW6Qx73djwOkw77E9F/021nEq8b0z+HJy9EqaQmY2f0Djf5wNP92ho+XYd
	tEe2bQf2dn610BhGrpsf6Pqw6hBFq7m4=
X-Received: by 2002:a05:620a:470e:b0:915:d322:c465 with SMTP id
 af79cd13be357-915d322c6d2mr2656769485a.6.1781125939515; Wed, 10 Jun 2026
 14:12:19 -0700 (PDT)
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
References: <cover.1781000840.git.ritesh.list@gmail.com> <68591daf0d679e5a0072d63751f187d14613e2b0.1781000840.git.ritesh.list@gmail.com>
 <CAKEwX=NCB6yrf4Dc0yU_CwZWi0Kk3tBup7yvP7EUz2k7_CR2RA@mail.gmail.com>
In-Reply-To: <CAKEwX=NCB6yrf4Dc0yU_CwZWi0Kk3tBup7yvP7EUz2k7_CR2RA@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 11 Jun 2026 05:12:08 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zFi78j5hz4=B7-25y__zOi70pzsA4c+BN3weyJW+gpHQ@mail.gmail.com>
X-Gm-Features: AVVi8CdJOzMhytTtNw_cCB_84EbqZdsx2mxO9urY7WCpZCzlojMVKFUa_ya4iOk
Message-ID: <CAGsJ_4zFi78j5hz4=B7-25y__zOi70pzsA4c+BN3weyJW+gpHQ@mail.gmail.com>
Subject: Re: [RFC 1/4] include/linux/swap.h: Remove unused leftovers
To: Nhat Pham <nphamcs@gmail.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-mm@kvack.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	David Hildenbrand <david@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Sayali Patil <sayalip@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:41=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Jun 9, 2026 at 6:20=E2=80=AFAM Ritesh Harjani (IBM)
> <ritesh.list@gmail.com> wrote:
> >
> > This removed unused leftovers most of them are forward structure
> > declarations. Also removes SWAP_BATCH macro which isn't used any
> > where in the code.
> >
> > Found these during manual code review.
> >
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >  include/linux/swap.h | 7 -------
> >  1 file changed, 7 deletions(-)
>
> Seems like this can be submitted independently of this patch series right=
?

+1

Applied the patch and built the kernel. It seems to work.
Feel free to add:
Reviewed-by: Barry Song <baohua@kernel.org>

