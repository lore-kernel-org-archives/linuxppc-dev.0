Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68812DE472
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 02:03:09 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1Jmt2u-0007tz-FR
	for linuxppc-dev@ozlabs.org; Fri, 18 Apr 2008 18:02:51 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Fri, 18 Apr 2008 18:02:34 +0200
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<4808C1BE.1050607@fang.fa.gau.hu>
In-Reply-To: <4808C1BE.1050607@fang.fa.gau.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804181802.34833.jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 18 April 2008 17:43, Peter Czanik wrote:
> Hello,
>
> Juergen Beisert =EDrta:
> > Hi,
> >
> > if someone is interested: Here the full patch to get sound support for
> > MPC5200b and a current 2.6.25 kernel.
>
> First of all, thanks for fixing the driver. I just tested it on the
> EFIKA, it (almost) works. In its current state loading the kernel module
> results in a segfault and oops. The fix is to add a missing line to the
> device-tree. The forth version of the EFIKA fix works fine (taken from
> http://www.powerdeveloper.org/platforms/efika/devicetree ):
>
> efika:~ # cat /mnt/sound.forth
> \ FORTH
>
> s" /builtin/sound" find-device
>         \ Audio is on PSC2, just for informational purposes
>         1 encode-int s" cell-index" property
> device-end
> efika:~ #
>
> But trying to fix it up from prom_init.c does not seem to work, the
> missing 'cell-index' property does not show up. Please let me know, how
> to add it properly. Here is what I tried:
>
> factory:/usr/src/linux-2.6.25 # diff -u
> arch/powerpc/kernel/prom_init.c.orig arch/powerpc/kernel/prom_init.c
> --- arch/powerpc/kernel/prom_init.c.orig        2008-04-18
> 13:55:07.000000000 +0200
> +++ arch/powerpc/kernel/prom_init.c     2008-04-18 16:26:51.000000000 +02=
00
> @@ -2212,6 +2212,7 @@
>
>  static void __init fixup_device_tree_efika(void)
>  {
> +       int sound_ci =3D 1;
>         int sound_irq[3] =3D { 2, 2, 0 };
>         int bcomm_irq[3*16] =3D { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
>                                 3,4,0, 3,5,0, 3,6,0, 3,7,0,
> @@ -2257,6 +2258,8 @@
>                 rv =3D prom_getprop(node, "interrupts", prop, sizeof(prop=
));
>                 if (rv =3D=3D PROM_ERROR) {
>                         prom_printf("Adding sound interrupts property\n");
> +                        prom_setprop(node, "/builtin/sound", "cell-index=
",
> +                                     &sound_ci, sizeof(int));
>                         prom_setprop(node, "/builtin/sound", "interrupts",
>                                      sound_irq, sizeof(sound_irq));
>                 }
> factory:/usr/src/linux-2.6.25 #
>
> Bye,
> CzP

I'm not sure if "cell-index" is a correct property. I copied it from the ua=
rt=20
driver, because this driver needs something to distinguish between PSC1 and=
=20
PSC2. Maybe there is a better and correct oftree solution? Any oftree exper=
t=20
here?

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
