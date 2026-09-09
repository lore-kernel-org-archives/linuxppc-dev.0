Return-Path: <linuxppc-dev+bounces-27028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A5C79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:24:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgdgd238rz2xqM;
	Thu, 10 Sep 2026 23:24:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788978563;
	cv=none; b=GLwfGDiTiCdm24yt+tmS+VOt+Qi0FldbDXKdt/oZkMqkWocsFM/oZdBdLLz6FjYmUwFqGYt3gZbmo7S9kwjbsIBh8dWNOMbAAuFJEs0c6CF3gJANU/WY0ii7pUhEeQOOuIqm7QdH5Xxn8AZK19szGZERC9QNNPog+dNK0/vXHOjb7X8u2qwoofQj9inJ8nnzIdLkani5Q/AAnoKVSN4p1+e2Z13rM/Pm+fWis0GapBuJxYuFNJABlsVBbovDsCH9EbGvEWvOnS1VxL2ygtnZmJg7l2uy6V+ugZ1qo0jKFPcyuVHcJFQt0mCaUwdSyyUjRfxJgGlIKHPeqVY//cnfng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788978563; c=relaxed/relaxed;
	bh=1oUEgD/rN41C0bVeA3gI1cpMDgX5748s/d/3oZ5kHgc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=efojiLFJPAC2NiLf0Eb+ThUbYtiP06OA3WrC2wjzXWPm0OEu7dhohBMgppQBxEBIlde0X4Nxv6ROMmX3PmqG8nyg/i5pA2yGVWvXLzXP19iI2yqSxQ/tS5Velc/w9/sYqE4Ph2NW4fpmouo3rQtxIAvy9TDxieckIcOHWPpjdRcnabh6IlFs3Jzh7qUVX8mNTbyrHnWHA5U1OGnjzRpdWyIlcbVpVXPnqD8kH0rzKwZc1lye/OdTaUDeMF5VkiZbxmxl60KveZa/O/3ZYHpYCG/MewwMW1Ig6yOaKYM6SRsdqynnreWi4Pk+zvGddBRMTgx4v2izS/6Sdq+wxuJW+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; dkim=pass (2048-bit key; unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TNGb5vk8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=emil@etsalapatis.com; receiver=lists.ozlabs.org) smtp.mailfrom=etsalapatis.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TNGb5vk8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=etsalapatis.com (client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com; envelope-from=emil@etsalapatis.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg8Tr2D4Fz2yvh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 04:29:18 +1000 (AEST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso464347a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1788978555; x=1789583355; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1oUEgD/rN41C0bVeA3gI1cpMDgX5748s/d/3oZ5kHgc=;
        b=TNGb5vk80R1KIC4uzBHln9Zc7wfWBHd53XwRmv7fWCGVXWK+Fzny25NyZ6N1zHxHJE
         e//D+Kc1hKfxIjiuDi+xF4Jd6wmujJPDbbNYmZ2W1xH1LnB71gvZcm7vXta4rAygVFf4
         Duw4FeFL+LG09ytVOxvj1gjWT4Gq8/mVbuhS3SP9lA1HRWeP1j9Bg/8cqFZtG9M278PD
         GHBe3zdKaF9r8vylEk5S4FnUcQiqZ+TM8oh++Hjy4XpaU73uKXKPtjZbbOTNmXIOtFmw
         1weLykZnXN6qyM1nZ4BV6hK0NlUJuFFFl43IO1e/KjwM7ikkqbNAQtZ0XOUwKU4fPo1G
         0Q8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788978555; x=1789583355;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1oUEgD/rN41C0bVeA3gI1cpMDgX5748s/d/3oZ5kHgc=;
        b=lsfhxU+5Fzhlpqs6/f+Wj1LAKEiQLXXc4z3c3didlYpfuRwbVck8ef2KtDjnZkuJrj
         GvfzSjoLkLhKq2frJ8VVcCym1w0fqszy19c8kWPYko6LkH6n2dC1L60UPFISRDud8z8Q
         HtsGbljJOZTep92c8FMtjYkg1dNHVWHuyuA3w7griCUcRPn6jKpGXCjfcTJZgtBu3dYZ
         YxdTfxjFBrUOQPWKmY+QPDapBHUOw7mASxKz8QH6627BvamjgUIu13PFehVUQFjt/hE5
         BlnP5d9E7oezVc82njvEdUsZpeC4FaH5Q7J1/Iik0LI1OjOBPq2MRz2XIDiLeD0vLbW3
         vMJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAQJELaMumhsS1lIi6yz9SvJVKYzfVhR/83N19kq+nzgheoRr04ImdX72YSyY4S871bPSimOUhlprsiRU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kVDgjlep9hw/F8S9SsQ0FdQPigQHE+8Erx/B8NxFCPT1naNY6Q
	PLRBQ7G409PSiDhul5Log3u6yRNQico/Jobm4wKW9wEvUy1aCv0fTt8/6F4c2R0M6zc=
X-Gm-Gg: AYBFou3zq8X5STBpkF8jwBkH7XhpxXDWcy4TU404rSfJo42KT56haD9Bhi/h+ko341/
	XwlALKQu8kiyJG+1JuWSPDK/wKgUHYjDRGWjN9PDYlJaa53rr6Ol0iDXFcxGxXuPVweXKeIoWSN
	LFY1Z2Y1L8O/quCeuV26Tt6qv6F7p8W2I5feLaxRQY5TsuiyrWZUdRgztyWlFtRNs0iiYLcFZ0/
	jkugafjfs8yhqNDbbqqAeUpSbbkC5aaSDIDGRkwVZy4WsROcUxLWYPa8MUMz5wjnX9dlJUCun6u
	bRsdmf5ejfaJVbBLMaRiK9MDrm7JtnRR2lazqR3gO8yUnTAJeKlaFBAxxPcXhSvodOWIvX0pJu2
	vJLbrg3VFdpxj9gLI1pB1a6JnICJA1Sra2thn3hKALgyoYew2McUiJStPoLQLHVupTPN4GKCvdA
	0u0BnIlWYy9dLks6C8//yOzWFEdPTvN2cBCf72wSBM2NlVbWw+j+wRjZHBOBV5dsZgXc03f7Dac
	vvPkX/0DXLob9ZFDZNN+aIIEMXc
X-Received: by 2002:a17:90b:264e:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39b262e28cdmr58011908a91.22.1788978554953;
        Wed, 09 Sep 2026 11:29:14 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39cfa5b2fffsm1727085a91.4.2026.09.09.11.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 11:29:14 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Sep 2026 14:29:12 -0400
Message-Id: <DLAZYXG7B54C.23SY9Z6V3JRT1@etsalapatis.com>
Cc: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kselftest@vger.kernel.org>, <sparclinux@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/7] bpf: fix typos and repeated words in
 comments
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Hemanth Selam" <hemanth.selam@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Russell King" <linux@armlinux.org.uk>,
 "Puranjay Mohan" <puranjay@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Hari Bathini" <hbathini@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Naveen N Rao"
 <naveen@kernel.org>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>,
 "Shuah Khan" <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>

On Tue Sep 8, 2026 at 1:48 AM EDT, Hemanth Selam wrote:
> Fix misspellings and repeated words in comments, found with
> scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
> Comments only, no code changes.
>
> Changes since v3:
>  - rebased onto bpf-next.  CI reported a conflict on v3 and asked for a
>    rebase and resubmit; the tree has moved on since and the series
>    applies cleanly again.  The patches are otherwise identical to v3.
>
> Changes since v2:
>  - moved from mainline to bpf-next, which resolved the earlier conflict
>    in stream.c where the typo had already been fixed upstream.
>  - renamed the selftests patches to the selftests/bpf: prefix used by the
>    rest of that directory, as CI suggested.
>
> Hemanth Selam (7):
>   ARM: net: fix typo "arithmatic" in comment
>   bpf: fix typos in comments
>   powerpc: net: fix typo "upto" in comments
>   selftests/bpf: fix typos in comments
>   sparc: net: fix typo "evalute" in comment
>   libbpf: Fix typos in comments
>   selftests/bpf: fix repeated words in comments

NACK, this kind of churn for no measurable gain is not productive.

pw-bot: cr

>
>  arch/arm/net/bpf_jit_32.c                                    | 2 +-
>  arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
>  arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
>  arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
>  include/linux/filter.h                                       | 4 ++--
>  kernel/bpf/reuseport_array.c                                 | 2 +-
>  tools/lib/bpf/btf.c                                          | 4 ++--
>  tools/lib/bpf/usdt.c                                         | 2 +-
>  tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
>  tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
>  tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
>  tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
>  14 files changed, 17 insertions(+), 17 deletions(-)


