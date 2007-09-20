Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8B2EEDDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 23:35:38 +1000 (EST)
Date: Thu, 20 Sep 2007 08:35:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Message-ID: <20070920133528.GC14820@ld0162-tx32.am.freescale.net>
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070920104313.217207466@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 20, 2007 at 12:42:14PM +0200, Peter Korsgaard wrote:
> Index: linux/arch/powerpc/boot/dts/mpc8349emitx.dts
> ===================================================================
> --- linux.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ linux/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -68,6 +68,13 @@
>  			interrupts = <f 8>;
>  			interrupt-parent = < &ipic >;
>  			dfsrr;
> +
> +			rtc@68 {
> +				device_type = "rtc";
> +				compatible = "dallas,ds1339";
> +				reg = <68 4>;
> +			};

#size-cells is zero on i2c, so it should just be reg = <68>.

You'll probably need to add #address-cells and #size-cells to the
controller node, as well.

-Scott
