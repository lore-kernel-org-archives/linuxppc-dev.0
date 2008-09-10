Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A7188DE2F0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Sep 2008 01:57:23 +1000 (EST)
Message-ID: <48C7EE10.40500@freescale.com>
Date: Wed, 10 Sep 2008 10:56:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: skepper@ukf.net
Subject: Re: Not probing devices on PowerPC MPC8247 and kernel 2.6.26
References: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
In-Reply-To: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Chris Skepper wrote:
> Hi All,
> 
> I have an MPC8247 based board.  I can get the SMC1 console working, but 
> the other SCCx serial ports and the FCC1 ethernet doesn't work.
> 
> It appears that a part of the problem is that the probe methods are not 
> called.  The "match" table stuff all looks fine and the serial ports and 
> ethernet are defined in the .dts file. The module init function is 
> called, but the probe methods are not reached. It seems driver_register 
> gets called, so why doesn't something call probe?
> 
> Is there likely to be some problem with the bus setup?

Are you calling of_platform_bus_probe() from your platform code, and do 
the soc and cpm nodes match the bus list (I recommend using compatible = 
"simple-bus")?

-Scott
