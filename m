Return-Path: <jan-hinnerk.dumjahn@arcor.de>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D28BBDDF18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 00:08:16 +1000 (EST)
From: Jan-Hinnerk Dumjahn <jan-hinnerk.dumjahn@arcor.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problems with PHY on STK5200
Date: Mon, 26 Mar 2007 16:07:57 +0200
References: <20070301185745.254BB353C3A@atlas.denx.de>
	<200703051712.29021.jan-hinnerk.dumjahn@arcor.de>
In-Reply-To: <200703051712.29021.jan-hinnerk.dumjahn@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703261607.57617.jan-hinnerk.dumjahn@arcor.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 05 March 2007 17:12, Jan-Hinnerk Dumjahn wrote:
> On Thursday 01 March 2007 19:57, Wolfgang Denk wrote:
> > In message <200703011216.57611.jan-hinnerk.dumjahn@arcor.de> you wrote:

[...]
> > > Can anybody explain what the driver should to? Or even better has some
> > > patch to make it work?
> >
> > The driver should work :-) And it certainly does for me.
>
> It certainly doesn't work for me ;-(
>
> All least newer versions of the kernel don't register
> "mdio_timer_callback()". So, link up report isn't working.
> This is caused by two occurences of the following code in
> mpc5xxx_fec_setup().
>
> if(!reinit) {
> ...
>   if(reinit) {
> ...
>   }
> ...
> }

I've done some more analysis: the following is a list of code/data in "fec.c" 
that is never used:

- lines 936-950 (if-clause)
- lines 1035-1069 (if-clause)
- mdio_timer_callback()
- mpc5xxx_fec_link_up()
- mii_display_status()
- phy_cmd_config
- mii_queue_config()
- mii_display_config()
- mii_do_cmd()

BTW: What is the status of the code guarded by CONFIG_USE_MDIO_NOT_YET?

Best regards
  Jan-Hinnerk Dumjahn
