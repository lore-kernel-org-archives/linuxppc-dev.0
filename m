Return-Path: <jhautbois@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 803C3B70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Jan 2011 03:24:50 +1100 (EST)
Received: by yxs7 with SMTP id 7so2236668yxs.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 17 Jan 2011 08:24:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1291379651-8822-5-git-send-email-leoli@freescale.com>
References: <1291379651-8822-1-git-send-email-leoli@freescale.com>
	<1291379651-8822-2-git-send-email-leoli@freescale.com>
	<1291379651-8822-3-git-send-email-leoli@freescale.com>
	<1291379651-8822-4-git-send-email-leoli@freescale.com>
	<1291379651-8822-5-git-send-email-leoli@freescale.com>
Date: Mon, 17 Jan 2011 17:24:47 +0100
Message-ID: <AANLkTi=s9y=67bNnAbVR5E0YcL4T0VSH3nUbYyO5m9yd@mail.gmail.com>
Subject: Re: [PATCH 5/7] powerpc: add the mpic timer support
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I am interested by this implementation.

> +static ssize_t mpic_tm_timeout_store(struct device *dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_attribute *attr,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *buf, size_t count)
> +{

<snip>

> +
> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irq(&priv->lock);
> +
> + =C2=A0 =C2=A0 =C2=A0 /* stop timer 0 */
> + =C2=A0 =C2=A0 =C2=A0 temp =3D in_be32(&priv->regs->gtbcr);
> + =C2=A0 =C2=A0 =C2=A0 temp |=3D MPIC_TIMER_STOP; /* counting inhibited *=
/
> + =C2=A0 =C2=A0 =C2=A0 out_be32(&priv->regs->gtbcr, temp);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (interval !=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* start timer */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&priv->regs->=
gtbcr, interval | MPIC_TIMER_STOP);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_be32(&priv->regs->=
gtbcr, interval);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irq(&priv->lock);
> + =C2=A0 =C2=A0 =C2=A0 return count;
> +}

What is the delay when doing that stop/start thing ?
Is this delay variable and/or big or not ?
I would imagine a timer which would see its interval regularly
corrected, and I would like to know if this is really really fast
(say, less than some ticks) or not.

Thanks in advance for any answer !
Regards,
JM
