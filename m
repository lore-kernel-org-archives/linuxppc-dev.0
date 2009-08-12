Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kp.nortel.com (zrtps0kp.nortel.com [47.140.192.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AE89CB7B70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:54:00 +1000 (EST)
Message-ID: <4A83442B.6080305@nortel.com>
Date: Wed, 12 Aug 2009 16:37:31 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Jumbo Frames, sil24 SATA driver, and kswapd0 page allocation
	failures
References: <BB99A6BA28709744BF22A68E6D7EB51F01FE4C90D0@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F01FE4C90D0@midas.usurf.usu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jonathan Haws wrote:
> All,
> 
> I am having some issues with my target and was hoping that someone
> could lend a hand.  I am using an AMCC 405EX (Kilauea) board running
> Linux kernel 2.6.31.
> 
> Here is the problem.  I have some code that receives jumbo frames via
> the EMAC, sticks the data in a buffer, and writes the data out to a
> solid-state SATA disk (using a Silicon Image 3531 controller).
> 
> What is happening is that I appear to be running out of memory and I
> cannot figure out why.  The closest thing I can tell is that the
> sil24 driver for the SATA controller does not seem to be releasing
> memory back to the kernel for some reason.  After some time of
> capturing data and logging it to disk, I get the following kernel
> dump:
> 
> kswapd0: page allocation failure. order:2, mode:0x4020 Call Trace:


I ran into something similar on e1000 a long time ago.  Notice the
"order 2".  That means that you're requesting 16KB of physically
contiguous memory from the kernel, or four physical pages.

It's possible to get into a scenario where there is lots of memory
available but it's all fragmented.  It looks like you have a 64K area
and a 128K area available still so you may not be hitting this, but you
might want to fix it anyways.

If the hardware supports it, the best way to deal with it is to set up
the driver so that it only ever deals in single pages.  See the page
split code in the current e1000/e1000e for examples of this.

Chris
