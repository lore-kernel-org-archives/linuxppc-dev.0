Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 911B0DE525
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 02:37:41 +1000 (EST)
Message-ID: <47FE4268.2000504@freescale.com>
Date: Thu, 10 Apr 2008 11:38:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] FCC: fix confused base / offset
References: <20080409130610.GE10465@pengutronix.de>
	<20080409161110.GA5296@ld0162-tx32.am.freescale.net>
	<20080409165324.GF10465@pengutronix.de>
	<47FCFF64.9050109@freescale.com>
	<20080410104655.GH10465@pengutronix.de>
In-Reply-To: <20080410104655.GH10465@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sascha Hauer wrote:
> See bottom of this mail. The board really is a 8260 based board. Our
> bootloader does not fill in the clock values, so they are hardcoded. I'm
> not very sure about the muram entries because the dpram is organized
> slightly different on the 8260. It has some dedicated FCC space and I
> don't know how to properly encode this in the device tree.

I think the FCC space should just be left out.

>> Does the PHY negotiate OK?
> 
> Well I put some printks into the phy_read/write functions so I can say
> that it at least properly talks to the phy.

Do you get a console message indicating that the link came up?

> 	soc@f0000000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		device_type = "soc";
> 		compatible = "fsl,mpc8272", "fsl,pq2-soc";

Change the 8272 references to 8260.

> 		// Temporary -- will go away once kernel uses ranges for get_immrbase().
> 		reg = <f0000000 00053000>;

This can go away now.

> 		cpm@119c0 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
> 			reg = <119c0 30>;
> 			ranges;
> 
> 			muram@0 {
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 				ranges = <0 0 10000>;
> 
> 				data@0 {
> 					compatible = "fsl,cpm-muram-data";
> 					reg = <0 2000 8000 800>;

reg should be <0 4000>.  Don't include parameter RAM here.

> 			ethernet@11300 {

ethernet@11320

> 				device_type = "network";
> 				compatible = "fsl,mpc8272-fcc-enet",
> 				             "fsl,cpm2-fcc-enet";
> 				reg = <11320 20 8500 100 113b0 30>;

reg = <11320 20 8500 100 113b0 1>;

> 				local-mac-address = [ 80 10 20 30 40 50 ];
> 				interrupts = <21 2>;

interrupts = <21 8>;

-Scott
