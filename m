Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFC606A338
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xiv3txIT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbbQJ6VlFz3bSK;
	Sat, 28 Nov 2026 01:29:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795789752;
	cv=none; b=SlCZL/BH9DlxtpemEsAJLFTeZWN1J2HaLPi/k3+LswY4ckoMpBILhMU83a5DzyXvHNsvzrb80h/Lp95uJhI2g8mxcjFZXv3EVvWy0BTl1Hk3rCExl0u/lbiRWDBghdWkFYDL2pKn4jsvc5+4BywE99CZZznZLzv9JO8KyZCs+z2fqQMKUI8EU7seW+39EVW5sEiOV68jDNd5cIlIpAAeeWlS6WtEWInFzOg282gM6/YM8F6RzbZ46BmdNjWheNevwxIaCqyMzn3/WRcx2zdL/cbtNUJ27uEjR5K16FyWkKU7gdjxD3SwYS7dviYEdux8BjVSHYQQbpanFslFhz/J6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795789752; c=relaxed/relaxed;
	bh=dm6cr41faFC8ArIx047bjmXEdHglWtT+kfMScNTGFvA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=hAhB9pWuVHnzWNojvMy8g3o5RjqqjsVcQO1Um+yy05nOnztzmqHzhvoIka2bzVj2RRzIeocBbfc6fkVnbihiZAtdM5L9Pprmf6f1qheGThHJsUvmoWpzWihz8QBVbP4zi+yFJbK+FUvvheGDJtU2BW1spVQRiyhxueDVTn9LRcbVcrIEXZvcRTzA/xNr3jkb+3Axt23eiiZoyLd+nJpyl2n01xzPSyrVfxc4TusyOsDIeo68qKakTyRqrLrt2FoADt6oX+AkeHVssNpP9aQ1rZElTheJlTbtH6fFWvzW27khExF01ibYvDATCaCsmsS1kerHjpyVG8Tlr9CZO917uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xiv3txIT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xiv3txIT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbbQH4GFwz3bcB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 01:29:11 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-38431138772so10638955eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795789749; x=1796394549; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dm6cr41faFC8ArIx047bjmXEdHglWtT+kfMScNTGFvA=;
        b=xiv3txITTcO+wCt5d6zq7Dofa5ENnn3U58izUbTNmtE1o3E7RoNSTVcFgcAGUxBRcF
         0N+twLi2jHbeN7ZqVEIR3yLZU98LwzCgsiQP0ujfgYVoii/aACNKv0UDZeHpWOAdltgJ
         kqH8nUV7jRtv3d3iHESlNqWSLr+dmUcV4IJoTsNqMZ/8HIGNU8OaUJDccjF+bnVxwOdx
         3LxGfDIOQqaDGnSm9wmZEDNpJ+2c9Jj9rkZ2M+eb9efHlnT5aH730zzvhJAji17RpyxD
         aAHGv2MWrGROxla9TobRKr4zjvsMVUfM83nmY4lN7NXJPoEl2y+Pn85V+jMHobPAPBTQ
         LDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789749; x=1796394549;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dm6cr41faFC8ArIx047bjmXEdHglWtT+kfMScNTGFvA=;
        b=T70j4o6MrKANQ0SvyjNNtKr/9gI/4/db5DvA36Plxi1TXxkubdAzdQ2Kh/tHEYRFmM
         9io5F+GEATuMqXO1coJE2SA0fvKKrpBgcVYTAqeCSnGXoyjRhETwUNBrW9kumKC2pn3a
         PiuHbini87Yd7kQB/8OxXsfkzalN7ZPJwmKsQujP94Kc8QS6EaoWydKuhlCrfCJrMeZ+
         6tq6BX/yFhdUvx+QrUi1pq6oD3LHNGiiHbbHTuZUc67oaqDxvD8qhxY0qYGOl5XaH7iP
         hiCbiZ3AVp3jPY0EEk4DcS0HbKcePSt7yr/4Yd41LnkFYD6zOg7WrHInI8ntrZ8I+HRG
         7IJg==
X-Forwarded-Encrypted: i=1; AL+hErEpUh1WuYNHeBaANW+cb+YbQfsHS3JCHDA6psa4PO+kDAWI8LM28XKlr11jVYD1FJ+P/rUYvG94LTXneU0=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8CIIN9x0iuF9wzF1lkkZU5PQiH2W9YKx/XLnMMA3DV9Clkiw7o
	lQWwsM8u1laZuLIuGjBTJL+UJ9xxN43/zwRepMB1IRNjkqJ9i1niBKqI
