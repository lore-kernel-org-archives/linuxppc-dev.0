Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1B74CDDF06
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 06:27:37 +1000 (EST)
Date: Fri, 28 Sep 2007 15:31:04 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
Message-ID: <20070928203104.GC23749@lixom.net>
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 28, 2007 at 12:17:13PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Acked-by: John Williams <jwilliams@itee.uq.edu.au>
> ---
> 
>  arch/ppc/syslib/virtex_devices.c |    2 +-
>  drivers/serial/uartlite.c        |   32 ++++++++++++++++----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
> index ace4ec0..270ad3a 100644
> --- a/arch/ppc/syslib/virtex_devices.c
> +++ b/arch/ppc/syslib/virtex_devices.c
> @@ -28,7 +28,7 @@
>  	.num_resources = 2, \
>  	.resource = (struct resource[]) { \
>  		{ \
> -			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
> +			.start = XPAR_UARTLITE_##num##_BASEADDR, \
>  			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
>  			.flags = IORESOURCE_MEM, \
>  		}, \
> diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
> index f5051cf..59b674a 100644
> --- a/drivers/serial/uartlite.c
> +++ b/drivers/serial/uartlite.c
> @@ -61,7 +61,7 @@ static int ulite_receive(struct uart_port *port, int stat)
>  	/* stats */
>  	if (stat & ULITE_STATUS_RXVALID) {
>  		port->icount.rx++;
> -		ch = readb(port->membase + ULITE_RX);
> +		ch = in_be32((void*)port->membase + ULITE_RX);

Hmm, I see the start changed, and you're now reading/writing a full
32-bit word instead of individual bytes. Still, looks a little fishy to
me. Wouldn't it be more appropriate to change the ULITE_RX offset to be
3 higher and still read/write bytes?

Or are the registers defined as 32-bit ones? (I don't remember, it was
so long since I touched uartlite myself. :-)

(Same for the other functions below, but the general principle applies.)

Also, I'm not sure you need to cast port->membase to void*, do you? The
math will still be right since it's declared as char *.


-Olof
