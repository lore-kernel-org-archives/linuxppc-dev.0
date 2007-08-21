Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 12:42:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 10/20] bootwrapper: Add CPM serial driver.
Message-ID: <20070821024200.GJ15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820173957.GI30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173957.GI30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:39:57PM -0500, Scott Wood wrote:
> This serial port is used on all 8xx, many 82xx, and some 85xx chips.
> 
> The driver requires that the port has already been set up by the firmware
> and/or platform code.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

[snip]
> diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
> index 944f0ee..d47f8e0 100644
> --- a/arch/powerpc/boot/serial.c
> +++ b/arch/powerpc/boot/serial.c
> @@ -121,6 +121,11 @@ int serial_console_init(void)
>  		rc = ns16550_console_init(devp, &serial_cd);
>  	else if (dt_is_compatible(devp, "marvell,mpsc"))
>  		rc = mpsc_console_init(devp, &serial_cd);
> +	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
> +	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
> +	         dt_is_compatible(devp, "fsl,cpm2-scc-uart") ||
> +	         dt_is_compatible(devp, "fsl,cpm2-smc-uart"))
> +		rc = cpm_console_init(devp, &serial_cd);

If all these variants admit a compatible driver, there really should
be defined a compatible value that they all include in the device
tree.   But I guess you'd still need all these tests for device trees
which didn't have it.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
