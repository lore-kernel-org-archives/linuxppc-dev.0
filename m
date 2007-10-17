Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D922EDDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 06:19:01 +1000 (EST)
Message-ID: <47166DF7.6060300@freescale.com>
Date: Wed, 17 Oct 2007 15:17:59 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: loading NOR flash from DT
References: <20071017192651.GA5192@Chamillionaire.breakpoint.cc>	<20071017144759.320209bd@weaponx.rchland.ibm.com>
	<20071017195542.GA5501@Chamillionaire.breakpoint.cc>
In-Reply-To: <20071017195542.GA5501@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sebastian Siewior wrote:
> 	flash@fc000000 {

It's probably not getting probed, because it's not under a probed bus.
Try adding the root node to the list passed to of_platform_bus_probe().

> 			compatible = "amd,s29gl512n", "cfi-flash";
> 			reg = <fc000000 4000000>;
> 			bank-width = <2>;
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			fs@0 {
> 					label = "fs";
> 					reg = <0 f80000>;
> 			};
> 			firmware@f80000 {
> 					label ="firmware";
> 					reg = <f80000 80000>;
> 					read-only;
> 			};
> 
> 	soc8544@e0000000 {

Missing }; for the flash node.

-Scott
