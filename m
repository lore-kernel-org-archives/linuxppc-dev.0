Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1117819176.6517.290.camel@cashmere.sps.mot.com>
References: <1117614390.19020.24.camel@gaston>
	<1117614484.19020.27.camel@gaston> <1117783104.31082.151.camel@gaston>
	<1117819176.6517.290.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 13:06:37 +1000
Message-Id: <1118199997.6850.106.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Discuss: Adding OF Flat Dev Tree to ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2005-06-03 at 12:19 -0500, Jon Loeliger wrote:
> Ben and Folks,

Hi Jon !

> I've read through ppc64/kernel/prom.c and done some minor
> call-chain analysis rooted at the two functions:
>     early_init_devtree()
>     unflatten_device_tree()
> as they are apparently the only two referenced in the
> initial early boot up process.

Yes. The first one is called very early on ppc64 with MMU still
off (the ppc64 kernel can happily run C code without translation
due to a "feature" where the top 2 bits of addresses are ignored
in real mode, ppc32 will need to be a bit smarter here). 

It's basically used to extract some infos directly from the flattened
tree in order to construct the LMB list (list of memory blocks,
equivalent of ppc32's mem_pieces), get the platform number (though we
are thinking about killing that platform number thing) and get a few
other things that are used very early during boot.

It uses functions that iterate the flattened device-tree directly that
are currently not exported outside of prom.c but that may change,
especially if we remove the platform number, we may let the
ppc_md.probe() function use those to look at the device-tree
model/compatible properties.

The other function is called much later, with MMU enabled, to do the
actual expansion of the tree into a pointer based tree that can be more
easily walked & manipulated.

> My notion was to take the portion of prom.c rooted at
> these two functions and add them to the ppc32 line.
> 
> First, what portions of pp64/kernel/prom.c are obsolete?
> Anything?  You alluded to cleaning this up some, but I
> am not too familiar with it to know where that was headed.

Well, I want to remove pretty much all of the stuff done in
finish_device_tree(). That is the pre-parsed n_addrs/addrs and
n_intrs/intrs fields of struct device_node, and all the functions
involved in this parsing. I would then provide a better function to be
called externally to "on-demand" map an interrupt, and eventually to
process "reg" properties properly.

I also want to move the other unrelated stuff from struct device_node
like PCI gunk that we have on ppc64 to some separate structure that is
only used by PCI or VIO devices.

> Second, there is already a fairly similar prom.c file
> hanging out over in ppc32 land.  I _think_ it houses
> roughly the complementary code out of ppc64's prom.c
> that is NOT derived from the call chain derived from
> the above two functions.

Yes.

> Which leads me to the questions:  Is there, or should
> we create, a plan to factor the flat-dev-tree handling
> code into common or shared ppc code?  

Hrm... There is lot of code duplication in ppc vs. ppc64 land (and in
some case, we do actually use the same headers, that is,
include/asm-ppc64/something.h may just itself include the "asm-ppc"
version. Steven Rothwell here is working on patches to make that more
systematic for things that really should be identical, like termios.h
etc...

Regarding code in arch/ppc*, I'm not sure what the right approach would
be. I'd say first copy things around, and we'll what we end up with.

> I am reluctant
> to just outright clone and copy that code if it will
> ultimately "be the same" or even "mostly the same".
> It seems that the early_init_devtree() might then need
> to be refactored or duplicated for ppc32-land.

Sort-of. We don't run in the same context though. We need to call this
before MMU_init() on ppc32. Depending on the processor type that code
runs mapped by BATs or bolted TLBs or whatever trick is used that early
during boot and may not be able to access all of RAM. So you may need to
add additional restrictions on the location of the device-tree in memory
or run code in real mode if possible or whatever. We need the BookE
folks for example to look at this closely. On 6xx & friends, I think
only 16Mb. On POWER4 runninng 32 bits, RAM is bolted in the hash table
by prom_init.c but that's just a gross hack. etc...

> Are you anticipating the same r3,r4,r5 interface outlined
> in your 0.4 rev of the ppc4 OF spec to be used by the
> ppc32 world as well?  Seems like it just might...

Yes.

> Naturally, I'm willing to jump in here, just looking
> for a bit of global-direction from you. :-)

No problem :) We'll also want to refactor prom_init to be much more like
the ppc64 version, that is cut all ties between it and the rest of the
kernel (so it doesn't share any global) and so that it generates a
flattened tree and passes that to the kernel.

Ben.
 
