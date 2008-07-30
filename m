Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA69CDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 31 Jul 2008 01:45:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m6UFjkO9006528 for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 08:45:46 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6UFjjkr028333
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 10:45:46 -0500 (CDT)
Date: Wed, 30 Jul 2008 10:45:45 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matvejchikov Ilya <matvejchikov@gmail.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
Message-ID: <20080730154545.GB25428@ld0162-tx32.am.freescale.net>
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
	<20080729193901.GC8051@ld0162-tx32.am.freescale.net>
	<8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 01:37:43PM +0400, Matvejchikov Ilya wrote:
> 			smc1: serial@11a80 {
> 				device_type = "serial";
> 				compatible = "fsl,cpm2-smc-uart";
> 				reg = <11a80 20 0 40>;
> 				interrupts = <4 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <7>;
> 				fsl,cpm-command = <1d000000>;
> 			};
> 
> 		};
> 
> (muram node for 2.6.25 is differs from muram node for the 2.6.26)
> 
> With this device tree I have a warning message from cpm_uart driver
> tells that the dts file needs to be updated.

Right, but does the serial port work?  If it works with this tree and not
with the new version, then that points to a problem in the dynamic pram
allocation.  Otherwise, I'm not sure what's causing the difference
between the two versions; you may want to bisect.

-Scott
