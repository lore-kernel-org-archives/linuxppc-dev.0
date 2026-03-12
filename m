Return-Path: <linuxppc-dev+bounces-18092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF4FED2F0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 08:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWgyG24pKz3cFm;
	Thu, 12 Mar 2026 19:39:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773304742;
	cv=none; b=ADXW6r7eawwZujRFkVyjY3b59CEYvgnO/x88GLhQK/0YGLxqIO2EEPLxAnALALjpLQXUEpEKqpdaw6JyzLwAiSuKObhU4KENFJ/ozVjhCdF/r/AGqBRNyD6OFW9ytWheblYBa705K1qBxQf9S3ugG6GKhoe/Y3A4s6zXlpGWN30u58oBGewRXCL8FGPJPf65m2Yu+OuDlEwMM+U5CqelnM4Tae0CQldlNB5rE7ipx1THZoXXFM1Ayx+iv6oqXosmRJGKra5t2ZzDKbmJY1mrMTi5Ptnvm93guo2EHIcVMUnAJKj2tUdw2ptdTWQrfICg3gKwii9JMhhu/hKsNAQVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773304742; c=relaxed/relaxed;
	bh=tXrAFYR5bIhSumOFjuc1G0swOeqj6K0Pq1d0oWdhjWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/whjaxfJza/4Ekvh0WnH610W2MJ9UX7Ok7KFF9pXyNrPso+uAkp9jKxzFhTMMo9a/83XHyAbO8lElNzUGG7JkK7tEKwkKNz+w3tDApmWQ3LexPTtuT/eH3SiQSNq8KWwV4j1Tbh82efEwqBzVSKLtv+hewV0aquKStctJokkLBzGYzoEG2GFtZeQXNPnN2Nw5iIFRuY+M7xvEBCpLcj8jPRdSbTMu/MNt4wf9K4yMcAV5j2AXakyHUHRZ5rpqXidsmAxwEaq1wOqMvOuD/ZOWCQ/06scT7ntI5YpUZDe34VEoSH6jmUWvjidT/pe0AroE+N4wxfpjtXoe56wh0G7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M2+3dUzw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=M2+3dUzw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWgyD5xDNz3cFN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 19:39:00 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so5961035e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 01:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773304736; x=1773909536; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXrAFYR5bIhSumOFjuc1G0swOeqj6K0Pq1d0oWdhjWU=;
        b=M2+3dUzwmgUj3T+eil1d/747P5xoHgkJs93updZHrR2Hn8KAPfv6C4sQoN814GVBsk
         vi/lNdFF1nJsS319w+FG65Ihd8EtFJsmnm6WkpLvFvnMAHoQGyhY7in1Z/fiePi6qxKE
         H2VrhZwIk8p/XPNvIK1fz7lQwjkoierP1hBgE5GSnXyjIiLy0uUV1knzhBf543OLJxz0
         v04tIL6rI2IQfh84mqJQBRyn1akQM9XuvDcd7B7dGowuMNrjvEW1j/FFi4dWjVC1bq0y
         LWKIr2J3dGquGhk1wAaP8X2km+bMdiyeI0WJVCIRh2+af67jgdq3UIJeqo5Qy5is4OBa
         XSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304736; x=1773909536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXrAFYR5bIhSumOFjuc1G0swOeqj6K0Pq1d0oWdhjWU=;
        b=wZwXxXMdIw1rTpYOVyP9JW7XOW+Ngm5uW3/E33+TDSRuWeCOazA6R2pHcO4TIysEfW
         ygG9KsqO6q6vtkS8MEOF4PrRbiN/o1WXL3qqfw2lJUo7Tr+FVlakJx1lcr+TlxRTDCfM
         xngFexVOKkcRQRkwuwkFqsx3TKk2CTrRBBwe1eFrRGrujscZvSkV2ZF8XKhA3kbPzRl3
         NjiYA4S0FzxfDWx6CjRc3Qz/Y+8dhuHpOow9maGO/G1VSB8x/zpmDOEKS7OBXlTLlnR/
         BeyFyNgkNTvZuuQHuis3zksGdjh3NqjnGu3oDEi9LeChX5rFo5AqbKte3ouWkm3uzqh9
         j5Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXcWA0MtBsTKS7gvWFNt7jKz9VI9RoLH2DKqfSErZNb0oTA813L+Pt4V+FE7CwUWDupAOo3Vcv6C8BByeM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxf+s2sgbPLdSlwtbQTuWjIrm9V3XD5GELQQerr8qmcUKJb9nB0
	LWTZhkHcSO/CI+h92GMNyWFhLL+6EmRBFaDm2eZ+YwdCnn1nua+mFs9S
