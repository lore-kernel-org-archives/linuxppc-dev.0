Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15B4FDE11D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 05:14:10 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0GIE6tK011144
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 11:14:07 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0GIE6Mx027921
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:14:06 -0600 (CST)
Date: Fri, 16 Jan 2009 12:14:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: Daniel Ng <daniel.ng1234@gmail.com>
Subject: Re: Device Tree setup for 8272-based board
Message-ID: <20090116181405.GB722@ld0162-tx32.am.freescale.net>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 16, 2009 at 02:40:03PM +1100, Daniel Ng wrote:
> I've tried various values for 'console' but I'm quite certain 'ttyCPM0' is the
> one to use as this is what I was using when it was working with Linux 2.6.14
> and an old (pre-Device Tree) version of u-boot.

Yes, that is correct.  You can also leave it out and rely on
/chosen/linux,stdout-path.

> I've even tried enabling the 'Early serial debugging for Freescale CPM-based
> serial ports' option in the Kernel config. Unfortunately this doesn't result
> in any noticeable difference.
> 
> Can you explain why my board is freezing?
> 
> Here is my Device Tree. It is a stripped-down version of mpc8272ads.dts (PCI
> has been removed among many others). I have tried to minimise the tree just to
> keep things simple.
> 
> Perhaps I removed something I shouldn't have?-

You removed the brg node, but early debug output should still work
without it.

> /dts-v1/;
> 
> / {
> model = "HPXRED";
> compatible = "fsl,mpc8272ads";

Is it 100% compatible?  If not, change the compatible to something else
(and make sure your board code matches it).

Do you currently have mpc8272ads support enabled in the kernel?  If the
kernel doesn't find a matching ppc_md, you won't get any debug output. 

You can use udbg_printf() directly after the call to udbg_early_init()
though.

-Scott
