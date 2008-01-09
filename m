Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BF81DDF8D
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 09:30:18 +1100 (EST)
Message-ID: <47854AE1.7080802@freescale.com>
Date: Wed, 09 Jan 2008 16:29:53 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
> Ok we're now using
> serial@11a80 {
> 	device_type = "serial";
> 	compatible = "fsl,mpc8280-smc-uart",
> 				 "fsl,cpm2-smc-uart";
> 	reg = <11a80 10 0 40>;            // <base_address length
> parameter_ram_address length>
> 	interrupts = <4 8>;                 // Interrupt from table 4.3
> of mpc8280rm, interrupt is level or edge
> 	interrupt-parent = <&PIC>;
> 	fsl,cpm-brg = <7>;
> 	fsl,cpm-command = <1d000000>;       // Page and Sub-block code
> of the CPCR
> };

Looks good.

> Right now we're trying to just get a kernel to give us some serial
> output, so we can continue the porting job.
> We're unsig a cuImage (using the pq2fads code right now).
> 
> Now our problem is that the serial port is spitting out 0x0a's as fast
> as it can.

Don't forget to exclude the SMC parameter RAM from the muram data area 
in /soc/cpm/muram/data/reg.  If you have an older device tree binding 
that has no /soc/cpm/muram node, but instead has two resources in 
/soc/cpm/reg, you need to move to head-of-tree to get this to work.

-Scott
