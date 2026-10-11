Return-Path: <linuxppc-dev+bounces-29191-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5457ECA9EC9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Oct 2026 11:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j2dtl456jz2yPR;
	Sun, 11 Oct 2026 22:39:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791690603;
	cv=none; b=gtChw/gkNHSsmNZ9hX2ZRMR/PjXPggs5+PpHk4uRuD1B1mTnW1VRvPA92/U6A5hbSCwVl3aMRZyT1IwnSFOt/XQEFsIzx/XP9Jdhrone7l23ZvwfNkY8inbJbYTe6e8M3iaJf/A8ryTpr5GZ9Kk/GwMtsTS848vnvNaZnJLoVeGCmWjbV52OApXMlh1X2aAR/4jcxgL+KwhJPTRjHhVeLobkl5dmCB4jmVYEh3UECZmodSzYALFbG+M8pvIErw/BM21t1K6e67nf3BOnw7nsvxPeLH4YcXawJCrVvrt9b6yAD2qV49sGIIZn5eGdZn5eBdR7BvoH8v768bUgh74mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791690603; c=relaxed/relaxed;
	bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ZPcCoRldqEVziCmsZzb0yvXaFtdX/UmwMnE39rKM+64QcTEH62boYI6Bj8dRForXkhItSmtZGZNNOShCWDg7Io//MUH+DT2wvqyfdwsbcDlk/VLECWwMcpHrkfLWUP0PAqh+GBOlz+MCodOlOq/CHx6PY16b+acqNgDCI9sdti2QFz/zCSqZgf/QD5WdEXs3fgMpRpp4oKU5m8/nZeSxZyDdQH+I5orXivJ1BNLZPil6NwC8fqP4z+dQVPbFf7f4BRFPuFkyqphgB3vV1EIiYHJqvXD4nq1p4F4B8LDHAAqYAAO/jNgFaS+YiZ19Iz8EFnK/htYYilCD1wbS1AIjRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bu7ACG1X; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bu7ACG1X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j2RST6FqGz2yNj
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2026 14:50:01 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-33fb4680717so3367685eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2026 20:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791690599; x=1792295399; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=Bu7ACG1XTRgcIAYj4Mt3GPt0nSH5fa/KAFw/559jx8aEO+/996qgQPWTPYEEGICrV5
         mhtufX+QKflGRC61ad1bGr6c41ytRl0TjZjsOQc+1bS1PuIwnmo2zNbCX6VloVScCBxc
         jGNCLbxEqs2NJAqkBo+C1Ac4eaqoPCnTOk2cQo+NLSi+QqBgcQkWBa/nmM1v7B2pzXau
         +2IVUKvL4Dk5dHZlAXNAdANAt7ejX+M17d68Arjs9YatYSYQM9/RTteJ2XiMrpSrvdGz
         OlW2tsvFc5qmHBHKw+AzreKo3vezAKY7qaEvMjQvVmoOND8uPPzLLgzONN5WEEEcfjdR
         9+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791690599; x=1792295399;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FyjOs8U6Ak5u7Fn/oZM+fBDOPJMJH3TRgM8xKhmhhZ0=;
        b=uHBCY7zkimNRczgcOaZJ+u1gLKsVmYcX4uWkgdmhNicRk0B/k1GGAjgMNnwt5+CTL0
         w9pcrlgbiYWFD9zJzWrAB15yj3EkmzQX14xLPnkVqBLPd0uVK1tFra9AU4qgxWIncyLk
         XJYEsKaZ/iEF7l5f7+XK8/Dj7EN1zxR/MTSovya2TA0FJIKcF850nyE3Zh+73UXe1Fyt
         CopyZCyF+IxYPxKIJ+1l+ITQUAtr0D2ZaOddf9gzrRE5TKyaHPFwICC7QYLJsz8050bU
         cAHE3Na6G9wCwd0MpN4KQ7irxTJtL4BaoZYZ0EuvSZbNc58KZsvjcvOmd7mnub6TLUvi
         lWkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ+5fsOVcNPYFf6GIG28UMnSTLf0OgmkdZO2HhihOdHY3DRo0rlUfYCGQ5beP5PfkSo/OslnPQ5Cw2Jmo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK8uucUedQwXurfwIjprgGgtFwYSMM5GM+VKjYBO1Emu5PCRiZq
	1xhdbs6RtCaBbH5pHS53mIy/Go814Td26w6Kde0sFvQQeHeWAMOuZLXC
