Return-Path: <linuxppc-dev+bounces-19039-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DD81061B2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 02:07:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flBMX4ccWz2ybQ;
	Tue, 31 Mar 2026 13:07:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774922840;
	cv=none; b=BysCHIii8LTM1ddV7rqBPsY+YhdmRyLNndry3H2fWQ0M9uOTwEMKFwCSaG4fZ805qbmqlqGasT+fMbTw4OSgepnn2ciDVHt0L16IxbdfLtoMr4FZknaxQZdFdZZGIFwFjNhaMvL5LYIxkTqSczlAF5K5KjlnL03Y1iBXnPR7j6F1mOwXtE8h2i0toldWCT979bIL+BbdxRyTcKRY+VVOKe4D1UCYZcgOZwUPIlMJ/mro/yFK9LAlNbfR2gfGEBZmuepITAELwhR8/7WWrH1dPAfA4e8vIXhUzCVUVFqU86f2ltvSZCSuqBMeGB/vHL5ZYl/JZm23k4z5fNlkeAmPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774922840; c=relaxed/relaxed;
	bh=Q7OinmlPHVygQxvfDVFJvK0ZY1pvhoxnbxOEnZnjSoM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bGoxaOJtuRQacguSSLcqPud++VcAvsDd22AUs0hwsOYa2UOWKmhHV97QBfShTHYF9Z82Cus2TF2Pu1hH7T1ahX9mBHlvh/E0j9kDybGMBVNYgE42sqWwek8jh2C8wDMfb43lCCb9S+IMLSQ6moRBGb8ycrdd5nuKv0WfDt1INsOdla2AYLXoNOlrt4Ofvuwpl1M8gZ6mn/KQUpNcWPb3BY+ps5OmnVBAKGuZE9FLGvFFjUVp54UsDvp7ukpTOhF4OfChkHxoYMAKrRXlH9kKkAOEFL4sakU+4ortELFqgc4Hf52mVQZpT5sptCu2q4p/KtqFSZ8eAxRMC3AckbhrrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fz4H3C4a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fz4H3C4a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flBMW60V6z2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:07:18 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35d9749c26dso1974033a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 19:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774922836; x=1775527636; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q7OinmlPHVygQxvfDVFJvK0ZY1pvhoxnbxOEnZnjSoM=;
        b=fz4H3C4aoemVq+Mpapw39v+gL4pXSOPU0AALR2Fu38IdBdG8KYlnP19cBEbUfnDfrj
         3A7Vx0Hcvs1VOEG/psr2hSbWI7DFb8b7GfTnBDoO0bDwRgpXnMal73Wx1EPvUOeaWjiW
         1CCafAo9ITMwdbxw8uPzZog5gRsH84r4Agzi/ocCYT3Ktb0gKtEHt0nZGAf/ZnAjMn9j
         KQVOtX86EglyU4QHYLw55RbijNDB73NAGEnNtRps/GoMaF+Dp2M2ysCSPYqhrCr1H4md
         ePuQyrtcepMgRPq7J9Y1az773MTw8kdnuOWuoEfry49ITWTwXcz+AMb/d05bAVtk4imD
         FZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774922836; x=1775527636;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7OinmlPHVygQxvfDVFJvK0ZY1pvhoxnbxOEnZnjSoM=;
        b=O0ks63+TdFeROru3A6d43/A2aam64j7OE+TauyF7U77HT3lZvuV3k4N1JRRgsvlO1r
         0jIrZ98SmXqR4ZnjMqK0q97EeWyN80tBX3vU7IrHOYuUchaZsY0vBAVw9r421NIwPCU2
         it1i4AdkpgB8YdYalsYQa32J0tDU0tM84T/M3Onh4ajiOSVLHBE6niW6tj8xDM8JLLMe
         gR+5RJGL+t6Oh2KTNWccWaXjyBMWB/cPBjNjWXfrcfkuKjEoGV3CDb+vId8hWp/YqbXA
         2segRdKbJ0m81tAlV9wWIdZ6yMfmJ2JdCfuYUHLktD+lxZBNzjQ+V3KexDTTMzE9FnG0
         y7Ng==