X-Gm-Gg: ATEYQzwXbmC80hCU2Ee3umEEwYHWbozv+ZqXRf5CCCRhPhCoq1Iaj3Da+XUWwwDjl+p
	1j60yUx5IUQDcn12m6qwWbtC/loQ3NBwWMI+tavFNzGiCRl+57eH1jC2ChTdob724A91UgTkOkr
	j+1ykwCWmKFj50D6kjt0GA5RbFWDLPRQltw2VRRLLitH9JRlKKUeDkaWgGoWZOEg4CtC0gFGYJk
	rCT43Zi4c1QIq4IFR1PjxN0AQZXSQFEQT8LRx24Ou5kEzhMTQpFWaPd0PLrnB0nnlqKNllmTqQw
	TNfQUggsTAGkKuts07PZWmw4SEkareHNPZf1uiAvGdqCMAoKsnjTK/oNrFmLBSiBveo1uHPKN5G
	0GKABvILZ1VZ18V4aykG/xKjCq+sqEYVhbx1vLDK3kgtI7hCHbJVN0jpOmsDrbkF0OFPPw2xPS0
	EedSpdFZdv/2+PpBbeQ9+S/erdUsU/MVafgZtnBu/T9qOfqMv+L48KixSgKBbSNmIi
X-Received: by 2002:a05:600c:3551:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-4854b0cbe81mr96719315e9.7.1773304735965;
        Thu, 12 Mar 2026 01:38:55 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5f6bb4sm111774365e9.4.2026.03.12.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:38:55 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:38:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Andreas
 Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Dan Williams
 <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba
 <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>, Song Liu
 <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, Li Nan
 <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld"
 <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 26/27] random: factor out a __limit_random_u32_below
 helper
Message-ID: <20260312083853.01dc18d3@pumpkin>
In-Reply-To: <20260311222935.GA3161@quark>
References: <20260311070416.972667-1-hch@lst.de>
	<20260311070416.972667-27-hch@lst.de>
	<20260311222935.GA3161@quark>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Mar 2026 15:29:35 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> On Wed, Mar 11, 2026 at 08:03:58AM +0100, Christoph Hellwig wrote:
> > Factor out the guts of __get_random_u32_below into a new helper,
> > so that callers with their own prng state can reuse this code.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>  
> 
> I think I'd prefer that the test just uses the mod operation instead,
> like many of the existing tests do:
> 
>     prandom_u32_state(&rng) % ceil

Or possibly what the old code used:
	(prandom_u32_state(&rnd) * (u64)ceil) >> 32

Which distributes the values evenly across the range although
some values happen 1 more time than others.
I suspect that is good enough for a lot of the users of the cryptographic
random number generator as well.

	David

> 
> Yes, when ceil isn't a power of 2 the result isn't uniformly
> distributed.  But that's perfectly fine for these tests, especially with
> the values of ceil being used being far smaller than U32_MAX.
> 
> There's been an effort to keep the cryptographic random number generator
> (drivers/char/random.c and include/linux/random.h) separate from the
> non-cryptographic random number generator (lib/random32.c and
> include/linux/prandom.h).  This patch feels like it's going in a
> slightly wrong direction, where random.c gains a function that's used
> with both cryptographic and non-cryptographic random numbers.
> 
> And if someone actually needs a fully unform distribution, then they'd
> probably want cryptographic random numbers as well.
> 
> So I'm not sure the proposed combination of "fully uniform
> non-cryptographic random numbers" makes much sense.
> 
> Plus the '% ceil' implementation is much easier to understand.
> 
> - Eric
> 


