Return-Path: <alonz@discretix.com>
Received: from mail.discretix.com (mail.discretix.com [192.116.217.178])
	by ozlabs.org (Postfix) with SMTP id 223441007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 Nov 2009 23:47:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 14:47:10 +0200
Message-ID: <8B957E110B62714A84290A01A597805F05D2AE31@Exchange.discretix.com>
In-Reply-To: <200911160909.08433.arnd@arndb.de>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911160909.08433.arnd@arndb.de>
From: "Alon Ziv" <alonz@discretix.com>
To: "Arnd Bergmann" <arnd@arndb.de>,<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Monday, November 16, 2009, Arnd wrote:
> > -       { .type =3D "serial", .compatible =3D "ns16550",  .data =3D (=
void
*)PORT_16550, },
> > +       { .type =3D "serial", .compatible =3D "ns16550",  .data =3D (=
void
*)PORT_16550A, },
>=20
> Does not seem logical. If the device claims compatibility with
ns16550, we should
> not automatically assume it's an ns16550a. Why not add another line
for=20
>=20

Unfortunately, there is no way to change what the device claims--it's
encoded into the OpenFirmware tree by the EDK tools.
And, in any case, the device is actually not lying: it _is_ compatible
with NS16550--just with a non-buggy one.  Unfortunately the kernel
driver for 8250-class UARTs makes the conservative choice to assume any
16550 is one of the (early, buggy) revisions where the FIFO was
non-functional; any 16550 with working UART is classed as a 16550A.

-az
*************************************************************************=
*********************
IMPORTANT: The contents of this email and any attachments are confidentia=
l. They are intended for the=20
named recipient(s) only.
If you have received this email in error, please notify the system manage=
r or the sender immediately and do=20
not disclose the contents to anyone or make copies thereof.
