Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528D6606A31A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2026 00:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RRIRyjwq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jBL5C3ZCkz2yD5;
	Sat, 24 Oct 2026 11:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792800943;
	cv=none; b=YMx1749Wl4e8lf8V8Kelfg1erTJ2ormYBH+TzhFgCWO6ANuMcx5qfYH2vKRfrjFOHjDK+qQHBULJfN7HHoo8WlC488KTmSLWPqGwQd8VjtaloZL0WB63MLFjz4BwET3qILxsr7+/BvJSPZv8IL5/0NIWVXepgi/JVffVS5iUgXE1JtQMNCPNevD4RGlAZKkihXR49mgfCLwzVESZItbJX3f8SmHAdD5S46TPps4Yck66msJZT9QZq/3hV2nxIRbSpJy/pNlM+6AFgU5KiKQUmFKyxmZ4gmbkWZy6Z8kHZ44srvcc4SUQsriJMIJe/HLVUiQCWHq+Wnb3EE48swBSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792800943; c=relaxed/relaxed;
	bh=AJdMBlp5AvW7Nf03LziKxpaZYi6yerfAfMO2esJZe/A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZjqLZtNinoRvPh2juidQsHnF5XXGertXihDZf6Yk7CbmaCI4clHZvobeF+lcEDpFKbL+yroTqbVwEuc7VWqb1YlTN+l0SgVcXAI0n4Y7242MaVql+DSwFxThiLiTtU2r+ZJxgOJUqbcnmdv/zt/ZgQDybWrEqkqK2RdQvfvPtb0nXWDsstWQ/GWg2rY9ocA7KNB8nr/dTZdVcSxG9Yuk7t1MX0ZvFfk+j7FRcQkM2FELxv+A25r6s+mgDXbafRcy/NIHZE3gd/uK26UZx09czczLyuQGzAmWl5T41O2o86Stab/nreBKJovgkB5z5gXElm7QFhuSWK5R/cqqOZNDRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RRIRyjwq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RRIRyjwq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jBL5966D5z2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2026 11:15:40 +1100 (AEDT)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2408545eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800937; x=1793405737; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AJdMBlp5AvW7Nf03LziKxpaZYi6yerfAfMO2esJZe/A=;
        b=RRIRyjwqu+h2HmDRuWt0i2ZtqAFzLOJVbM3XcrRksuUWFkjmz7diFf8btL0mOu883b
         cpX4OQ1wGiUOWiTfmrBQdZEaSyQ2Td2oe3H2PhKhYjZfKtybdg6PL4L0mgn4KljpQjAH
         aL+WgYA18HmRjNGZF2HW9LfhQuYlcVBo4cLl2aNaxkubPzU20KlixpxIdffUDg+yXje8
         TN7vHJlOnu9MzXD94WxLhF8znRs/38+lTp8uXgGZABs3DeURFzLWbxPax7YBW/dkT70v
         n4E+R8dQFYcucziYywtXHPNh9PAkVM5tESgKkvJkxGe8HfhLMq8ccWzVA4NuBTXbAF5Q
         JFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800937; x=1793405737;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJdMBlp5AvW7Nf03LziKxpaZYi6yerfAfMO2esJZe/A=;
        b=pi7byaV0b5yaiIP9um24yXGGzT7dhFiwtbJmCAM7ikrUA5nm2SIo09bTApXh1sYoTF
         OtiQR1/qA+31SlCq12Hua9GsNxIpeT7u85c71AvNpn+n3ynVoNMogtktrD34z4F2BFQy
         tthyOGEiv2qlDgzFjIgn9JBTdcXaZzf0RBHCDfuXmEBUwQwzWR12prxGlZnLJYE6UqZY
         1xyocSQUfkTDmXT1o7IjbY0ZLeaC7GORTuYYBLpKD+eCvcQrWbxqgNaW8MvNUwpwdIFh
         TdJdkQ3/aFD72xeohfQ4gEO6kG1DP6hmByufAcO4AC4xpRWIhmUKGtkFwsxHx6LRB3Yw
         I1DQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdgNSgQfE5rLDfeWAqqle+Xoxkfk7T/FinOeRFId8Dm+bW9IkheSgoU4gl+l0uMOv4VrSEJuwsa9fc1QM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLhkw9r90IpX5dym/zwmBus9KI1Ok/LFNmmUWvzZGnS4IsNWScW
	0r/RsKInNlhKMjjsQK4oCYbIIRlRFZDHpJVP6rSaVctER+nwUdsm1SZ8
