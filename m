Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1DC0A67B66
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 01:00:37 +1000 (EST)
Message-ID: <45169D90.8060709@ru.mvista.com>
Date: Sun, 24 Sep 2006 19:00:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] UPIO_TSI cleanup
References: <E1GQvYX-0002iX-IN@ZenIV.linux.org.uk>
In-Reply-To: <E1GQvYX-0002iX-IN@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, rmk+serial@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Al Viro wrote:
> (le32_to_cpu(x) >> 8) & 0xff is a very odd way to spell (x >> 16) & 0xff,
> even if that code is hit only on ppc.  The value is host-endian - we've
> got it from readl(), after all...

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  drivers/serial/8250.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index 0ae9ced..10c2daa 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c

    Shouldn't this go to rmk+serial@arm.linux.org.uk instead?

> @@ -320,8 +320,8 @@ #endif
>  
>  	case UPIO_TSI:
>  		if (offset == UART_IIR) {
> -			tmp = readl((u32 *)(up->port.membase + UART_RX));
> -			return (cpu_to_le32(tmp) >> 8) & 0xff;
> +			tmp = readl(up->port.membase + (UART_IIR & ~3));
> +			return (tmp >> 16) & 0xff; /* UART_IIR % 4 == 2 */
>  		} else
>  			return readb(up->port.membase + offset);
>  

    I'd also like to suggest actually writing to IER in the serial_out() even 
if the UUE bit is set, jusk mask 2 MSBs off (Xscale UART detection code which 
breaks Tsi10x UART sould have been CONFIG_ARM dependent I think). The whole 
UPIO_TSI thing looks much like an abuse to me, however it still seems to be a 
necessary evil... :-/

WBR, Sergei
