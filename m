Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 445336847B
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Oct 2005 16:34:40 +1000 (EST)
From: Marc <marvin24@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 5 Oct 2005 08:34:35 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B859476@ismail.innsys.innovsys.com>
	<200510040814.07188.marvin24@gmx.de>
	<1128464094.6417.31.camel@gaston>
In-Reply-To: <1128464094.6417.31.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200510050834.35493.marvin24@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Ben,=20

Le Mittwoch 05 Oktober 2005 00:14, Benjamin Herrenschmidt a =C3=A9crit :
> The problem is indeed in via_calibrate_decr(). This routine works on
> HZ/100 so it will not do any good with HZ not beeing a multiple of 100.
>
> Can you test this patch ?

I can confirm that this patch solves the timer skew on my mac.

Thanks!

>
> Index: linux-work/arch/ppc/platforms/pmac_time.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/arch/ppc/platforms/pmac_time.c	2005-09-22
> 14:06:18.000000000 +1000 +++
> linux-work/arch/ppc/platforms/pmac_time.c	2005-10-05 08:14:17.000000000
> +1000 @@ -195,7 +195,7 @@
>  		;
>  	dend =3D get_dec();
>
> -	tb_ticks_per_jiffy =3D (dstart - dend) / (6 * (HZ/100));
> +	tb_ticks_per_jiffy =3D (dstart - dend) / ((6 * HZ)/100);
>  	tb_to_us =3D mulhwu_scale_factor(dstart - dend, 60000);
>
>  	printk(KERN_INFO "via_calibrate_decr: ticks per jiffy =3D %u (%u ticks)=
\n",
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
