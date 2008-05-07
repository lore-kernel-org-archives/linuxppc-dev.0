Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 1CC40DE097
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 04:03:02 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id 13069F49114
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 19:38:17 +0200 (CEST)
Subject: Re: powerpc port for sbc8260-based board problem
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Boris Shteinbock <bshtein@yahoo.com>
In-Reply-To: <733382.15174.qm@web50603.mail.re2.yahoo.com>
References: <733382.15174.qm@web50603.mail.re2.yahoo.com>
Date: Wed, 07 May 2008 19:38:16 +0200
Message-Id: <1210181896.3519.2.camel@p60365-ste>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo.

I had the same problem.
The following patch can help.

diff -pruN paulus-git/drivers/serial/cpm_uart/cpm_uart_core.c linuxppc-2.6.=
24-ids8247/drivers/serial/cpm_uart/cpm_uart_core.c
--- paulus-git/drivers/serial/cpm_uart/cpm_uart_core.c	2008-03-28 11:03:32.=
000000000 +0100
+++ linuxppc-2.6.24-ids8247/drivers/serial/cpm_uart/cpm_uart_core.c	2008-05=
-07 19:35:21.000000000 +0200
@@ -1350,6 +1349,9 @@ static int __init cpm_uart_console_setup
 	uart_set_options(port, co, baud, parity, bits, flow);
 	cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
=20
+#ifndef CONFIG_PPC_EARLY_DEBUG_CPM
+	cpm_set_brg(pinfo->brg - 1, baud);
+#endif
 	return 0;
 }
=20
Regards
Sergej.

Am Mittwoch, den 07.05.2008, 01:31 -0700 schrieb Boris Shteinbock:
> Hi.
> I am doing a port from ppc to powerpc ARCH on sbc8260 based board.
> The problem is, that I can't get  SMC1 UART to work.
> After SMC console  is initialized. =20
> cpm_uart_console_write() hangs here
>=20
>         /* Wait for transmitter fifo to empty.
>          * Ready indicates output is ready, and xmt is doing
>          * that, not that it is ready for us to send.
>          */
>         while ((in_be16(&bdp->cbd_sc) & BD_SC_READY) !=3D 0)
>             ;
>=20
> I am using dts tree modified  from ep8248 port since it is the only one t=
hat has smc description in it. :
>=20
>=20
>      brg@119f0 {
>        compatible =3D "fsl,mpc8260-brg",
>                     "fsl,cpm2-brg",
>                     "fsl,cpm-brg";
>        reg =3D <119f0 10 115f0 10>;
>        clock-frequency =3D <135000000>;
>       =20
>      };
>=20
>      /* Monitor port/SMC1 */
>      smc1: serial@11a80 {
>        device_type =3D "serial";
>        compatible =3D "fsl,mpc8260-smc-uart",
>                     "fsl,cpm2-smc-uart";
>        reg =3D <0x11a80 0x20 0x1100 0x40>;
>        interrupts =3D <4 8>;
>        interrupt-parent =3D <&PIC>;
>        fsl,cpm-brg =3D <1>;
>        fsl,cpm-command =3D <0x1d000000>;
>        linux,my-label =3D "SMC1";
>      };
>=20
> I checked a BRG settings against working u-boot configuration and they ar=
e the same. Anyway a wrong BRG setting wouldn't hang this loop
>=20
> So I have a few questions.
> If someone has done sbc8260 dts tree and port to "powerpc" already, I'd b=
e very  grateful if he can share it with me.
> I couldn't find anything on the internet.
>=20
> Can someone, also, explain, how "fsl, cpm-command" field works,  booting-=
without-of document doesn't provide much information.
> I feel, that just copying this value from ep8248.dts isn't right somehow.
>=20
> Thank you
>=20
>=20
>       ___________________________________________________________________=
_________________
> Be a better friend, newshound, and=20
> know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_y=
lt=3DAhu06i62sR8HDtDypao8Wcj9tAcJ
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
--=20
Dipl.-Ing. Sergej Stepanov=20
Software-Entwicklung

IDS GmbH=20
E-PA  (Entwicklung - Prozess Automatisierung)
Nobelstr. 18,=20
D-76275 Ettlingen=20
T. (0) 72 43/2 18-615=20
F. (0) 72 43/2 18-100=20
E. Sergej.Stepanov@ids.de

<http://www.ids.de>
Gesch=C3=A4ftsf=C3=BChrer: Norbert Wagner, Friedrich Abri=C3=9F=20
Sitz der Gesellschaft: Ettlingen=20
Amtsgericht Mannheim HRB 362503=20
