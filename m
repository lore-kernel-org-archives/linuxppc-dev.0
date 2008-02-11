Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6B52DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 08:39:29 +1100 (EST)
Message-ID: <47B0C099.5030205@freescale.com>
Date: Mon, 11 Feb 2008 15:39:37 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: NM <therealshowman@yahoo.ca>
Subject: Re: MPC8272 FCC2 MDIO on Port D and FS_ENET
References: <235903.35949.qm@web32704.mail.mud.yahoo.com>
In-Reply-To: <235903.35949.qm@web32704.mail.mud.yahoo.com>
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

NM wrote:
> My problem is solved now after probing the lines, MDC was not showing 
> any activity.
> So, after explicitly setting the PD23 (MDC) to : OUTPUT/GPIO in 
> mpc8272_ads_pins and  it worked in
> 
> I'd previously thought about that, but I was sure that this was being 
> taken care of, but now that I'm thinking of it, I'm questioning my belief. 
> I think in the fs_enet/mii-bitbang.c: mdio_dir(..) it is supposed to 
> take care of this.

No, the mdc pin is static; only bits which need to be changed 
dynamically are dealt with in mii-bitbang.c.  Either the firmware or the 
platform code should set up static pins.

> But why I had to explictly set it initially beats me. 
> I wonder how this works in standard distribution.

It's probably set up by u-boot normally, at least if you boot from ethernet.

-Scott
