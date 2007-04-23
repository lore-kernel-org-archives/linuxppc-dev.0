Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE1C6DDF05
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 06:59:52 +1000 (EST)
In-Reply-To: <20070423144052.261f68ad.kim.phillips@freescale.com>
References: <20070423144052.261f68ad.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5c96dd623e3a6737db48ab17c3550610@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v4] powerpc: document phy-connection-type property
Date: Mon, 23 Apr 2007 22:59:43 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Since ucc_geth is being migrated to use the phylib, the existing
> (undocumented) 'interface' property is being deprecated in favour
> of 'phy-connection-type'.

Okay.

> phy-connection-type is now maintained one-to-one with definitions
> in include/linux/phy.h, albeit in the form of a string.

That's sort-of accidental though :-)

> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1562,6 +1562,9 @@ platforms are moved over to use the 
> flattened-device-tree model.
>       network device.  This is used by the bootwrapper to interpret
>       MAC addresses passed by the firmware when no information other
>       than indices is available to associate an address with a device.
> +   - phy-connection-type : a string naming the controller/PHY 
> interface type,
> +     i.e., "mii" (default), "rmii", "gmii", "rgmii", "rgmii-id", 
> "tbi",
> +     or "rtbi".

Could you put this right after the "phy-handle" definition
please?

> @@ -1573,6 +1576,7 @@ platforms are moved over to use the 
> flattened-device-tree model.
>  		interrupts = <a0 0>;
>  		interrupt-parent = <700>;
>  		mac-address = [ 00 04 9f 00 23 23 ];
> +		phy-connection-type = "gmii";
>  		rx-clock = "none";
>  		tx-clock = "clk9";
>  		phy-handle = <212000>;

Same here.  It's nice to keep things grouped, it
improves understanding ;-)


Segher
