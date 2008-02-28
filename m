Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C36CBDDFF9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 06:12:00 +1100 (EST)
Date: Thu, 28 Feb 2008 13:12:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 2/4] Emerson KSI8560 device tree
Message-ID: <20080228191230.GB3897@loki.buserror.net>
References: <20080228183503.GA26971@ru.mvista.com>
	<20080228184727.GC26971@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228184727.GC26971@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2008 at 09:47:27PM +0300, Alexandr Smirnov wrote:
> +	soc@fdf00000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0x00000000 0xfdf00000 0x00100000>;
> +		reg = <0xfdf00000 0x200>;

The reg property is no longer needed here.

> +		mdio@24520 {					/* For TSECs */
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "mdio";
> +			compatible = "gianfar";

No device_type, compatible should be "fsl,gianfar-mdio".

> +	localbus@fdf05000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc8560-localbus";
> +		reg = <0xfdf05000 0x68>;
> +
> +		ranges = <0xe0000000 0xe0000000 0x00800000>;

The localbus node isn't just a container for flash; if you're not going to
use the chipselect mechanism (and you should), then at least use a blank
"ranges;".

> +	cpld@e8080000 {
> +		compatible = "altera,maxii";
> +		reg = <0xe8080000 0x80000>;
> +	};

Should this go under the localbus node?

-Scott
