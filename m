Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 3F17FDDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 10:01:10 +1100 (EST)
Date: Mon, 12 Mar 2007 16:01:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 16/19] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070312230148.GG31268@mag.az.mvista.com>
References: <20070312204202.GP28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204202.GP28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:42:02PM -0600, Scott Wood wrote:

> diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
> index 1ffe72e..cce7a11 100644
> --- a/arch/powerpc/boot/ns16550.c
> +++ b/arch/powerpc/boot/ns16550.c
> @@ -55,10 +55,15 @@ static u8 ns16550_tstc(void)
>  int ns16550_console_init(void *devp, struct serial_console_data *scdp)
>  {
>  	int n;
> +	unsigned long reg_phys;
>  
>  	n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
> -	if (n != sizeof(reg_base))
> -		return -1;
> +	if (n != sizeof(reg_base)) {
> +		if (!xlate_reg(devp, 0, &reg_phys, NULL))
> +			return -1;
> +
> +		reg_base = (void *)reg_phys;
> +	}

NACK.

'virtual-reg' _is_ the fully translated virtual address.
Its simply the virtual address that maps to the fully translated
physical addr in the 'reg' property.

Even if it wasn't, 'ranges' only work for physical/'reg' properties
and can't be used for a virtual one--you'd have to make a parellel
'ranges' thingy for 'virtual-reg'.

Mark
