Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ew0-f214.google.com (mail-ew0-f214.google.com
	[209.85.219.214]) by ozlabs.org (Postfix) with ESMTP id C2D01B6EEE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jan 2010 23:43:50 +1100 (EST)
Received: by ewy6 with SMTP id 6so12415911ewy.9
	for <linuxppc-dev@ozlabs.org>; Sat, 02 Jan 2010 04:43:48 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <alpine.OSX.2.00.0911171657290.371@silk.local>
References: <alpine.OSX.2.00.0911171657290.371@silk.local>
Date: Sat, 2 Jan 2010 13:43:46 +0100
Message-ID: <10f740e81001020443h78c615d2l206b99c386600108@mail.gmail.com>
Subject: Re: [PATCH 1/2] pmac-zilog: add platform driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Finn Thain <fthain@telegraphics.com.au>
Content-Type: text/plain; charset=UTF-8
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2009 at 10:04, Finn Thain <fthain@telegraphics.com.au> wrot=
e:
> Add platform driver to the pmac-zilog driver for mac 68k, putting the
> powermac-specific bits inside #ifdef CONFIG_PPC_PMAC.

> --- linux-2.6.31.orig/drivers/serial/pmac_zilog.c =C2=A0 =C2=A0 =C2=A0 20=
09-11-17 17:07:28.000000000 +1100
> +++ linux-2.6.31/drivers/serial/pmac_zilog.c =C2=A0 =C2=A02009-11-17 17:0=
7:38.000000000 +1100

> @@ -1427,6 +1439,8 @@ static struct uart_ops pmz_pops =3D {
> =C2=A0#endif
> =C2=A0};
>
> +#ifdef CONFIG_PPC_PMAC
> +
> =C2=A0/*
> =C2=A0* Setup one port structure after probing, HW is down at this point,
> =C2=A0* Unlike sunzilog, we don't need to pre-init the spinlock as we don=
't
> @@ -1823,6 +1837,88 @@ next:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> =C2=A0}
>
> +#else
> +
> +extern struct platform_device scc_a_pdev, scc_b_pdev;

scripts/checkpatch.pl doesn't like this extern, and it's right.
Can't this be found using standard platform device/driver matching?

BTW, there are a few other minor checkpatch issues with some of the
other patches in the series,
too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