X-Gm-Gg: AZFdTZfb6gv/HC0bnOkDn7WxsU5osqDBubXpDfarZl3Able5UHJCX0DTIe2aX0YgHm3
	wxpP0uhPBkp48hlQzIhDnXm9Da6TMqcC74YW5OhLK3nyXok2DkxnWIC3xiwyMgShm9wM8PKWV11
	cyiCumgOAbOjiJmFcgFbGt12o6bG8WThWLzLIvylbzjXIZoFZn6Rh/aWJzj4bgCPPbyGdspzY1o
	WxWMlL4UAC0McVj+kXVeK2pL1fMePLgmy9uHHsE2jA97sclOsd1r8WQN/sp94SFLh1/HfM499/R
	rakAdO0/WLbIwe0GfMPQPCLsAvK8Uwg3nqBPr7Gvv5Kwiy/CUpfZoEq6HiZm3w7tbryUjqTwEmB
	YrzB32NjjIZDhGC0/hxE4ToVIcDFh3lXW/s5a4275XgRSQ38LtWbrZZomL6tSQE60b5Lofu+BFq
	D/JMI2o/+za8s+GuyW7mWAIm0CqOtnuC0Zu2GRuuXIzIkgUTA7cG7eb1URLaoTHoEt8LgvHKOxH
	Gl7YjHuh+v2zIuLFEV42pBSSef+qlqYa+OxdVlgIn7P+JyoJxnWKdgblsBI3bIFQ2CyUPzf2098
	ze+SdkSU1QCWwby/DhmYvMqp2nuGfg4kbbpJ9Iwx4gs6lKPsOQ==
X-Received: by 2002:a05:7301:152f:b0:376:203e:7d7b with SMTP id 5a478bee46e88-3856c6b35b5mr27107990eec.2.1795789749052;
        Fri, 27 Nov 2026 06:29:09 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm78273881eec.14.2026.11.27.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:29:07 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: mdshahid03@gmail.com, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, sshegde@linux.ibm.com, atrajeev@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Mohammad Shahid <mdshahid03@gmail.com>, Tanushree Shah <tshah@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/perf: vpa-dtl: fix resource leak on allocation failure
In-Reply-To: <20261127052345.23361-1-mdshahid03@gmail.com>
Date: Fri, 27 Nov 2026 19:46:53 +0530
Message-ID: <5wxiwe96.ritesh.list@gmail.com>
References: <20261127052345.23361-1-mdshahid03@gmail.com>
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

mdshahid03@gmail.com writes:

> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> vpa_dtl_event_init() allocates the DTL buffer while holding
> dtl_global_lock. Move the allocation before acquiring the spinlock
> to avoid performing memory allocation while holding a spinlock.
>
> Since the buffer is allocated before acquiring dtl_access_lock
> allocation failure can be returned directly without releasing the
> semaphore.
>
> Free the allocated buffer if acquiring dtl_access_lock fails.
>
> Fixes: 4708fba19ade ("powerpc/vpa_dtl: Add interface to expose vpa dtl counters via perf")
> Suggested-by: Athira Rajeev <atrajeev@linux.ibm.com>
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
>  arch/powerpc/perf/vpa-dtl.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

I am unable to apply this patch on any of the upstream trees.
Could you please rebase your patch on top of powerpc/next-test [2]?

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=next-test

>
> diff --git a/arch/powerpc/perf/vpa-dtl.c b/arch/powerpc/perf/vpa-dtl.c
> index 20eafeaffa6b..57bc5773949f 100644
> --- a/arch/powerpc/perf/vpa-dtl.c
> +++ b/arch/powerpc/perf/vpa-dtl.c
> @@ -338,7 +338,7 @@ static int vpa_dtl_mem_alloc(int cpu)
>  	if (!dtl_cache)
>  		return -ENOMEM;
>  
> -	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL | GFP_ATOMIC, cpu_to_node(cpu));
> +	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL, cpu_to_node(cpu));

E.g. in this commit [1], we already had changed this above allocation to
GFP_ATOMIC, which is even merged in mainline. So it seems your base tree
is old. Please rebase your changes to powerpc/next-test as pointed above
and resend.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9500416c8aa7c271b85be6a0d5856da62b60223a


-ritesh

