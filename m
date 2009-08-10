Return-Path: <nathan.french@onrampwireless.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F3A99B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 02:13:02 +1000 (EST)
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.55])
	by ozlabs.org (Postfix) with ESMTP id 6156BDDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 02:13:02 +1000 (EST)
Subject: Re: need help getting SPI controller working on 405EX
From: Nathan French <nathan.french@onrampwireless.com>
To: Lorenz Kolb <lorenz.kolb.newsgroups.nospam@lkmail.de>
In-Reply-To: <h5mjg0$rqs$1@ger.gmane.org>
References: <1249574886.3747.2650.camel__48649.694157257$1249575290$gmane$org@localhost.localdomain>
	<h5mjg0$rqs$1@ger.gmane.org>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 09:07:15 -0700
Message-ID: <1249920435.3747.8569.camel@localhost.localdomain>
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lorenz, thanks for the reply.

> For getting spidev devices you have to add entries for an spidev device 
> to your newly created spi-"bus". So what you are currently missing are 
> the spidev child-nodes in the device tree.
> As I'm currently cut off from some device to test, no guaranty that it 
> will work, but your dts entry should look something like:
> 
>               SPI0: spi@ef600600 {
>                   cell-index = <0>;
>                   compatible = "ibm,spi-405ex", "ibm,spi";
>                   reg = <ef600600 6>;
>                   interrupts = <8 4>;
>                   interrupt-parent = <&UIC0>;
>                   mode = "cpu";
> 
>                   yourdevice@0 {
>                       compatible = "spidev";
>                       spi-max-frequency = <1000000>; /* what ever your 
> max-freq. is */
>                       reg = <0>; /* Chipselect-address */
>                   };
>               };

This did not appear to have any effect.

> At least something similar worked for me some months ago (before we 
> switched to a "real" driver for some custom peripheral).

Did this work on a 4xx PowerPC platform?  Or something else?  I've been
told that there is no SPI driver for 4xx.  If you have done this on 4xx
then I'm very interested.

Thanks,

Nathan
