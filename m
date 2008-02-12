Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Feb 2008 11:20:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212002030.GE18348@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211001451.GA11572@localhost.localdomain>
	<47AFB593.30805@pikatech.com>
	<20080211031110.GD11572@localhost.localdomain>
	<47AFC5E3.20101@pikatech.com>
	<20080211235958.GD18348@localhost.localdomain>
	<47B0F142.40206@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B0F142.40206@pikatech.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2008 at 08:07:14PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> > But the partitions are all the same size, so in Map 2 there's a great
> > big gap between Env and U-boot?  Or there's a great big gap before
> > FPGA?
> >   
> There's a great big gap before the FPGA, 63M worth. Before we got the 
> NAND working, we stored the kernel, the ramdisk image, and a persistent 
> store there. But we moved everything to the NAND and are now going to a 
> much smaller NOR chip.

Ok.

> >> The u-boot, env, and FPGA are anchored at the bottom of the flash. 
> >> Kernel is anchored at the top. Everything else goes in the middle.
> >>     
> >
> > Um.. so "bottom" actually means "high addresses" in the above?
> >   
> Yes. Top = offset 0, bottom = size-of-flash.

Um.. ok.  Not the way around I'd use, certainly...

> And there is a bug in the initial code, I have to update the reg length 
> field. 

Err.. now I'm doubly confused.  Initially I thought you'd need to
change the size part of reg somewhere, but your description above just
convinced me you didn't (because you were essentially just shifting a
4M map up into the high rather than low 4M of the 64M space).  Now
you're saying you do..

> I now have a Rev B board in my hands and tested that it works for 
> both Rev A and Rev B.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
