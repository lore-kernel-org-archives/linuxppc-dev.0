Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302A1606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 03:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBI849yp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXDT26V0pz2xnn;
	Sun, 22 Nov 2026 14:04:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795316694;
	cv=none; b=ciebhqI5d++IGP12pXQa5x93jLNiw34j+T7nMTHoUg0HefNRkcpvWtgwQZnHcihanSQL35pxh+YZVzY7dKveBYHG11YBPCWs+yC/G4mtytJJKCDAgJl93ZjoaHLkn0VN0l8GUJTWrTCbca4ikmtKtapS+1evOMapDq4kT9i87lYNUjykx2sB6Dw2e4LKCVF3XgRCdrTZry9Nc56RBKSOP02UE4XvtWuQqpHxPx6qW06uJerkVPiKMHKDwKu4VDH7NjBqz7tfMjJCrfozlH33eTRPvo7/V+wVJheLgYBXIAPKA5qhVUYYx0dCVHTC41tnyLgP291vkGGMA+dMtbnTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795316694; c=relaxed/relaxed;
	bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=WIyT8NCH0STZJ/t9g2DJaCwreFpaxO5hfOjjZZI2kH+Al2QvqrMpfY7PjvLJYMX9vetexA/b/ZB03bH4oNe6C5R9pWUSw1xTOMSUhQEDO55bCZTzAA6D/0hBvmAS3R82GpgBCNUfC32sqewJ/Nvy7YL6/ATRtYB7MyBtORAhYs3I+dzR7inLI4FkxaOQqaOPqOzJvjuhcM8I/CrS2uIrFcHWg7BZ6yGzwvxQrSA0QTb3VAPSUJLo/iSU7rlJzr11MaL1UMt0My87WZvpRSa528beQUtwTXEyBvOBobZSTYX9M4AoW9N+seyvPO8uumd3hpCrdJ7tuSjzfe9EyqJrfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBI849yp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rBI849yp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com [IPv6:2607:f8b0:4864:20::1330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXDT20v4Hz2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 14:04:53 +1100 (AEDT)
Received: by mail-dy1-x1330.google.com with SMTP id 5a478bee46e88-3869f03af6aso968346eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2026 19:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795316691; x=1795921491; darn=lists.ozlabs.org;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=rBI849ypkKWqe4cfwWguAFiuDmcHMj0+Mv5XhHjlgBg8hvZFHcZIE/ZNRHKzy32KDa
         GMR46bMDAL3TR8YqTHLfAcu8W4ctkMuTJDdQv+wvLYYQa5rS6QzMS48/OOO3Im+aj1CD
         J3nltjyBbZSTd7xJS1Pv8/T7YUUkR67e5xSGrWdVxDJP2a5w0XscbSqiA4yvRf5Gn2g+
         m19OMWzkwIk7rbnP1cebZTXM0KquNRaaGMo7/Tji81r29oeM3hrS6E2ICKMi2dJdCFmc
         StsG+4rY3Q/d+ZPY40FVMSX0/WD/lG8s6/joqEgl+P+nWbon5bfcSp1bU8TGK88rdwcl
         polQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795316691; x=1795921491;
        h=content-type:mime-version:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NieCLCvG+gDw8VjVQsEmj+Xb3Nuvde1xSdj6TYYBmIA=;
        b=GTYiVArJS/RQOsxXyFF8RXmcPAY/tWwqJrA+dkxQ7n1occQA3Hux55tjYKA6pNXS3/
         a1oppaVSIO6HAoyfJQ5rxfucgLK32fwMTFLrjUNtYn3OaD0BwgGkLq8ytfYqbLfzFk1O
         8DS4XbMDy4tK4QW01YnrLtJ1fDdXYvQPsocd/6SUADhCW/nGFEMrsMqDslV/gAs5tz4n
         T1sDnX/Q8YIGM18CZUnQYI7xCM/QzKRzcpIQ4wRqffnqiceDTXob3ZWP1XjMdh52rIPt
         SaIUqZedI7zjI05p941otnWnSUHvLpRnVbQ5ZoX2T+cTZRLyXiopyTItphvBHmgZFDcI
         MVAQ==
X-Forwarded-Encrypted: i=1; AL+hErHV71snSaEwBdx9cLJvUh4oRvpgyx3N1Nz7w+mCILGAa6kM+TrlRf1h5NExoN50z8tWX/Rf1k7XNpc4XoI=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/JaM1+sUwxvNcvCjd7eg1BlX9QEpjn4a5HxjhIWFm5V1awQAa+
	o2imMAlNu/I4K1d2zqU5Grz+p0nkJRe6aNVEX6pLBjqAFFePKex9RJbS
X-Gm-Gg: AZFdTZdP2fimE9OuMi5udQvy0gZxrXicBpRqhaW/L/WGZMX1s2g5MnWef4xcGVuscL3
	4oT3kU2UsCDE+8XhUMeedpQobMdJJOI7VqoPFXKI4Hc3/NKevS5HDVb49UXMqvN7Nos+WB7oKOI
	SDhDlSBOTTNDDhnzsMA1RvECAn9OJwarbcAt5V1Rz/sqb1NPCvod8EWzhV35woRApdp58l+BYlJ
	i7se3ZE2IXOR6fsPuKyfsFhdY1RttGHQohmcXhWnX2DJAYbMLlbgKqBB2LKIb5vztNntIxEBGJN
	f4MzggqrQNjfpxSWpiFUIztG1hD7lcYPBKHDwXJNnXznnD+UbsAqknHmy0uyXewbqrox2uGX355
	+ubMcmNUV7vx8INE6BaY5ZMkv5gVPPL613GF3qkQx0+jLwP96zij4cNcdxG9q1c48hFyNCTrWge
	5a9XvhXv2yJzCJoEzuU0Qk91xgRli6db6AgIp6ZlvE+Gu5pi77FW9i31e/fTKLK3foaVIIavNRl
	9OkHGRcku8A1B0TzWaNPEYUldrdZYyUYYmMRjIb5saFIxMqFvIKejqilv61f8bGN4rJnsP63Hs2
	Ef9N32nPjQWE1f0BFxJfZ3np3dhVgaEgTu5QYYfEBDYjo1Iw
X-Received: by 2002:a05:7300:50fa:b0:383:9f52:e54d with SMTP id 5a478bee46e88-3856ff52e83mr8869235eec.8.1795316691531;
        Sat, 21 Nov 2026 19:04:51 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm24302948eec.27.2026.11.21.19.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:04:50 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Rich Felker <dalias@libc.org>, 
	Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Cc: Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Sun, 22 Nov 2026 08:33:10 +0530
Message-ID: <wlq5k1ox.ritesh.list@gmail.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org> <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
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
Content-Type: text/plain
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Mike Rapoport (Microsoft)" <rppt@kernel.org> writes:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

No function change observed in this patch (as described in the commit msg).

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc


