Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ED2B12C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2013 10:46:43 +1100 (EST)
Received: from mail216-tx2 (localhost [127.0.0.1])	by
 mail216-tx2-R.bigfish.com (Postfix) with ESMTP id 013CD1400C4	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:46:39 +0000 (UTC)
Received: from TX2EHSMHS009.bigfish.com (unknown [10.9.14.239])	by
 mail216-tx2.bigfish.com (Postfix) with ESMTP id D852F4009C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:46:37 +0000 (UTC)
Date: Mon, 18 Mar 2013 18:46:32 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] powerpc/mpic: add global timer support
To: Wang Dongsheng <dongsheng.wang@freescale.com>
In-Reply-To: <1362728327-21013-2-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Fri Mar  8 01:38:46 2013)
Message-ID: <1363650392.27435.22@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2013 01:38:46 AM, Wang Dongsheng wrote:
> The MPIC global timer is a hardware timer inside the Freescale PIC =20
> comply
> to Open-PIC standard. When the timer is timeout of the specified =20
> interval,
> the hardware timer generates an interrupt. The driver currently is =20
> only
> tested on fsl chip, but it can potentially support other global timers
> complying to Open-PIC standard.
>=20
> The two independent groups of global timer on fsl chip, group A and =20
> group B,
> are identical in their functionality, except that they appear at =20
> different
> locations within the PIC register map. The hardware timer can be =20
> cascaded to
> create timers larger than the default 31-bit global timers. Timer =20
> cascade
> fields allow configuration of up to two 63-bit timers. But These two =20
> groups
> of timers cannot be cascaded together.
>=20
> It can be used as a wakeup source for low power modes. It also could =20
> be used
> as periodical timer for protocols, drivers and etc.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/include/asm/mpic_timer.h |   46 +++
>  arch/powerpc/platforms/Kconfig        |   12 +
>  arch/powerpc/sysdev/Makefile          |    1 +
>  arch/powerpc/sysdev/mpic_timer.c      |  606 =20
> +++++++++++++++++++++++++++++++++
>  4 files changed, 665 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/mpic_timer.h
>  create mode 100644 arch/powerpc/sysdev/mpic_timer.c
>=20
> diff --git a/arch/powerpc/include/asm/mpic_timer.h =20
> b/arch/powerpc/include/asm/mpic_timer.h
> new file mode 100644
> index 0000000..0e23cd4
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpic_timer.h
> @@ -0,0 +1,46 @@
> +/*
> + * arch/powerpc/include/asm/mpic_timer.h
> + *
> + * Header file for Mpic Global Timer
> + *
> + * Copyright 2013 Freescale Semiconductor, Inc.
> + *
> + * Author: Wang Dongsheng <Dongsheng.Wang@freescale.com>
> + *	   Li Yang <leoli@freescale.com>
> + *
> + * This program is free software; you can redistribute it and/or =20
> modify it
> + * under the terms of the GNU General Public License as published by =20
> the
> + * Free Software Foundation; either version 2 of the License, or (at =20
> your
> + * option) any later version.
> + */
> +
> +#ifndef __MPIC_TIMER__
> +#define __MPIC_TIMER__
> +
> +#include <linux/interrupt.h>
> +#include <linux/time.h>
> +
> +struct mpic_timer {
> +	void			*dev;
> +	struct cascade_priv	*cascade_handle;
> +	unsigned int		num;
> +	unsigned int		irq;
> +};
> +
> +#ifdef CONFIG_MPIC_TIMER
> +struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
> +		const struct timeval *time);
> +void mpic_start_timer(struct mpic_timer *handle);
> +void mpic_stop_timer(struct mpic_timer *handle);
> +void mpic_get_remain_time(struct mpic_timer *handle, struct timeval =20
> *time);
> +void mpic_free_timer(struct mpic_timer *handle);
> +#else
> +struct mpic_timer *mpic_request_timer(irq_handler_t fn,  void *dev,
> +		const struct timeval *time) { return NULL; }
> +void mpic_start_timer(struct mpic_timer *handle) { }
> +void mpic_stop_timer(struct mpic_timer *handle) { }
> +void mpic_get_remain_time(struct mpic_timer *handle, struct timeval =20
> *time) { }
> +void mpic_free_timer(struct mpic_timer *handle) { }
> +#endif

I'm not sure how useful these stubs are...

> +config MPIC_TIMER
> +	bool "MPIC Global Timer"
> +	depends on MPIC && FSL_SOC
> +	default n
> +	help
> +	  The MPIC global timer is a hardware timer inside the
> +	  Freescale PIC comply to Open-PIC standard. When the

s/comply to/complying with/
s/Open-PIC/OpenPIC/

> +	  timer is timeout of the specified interval, the hardware

s/timer is timeout of the specified interval/specified interval times =20
out/

> +	  timer generates an interrupt. The driver currently is
> +	  only tested on fsl chip, but it can potentially support
> +	  other global timers complying to Open-PIC standard.

s/to Open-PIC/with the OpenPIC/

> +static void convert_ticks_to_time(struct timer_group_priv *priv,
> +		const u64 ticks, struct timeval *time)
> +{
> +	u64 tmp_sec;
> +	u32 rem_us;
> +	u32 div;
> +
> +	if (!(priv->flags & FSL_GLOBAL_TIMER)) {
> +		time->tv_sec =3D (__kernel_time_t)
> +			div_u64_rem(ticks, priv->timerfreq, &rem_us);
> +		tmp_sec =3D (u64)time->tv_sec * (u64)priv->timerfreq;
> +		time->tv_usec =3D (__kernel_suseconds_t)
> +			div_u64((ticks - tmp_sec) * 1000000, =20
> priv->timerfreq);
> +
> +		return;
> +	}
> +
> +	div =3D (1 << (MPIC_TIMER_TCR_CLKDIV_64 >> 8)) * 8;
> +
> +	time->tv_sec =3D (__kernel_time_t)div_u64(ticks, priv->timerfreq =20
> / div);
> +	tmp_sec =3D div_u64((u64)time->tv_sec * (u64)priv->timerfreq, =20
> div);
> +
> +	time->tv_usec =3D (__kernel_suseconds_t)
> +		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq / =20
> div);
> +
> +	return;

Why don't you just adjust the clock frequency up front for CLKDIV_64,
rather than introduce alternate (and untested!) code paths throughout =20
the
driver?

> +	list_for_each_entry(priv, &timer_group_list, node) {
> +		ret =3D convert_time_to_ticks(priv, time, &ticks);
> +		if (ret < 0)
> +			return NULL;
> +
> +		if (ticks > MAX_TICKS) {
> +			if (!(priv->flags & FSL_GLOBAL_TIMER))
> +				return NULL;
> +
> +			timer =3D get_cascade_timer(priv, ticks);
> +			if (!timer)
> +				continue;
> +			else
> +				return timer;
> +		}

	if (!timer)
		continue;

	return timer;

-Scott=
