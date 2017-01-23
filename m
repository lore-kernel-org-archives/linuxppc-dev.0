Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6Ldy1rq0zDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:15:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, rtd@a-eon.com, aperez@alexperez.com,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [PATCH] powerpc/pasemi/nemo: Fix low memory values for boot.
In-Reply-To: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
References: <49760dd82b0.759fd78a@auth.smtp.1and1.co.uk>
Date: Mon, 23 Jan 2017 17:15:33 +1100
Message-ID: <87h94qb8u2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Darren Stevens <darren@stevens-zone.net> writes:

> Commit 5c0484e25ec0 ('powerpc: Endian safe trampoline') added a
> macro 'FIXUP_ENDIAN' to head_64.S. The CFE on Nemo has a bug 
> that shows up when this is included, the system hangs right after
> printing the initial memory map, before the CPU's are started.
>
> Clearing the long long at addr 8 has been shown to fix this, so
> add an initalisation to head_64.S so the system will boot.

I'd really prefer it if someone could tell me why we need to clear it.
But I assume no one knows?

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 1dc5eae..032b317 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -79,6 +79,13 @@ _GLOBAL(__start)
>     /* NOP this out unconditionally */
>  BEGIN_FTR_SECTION
>     FIXUP_ENDIAN
> +#ifdef CONFIG_PPC_PASEMI_NEMO
> +   /*
> +    * Zero address 8 so Nemo will boot
> +    */
> +   li  r0,0
> +   std 0,8(0)
> +#endif
>     b   __start_initialization_multiplatform
>  END_FTR_SECTION(0, 1)
 
I don't want to pollute this code with NEMO workarounds if we can avoid
it.

You said the hang happens after printing the initial memory map, I'm not
quite sure where you mean, but it sounds like that will be late enough
that we can do the clear in pasemi platform code?

cheers
