Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id C8188DE10E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 03:46:49 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1738599qwe.15
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 10:46:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242761199-17875-2-git-send-email-timur@freescale.com>
References: <1242761199-17875-1-git-send-email-timur@freescale.com>
	<1242761199-17875-2-git-send-email-timur@freescale.com>
Date: Mon, 25 May 2009 13:46:47 -0400
Message-ID: <9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
From: Jon Smirl <jonsmirl@gmail.com>
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 19, 2009 at 3:26 PM, Timur Tabi <timur@freescale.com> wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters. =A0It spins until either the condition i=
s true
> or the timeout expires. =A0It returns the result of the condition when th=
e loop
> was terminated.
>
> This primary purpose of this macro is to poll on a hardware register unti=
l a
> status bit changes. =A0The timeout ensures that the loop still terminates=
 if the
> bit doesn't change as expected. =A0This macro makes it easier for driver
> developers to perform this kind of operation properly.


I just tried using this. The !rc has the effect of making the error
return be zero instead the normal not zero.

	/* Wait for command send status zero =3D ready */
	spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
	if (rc =3D=3D 0) {
		pr_err("timeout on ac97 bus (rdy)\n");
		return -ENODEV;
	}

I want the register to be zero, would this be more obvious?

	/* Wait for command send status zero =3D ready */
	spin_event_timeout((in_be16(&psc_dma->psc_regs->sr_csr.status) &
				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
	if (rc !=3D 0) {
		pr_err("timeout on ac97 bus (rdy)\n");
		return -ENODEV;
	}


>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> v8: added a copyright notice
>
> =A0arch/powerpc/include/asm/delay.h | =A0 33 ++++++++++++++++++++++++++++=
+++++
> =A01 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/=
delay.h
> index f9200a6..af4a270 100644
> --- a/arch/powerpc/include/asm/delay.h
> +++ b/arch/powerpc/include/asm/delay.h
> @@ -2,8 +2,11 @@
> =A0#define _ASM_POWERPC_DELAY_H
> =A0#ifdef __KERNEL__
>
> +#include <asm/time.h>
> +
> =A0/*
> =A0* Copyright 1996, Paul Mackerras.
> + * Copyright (C) 2009 Freescale Semiconductor, Inc. All rights reserved.
> =A0*
> =A0* This program is free software; you can redistribute it and/or
> =A0* modify it under the terms of the GNU General Public License
> @@ -30,5 +33,35 @@ extern void udelay(unsigned long usecs);
> =A0#define mdelay(n) =A0 =A0 =A0udelay((n) * 1000)
> =A0#endif
>
> +/**
> + * spin_event_timeout - spin until a condition gets true or a timeout el=
apses
> + * @condition: a C expression to evalate
> + * @timeout: timeout, in microseconds
> + * @delay: the number of microseconds to delay between eache evaluation =
of
> + * =A0 =A0 =A0 =A0 @condition
> + * @rc: the last value of the condition
> + *
> + * The process spins until the condition evaluates to true (non-zero) or=
 the
> + * timeout elapses. =A0Upon exit, @rc contains the value of the conditio=
n. This
> + * allows you to test the condition without incurring any side effects.
> + *
> + * This primary purpose of this macro is to poll on a hardware register
> + * until a status bit changes. =A0The timeout ensures that the loop stil=
l
> + * terminates even if the bit never changes. =A0The delay is for devices=
 that
> + * need a delay in between successive reads.
> + *
> + * gcc will optimize out the if-statement if @delay is a constant.
> + */
> +#define spin_event_timeout(condition, timeout, delay, rc) =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 \
> +{ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 \
> + =A0 =A0 =A0 unsigned long __loops =3D tb_ticks_per_usec * timeout; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 unsigned long __start =3D get_tbl(); =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 while (!(rc =3D (condition)) && (tb_ticks_since(__start) <=
=3D __loops)) \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (delay) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(delay); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax(); =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> +}
> +
> =A0#endif /* __KERNEL__ */
> =A0#endif /* _ASM_POWERPC_DELAY_H */
> --
> 1.6.0.6
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Jon Smirl
jonsmirl@gmail.com
