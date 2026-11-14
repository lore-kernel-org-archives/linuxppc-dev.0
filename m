Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B461606A327
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Nov 2026 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWv41y06
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRYTV6sbsz30HB;
	Sat, 14 Nov 2026 23:34:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794659646;
	cv=none; b=lWIoggAo1XJrkeCiR6Lu6fbPXqpeW/UfMfAME0Au9hppBrzCB6Lpxb+PGeH7AFPJ/7vQ3HDqc8RH1SQ8Rpeu86jG2Xr/VqTiDIVKn+Wm/DvWx23Q/t52rCXbJIpkTILhJUHrQdogUtvE6JD382caWwRknGNgXYUFEBt4r9uGavM/vYZCsnLZyXYomiXRbcz6Z95VoSL2NHWDLuQsneQ8QD6t1bJfS7rDvVGPZnGtMRluA4i37mIQhVLbNO9Y/FcPItx00+AUqrzBCtWgLQeWs1PUBXHL+59yVhNmnwsNSt0OFDaHQmTqg8klxJzAtiH+qBmRHa36qfKlOQC7cogiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794659646; c=relaxed/relaxed;
	bh=YluE8J+/JrXXpXAxA9V3z+4IjC8O0zarKz/bVofFq0M=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Oo0hQ7ggKikP5A5wJ4P/CpSdlw1zZfZ9BPsxUZgBcgcQ4c+9i8AkMgtq+4Vyf72Xs22u3kI/k+y8yyErAd3tuFbVmzpa9FRA0KSQwfh40xLSUrBrzqUOxcehIYvRBDa0VYu3QZuz9KW5KIrtFoCXikqMi2smUSTAaRIuNlvu6Eiv+/IbUacDu4Qjvh6qmzjx93s9+sEZGqSBtEjCn8pd6FcgpXdS8DiFFm/kDOKLmFgWjaWhl4HNSB3XeNHt6V/SPHmnWl+bdHK5/LhltA9pp76wSOsepe/3OTuuNqt+0VEPGG00wqS78OnP9TyG//ZVQIZItLjzeEjQPAVkoJfJDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWv41y06; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IWv41y06;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jRYTT6v2Wz2xnh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 23:34:05 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so2454348eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Nov 2026 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794659642; x=1795264442; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YluE8J+/JrXXpXAxA9V3z+4IjC8O0zarKz/bVofFq0M=;
        b=IWv41y065GcZXXYMR1DdYXcR/+X8rr2QIJqC5ZeKGuvZC/QTgOe0IAZ/spTMq3l/9C
         Q44qZ3MBgZTmoauAnTc9ezisUC62a6q0I8i6s/vu9g7uQndNRgTZaWGBohjBUvSiW44V
         fNYpBLRgEE5Bi5aWn9LGxchPo0KePS/HQMoZUy15gRgjBfcdAEA3mdP7xp3MytfC8VJU
         87hEc4Abe4C0R8DB6QOEHaWxGQfmGnshrDSRfdcozZxowF8rxdfflsp8KkWR3e+2vNKt
         d3AXxO6HEYFqdJ4nPkzBykRvhM7D1X9vaIBHKWHGVqLTX/w+wn2wn5Zkw24PFqSIkwtO
         t4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794659642; x=1795264442;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YluE8J+/JrXXpXAxA9V3z+4IjC8O0zarKz/bVofFq0M=;
        b=1XyPTQKQ6MV8kiD84TXL9AnC6M8LlcmpPsGBLCE128xs4zyKTy/T5oUmoQcH3vLUO0
         FWPagUXHX2vr/eb4XDheajJMzl8ObQDJNoZWXJKf8HNGlz+wB/wy0jK62GlAKBucp5ia
         t3pEeonTCuh7QtOjGQT+dC7vUOrnnSt2PWZ1RZh9rSv/ZmIZXG3tV+pVPyIjNggLjalR
         3cH/OUgKmzH4BUXJOOqgPSZskGsCyZz1afawTnCfC7qjjk0Js06C/Q+LoThEJeTTd1yw
         RGkEd6qdE+OcjLxKKe3xkYniuolvZYDz5+yh5ZfIPeAv/B3d5DdJefic1nb4WUVOryJj
         9zTQ==
X-Forwarded-Encrypted: i=1; AL+hErGRZxQ5v2naGTUundpcJ1cRe/5jk0gtsgaDg5FSVTSs7PgeSgmP9RROopA2q23cr1szlxgh26BlY3kEVNY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z84z8bY2D8i/VJeSTVshF6Rq3McjZOpGurEkZsW17DXMbxlfZ3K
	dOeF9P1h4OEr/WqIP1leW8XsQXXA7r3BGHjXJIpPVMa0a8npCYREnOLL
X-Gm-Gg: AYBFou02TUlXVBgs/LEx78WyvxT/hkPx0GqrhuSB7TqkpEXo03UOACaTvC40xzKwHDg
	TTj7G1MPGcLScjNXyo5xzRbfZ5PTU2Am8Hz1QUFXv2H7n/2xbw5BJkVcp1IN0g9t41VzFVdhv4p
	sB5bG1sek6MxSzVWJ8V0DrNBVuCvvC0QdMXnA1oHQ0G9Z84kY6t185+xPKE/Vb3uh6FUgTYOTOu
	i7VlqyVL1FXjfJhVBvMSKflaQ9KOxmTRPEAP65eDRlbn26pXaNsi6dnMg8Z0ucD7WqDAVed7RRl
	s+lTjI3jUxlByf6+Tqd34XS0PskNCKReEPfD55asL0u5fYZ3uBQq0+2sgSaKLz5iJabTV6f081O
	AA5vNEPDdYxiHpoE1m7lhLTFi0yFMOyxN9xhG+LJz/ZbtQ6FhA7rOiwKOSj01Tv1A/HyPemW19H
	dEjntf5A8dHbgUSjKzCWcZ/4IFc3RtsLV8fU9S+JMPhFKMULRDjjnAFF4nMLDhz0dmFGCqrLF2U
	7imYeUXm6yN/M/mguYt3GTnJT+/txWXK65vozhYn0eq4/Jy97vqRQLZC4ie6rh4jgb7gFQjPoaW
	3cWDBtbRjmbGh0fT/8ubKaNosf4=
X-Received: by 2002:a05:693c:831c:b0:376:c352:2fcb with SMTP id 5a478bee46e88-37966e3ad42mr4866293eec.9.1794659641790;
        Sat, 14 Nov 2026 04:34:01 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm26708201eec.8.2026.11.14.04.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:34:01 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Ogness <john.ogness@linutronix.de>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/smp: parse_thread_groups() return error on missing property
In-Reply-To: <87mrrbrhf2.fsf@jogness.linutronix.de>
Date: Sat, 14 Nov 2026 18:01:51 +0530
Message-ID: <eccn8uh4.ritesh.list@gmail.com>
References: <87mrrbrhf2.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>

John Ogness <john.ogness@linutronix.de> writes:

> parse_thread_groups() is supposed to return -EINVAL if the property
> does not exist and -ENODATA if property does not have a value.
> However, it is currently assuming it exists and blindly calling
> kzalloc_objs() with whatever of_property_count_u32_elems() returns.
>
> Since of_property_count_u32_elems() returns exactly these same error
> values in those cases, simply return with the returned error value.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/powerpc/kernel/smp.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks! However, the fix for this is already queued to powerpc's fixes branch.

https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=126b47221b7b98d83c118781ce724c0515d86d9c


-ritesh

