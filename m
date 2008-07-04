Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 89817DDE24
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 14:18:37 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id n7so666757wag.13
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 21:18:36 -0700 (PDT)
Date: Thu, 3 Jul 2008 22:17:58 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Chen Gong <G.Chen@freescale.com>
Subject: Re: [PATCH v2 4/5] spi: Add OF binding support for SPI busses
Message-ID: <20080704041758.GH12945@secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010313.26187.99119.stgit@trillian.secretlab.ca>
	<58A20A281BAF1047B4EAE68DE5C0BDC2010121B7@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC2010121B7@zch01exm21.fsl.freescale.net>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: david-b@pacbell.net, linuxppc-dev@ozlabs.org, fabrizio.garetto@gmail.com,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 11:54:57AM +0800, Chen Gong wrote:
> Grant Likely wrote:
> > +		/* Mode (clock phase/polarity/etc.) */
> > +		if (of_find_property(nc, "spi,cpha", NULL))
> > +			spi->mode |= SPI_CPHA;
> > +		if (of_find_property(nc, "spi,cpol", NULL))
> > +			spi->mode |= SPI_CPOL;
> 
> so becuase in function spi_alloc_deive, spi is allocated by kzalloc,
> how about writing as follows:
> 		/* Mode (clock phase/polarity/etc.) */
> 		prop = of_get_property(nc, "spi,cpha", NULL))
>                         if (prop)
> 			spi->mode |= *prop;
> 		prop = of_get_property(nc, "spi,cpol", NULL))
>                         if (prop)
> 			spi->mode |= *prop;

spi,cpha and spi,cpol are defined as empty properties.  The presence of
the property in the node means I need to set the flag in the spi_device.

> > +		/* Select device driver */
> > +		sprop = of_get_property(nc, "linux,modalias", &len);
> > +		if (sprop && len > 0)
> > +			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN);
> > +		else
> > +			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN);
> > +
>  how about writing as follows:
> 
> 		if (sprop && len > 0)
> 			strncpy(spi->modalias, sprop, KOBJ_NAME_LEN -
> 1);
> 		else
> 			strncpy(spi->modalias, "spidev", KOBJ_NAME_LEN -
> 1);

Actually, neither are very good.  What it should really be is:

	if (sprop && len > 0)
		strlcpy(spi->modalias, sprop, sizeof (spi->modalias));
	else
		strlcpy(spi->modalias, "spidev", sizeof (spi->modalias));

This ensures that the string is always null terminated and always the
right size.

... But the whole argument is a bit moot.  The fact that I even defined
a "linux,modalias" property is a great big hairy hack that I would
never want my mother to see.  Instead, I need a method to bind to an SPI
driver based on the compatible list.  Jon Smirl has done some work
in this regard for i2c, but I haven't looked at it very deeply, and so
do not at all understand it (yet).

Thanks for the comments.
g.
