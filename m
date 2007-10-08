Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B93D5DDEE1
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 00:58:13 +1000 (EST)
Date: Mon, 8 Oct 2007 09:58:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH 07/15] [POWERPC] Promess Motion-PRO DTS
Message-ID: <20071008145823.GA4289@loki.buserror.net>
References: <47075FA7.3030108@semihalf.com> <4708C22D.5060805@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4708C22D.5060805@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Oct 07, 2007 at 01:25:33PM +0200, Marian Balakowicz wrote:
> +		gpt@600 {	// General Purpose Timer
> +			compatible = "mpc5200b-gpt\0mpc5200-gpt";
> +			device_type = "gpt";

"timer" would be a better node name than "gpt", and the device type should be
left out entirely.  As others pointed out, compatible should be
"fsl,mpc5200b-gpt", "fsl,mpc5200-gpt".

> +			has-wdt;

fsl,has-wdt

> +		rtc@800 {	// Real time clock
> +			compatible = "mpc5200b-rtc\0mpc5200-rtc";
> +			device_type = "rtc";

This doesn't actually implement the OF rtc interface...

> +		mscan@980 {

What is mscan?

> +			device_type = "mscan";

This is not a standard device type.

> +		bestcomm@1200 {
> +			device_type = "dma-controller";

dma-controller should be the node name, and device_type should be omitted.

> +		ethernet@3000 {
> +			device_type = "network";
> +			compatible = "mpc5200b-fec\0mpc5200-fec";
> +			reg = <3000 800>;
> +			mac-address = [ 02 03 04 05 06 07 ]; // Bad!

Should be local-mac-address.  
And yes, hardcoding a mac address is bad.  Don't do it. :-)

> +		i2c@3d40 {
> +			device_type = "i2c";
> +			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
> +			cell-index = <1>;

What is cell-index?  The fsl-i2c driver doesn't use it AFAICT.

> +		sram@8000 {
> +			device_type = "sram";

No device type.

> +	cpld {
> +		device_type = "cpld";
> +		compatible = "cpld";
> +		reg = <50010000 ffff>;
> +	};

This device is compatible with every CPLD that has ever existed?  Wow! :-)

-Scott