X-Gm-Gg: AYBFou0NUyzzr+iJvjrDtZEGytwKWrmvIZmTY1bkRFDZ1ln9KA/Subj3VxAgJFTM0wp
	W7Hyh5DhwS8Uo1ANVQKmsNHZ4Vd6J8IySYqR6b7t9/JRKrXbZy+GKwZTQqdfvPWWBHsMUH8A9Cl
	u3I6ao0wjnMj6nhab4A15WtTZdEIlixDWPvm8CgAnYF7gKi8+flLlsZrwr0hfp3zy4L95FHHI55
	sOzMsIlG+Akflfk4MGBqsoYIyi13lIXiHJYnbRa1BNTvMu4ZBIHM9TuL1gQJ7VTiyrKlLLeMemT
	ZFEJaNskN4+cC4EJVHJSBm4GYAWJTP7LEgVYZbwfcQeZ8TEt0uqIkLdI7Zo89o2szAswkwxc6xz
	ONp9m+MtwzIxT6EYxOmoMKcxAvj3KggruiGtNjzCkAGgdw5mAcrQoUKvkIeCgKQKsXOgbvcntzH
	xfCGgVYh0a483vGN6pR9eSExbS9l4vWF2nr3MYGYeYT3a1yl4LW9Uiyn6gDKRtoynm15kD
X-Received: by 2002:a05:7300:2442:b0:351:39db:42db with SMTP id 5a478bee46e88-3537dfe388fmr8395787eec.20.1791690598985;
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358de54fe47sm7430579eec.31.2026.10.10.20.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 20:49:58 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, 
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: PPC: Book3S HV: Ensure that calls to idr_alloc are synchronized
In-Reply-To: <20261009123035.157770-2-gautam@linux.ibm.com>
Date: Sun, 11 Oct 2026 08:47:35 +0530
Message-ID: <zewlq628.ritesh.list@gmail.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com> <20261009123035.157770-2-gautam@linux.ibm.com>
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

Gautam Menghani <gautam@linux.ibm.com> writes:

> Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
> According to the documentation [1], the caller should provide their own
> locking to prevent concurrent modifications to the idr to prevent bugs.
>
> Wrap the call to __prealloc_nested() in	a spinlock to prevent concurrent
> modifications to idr.
>

This looks to be the leftover of previous implementation. IMO, the
commit msg needs fixing.

How about this?

Calls to idr_alloc() in __prealloc_nested() are not currently synchronized.
According to the documentation [1], the caller should provide their own
locking to prevent concurrent modifications to the idr to prevent bugs.

Now __prealloc_nested() calls idr_alloc() with GFP_KERNEL which can
sleep and mmu_lock is a spinlock. So idr_alloc() cannot be moved under
mmu_lock. In such cases the idr Documentation says:
    If you need to take a lock while allocating a new ID from the IDR,
    you may need to pass a restrictive set of GFP flags, which can lead
    to the IDR being unable to allocate memory.  To work around this,
    you can call idr_preload() before taking the lock, and then
    idr_preload_end() after the allocation.

Hence preload the idr memory with idr_preload() before taking mmu_lock,
which allows us to use idr_alloc(..., GFP_NOWAIT) under the spinlock.

This also allows to kill __prealloc_nested() and __add_nested(), as they
are not needed anymore with idr_preload().

[1]: lib/idr.c
<...>

> [1]: lib/idr.c
>
> Fixes: c0f00a18e2a8 ("KVM: PPC: Book3S HV Nested: Change nested guest lookup to use idr")
> Cc: stable@vger.kernel.org # 5.19+
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Otherwise LGTM. Thanks for taking it ahead and validating this.

-ritesh

