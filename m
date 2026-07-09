Return-Path: <linuxppc-dev+bounces-23940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B14C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 15:51:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwzwc1MBWz3c9w;
	Fri, 10 Jul 2026 01:51:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::52e" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783612304;
	cv=pass; b=UY1pu2Xa9FMmo4meJgk6m3ZyKFL0osPXheL39fmVXb+YB9ZFGjnN1RxBs8dPzWxM0ELAwVScjMzc+tCW1bVI4AhI3/SHMQVcH/TBseJGLzWXdutJqW5kdFBp7j+m6/Sb0WJ8YQYukkffewiDzf4qtl3K96Wvt2KRQaH0S7lRA74UMu+mqaaMxAr/4O98znq25BbX5oN/LuJh3OUWf5hVevTYiYrJ2t3/Lty7Gkp2x9iDAYxkNnPi2X40b+VVT66wp0jMSOHakGMG+KB4OAaTS3GWU3IepeYtuCSGcoHrk3SagQOnjo5P0T9RTdQsTwxErfoPUTz7k8jQUjE2aXcE9g==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783612304; c=relaxed/relaxed;
	bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxzUEjRHZOccjoOtWzq6UwmXQtVOEGtuZModPP13Sd7V9b+VSv5ZM/NC44a9I7VEwmChPs+MHQ8MUGEWiPF38muINsCDuFQ7BlTzOQrvKY55XPehanyIz+AWFjKG//PFWwWOIV4v1CKtsMHv9XR4RVU9c0r4ynKrTa1romoNY9719zWJg/b++kJ0sjLSrRaOyQ4PD0xpzggIzwMwoX8Ch87Tqvdp8FUFKn6w4Gi5XKLxdLosVwrU38OgPZg9VZn5mj5ZhqjG+/KJPyqqO82lI8atPbKG6MVdWSxv07JdWvVwn4X9Nz5Fp2VxEKMrIHy+aHCgkSlsiukfy5QUNRkGkg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NqbZYDpT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=dmatlack@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=NqbZYDpT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=dmatlack@google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwzwZ4DCzz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 01:51:42 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1886226a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 08:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783612300; cv=none;
        d=google.com; s=arc-20260327;
        b=K86XlNirCUTw91M1vsNiOeR40KYV26IMkrkr8MhQhBf1q+gs9XQhbtQzX8cUo/oy1g
         TjX+DieBhX+Hyo9yWdxpjlLZpZ76mmddS4Bly81G7L1MIlZY0Rm969YBugt6A2s60rnm
         zAnbpabYqjIABSuzCqu9n6DTG46/Dcbx04QS+PkajU4Cca0EhjDOYhQfj7PPCe1YbFdq
         xBWAekG24crhtd8ag2/2PcAbC/PhO94WTyMHQvRtjBKFURp4enkLGaFnSe4k63WIsmGg
         Gr3eqg6BdqlsXzuUeWPV4LcJtgGm+ANhJ1BS1dTEuJHYJpMOpYLYCVLxBTqRc9+Sh6Fe
         7KJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        fh=U8CXfl4JUqKmEl6duJvsEtEDHQzOrtm2zLKsqwm7M0k=;
        b=DqV2UfTxNYsyqTJUfYa5SDljlSIihXIt6kBtUS0awhXYZuZUgXUQOGnpPosgc9TWDh
         bWfdPQOSBdV50/ir87IHso+KV80yXwgt2+BnLW3axkzeq5d9STbHjODz1U0juo2QstwO
         CmCM1gIDsWwGzjcxIhRk4xkUghZWipuKyRm+Ld39+y10ZMkqms+HFSD+VwAIWOmHiGwG
         7QRE75uUuI1K41ha7ky/TbxIqOqJbQ/fYtRJQYSQ2jH4OSvb19r24lcXNiqguihIle9i
         AzRl4IYmza5qXzuvt9Qf8GuT57TXEPGp2MwYcW8+YmazsPapJ9uCDrYFIhKTO7U3eFch
         2PfQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612300; x=1784217100; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        b=NqbZYDpTbS9YkjA5S05Z6/ltfqIOZZFDI4Tr/U3qzePIAqWD3MxcBPog8CKAMvAqi+
         jbtkBeNNJnHeeCiLTxv9VBnqHwlSHO+/Lptj4w5DeXDLfr0M0TnncprW/SwhYYSF8R2Q
         7PkkVZGfddud6o8MgboHpuQVZYpOX5lAD7SfWt+G4TCLAe+xs+XDvwKQu0EsxhQ6ChHp
         HQQqt2WNRRsW2kQuAahWtN/mih7F7V7iikf0dgsVodv0P6Q/HZMffsXVas/sf55791xV
         s6yHgey3yd1eK2YU63OyXho8OO90P8coq/0ZkLGpw8iKkfAeOkkNn3aM9CYQO62AR4hS
         94Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612300; x=1784217100;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zYq7+F39g3Uh2HbdpTybELtY+tupvf/1ejmIDLIb7hQ=;
        b=oXrI6kThBXy5tpOOlmFJ7cU08LOTRYQC2wfD4maU+anNM8eI9l8upXtrzDS0jXXLQW
         Dw9qomJwDzP3jemcLqYpII0qnQBZkooF4vlQSg+SJDHZv4pWfvCjl6SWBS3Ond/q0lnw
         LQbeanT5+VRCWrdOTMwMyMJMw2bHHTMMIrbdPLo+lCfDyhgCi7z1EO7+ILo6L5eyOHGT
         kVcHKxI7tkBvjcFDLJPdx0H8BS1n54ZuV6Z6bNbTHa26ZY39O4uuQ+qsrLdGeyc21ERn
         SURvgbzAt/e98UzATdriFA0/R9e5NF7pjPDSw4zjmX9Ar6XyMMi3wDwAYnxiIX11d6jX
         WvGA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8t6qIsMJqFZDF8t8KGwgfNciF/D76vhpbv9j+y8btcAG+qVedW563rd1QL6qqeazRSNj79lQOKUL0Btg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMoe8Y5tkBpzesBTegmUoKjSfg18B6Qs5g6zqJAk8wU+LRKnTa
	YUPAbprnS8Dj/BJ8E0zK2smZJIQPUzyvx7gHceSjdO143pP3uaUkEqQOdYZv8K2Zof8C1d7pDT7
	Chaf1f/JF2PvFxtrhyoN+ptwOf5aG4nNh6qHoZesr
