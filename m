Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id 96E6C1007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 04:24:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 09:22:53 -0800
In-Reply-To: <8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com><200911191401.37531.arnd@arndb.de><8B957E110B62714A84290A01A597805F05D2AE44@Exchange.discretix.com><200911191441.27581.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Alon Ziv" <alonz@discretix.com>, "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@lists.ozlabs.org>
Message-ID: <c2bc536b-3765-4ead-b942-88bb25253ad3@VA3EHSMHS013.ehs.local>
Cc: John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


NAK.

If the problem is in the device trees that are being generated, we
should fix the issue there.
We've been trying to avoid putting the fully specified IP versions in
the kernel like this, since
the IP changes so often.

Steve

> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Alon
Ziv
> Sent: Thursday, November 19, 2009 5:49 AM
> To: Arnd Bergmann; linuxppc-dev@lists.ozlabs.org
> Subject: RE: Bug in drivers/serial/of_serial.c?
> =

> On Thursday, November 19, 2009, Arnd Bergmann wrote:
> > I'd still add support for the compatible=3D"ns16550a" property
> > so that we do the right thing for future systems.
> >
> =

> OK...
> ---
> Xilinx 16550 UART is actually 16550A-compatible
> =

> Signed-off-by: Alon Ziv <alonz@discretix.com>
> =

> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> index 02406ba..241be77 100644
> --- a/drivers/serial/of_serial.c
> +++ b/drivers/serial/of_serial.c
> @@ -161,7 +161,9 @@ static int of_platform_serial_remove(struct
> of_device *ofdev)
>  static struct of_device_id __devinitdata of_platform_serial_table[] =3D
{
>  	{ .type =3D "serial", .compatible =3D "ns8250",   .data =3D (void
> *)PORT_8250, },
>  	{ .type =3D "serial", .compatible =3D "ns16450",  .data =3D (void
> *)PORT_16450, },
> +	{ .type =3D "serial", .compatible =3D "xlnx,xps-uart16550-2.00.b",
> .data =3D (void *)PORT_16550A, },
>  	{ .type =3D "serial", .compatible =3D "ns16550",  .data =3D (void
> *)PORT_16550, },
> +	{ .type =3D "serial", .compatible =3D "ns16550a", .data =3D (void
> *)PORT_16550A, },
>  	{ .type =3D "serial", .compatible =3D "ns16750",  .data =3D (void
> *)PORT_16750, },
>  	{ .type =3D "serial", .compatible =3D "ns16850",  .data =3D (void
> *)PORT_16850, },
>  #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
>
************************************************************************
**********************
> IMPORTANT: The contents of this email and any attachments are
confidential. They are intended for the
> named recipient(s) only.
> If you have received this email in error, please notify the system
manager or the sender immediately
> and do
> not disclose the contents to anyone or make copies thereof.
> =

> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
