Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9104DDDFA8
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:46:12 +1100 (EST)
Message-ID: <4785246D.6090206@freescale.com>
Date: Wed, 09 Jan 2008 13:45:49 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
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
> Hi
> 
> We're trying to get a SMC serial port on a8280 to work.
> I cannot find any ecxamples on the binding, so we've tried to make one.
> 
> is this anywhere close to workable?
> 
> serial@11a80 {
> 	device_type = "serial";
> 	compatible = "fsl,mpc8280-smc-uart",
> 				 "fsl,cpm2-smc-uart";
> 	reg = <11a80 10 87fc 2>;

The current binding has the actual parameter ram block as the second reg 
property, not the two-byte pointer.  If your firmware doesn't initialize 
the pointer, you'll have to do it in platform code.

> 	interrupts = <4 8>;
> 	interrupt-parent = <&PIC>;
> 	fsl,cpm-brg = <7>;
> 	fsl,cpm-command = <01000000>;
> };

cpm-command should be <1d000000> for SMC1.

Otherwise, it looks OK.

-Scott
