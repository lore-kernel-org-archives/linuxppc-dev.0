In-Reply-To: <927068331.20040827153454@varma-el.com>
References: <927068331.20040827153454@varma-el.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <87957638-F833-11D8-994C-000393DBC2E8@freescale.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [RFC] Remove G2_LE core decl from CLASSIC_PPC part of arch/ppc/kernel/cputable.c
Date: Fri, 27 Aug 2004 09:15:20 -0500
To: Andrey Volkov <avolkov@varma-el.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What purpose does this change really serve.  Linux does not use the
true little-endian feature of the G2_LE core, beyond that it is very
much in the class of classic ppc.  Is the memory savings really that
much?

- kumar

On Aug 27, 2004, at 6:34 AM, Andrey Volkov wrote:

>
> Hello all,
>
> Since G2_LE is NOT a "classic" core ( in particular - true
> little-endian),
> may be now is time to remove it from CLASSIC_PPC part of
> arch/ppc/kernel/cputable.c, and move it to itself part.
> I bear in mind next:
>
> from arch/ppc/kernel/cputable.c:
>
> #if CLASSIC_PPC
> .....
>     {   /* All G2_LE (603e core, plus some) have the same pvr */
>         0x7fff0000, 0x00820000, "G2_LE",
>         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
>         CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
>         COMMON_PPC,
>         32, 32,
>         __setup_cpu_603
>     },
> ....
> #endif /* CLASSIC_PPC */
>
> May be better like this:
>
> #if CONFIG_G2_LE
>     {   /* All G2_LE (603e core, plus some) have the same pvr */
>         0x7fff0000, 0x00820000, "G2_LE",
>         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
>         CPU_FTR_CAN_NAP | CPU_FTR_HAS_HIGH_BATS,
>         COMMON_PPC,
>         32, 32,
>         __setup_cpu_603
>     },
> #endif
>
> With that move we'll conserve some memory of kernel,
> but need some explanations which PPCs based on
> it, for modify Kconfig ( I know MPC52xx and MPC82xx based on it).
>
> --
> Best regards,
>  Andrey Volkov
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
