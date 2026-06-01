Return-Path: <linuxppc-dev+bounces-21779-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DC5CD6E4C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:12:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTRWn0sG1z2xqn;
	Mon, 01 Jun 2026 18:12:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.222.43
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780301525;
	cv=none; b=djPcXb69yqrrG4r3KW+rG0PgOUCJiayky9usvRq0KkoLAc+3VV7gEqQr7OPWlP4s/2bWSrnwkdgW//nS+QJpwwHuk2NopMNScYrbbMuZFZN2PeWA3m8BvY4r1dqRKelwX+nQxtyitFsvK3TMD7mm3tWU8eeZvvA/eDjRwhfmWyl1K/Y+5DLFIJ4cmnClfHjVk5BZ/I7DZHSNTReFirjuuBS2/EbY0bOx3k4dxrOECIj2SP3hV9miME/CSsYsdzJ6iBxCW+U0ojioJF4NfloPESZrV9OmTB5GKKCEcclAVt4azmqIl7S8IRvKiz5/fQAnGiGaE0qJ++IkoE6hHFZD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780301525; c=relaxed/relaxed;
	bh=Z6bsjRyMlYCGVZWYk2Y60sUCqRedkIR0Vi6kAvx0wUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMqt87k7XWjJk8QF+/4adGspoR4JJc+E/WxJ+pbbscTK7/L37L9Y4aymXyXYVL+7tIrWsdN2kw9e09ws59SXzOsR3FVSuyA7WX+boabOqoOgsANyIcqa40gRTRrsoSb1fUYJjrNaX95JDoUU1UdReIODQZiwcwsJ93Ub/6AzpFb7XO7TmAtG5jAxwpMpcdIPdG3MJQGKBOh/OAZMz20MPukZwNe3jJ2lEezMEMnLipAktkpqs64YVkJreDOchxq64gByEY68Z74TrZOuxi10vv5DGMh2gNoVKY5mzLE7wpuMx3fow23j3CAo+KjMlInjACxjISgaWWVcoVu2ApNX4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass (client-ip=209.85.222.43; helo=mail-ua1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.222.43; helo=mail-ua1-f43.google.com; envelope-from=geert.uytterhoeven@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTRWl1lPkz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 18:12:02 +1000 (AEST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9639d7daff3so2262495241.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 01:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780301519; x=1780906319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6bsjRyMlYCGVZWYk2Y60sUCqRedkIR0Vi6kAvx0wUs=;
        b=eyD6HJM0CHx0OlF2jdCYGgzUwtH0g4dUlsq8vB4IP35j5zJ0nRW+AiPkwM3QWi38yq
         bRyVGX36b8FJusJPLlHM7Hr7GItWJek1pS3uqON3EzTX9dAxSwFo00aVjhDagPCrVVLF
         ZgRaUVj5WBg5mU1QvnYWwi0PJ9nrffvfImomcilomw9v0FnPDEWhyTDnKcMUQ9UQ4bcW
         35T2MtzQJ30APv/qPoQKM12O9odTeNdNgOydJSN+87+xSwXYorYLwlMmn2ZQc/O1brRS
         YudMZ+nUE14kvgA4nEjxvsQI/VS8NZpUtKL9QI38hF74Yd566luIH+qaiRm7wRISK9jY
         b6Hg==
X-Forwarded-Encrypted: i=1; AFNElJ+sDpqgbI4l5r4XDp3bx3263P93jHLNJd5ucb8e330z/BPCyqY1RxXkMeeWtlXTZpp6K1HA7+VDcBQnTg4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzWINxjSbskdUSfWP0kbPffYizwCRwu+GA6ydKrRwkv2TdYlaD4
	RoH/XvdaPQNAG0/xI4FzccAYv7PpEFzX/JCLY0QrCiyggQ8qj4LWFNzPEUnv1ox+
X-Gm-Gg: Acq92OGDdRCYHIzhtqgAoCpa1zMzcbue8hBOezg8R3YcPNkvX6xZy+GU4NNMuVHl9Kt
	WUyiYHLpf64cHAq8FgEJZue2cQaMbNsXJzTbxD+7yzkyq1uC0fzjE1vPH0js+9FK/3FfrWJkAUJ
	yCAO4P/2bOkYJMjGs+AnXNj+tl4Y8bUK4+ZdhgDErbM+DpHSuSTZpJQ5e5w49vyt0gO/6Pwvrad
	kWzqU6HVGWNTs2FoWWoOWwRINgKY/IMvagjKOBml25RqwD45OWCYMh/ubdZRT4FmGivEXWH9YEy
	9cfhWwqP5l2+iHb4iiCictyXoTjIKa1Ho+n1/WWz8ebOFCMT1R7iB0SFbiP8/TwL4Cur7rb+UI+
	8n4as60oYvFz/hIN3VCjS1IYYQCAnVpaYj0qVYxUWntHOHK9FXrjXicGvB1ev7HTHoo5Enme7sz
	jX0cgaYm7RmsZx+tuAhOQYr3DGd5etfqmPZsFbgh97l4QlE2ud2gyQE4P/1UH/m62SJw286/0=
X-Received: by 2002:a05:6102:4194:b0:631:2a82:111f with SMTP id ada2fe7eead31-6c6849db841mr4077985137.17.1780301518787;
        Mon, 01 Jun 2026 01:11:58 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963aba26091sm5576967241.1.2026.06.01.01.11.58
        for <linuxppc-dev@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 01:11:58 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-963d7e5ffddso598804241.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 01:11:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VrJiJjvGRmFe5u+45cDvdCvXQvFrtjP6VEuZRnuN7bQ+70V47t7MD/Oz6Lq8o5kSTh2ri7EonMGH/EhY=@lists.ozlabs.org
X-Received: by 2002:a05:6102:3ed4:b0:639:4bb7:c916 with SMTP id
 ada2fe7eead31-6c67682807bmr3734166137.3.1780301518249; Mon, 01 Jun 2026
 01:11:58 -0700 (PDT)
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
References: <20260529150150.1670604-17-ardb+git@google.com> <20260529150150.1670604-29-ardb+git@google.com>
In-Reply-To: <20260529150150.1670604-29-ardb+git@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Jun 2026 10:11:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXp0qp38vHJTDFMrY-AUDXPSJtc5Dds_qu58FSeS_242w@mail.gmail.com>
X-Gm-Features: AVHnY4I0grL2HGASleAgF6ybT4VX0NqDy8gokQJ4KkNhvH_ouOMg7ryFWIbyvcA
Message-ID: <CAMuHMdXp0qp38vHJTDFMrY-AUDXPSJtc5Dds_qu58FSeS_242w@mail.gmail.com>
Subject: Re: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, 
	Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 May 2026 at 17:02, Ard Biesheuvel <ardb+git@google.com> wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> SuperH performs cache maintenance on the zero page during boot,
> presumably because before commit
>
>   6215d9f4470f ("arch, mm: consolidate empty_zero_page")
>
> the zero page did double duty as a boot params region, and was cleared
> separately, as it was not part of BSS. The memset() in question was
> dropped by that commit, but the __flush_wback_region() call remained.
>
> As empty_zero_page[] has been moved to BSS, it can be treated as any
> other BSS memory, and so the cache flush can be dropped.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

