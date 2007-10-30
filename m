Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C67DDDDE03
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Nov 2007 05:58:02 +1100 (EST)
Date: Tue, 30 Oct 2007 11:32:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] using mii-bitbang on different processor ports
Message-ID: <20071030163200.GA4470@loki.buserror.net>
References: <1193760559.6244.25.camel@p60635-ste.ids.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1193760559.6244.25.camel@p60635-ste.ids.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 05:09:19PM +0100, Sergej Stepanov wrote:
> The patch makes possible to have mdio and mdc pins on different physical ports
> also for CONFIG_PPC_CPM_NEW_BINDING.
> To setup it in the device tree:
> reg = <10d40 14 10d60 14>; // mdc-offset: 0x10d40, mdio-offset: 0x10d60
> or
> reg = <10d40 14>; // mdc and mdio have the same offset 0x10d40
> The approach was taken from older version.

There are some formatting issues in fs_mii_bitbang_init(), but otherwise it
looks good.  It'll need to be sent to Jeff Garzik and the netdev list, not
just linuxppc-dev, though.

Also, please update Documentation/powerpc/booting-without-of.txt (probably
in a separate patch, since that one would go through Paul).

> @@ -142,13 +146,27 @@ static int __devinit fs_mii_bitbang_init(struct mii_bus *bus,
>  		return -ENODEV;
>  	mdc_pin = *data;
>  
> -	bitbang->dir = ioremap(res.start, res.end - res.start + 1);
> -	if (!bitbang->dir)
> +	bitbang->mdc.dir = ioremap(res[0].start, res[0].end - res[0].start + 1);
> +	if (!bitbang->mdc.dir)
>  		return -ENOMEM;
>  
> -	bitbang->dat = bitbang->dir + 4;
> -	bitbang->mdio_msk = 1 << (31 - mdio_pin);
> -	bitbang->mdc_msk = 1 << (31 - mdc_pin);
> +	bitbang->mdc.dat = bitbang->mdc.dir + 4;
> +	if( !of_address_to_resource(np, 1, &res[1]))

Space before the '(', not after.  A newline after the previous line would be
nice, too.

> +	{

Brace at the end of the previous line.

> +		bitbang->mdio.dir = ioremap(res[1].start, res[1].end - res[1].start + 1);
> +		if (!bitbang->mdio.dir)
> +		{

Likewise.

You could just use of_iomap() for the second one, since we don't need
the physical address for bus->id.

> +			iounmap(bitbang->mdc.dir);
> +			return -ENOMEM;

Please use the goto-style error handling that's used elsewhere in the
function.

> +		}
> +		bitbang->mdio.dat = bitbang->mdio.dir + 4;
> +	}
> +	else{

} else {

>  out_unmap_regs:
> -	iounmap(bitbang->dir);
> +	if ( bitbang->mdio.dir != bitbang->mdc.dir)
> +		iounmap(bitbang->mdio.dir);
> +	iounmap(bitbang->mdc.dir);
>  out_free_bus:
>  	kfree(new_bus);
>  out_free_priv:
> @@ -238,7 +258,9 @@ static int fs_enet_mdio_remove(struct of_device *ofdev)
>  	free_mdio_bitbang(bus);
>  	dev_set_drvdata(&ofdev->dev, NULL);
>  	kfree(bus->irq);
> -	iounmap(bitbang->dir);
> +	if ( bitbang->mdio.dir != bitbang->mdc.dir)
> +		iounmap(bitbang->mdio.dir);
> +	iounmap(bitbang->mdc.dir);
>  	kfree(bitbang);
>  	kfree(bus);

"if (bitbang", not "if ( bitbang".

-Scott