X-Gm-Gg: AYBFou1YwSZEdj62u/25Wqepy34cSK/Ds3ZgW58He8lNqqW/6s3kmeA52b0Uy08Go5D
	jE4/VGN8czTTJwskIkAFbpnpCRrKltiY+aZ9KqHHa6Y+dMpJAb252Lu0qXgWJgViyn45Os9EWuY
	hhj6UaLb1q24mq9x50Tf50uwtye+jZ1atnly27mWSN/B28XBsTdMure8lWw30AAZz32qs+01BKF
	OQlexwomgCZL4Ep/KUF+5hBoOrSPKGAf5PGvYhs6/HTIZ+EnDm1DXVUw2XxKAuL+mJsbBdiRWsY
	YnDwGWAl/qC1Yo1HTY7u8jYylDcs42/v1TTHRlb+yRQkONYUltf2RemHVJJJnU2z0H5L/GyL47V
	br1UzBmmsXsXWnxwSMyKmlDKeQFFGT1uEhguZ16PDWfjw3S2s9B3gdjQNOa+BIoE5wMDpzjobMi
	5mUZD/qbDBoYHO2wAVmAyBlDoPS370Y+T6mbqbw29qOLXCj2y8M93SkAY9eeBYLHhbImHncaaID
	Ig4gfiprDgrI1Idw4Ha/k28c/Cdequi1yMmvdwzJVYP4bBNNe3ngw==
X-Received: by 2002:a05:693c:2d84:b0:358:8f02:e0ca with SMTP id 5a478bee46e88-369e84fc4admr1462480eec.9.1792800937127;
        Fri, 23 Oct 2026 17:15:37 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d56957sm3151871eec.5.2026.10.23.17.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:15:36 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sasha Levin <sashal@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shrikanth Hegde <sshegde@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/irq: Fix build with CONFIG_PROC_FS=n
In-Reply-To: <20261023211503.3764302-1-sashal@kernel.org>
Date: Sat, 24 Oct 2026 05:39:30 +0530
Message-ID: <ecdg558l.ritesh.list@gmail.com>
References: <2331292e-1a40-44ef-8776-9155e8e41f03@linux.ibm.com> <20261023211503.3764302-1-sashal@kernel.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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

Sasha Levin <sashal@kernel.org> writes:

> Commit fbb22ceaaf8f ("powerpc/irq: Make irqstats array based") made
> arch_show_interrupts() call irq_proc_emit_counts(). That function lives
> in kernel/irq/proc.c, which is only built with CONFIG_PROC_FS, so
> kernels without procfs no longer link:
>
>   powerpc64-linux-ld: arch/powerpc/kernel/irq.o: in function `arch_show_interrupts':
>   arch/powerpc/kernel/irq.c:134:(.text+0x4b8c): undefined reference to `irq_proc_emit_counts'
>
> arch_show_interrupts() is only called from irq_seq_show(), which is in
> kernel/irq/proc.c as well, so build it only with CONFIG_PROC_FS, as x86
> already does.
>
> Fixes: fbb22ceaaf8f ("powerpc/irq: Make irqstats array based")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609271531.8kf2NTjK-lkp@intel.com/

Looks like it still slipped through.

> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Change looks good to me. Thanks Sasha for fixing it. 

-ritesh


