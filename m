Return-Path: <jan-hinnerk.dumjahn@arcor.de>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1E3BDDF27
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 03:13:29 +1100 (EST)
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net
	[151.189.8.15])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 295DE12231
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 17:13:20 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 0ECE02D3802
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 17:13:19 +0100 (CET)
Received: from [192.168.1.51] (pD95FF933.dip.t-dialin.net [217.95.249.51])
	(Authenticated sender: jan-hinnerk.dumjahn@arcor.de)
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id C756D2B6A4C
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  5 Mar 2007 17:13:18 +0100 (CET)
From: Jan-Hinnerk Dumjahn <jan-hinnerk.dumjahn@arcor.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problems with PHY on STK5200
Date: Mon, 5 Mar 2007 17:12:28 +0100
References: <20070301185745.254BB353C3A@atlas.denx.de>
In-Reply-To: <20070301185745.254BB353C3A@atlas.denx.de>
MIME-Version: 1.0
Message-Id: <200703051712.29021.jan-hinnerk.dumjahn@arcor.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 01 March 2007 19:57, Wolfgang Denk wrote:

> In message <200703011216.57611.jan-hinnerk.dumjahn@arcor.de> you wrote:
> > I'm trying to compile a recent kernel from DENX "linuxppc_2_4_devel" for
> > my STK5200 using ELDK 3.1.1.
>
> It should compile and run fine.

It is compiling fine and it is basically working, but I get lot of receive 
errors on the link, making it (almost) unusable for NFS root file system.

If I connect the STK5200 directly to my workstation using a crossover cable, 
everything works fine.

> > It seems that the current kernel there is not configuring the PHY. It
> > looks like the link is configured for full-duplex (although it should be
> > configured half-duplex).
>
> What makes you think it should be half duplex only?

The old version (up to and including cc891b92c2540487be1eeba4b5d38c913570d339) 
is negotiating half duplex. My linux workstation is also using half duplex if 
plugged into the same hub (a D-Link DFE-905DX).

However, I'm not 100% sure that the PHY on STK5200 is operating with 
full-duplex, because the link status is not reported by the kernel.

> > BTW: What is the normal way to reference a commit in a git-repository? I
> > haven't seen any revision numbers.
>
> You specify the git commit ID.

I hope the number above is a commit-ID...

> > Can anybody explain what the driver should to? Or even better has some
> > patch to make it work?
>
> The driver should work :-) And it certainly does for me.

It certainly doesn't work for me ;-(

All least newer versions of the kernel don't register "mdio_timer_callback()". 
So, link up report isn't working.
This is caused by two occurences of the following code in mpc5xxx_fec_setup().

if(!reinit) {
...
  if(reinit) {
...
  }
...
}

Nevertheless, the MDIO-code is doing something useful. Without CONFIG_USE_MDIO 
I don't get a single packet through the network interface (using either hub 
or crossover-cable).

I'm willing to do further tests and provide more information. However, I need 
some advice on the direction, because I don't understand enough of the code, 
yet.

Best regards,
  Jan-Hinnerk Dumjahn
