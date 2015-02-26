Return-Path: <ddaney.cavm@gmail.com>
Received: from mail-ie0-x232.google.com (mail-ie0-x232.google.com
 [IPv6:2607:f8b0:4001:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7222D1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 09:43:28 +1100 (AEDT)
Received: by iecrl12 with SMTP id rl12so22428239iec.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 14:43:24 -0800 (PST)
Message-ID: <54EFA189.3010509@gmail.com>
Date: Thu, 26 Feb 2015 14:43:21 -0800
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
References: <54EB735F.5030207@upv.es>
 <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>
 <20150223205436.15133mg1kpyojyik@webmail.upv.es>
 <20150224073906.GA16422@gmail.com>
 <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 Hector Marco Gisbert <hecmargi@upv.es>, LKML <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 ismael Ripoll <iripoll@upv.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/26/2015 02:38 PM, Andrew Morton wrote:
[...]
>
> From: Andrew Morton<akpm@linux-foundation.org>
> Subject: fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
>
> Consolidate randomize_et_dyn() implementations into fs/binfmt_elf.c.
>
> There doesn't seem to be a compile-time way of making randomize_et_dyn()
> go away on architectures which don't need it, so mark it __weak to cause
> it to be discarded at link time.
>
> Cc: "H. Peter Anvin"<hpa@zytor.com>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Hector Marco Gisbert<hecmargi@upv.es>
> Cc: Hector Marco-Gisbert<hecmargi@upv.es>
> Cc: Ingo Molnar<mingo@kernel.org>
> Cc: Ismael Ripoll<iripoll@upv.es>
> Cc: Kees Cook<keescook@chromium.org>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Russell King<rmk@arm.linux.org.uk>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Will Deacon<will.deacon@arm.com>
> Signed-off-by: Andrew Morton<akpm@linux-foundation.org>
[...]
> diff -puN arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/include/asm/elf.h
> --- a/arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/include/asm/elf.h
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 20q12 ARM Ltd.

This particular change looks like it may be a typo.

>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
