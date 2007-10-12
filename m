Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v3 5/9] add documentation for SATA nodes
Date: Fri, 12 Oct 2007 16:38:06 +0200
References: <1192195728-24189-1-git-send-email-leoli@freescale.com>
	<1192195728-24189-5-git-send-email-leoli@freescale.com>
	<1192195728-24189-6-git-send-email-leoli@freescale.com>
In-Reply-To: <1192195728-24189-6-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710121638.07618.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 12 October 2007, Li Yang wrote:

> +
> +=A0=A0=A0=A0=A0=A0=A0sata@19000 {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compatible =3D "fsl,mpc8315=
=2Dsata";
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reg =3D <19000 1000>;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0interrupts =3D <2d 8>;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0interrupt-parent =3D < &ipi=
c >;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0phy-handle =3D < &serdes1 >;
> + =A0 =A0 =A0 =A0};

I believe we should really have a generic way to probe ATA
ports as long as they are compatible to the standard register
set, and use a generic of-ata driver for that. The two
questions arising there are:

1. Should there be a new device-type for ATA? Alternatively
   we would only look at the "compatible" property, maybe
   looking for a generic "ata" name.

2. How do we make sure the of-ata driver and the specific
   (e.g. sata_fsl) driver don't fight over the same devices?
   Would it be enough to reject all known specific devices
   in of_ata_probe?

	Arnd <><
