Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 63296DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 01:13:55 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so675146ywt.39
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 08:13:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241560385-26868-1-git-send-email-timur@freescale.com>
References: <1241560385-26868-1-git-send-email-timur@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 14 May 2009 09:13:33 -0600
Message-ID: <fa686aa40905140813l5caf7085r64bce935be0a22d3@mail.gmail.com>
Subject: Re: [PATCH v7] introduce macro spin_event_timeout()
To: Timur Tabi <timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 5, 2009 at 3:53 PM, Timur Tabi <timur@freescale.com> wrote:
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
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

This version looks good to me.  Who's the first user? (I'd like to see
that something is ready to use this before merging it)

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>
> v7: add if-statement to use cpu_relax() if the delay is 0. =A0gcc will op=
timize
> out the if-statement if 'delay' is a constant.
>
> I'm making this a PowerPC-specific patch because I want to use
> tb_ticks_per_usec, which does not exist on all other platforms. =A0I don'=
t want
> to use jiffies because jiffies works only when interrupts are enabled, an=
d
> the resolution may not be fine enough.
>
> =A0arch/powerpc/include/asm/delay.h | =A0 32 ++++++++++++++++++++++++++++=
++++
> =A01 files changed, 32 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/asm/=
delay.h
> index f9200a6..2bde26f 100644
> --- a/arch/powerpc/include/asm/delay.h
> +++ b/arch/powerpc/include/asm/delay.h
> @@ -2,6 +2,8 @@
> =A0#define _ASM_POWERPC_DELAY_H
> =A0#ifdef __KERNEL__
>
> +#include <asm/time.h>
> +
> =A0/*
> =A0* Copyright 1996, Paul Mackerras.
> =A0*
> @@ -30,5 +32,35 @@ extern void udelay(unsigned long usecs);
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
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
