Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 16B7ADDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 02:47:19 +1000 (EST)
Date: Fri, 18 May 2007 11:46:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
Message-ID: <20070518164628.GA16825@ld0162-tx32.am.freescale.net>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
	<1179421139.8132.256.camel@rhino> <464CA302.9060707@freescale.com>
	<20070518005641.GA27350@localhost.localdomain>
	<464DB986.20205@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <464DB986.20205@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 18, 2007 at 09:34:46AM -0500, Timur Tabi wrote:
> We'll propose a spec once we have everything figured out.  Our current
> idea is to allow any node or property to have a conditional attached to
> it.  U-Boot will then scan the device tree, evaluate the conditional,
> and if it's false, delete the particular node/property.
> 
> U-Boot will be also be expanded to include the concept of "hardware
> options", whether the user and/or board-specific code can tell U-Boot
> that hardware option X is set to value Y. The conditions in the device
>   tree will be of the form "X == Y" (or X != Y, X > Y, etc).
> 
> For instance, on some board, if jumper 22 is on, then it means that the
> USB port is enabled.  If it's possible for software to scan the status
> of J22, then the board-specific code will do that, and it will create
> an environment variable "J22=ON".  The USB node in the device tree will
> have the conditional "J22 = ON".

I'd like to point out that what I originally proposed was much simpler
than this; it simply allowed a special section of the device tree to list
jumpers and other hw options, and associate a device tree fragment with
each possibility.  Something like this:

u-boot,hwoptions {
	J1 {
		description = "USB PHY selector";
		
		off {
			description = "USB internal PHY";
			
			tree {
				&usb {
					phy_type = "utmi_wide";
				};
			};
		};

		on {
			description = "USB external PHY";
			
			tree {
				&usb {
					phy_type = "ulpi";
				};
			};
		};
	};
};

The fragment that corresponds to the option that is either detected
automatically or specified by the user on the command line gets merged
into the main dts.  The u-boot,hwoptions tree gets removed before passing
to the kernel, to avoid confusion.  The descriptions can be used to
provide interactive help text, as an alternative to having to fetch the
manual to find jumper information.

I agreed with using conditionals at the dtc level, and having dtc
transform it into the above at the dtb level.  I'm not quite comfortable
with having general conditional expressions at the binary level.

-Scott
