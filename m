Return-Path: <dgibson@ozlabs.org>
Date: Sun, 6 Jan 2008 14:44:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Message-ID: <20080106034408.GM4326@localhost.localdomain>
References: <477F12D1.2070109@pikatech.com> <200801051041.18173.sr@denx.de>
	<20080105122542.GH4326@localhost.localdomain>
	<4780491A.8080006@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4780491A.8080006@pikatech.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 05, 2008 at 10:20:58PM -0500, Sean MacLennan wrote:
> David Gibson wrote:
> >> I'm pretty sure that you don't need a board specific mapping driver
> >> for NOR flash. physmap_of should be exactly what you need. You just need
> >> to fill the device tree properties correctly.
> >>     
> >
> > Absolutely.  We should not be using C-coded maps in arch/powerpc
> 
> Ok a couple of questions. How do I find out the size of the NOR flash? 
> It was in a global in the ppc arch.

The flash size goes in the "reg" property of the flash node.

> Also, where is the best place to fixup the partitions? We have paritions 
> that must be at the top and ones that must be at the bottom, so we 
> dynamically setup the partitions based on the NOR size. The NOR size is 
> variable.

Ok, you can fix this up in the bootwrapper.

> And is it ok the name the paritions in the dts based on an index? I 
> notice others use an address, but since I don't know the address up 
> front I just used index numbers.

No, the node name must match the node's "reg" property, which is the
partition's offset.  If you're creating the partition nodess on the
fly in the bootwrapper you can get that right there.  I'm also hoping
soon to add a function to fixup node names to libfdt, which will then
be usable in the wrapper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
