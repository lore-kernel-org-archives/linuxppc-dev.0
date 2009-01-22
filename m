Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03C08DDEF8
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 04:36:27 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0MHaOq7019738
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 10:36:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0MHaNPW019043
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 11:36:23 -0600 (CST)
Date: Thu, 22 Jan 2009 11:36:22 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng99 <daniel_ng11@lycos.com>
Subject: Re: [MPC8272ADS]Cannot start my Linux Kernel
Message-ID: <20090122173622.GA18427@ld0162-tx32.am.freescale.net>
References: <496F4760.1010007@denx.de>
	<8cad0aa0901150706u72538941rbc22655d5a8905ea@mail.gmail.com>
	<8cad0aa0901160406l3db9c025ubdcac40b4b464d23@mail.gmail.com>
	<20090116172903.GA722@ld0162-tx32.am.freescale.net>
	<8cad0aa0901160944l48bd0e99wa13f23907838376d@mail.gmail.com>
	<8cad0aa0901160953te6c7d1cg3a4df7de7da7d182@mail.gmail.com>
	<4970CBA9.60809@freescale.com>
	<8cad0aa0901200256n6122d17eh90f56e9cb8cae775@mail.gmail.com>
	<20090120163155.GA8978@ld0162-tx32.am.freescale.net>
	<21593750.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <21593750.post@talk.nabble.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 06:15:26PM -0800, Daniel Ng99 wrote:
> So the brg node looks like this-
> 
>       brg@119f0 {
>         compatible = "fsl,mpc8272-brg",
>                      "fsl,cpm2-brg";
>         reg = <0x119f0 0x10 0x115f0 0x10>;
>         clock-frequency = <0>;
> 
> But aren't the BRG registers 32 bits, so shouldn't we use?:
> 
>        reg = <0x119f0 0x20 0x115f0 0x20>;

reg lengths are bytes, not bits.

> -either way, changing these values doesn't seem to make a difference in my
> board's behaviour. Why?

The change above told it that the system has 16 BRGs rather than 8. 
However, this change did not affect the position of the BRG1 register.

> Regarding the following line in the serial@11a00 node:
> 
> fsl,cpm-brg = <1>;
> 
> -If I change the above number to anything other than 1 (even nonsense like
> '99') then it also seems to work. Why? 

Because BRG1 is already set up by u-boot.

> Adding 'clock-frequency = <0>;' to the brg node doesn't seem to make a
> difference to my board's behaviour.

Try setting it to the actual BRG clock.

-Scott