X-Forwarded-Encrypted: i=1; AJvYcCU2+ccV4IhQ4hvU1AMhi+Ebg+btdYNJvKvcIOqxMf1HCtUVwZp5zEUCTU7crUEp6op7w4xIjzUYaYKXxps=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywj95LJIZaTZKiJGPWOT2qKMKNS8jT0TtAfNc8BpPCfsWGZPOJU
	N0nY+xh9sZrN64q62IippTE6pptTrLc/DdDdSrp82YcnFF8dAf2gh0cD
X-Gm-Gg: ATEYQzzNHKg2YdM0QiBV28Kx49zB/9RCkq5wvnocuuH8w8OvFwq1zxfKzUdgzh1q3Ym
	JLPUDRnCfdFJagRV//BrvYlmF6TNRMK5P6aep6PfRaQ+UuFuZDKhLoUQnGLhxURZ2laZYJsrf1H
	Aj/R30powDrYyT3kMTj5RK/h9PvOwIKsrnROjy3t6RvTfeb8w8IDJs6qGFPI6FKZ9wcfSp09pt/
	dww8+ATP1plgN3bp1f7fqkZZftj2BjiFSq2xZNGoYLmcQST+nMmJJnTDdjF/9MOJh5e2x/QVODL
	x8Z/20MBjd5uSKe1j/rOgFzpJEfh/xIFLVLuqmmzK1qA3Fh06gZUuQBeQLfl9jWP7XFV7OJFm41
	+nZkR1gi+r2/Hw3sbS0Yv2+YVEKynTnWnuflt/64dN2s5bO7ieKEdas+ezEK1t4Td5XB8uoh99W
	pr2PV/MaEU9PZ2uqDyYmDWEA==
X-Received: by 2002:a17:902:e809:b0:2ae:4150:3118 with SMTP id d9443c01a7336-2b0cdc3b9d9mr146889945ad.12.1774922835833;
        Mon, 30 Mar 2026 19:07:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24264256asm93998405ad.13.2026.03.30.19.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 19:07:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, arnd@arndb.de, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v4] char/nvram: Remove redundant nvram_mutex
In-Reply-To: <20260330103530.6873-1-venkat88@linux.ibm.com>
Date: Tue, 31 Mar 2026 07:19:54 +0530
Message-ID: <qzp0n4xp.ritesh.list@gmail.com>
References: <20260330103530.6873-1-venkat88@linux.ibm.com>
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

Venkat Rao Bagalkote <venkat88@linux.ibm.com> writes:

> The global nvram_mutex in drivers/char/nvram.c is redundant and unused,
> and this triggers compiler warnings on some configurations.
>
> All platform-specific nvram operations already provide their own internal
> synchronization, meaning the wrapper-level mutex does not provide any
> additional safety.
>
> Remove the nvram_mutex definition along with all remaining lock/unlock
> users across PPC32, x86, and m68k code paths, and rely entirely on the
> per-architecture nvram implementations for locking.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> ---
> v4:
>   - Remove all remaining nvram_mutex call sites, completing the mutex removal
>

Let me cut paste the review from Sashiko here..

    Does this removal expose the underlying raw spinlock to concurrent userspace
    contention?
    Looking at ppc_md.nvram_sync() implementations like core99_nvram_sync() on
    PowerMac, the code acquires a raw spinlock (nv_lock) and performs hardware
    flash memory operations with polling loops and udelay() calls that can take
    hundreds of milliseconds to complete.
    Because IOC_NVRAM_SYNC does not require CAP_SYS_ADMIN, any user with access
    to the device can call this ioctl.
    Previously, nvram_mutex provided a sleepable barrier for concurrent
    IOC_NVRAM_SYNC callers. Without it, won't secondary callers spin on the raw
    spinlock with interrupts disabled for the entire duration of the first
    caller's slow flash I/O?
    Could this prolonged spinning with IRQs disabled completely freeze the
    waiting CPUs and trigger NMI watchdog timeouts or system lockups?

First of all the above problem is only being talked about PowerMAC and
not for x86 / m68k. In there I think, we just read/write few bytes under
the spinlock.

On PowerMac too, I don't think the above problem gives a reason, to keep
a redundant locking at a generic wrapper layer which can affects other
platforms/archs. And the comment in PowerMac code above nv_lock says:
    // XXX Turn that into a sem
    static DEFINE_RAW_SPINLOCK(nv_lock);

So, it looks like Sashiko review comment can be ignored, and the patch
looks right to me, which kills the redundant mutex lock from here. So as
for this patch please feel free to add...

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

... But I would also let Chrisptophe comment from ppc32 / PowerMac perspective.

-ritesh


