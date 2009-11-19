Return-Path: <alonz@discretix.com>
Received: from mail.discretix.com (mail.discretix.com [192.116.217.178])
	by ozlabs.org (Postfix) with SMTP id 4CE6F1007D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 00:49:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 15:49:24 +0200
Message-ID: <8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
In-Reply-To: <200911191441.27581.arnd@arndb.de>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911191401.37531.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE44@Exchange.discretix.com>
	<200911191441.27581.arnd@arndb.de>
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

On Thursday, November 19, 2009, Arnd Bergmann wrote:
> I'd still add support for the compatible=3D"ns16550a" property
> so that we do the right thing for future systems.
>=20

OK...
---
Xilinx 16550 UART is actually 16550A-compatible

Signed-off-by: Alon Ziv <alonz@discretix.com>

diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
index 02406ba..241be77 100644
--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
@@ -161,7 +161,9 @@ static int of_platform_serial_remove(struct
of_device *ofdev)
 static struct of_device_id __devinitdata of_platform_serial_table[] =3D =
{
 	{ .type =3D "serial", .compatible =3D "ns8250",   .data =3D (void
*)PORT_8250, },
 	{ .type =3D "serial", .compatible =3D "ns16450",  .data =3D (void
*)PORT_16450, },
+	{ .type =3D "serial", .compatible =3D "xlnx,xps-uart16550-2.00.b",
=2Edata =3D (void *)PORT_16550A, },
 	{ .type =3D "serial", .compatible =3D "ns16550",  .data =3D (void
*)PORT_16550, },
+	{ .type =3D "serial", .compatible =3D "ns16550a", .data =3D (void
*)PORT_16550A, },
 	{ .type =3D "serial", .compatible =3D "ns16750",  .data =3D (void
*)PORT_16750, },
 	{ .type =3D "serial", .compatible =3D "ns16850",  .data =3D (void
*)PORT_16850, },
 #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
*************************************************************************=
*********************
IMPORTANT: The contents of this email and any attachments are confidentia=
l. They are intended for the=20
named recipient(s) only.
If you have received this email in error, please notify the system manage=
r or the sender immediately and do=20
not disclose the contents to anyone or make copies thereof.