X-Gm-Gg: AfdE7clmRXhF3WFqG8SBLktErW0MXZz2RXMCOdhLIBtHDUe+A3iFs42BJCFZrbGh6rM
	+as0rCbgXVo5SQ19bGlPM7h8/v8guEy6rx+IdivQIK0XgDHmCbR5Tp7lKHm60jKMMLI/oMgvgKO
	2micPVqKVFnfN+pqxmxHdVRW2jslLX3YVVCw+kuZ8P8D9RifChWegjAfLj9Tzo6mQOMC5ngkjGA
	CLuZgDEZVikHLcPvLwu8KNAB4dSiwpcQSb2ZdXrxXVVjAuzEggYiz+syTt1DIHQAGA6fgNh
X-Received: by 2002:a05:6a20:430b:b0:398:77ae:8d8b with SMTP id
 adf61e73a8af0-3c0bcf163d7mr9590607637.10.1783612299159; Thu, 09 Jul 2026
 08:51:39 -0700 (PDT)
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
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
 <akwyZvbv7Fg8mfB2@google.com> <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
In-Reply-To: <afb9bf4d-2258-4731-a28e-7f4eaa01ee0b@linux.ibm.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 9 Jul 2026 08:51:11 -0700
X-Gm-Features: AVVi8CfpfsqwkcJZWry_SVaBgp7lq6qU6G2-M-O5llXVY_AFh-tgNmotP1cgLe8
Message-ID: <CALzav=eB5NwrHNq4bm2ooSFmTtGk3sfUk7_k+iE+Kwm+Jc9LFA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] selftests/vfio: Add sPAPR TCE v2 coverage
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: alex@shazbot.org, shuah@kernel.org, amastro@fb.com, rananta@google.com, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com, sbhat@linux.ibm.com, 
	harshpb@linux.ibm.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 1:49=E2=80=AFAM Narayana Murty N <nnmlinux@linux.ibm=
.com> wrote:

> >> Feedback is requested from the VFIO and PowerPC communities on:
> >> 1. whether the sPAPR TCE v2 helpers should remain in the common VFIO
> >> selftest library or move into a sPAPR-specific test helper?
> > Responded in the patch. Let's move to their own file.
> Will do. v2 will have:
>
>    lib/iommu_spapr.c         =E2=80=94 all sPAPR logic, compiled only on =
powerpc
>    lib/iommu_spapr_stub.c    =E2=80=94 empty stubs returning -EOPNOTSUPP,
>                                compiled on all other architectures
>    lib/include/libvfio/iommu_spapr.h =E2=80=94 declarations

Just one small thing here: You can put all the stubs in iommu_spapr.h
as static inlines, then you don't need the extra C file. e.g.

#ifdef __powerpc__

... prototypes ...

#else

... static inline stubs ...

#endif

