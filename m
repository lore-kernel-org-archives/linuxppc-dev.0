Return-Path: <jwboyer@gmail.com>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A81FA2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2012 22:16:32 +1000 (EST)
Received: by vbbfn1 with SMTP id fn1so4866777vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Oct 2012 05:16:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120930232723.GF30637@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
Date: Mon, 1 Oct 2012 08:16:29 -0400
Message-ID: <CA+5PVA767HNZUoFNj=UubLCdh91EtWiuK2JaY2qarMn=oCCB+A@mail.gmail.com>
Subject: Re: [PATCH] PPC: Enable the Watchdog vector for 405
From: Josh Boyer <jwboyer@gmail.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 30, 2012 at 7:27 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> Move the body of the PIT exception out of line to make room.

What boards did you test this on?  What driver are you using for the
watchdog?

> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  arch/powerpc/kernel/head_40x.S |   26 +++++++++++++-------------
>  arch/powerpc/kernel/traps.c    |    2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
> index 4989661..7edd7b1 100644
> --- a/arch/powerpc/kernel/head_40x.S
> +++ b/arch/powerpc/kernel/head_40x.S
> @@ -431,29 +431,19 @@ label:
>
>  /* 0x1000 - Programmable Interval Timer (PIT) Exception */
>         START_EXCEPTION(0x1000, Decrementer)
> -       NORMAL_EXCEPTION_PROLOG
> -       lis     r0,TSR_PIS@h
> -       mtspr   SPRN_TSR,r0             /* Clear the PIT exception */
> -       addi    r3,r1,STACK_FRAME_OVERHEAD
> -       EXC_XFER_LITE(0x1000, timer_interrupt)
> +       b pit_longer
>
> -#if 0
>  /* NOTE:
> - * FIT and WDT handlers are not implemented yet.
> + * FIT handler is not implemented yet.
>   */
>
>  /* 0x1010 - Fixed Interval Timer (FIT) Exception
>  */
> -       STND_EXCEPTION(0x1010,  FITException,           unknown_exception)
> +//     STND_EXCEPTION(0x1010,  FITException,           unknown_exception)

Please just move the #endif for the #if 0 up instead of putting a C++
style comment here.

>  /* 0x1020 - Watchdog Timer (WDT) Exception
>  */
> -#ifdef CONFIG_BOOKE_WDT
>         CRITICAL_EXCEPTION(0x1020, WDTException, WatchdogException)
> -#else
> -       CRITICAL_EXCEPTION(0x1020, WDTException, unknown_exception)
> -#endif
> -#endif

Please leave this wrapped in CONFIG_BOOKE_WDT.  I don't agree with
unconditionally enabling this for every 405 chip out there.

>  /* 0x1100 - Data TLB Miss Exception
>   * As the name implies, translation is not in the MMU, so search the
> @@ -738,6 +728,16 @@ label:
>                 (MSR_KERNEL & ~(MSR_ME|MSR_DE|MSR_CE)), \
>                 NOCOPY, crit_transfer_to_handler, ret_from_crit_exc)
>
> +       /* Programmable Interval Timer (PIT) Exception. The PIT runs into
> +          the space reserved for other exceptions, so we branch down
> +          to here. */
> +pit_longer:
> +       NORMAL_EXCEPTION_PROLOG
> +       lis     r0,TSR_PIS@h
> +       mtspr   SPRN_TSR,r0             /* Clear the PIT exception */
> +       addi    r3,r1,STACK_FRAME_OVERHEAD
> +       EXC_XFER_LITE(0x1000, timer_interrupt)
> +
>  /*
>   * The other Data TLB exceptions bail out to this point
>   * if they can't resolve the lightweight TLB fault.
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index ae0843f..0701ec1 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1514,7 +1514,7 @@ void unrecoverable_exception(struct pt_regs *regs)
>         die("Unrecoverable exception", regs, SIGABRT);
>  }
>
> -#ifdef CONFIG_BOOKE_WDT
> +#if defined(CONFIG_BOOKE_WDT) | defined(CONFIG_40x)

Pretty sure you meant || here?  Thought if you just enable the existing
config option, I don't think you'd need to edit this file at all.

josh
