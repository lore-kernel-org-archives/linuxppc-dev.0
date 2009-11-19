Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 364DD1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 01:10:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Alon Ziv" <alonz@discretix.com>
Subject: Re: Bug in drivers/serial/of_serial.c?
Date: Thu, 19 Nov 2009 15:09:31 +0100
References: <8B957E110B62714A84290A01A597805F05CA0AA0@Exchange.discretix.com>
	<200911191441.27581.arnd@arndb.de>
	<8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
In-Reply-To: <8B957E110B62714A84290A01A597805F05D2AE47@Exchange.discretix.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200911191509.31270.arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
	Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 19 November 2009, Alon Ziv wrote:
> On Thursday, November 19, 2009, Arnd Bergmann wrote:
> > I'd still add support for the compatible="ns16550a" property
> > so that we do the right thing for future systems.
> > 
> 
> OK...
> ---
> Xilinx 16550 UART is actually 16550A-compatible
> 
> Signed-off-by: Alon Ziv <alonz@discretix.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Does this go through the powerpc or the tty tree?
I'd be happy if either Ben or Greg could pick this up.

I'm happy to keep maintaining the driver itself but it
would be nice to know a definite subsystem maintainer
responsible for it.

Greg, if you want to take patches for of_serial.c generally,
I'll start forwarding them to you as they come in and make
sure they apply to your tree.

	Arnd <><

> diff --git a/drivers/serial/of_serial.c b/drivers/serial/of_serial.c
> index 02406ba..241be77 100644
> --- a/drivers/serial/of_serial.c
> +++ b/drivers/serial/of_serial.c
> @@ -161,7 +161,9 @@ static int of_platform_serial_remove(struct
> of_device *ofdev)
>  static struct of_device_id __devinitdata of_platform_serial_table[] = {
>  	{ .type = "serial", .compatible = "ns8250",   .data = (void
> *)PORT_8250, },
>  	{ .type = "serial", .compatible = "ns16450",  .data = (void
> *)PORT_16450, },
> +	{ .type = "serial", .compatible = "xlnx,xps-uart16550-2.00.b",
> .data = (void *)PORT_16550A, },
>  	{ .type = "serial", .compatible = "ns16550",  .data = (void
> *)PORT_16550, },
> +	{ .type = "serial", .compatible = "ns16550a", .data = (void
> *)PORT_16550A, },
>  	{ .type = "serial", .compatible = "ns16750",  .data = (void
> *)PORT_16750, },
>  	{ .type = "serial", .compatible = "ns16850",  .data = (void
> *)PORT_16850, },
>  #ifdef CONFIG_SERIAL_OF_PLATFORM_NWPSERIAL
