Return-Path: <s104259@yahoo.it>
Received: from web23105.mail.ird.yahoo.com (web23105.mail.ird.yahoo.com
	[217.146.189.45]) by ozlabs.org (Postfix) with SMTP id 1D65EDDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Nov 2008 09:12:43 +1100 (EST)
Date: Thu, 13 Nov 2008 22:12:41 +0000 (GMT)
From: Angelo <s104259@yahoo.it>
Subject: R: Serial console on board based on Lite5200b
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <31090.73221.qm@web23104.mail.ird.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <335718.75634.qm@web23105.mail.ird.yahoo.com>
Reply-To: s104259@yahoo.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ok i solved my problems, but ...

The file /driver/serial/mpc52xx_uart.c in function mpc52xx_uart_of_enumerat=
e(void) try to keep find the device number with:
...
/* Is a particular device number requested? */
devno =3D get_property(np, "port-number", NULL);
...

I set the device tree in order to use PSC4 in uart mode enabling:
serial@2600 {=09// PSC4
=09device_type =3D "serial";
=09compatible =3D "mpc5200b-psc-uart\0mpc5200-psc-uart";
=09port-number =3D <3>; // Logical port assignment=09=09=09
=09cell-index =3D <3>;
=09reg =3D <2600 100>;
=09interrupts =3D <2 b 0>;
=09interrupt-parent =3D <&mpc5200_pic>;
};

But port-number =3D <3> seems less!
Any idea??

--- Ven 7/11/08, Angelo <s104259@yahoo.it> ha scritto:

> Da: Angelo <s104259@yahoo.it>
> Oggetto: Serial console on board based on Lite5200b
> A: linuxppc-embedded@ozlabs.org
> Data: Venerd=EC 7 novembre 2008, 13:10
> Hi, I have a board based on the Lite5200b, except that the
> serial console is on PSC4 instead of PSC1.=20
>=20
> Using the a custom U-boot (1.2.0) and kernel 2.6.21
> (compiled for powerpc), I managed to get U-boot to output on
> the console on PSC4, but the kernel
> does not.
>=20
> I had just modified lite5200b.dts in some points:
>=20
> 1- My memory is 128Mb
> 2- I don't need eth,mdio,ata so I had commented
> 3- Enable PSC4
> 4- Added the chosen node:
>=20
> chosen {
>       linux,stdout-path =3D
> "/soc5200@f0000000/serial@2600";
>       bootargs =3D "console=3DttyPSC4,115200";=20
> };
>=20
> Debugging my board i notified that u-boot read & modify
> the device tree blob adding the chosen node:
> chosen{                                                   =20
>               =20
>   name =3D "chosen";                              =20
>                        =20
>   bootargs =3D "console=3DttyPSC3";
>   linux,platform =3D <600>;
>   linux,initrd-start =3D <7e2e000>;
>   linux,initrd-end =3D <7f0fbf2>;
>   linux,stdout-path =3D
> "/soc5200@f0000000/serial@2600";
> };=20
>=20
> I follow step by step the kernel start procedure.. and I
> notify that in setup_arch funtion is called
> find_legacy_serial_ports, but when is done
> if(legacy_serial_console >=3D 0)=20
> legacy_serial_console is equal to -1.
>=20
> However, it is not sufficient.  What am I missing?
>=20
> Thank you!
>=20
>=20
>=20
>       Unisciti alla community di Io fotografo e video, il
> nuovo corso di fotografia di Gazzetta dello sport:
> http://www.flickr.com/groups/iofotografoevideo
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded=0A=0A=0A      Unisc=
iti alla community di Io fotografo e video, il nuovo corso di fotografia di=
 Gazzetta dello sport:=0Ahttp://www.flickr.com/groups/iofotografoevideo
