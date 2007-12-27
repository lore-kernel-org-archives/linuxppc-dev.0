Return-Path: <ma.alvarez@usyscom.com>
Received: from correo.ziv.es (correo.ziv.es [212.55.31.237])
	by ozlabs.org (Postfix) with ESMTP id 17730DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Dec 2007 22:12:02 +1100 (EST)
Message-ID: <477385A4.8020808@ziv.es>
Date: Thu, 27 Dec 2007 11:59:48 +0100
From: "Miguel Angel Alvarez" <ma.alvarez@ziv.es>
MIME-Version: 1.0
To: <linuxppc-embedded@ozlabs.org>
Subject: Using SPI in lite5200
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.

We are trying to use the SPI subsystem in the MPC5200 to write a driver=20
that supports SC16IS752 (SPI->2 UARTs).

Although I have read the spi-summary in the Documentation of the kernel, =

I am not quite sure of having understood all the pieces that I require=20
to make the system work.

First of all, I am using the SPI associated to PSC3, so in  the=20
mpc52xx_devices.c I have added a "[MPC52xx_PSC_SPI]" entry with exactly=20
the same parameters as "[MPC52xx_PSC3]", except for the name, which I=20
assign to mpc52xx-psc-spi (I suppose this is the correct driver for the=20
master of the SPI bus).

That is:
[MPC52xx_PSC_SPI] =3D {
        .name        =3D "mpc52xx-psc-spi",
        .id        =3D 2,
        .num_resources    =3D 2,
        .resource    =3D (struct resource[]) {
            {
                .start    =3D 0x2400,
                .end    =3D 0x249f,
                .flags    =3D IORESOURCE_MEM,
            },
            {
                .start    =3D MPC52xx_PSC3_IRQ,
                .end    =3D MPC52xx_PSC3_IRQ,
                .flags    =3D IORESOURCE_IRQ,
            },
        },
    },

My question is: Am I using the correct IRQ? Where can I find which is=20
the correct one?

Thanks

Miguel =C1ngel=20
=20
----------------------------------------- PLEASE NOTE =
-------------------------------------------
This message, along with any attachments, may be confidential or legally =
privileged.=20
It is intended only for the named person(s), who is/are the only =
authorized recipients.
If this message has reached you in error, kindly destroy it without =
review and notify the sender immediately.
Thank you for your help.
ZIV uses virus scanning software but excludes any liability for viruses =
contained in any attachment.
=20
------------------------------------ ROGAMOS LEA ESTE TEXTO =
-------------------------------
Este mensaje y sus anexos pueden contener informaci=F3n confidencial y/o =
con derecho legal.=20
Est=E1 dirigido =FAnicamente a la/s persona/s o entidad/es rese=F1adas =
como =FAnico destinatario autorizado.
Si este mensaje le hubiera llegado por error, por favor elim=EDnelo sin =
revisarlo ni reenviarlo y notif=EDquelo inmediatamente al remitente. =
Gracias por su colaboraci=F3n. =20
ZIV utiliza software antivirus, pero no se hace responsable de los virus =
contenidos en los ficheros anexos.
