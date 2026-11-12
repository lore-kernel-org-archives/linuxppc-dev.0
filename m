Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59884606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 19:08:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQVKP2jxmz30gC;
	Fri, 13 Nov 2026 06:08:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.217.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794510505;
	cv=none; b=AP0Sbwvo4u4vdN0UdY+Y8O8t9Fji9s9VQhb6bf6BnxR7w+bWzNnjLnfq4p/RrRmBhojk9O6lFAr9AB0xVP/1viNdw2DNlrR1ykEJ77ENUGDU7hcvNXkeaVE4Ut49kf0ajTxjfTnkSBVhM7NIWjdGW02KWySjBYKvx8PsKfeFj4s8lsSAlLeF7N3gab0/R82Mmxj/4N860D8adrZwrAEEehOy5n+YjCtve/RD8g4rrQQmG/3I0Z+BKX4BfLFGFlCNbQi8vV6s4wAnAdKJZ1KGdAICB40uDT1kbfdV5PrE5f5tf9Lf5pHrNtp+9f3dcWCg0CBYW1zARtcrFHWJOx5FqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794510505; c=relaxed/relaxed;
	bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XC2qOwKOhbwU+uCffQ8MUU1wcknG/O5UvBfMA5FYDhWLy2+wwIHhoURGfpuBoSt+VhOS1naDevnNksmPOeCF90kIK9IMo3L/3WUxS9igWAoE2mgx66sZJSX8pvv82LTOlFWC13MxBoxYWICciaqZxlUiw88CDm/omXjG192pvte1R2uH+pQGHennfnh1QHi5rPUv/Uf7XpB5+LNyQUP33ACQ3JEOs70nsB0+cWAzAzMpfxsEw5UV6lTOIS2dNKN/mYicUr6MXNEPltHH+urdweG1tn7wKIyDmTO9xN/VhE90qmT9trSe7mPCq+S7L74N4KaAXbZI1CQKP8c3FIhWFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.217.50; helo=mail-vs1-f50.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.217.50; helo=mail-vs1-f50.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQVKN1Cf5z30g6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 06:08:23 +1100 (AEDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7d2dc9a7b52so49200137.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794510499; x=1795115299;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x7avfF8CE7MQkedzx8waSCJsEYoj4qczcsv6b4mLDHA=;
        b=zHOl809lDCbU+hgZk1y97CogA4Ita72E4CgCqef1eADgUnFB38u4p7tq7aYzbSQFaa
         KAvOt7QC0YNdKK1TiH4vX9bU9aSgA7C9WeW56xKqWPE/cnvW2JAuHgGWPQcbZ0SYRNSt
         CFPGs9jiXGt14anREubkQqVofouoSSFkc3KykOuFHS9t9QLcpfUa242gXPaOsEoeoBcC
         ZvWYWIrV0iof9dMvoBYc076dKOOhLe+S+6SIJQACqCYw2oZx9qPIiF/LzJAAqXF9O1xf
         1jy1u42gUnkgF6EJA0t4XXmUhtMAs2ZVsW+3OAn1818FQ9yFckstYb9ww9fSjZOVe9SO
         hDyQ==
X-Forwarded-Encrypted: i=1; AL+hErG4NuWpcBC/9JcmXkEqQeQBXuwoi8EUMYf5RnSurfenQ4en+Lv2qTrwB+Ws9YgaNP/iWT9q5i1BZHXNhkA=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8rOeMWiwdroH234Ko4fEqC1jFyxpo6qr7hYjA1Iz6Hl6aGg4EQ
	7606Xg5Nw+pCeabfr4gCuP9m4a3oXzC2zEY67iDOHy2r84eU6QOYZG2JWkpe1U5joRo=
X-Gm-Gg: AYBFou1rvgQguE5bHXyI3t1WUhVxMXdNIVg5mlQReK7K4Kh4CWxYpvmXmaSf1pujTFO
	331B/sVhm4NmMk9MevmzZm1zLwSxeoxRTawMAYKKdcLeakohMukUNtG2QAeaTSLK64+5dkL9TLv
	rM7uxMnipomjTZf2rYByijm6B7upiV2d2c6wIvhfurnzb0B90+pwGyy7mhtvhIhKpHl9uYge6kw
	lG5ZbjJ6QKYhQEbMg79yrqXVjpqMKnhTksYdAtL1BvIC4EzqeaHAdj0ncihvFjBOjcH92PjqdzF
	AjSVhzvU9iGHAvo1cZm5RqgD+HCrHAEQYjcEviBAC6GeZ4ZV270+SqH5rhdHTzzUqfwjnnLpHYI
	vXcy05/KIRyfSi0TZiw4DzX1V1pnkdrrlUxPVthBNuHOWChFEnyiNKSQVRSGjmSn8RHrsWGj7Xf
	rMUNElZt/H10JwtfdlH2CaBcHQBhGpfNsjJCb/O/xEcWO9tyuJZhRw0dXwwjs+5Yv7Rs+Zpxuvy
	8Rg3AVUX95pVrgFG3mnOl9ya6WjKlSPa7qXNgXwpyrE1epavJ8j4N8wgULe8M9JpPuW+dI101L/
	oHvmXZn7YSMh94sPs820Gch0g1/ssXHdjouajJ3M+kcGcbSlAUcVMaJiYn+CNLRGO1s=
X-Received: by 2002:a05:6102:6f08:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d64d7ca46bmr53964137.20.1794510499385;
        Thu, 12 Nov 2026 11:08:19 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8424fb84sm270968241.4.2026.11.12.11.08.02
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:08:07 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-99c0c1d07feso131023241.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 11:08:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEjGFdQBhvMa5swKnjjIIHAPPSBIH7/11mYpfaZ2X6GtUSCneN/EDR48E8Fr30q6+AjA2s35jhmKdKQ2lQ=@lists.ozlabs.org
X-Received: by 2002:a05:6102:c15:b0:7d2:8dd0:2eb with SMTP id
 ada2fe7eead31-7d64d6ed886mr73919137.8.1794510481935; Thu, 12 Nov 2026
 11:08:01 -0800 (PST)
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
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org> <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2026 20:07:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
X-Gm-Features: AclHuK8l5OcVstuPYNpoHJ657hIuMQK5i9ySH9sE9lHb16H-lVuh0fnzCqi0JCs
Message-ID: <CAMuHMdUgOGjwOUMxSabUgtaVeKZW1wx78XOJL8joGKkZEj7RZw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in copy_oldmem_page()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, 
	Chris Mason <mason@kernel.org>, Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, 
	kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 at 17:43, Christian Brauner <brauner@kernel.org> wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>
> Return -ENOMEM like the other architectures do. read_from_oldmem() turns
> that into -EFAULT like any other short copy.
>
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

