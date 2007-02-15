Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <692d02b69479653f689a50a1257f43e9@kernel.crashing.org>
References: <20070213061026.5837FDDDE9@ozlabs.org>
	<e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org>
	<20070214002210.GE11491@localhost.localdomain>
	<45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org>
	<1171488643.20192.177.camel@localhost.localdomain>
	<7fa77edce7aeb8a41d03b8b422f7f71b@kernel.crashing.org>
	<1171500782.20192.204.camel@localhost.localdomain>
	<692d02b69479653f689a50a1257f43e9@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 13:22:43 +1100
Message-Id: <1171506164.20192.228.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-02-15 at 02:00 +0100, Segher Boessenkool wrote:
> >>> Note that the "open-pic" node does not have a "#address-cells"
> >>> property, so that  the number of cells for the parent unit interrupt
> >>> specifiers is 2 (which is the value of its "#interrupt-cells"
> >>> property).
> 
> > Yes, "missing" is equivalent to 0,
> 
> ...and the reason for that is that nodes without physical
> children should not _have_ a "#address-cells" property.
> 
> > but the common practice has always
> > been to specify it explicitely. Check existing Apple and IBM
> > device-trees for example.
> 
> You do realise how many other borderline (or outright
> wrong) things are done in those trees, right?
> 
> It doesn't really hurt to have a "#a = 0" prop, but it's
> better to just not have a #a prop if you shouldn't have one.

Let's have one for now. I think that's how I documented it and it works
fine while I'm not sure the kernel code will cope with not having it (it
may ... or not).

There are various issues with the OF bindings, especially the imap one
(and some pretty bad bugs in it) and that's one of the reason I prefer
not leaving anything to be "implicit" like this case. It want explicit
mention of #address-cells/#size-cells/#interrupt-cells at all levels
where they might enter the parser.

Ben.
