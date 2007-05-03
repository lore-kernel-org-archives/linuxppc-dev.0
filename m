Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 1EAD6DDFBF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 17:48:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Date: Thu, 3 May 2007 09:48:03 +0200
References: <20070503065435.4533.64938.stgit@localhost.localdomain>
In-Reply-To: <20070503065435.4533.64938.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705030948.03984.arnd@arndb.de>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 May 2007, Vitaly Bordug wrote:

> Adds support for PowerQuicc on-chip PCMCIA. The driver is implemented as
> of_device, so only arch/powerpc stuff is capable to use it, which now
> implies only mpc885ads reference board.

Very nice, looks much better now than the previous version.

> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
> index 110bf61..89d585f 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -112,6 +112,18 @@
>  			compatible = "CPM";
>  		};
>  
> +               pcmcia@0080 {
> +                       linux,phandle = <0080>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       compatible = "8xx";
> +                       device_type = "pcmcia";
> +                       reg = <80 80>;
> +                       clock-frequency = <2faf080>;
> +                       interrupt-parent = <ff000000>;
> +                       interrupts = <d 1>;
> +		};
> +
>  		cpm@ff000000 {
>  			linux,phandle = <ff000000>;
>  			#address-cells = <1>;

The compatible property should be a little more specific, imho. Since there
are differences in how things are done depending on the board, it would be
good to tell the exact method from the pcmcia node itself.

For example, you could make this

	compatible = "8xx\0mpc885ads";

Your code doesn't currently use this, I like to have the option.

> +#ifdef CONFIG_PCMCIA_M8XX
> +static void pcmcia_hw_setup(int slot, int enable);
> +static int pcmcia_set_voltage(int slot, int vcc, int vpp);
> +
> +struct mpc8xx_pcmcia_ops m8xx_pcmcia_ops = {
> +	.hw_ctrl = pcmcia_hw_setup,
> +	.voltage_set = pcmcia_set_voltage,
> +};
> +#endif
> +
>  void __init mpc885ads_board_setup(void)
>  {
>  	cpm8xx_t *cp;

If you define the global variable in the board code, you can not have multiple
board implementations in a multiplatform kernel.
In order to make that work, you'd need to have the definition of m8xx_pcmcia_ops
in 8xx common code, and then assign the two function pointers dynamically in the
board initialization.

> +	if (of_address_to_resource(np, 0, &r))
> +		return -EINVAL;
> +
> +	pcmcia = ioremap(r.start, r.end - r.start + 1);
> +	if(pcmcia == NULL)
> +		return -EINVAL;

A new of_iomap() function was recently added that allows you
to do these two steps in one.

> -/* connect interrupt and disable CxOE */
> +	out_be32(M8XX_PGCRX(0), M8XX_PGCRX_CXOE | (mk_int_int_mask(hwirq) << 16));
> +	out_be32(M8XX_PGCRX(1), M8XX_PGCRX_CXOE | (mk_int_int_mask(hwirq) << 16));

I'm not sure why you need to use the hwirq here, it should not be visible to
device drivers normally.

Is this the same as enable_irq(pcmcia_schlvl) ?

	Arnd <><
