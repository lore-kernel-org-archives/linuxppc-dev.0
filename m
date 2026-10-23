Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69451606A31B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 23:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AgSsazjy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBKXh3l4rz2y8Z;
	Sat, 24 Oct 2026 10:51:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792799460;
	cv=none; b=P0rBvvtlJ4cU4XrYpxbsxlXoqIDWuRJmHz3yGSjBeGmce4ffk7Lgftrjh6J8i/aiQA+txTJOJfhP+M3eEAmvUIzwSd8olYbt61KLILHJrA2nZ9iL5qactJoQQfBexy/LZ810zZDANepGkkIblTMiIiGxEYdl9obPxKYZKXdpmzGYuNEMCBGSybWEK8qv7pWwB+x9zb9MiUlphnwje4UMnjQGkyJzialBKwMfaW0HVfVWUor9n08RAoTqcqSXSse5/JpcZ7miN9FqhEk9m3G0OueDSPhj6ioZ/YGujMWyzK7rqhz8jqwhiMifWRKrY/ZDET4z8cjFbRkiwGhy70DPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792799460; c=relaxed/relaxed;
	bh=vlcBaig2eiYIC7Heg76adexHzQQLeESxJrW75j/rih4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtATA2kdfkz0PswnikLI6ab08/nX736d1XDkvCwykVU62xh1pS6/1dLvnHfxFunp1qBTbx5eDbTriV+HLwHJmcZNCKVMsZJ5kzl2JiiOoV1rCRzEn8C8N7uUHjB7rUKu8M5ZocafmZK5OiRYKbo9BtOnyau0SjocM3T9xKrVLOv+dFyGyGbF/SdCdd2YYBhzh+K8mtPkO3556HqnmP/mcjSut9DnAssO4KBxxUchZTmg7P1UWBKkmOoskTJIU1Fwjqnxi/MDXAMeWdHRUvo6lKTheS21o7gydwDI1nKkFcwAvT/1clfhN5e7Bv7vYOEJ5ZJhXwuiYTRGSsxNZMxzIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AgSsazjy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=AgSsazjy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBKXb3myPz2xTl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 10:50:54 +1100 (AEDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-c2acc1e170cso200488366b.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 16:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1792799449; x=1793404249; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vlcBaig2eiYIC7Heg76adexHzQQLeESxJrW75j/rih4=;
        b=AgSsazjy8JDFsf0fNYG1BdCw8to+FEJmDolBLldlvhRRJnSn2x39f84B8LMpLwZnfn
         e1YpS9m+bZm9EkeFhcDOgRi+aEQMPuZsSVGmqOvtPQs6W5esBBAAfNkSUaZgYpkz1Aqt
         mJsx/WfOP/j6QK2zqnFCLsDcimINSBW1KO4KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792799449; x=1793404249;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vlcBaig2eiYIC7Heg76adexHzQQLeESxJrW75j/rih4=;
        b=hFcS7HNMUBQYsc+ehvOXwlZXBzFmblZFv4YlYBKv0peArg1ZW0sBux8aA9t2yFd9wB
         +a3Td6cP58OktvB/3z/S5A2UBrghmmkTQWBwSWa0GHtpQtnvCHUYUakMjIg3fdRhuMGm
         5Q+OFWS8oqrMGjQlc1yU7lhDY2tTgRajNgQFFdfC0Y7fGvPGVujxPBLcDiRYQWthw3eJ
         SSB61Ww/UwJtiIY8IGAKNGmbHjvtdsLHP5vQnILaM7u/1V/J1gcJF35A6dFLI33DisRw
         DZ3Wbgj3/LfxD0TAHe7T8rMWFgRH/vADRxKt3CVVnk2NMAHmV5RGt5HHn70+QOeprYme
         YPCg==
X-Forwarded-Encrypted: i=1; AKwUvByr1sldV+Uyea/m/1KpMTKMQD1r0TNFYpc3iksgpNfAoRd6RJ3bta1H+HBRBg7RbT45T9LAXt8yLGrnEmE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIO0TvhjVbmRQVDZxitGu1F139D1LWs/PsXj7da8EPZDgN20xMA
	W+0YcOdUhp6hsWyBe3pTiFzdqkTCG4JFYYzUDFBQp2dJxmM+Su5Zwe+vi5WbCWVfdlozLN3WWLF
	jujjVVMc=
X-Gm-Gg: AYBFou1wagmBhDQhdCy4ohw3JaoRFbfAmQK/4L9Ir5Ok6Fj0phGRVVs5+w0iUifKlta
	FhRwT5rtDX9FyIE7EI6gCz+ZBEjG0Zyw0UJbi2Q6Eks5W1LLJ/1N5+A6lqs0Sgjozlifw3wu1kW
	6+nEcq36t52FpWw+QuEyNDmBiSIPFsBqIJ6THnGI9pp9+3PYR3FIQQsEmlf6ncB0mgl79kbN0lm
	mvVF9DBBfMuwl0eW3HDhgv3y8Xp1NK+NzAEtxQ6mYIICmRkZLZzbytIjDQggaUoO+o6owv2sr2i
	PZDtwPsrPR2cVEDngbVK8GAUTDybCbyjiG/8TIjKpIkHORgX4lc/KFuqWEHUff4C36biXmmkywS
	Cjvxlm8yhTqLqyYPo7rZkXJXbiIDB8nBXwHDtMiKeeute/fMEpx77MtkM9mbERAfdUOclyz1sRB
	zYx2YADOW/xCnuHikE2ovU1zom6mjArgeO/3Mq/QVY186YqFZrVLCByb/TUT40F1nFaQf5GXISe
	gHZ6MRdFHbe7ewB3zdtDIq/rl7qOmaCbw58PACyi3sOMkT2L3Y+JulGMK82YLF5MT4oDaUnLkkd
	z2SSDWOKB5da6BxEPBF/Drm5YJKWKw==
X-Received: by 2002:a17:907:6e88:b0:c29:4a1f:76be with SMTP id a640c23a62f3a-c46bdd971demr55031166b.20.1792799448980;
        Fri, 23 Oct 2026 16:50:48 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fa1asm21743266b.6.2026.10.23.16.50.48
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 16:50:48 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4677aad67bso154907466b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 16:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzNioEvLO4/xkj0WhYSicqN9AbW6ZHeP2U3zSYWhHyJYr24clzpG6AmDtnr1D2H7hYqAxVqt0SkKH6ZDqQ=@lists.ozlabs.org
X-Received: by 2002:a17:907:94ca:b0:c3e:34fa:611d with SMTP id
 a640c23a62f3a-c46bde7eaf0mr60592766b.35.1792799448215; Fri, 23 Oct 2026
 16:50:48 -0700 (PDT)
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
MIME-Version: 1.0
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com> <20261023211503.3764302-1-sashal@kernel.org>
In-Reply-To: <20261023211503.3764302-1-sashal@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Oct 2026 13:50:31 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh7ZfsDA8Jh0+GSpLehCzfnyME_ztcpwebnvBMDnqjM6A@mail.gmail.com>
X-Gm-Features: AclHuK-CIEJzNq1XJsklQg2H6GwGKSjs4ObZvBlYB4talL4LPjV721L19Rv5bZ0
Message-ID: <CAHk-=wh7ZfsDA8Jh0+GSpLehCzfnyME_ztcpwebnvBMDnqjM6A@mail.gmail.com>
Subject: Re: [PATCH] powerpc/irq: Fix build with CONFIG_PROC_FS=n
To: Sasha Levin <sashal@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 11:15, Sasha Levin <sashal@kernel.org> wrote:
>
> arch_show_interrupts() is only called from irq_seq_show(), which is in
> kernel/irq/proc.c as well, so build it only with CONFIG_PROC_FS, as x86
> already does.

Thanks, applied.

                    Linus

