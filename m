Return-Path: <dan@embeddededge.com>
In-Reply-To: <1117089669.9076.105.camel@gaston>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
	<1117089669.9076.105.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4a9d31a2d06786004054e2119aafd35d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 26 May 2005 15:32:32 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 26, 2005, at 2:41 AM, Benjamin Herrenschmidt wrote:

> io_block_mapping() as a way to set a BAT/CAM to speed up access to some
> PCI resources make sense, and ioremap() can I think already find out
> whether this is BAT-mapped or not. I don't see any way that can prevent
> what I proposed.

And that's the only way it should be used.  Calling io_block_mapping()
with a zero virtual address makes no sense.

> ioremap_bot is set by MMU_init() and nowhere else, and to a constant
> value (depending on HIGHMEM) and thus can perfectly be initialized
> statically instead. It is _NOT_ intialized by io_block_mappingt() as I
> explained already.

I'm only going to say this once more with an example.  A call to
io_block_mapping() may change ioremap_bot.   If ioremap_bot
is set to say 0xf0000000, and someone says ".. I need to allocate
more VM and phys space to my IO to make sure my devices are
covered "  will do an io_block_mapping(0xe0000000, 0xe0000000, size, 
flags)
This will then push ioremap_bot down to 0xe0000000 to ensure
calls made to ioremap() won't multiply map this space if the Linux
VM has not been initialized.


>  - io_block_mapping() will push-down ioremap_bot as well if the mapping
> requests a virtual address above KERNELBASE and below the current
> ioremap_bot value. This is obviously necessary or further unrelated
> vmalloc/ioremap's may be "allocated" to virtual addresses overlapping
> the io_block_mapping() which is wrong.

So, why are you telling me I don't understand the code when this is
what I've been trying to tell you for the last several days? :-)

> So there is nothing, I mean absolutely _nothing_ that prevents us from
> "improving" io_block_mapping() so that it can request virtual space by
> pushing ioremap_bot down the way ioremap() does when called early.

The io_block_mapping() is used in conjunction with setting up BATs or
CAMs that have size and alignment restrictions.  The io_block_mapping
is not a memory allocator and isn't intended to be used as a substitute
for ioremap().  If code is doing that, fix that and stop blaming a 
useful
set up function.

Somewhere, someone has to know all of these alignment concerns.
I think it's just easier to use a simple call to io_block_mapping with 
the
values you want for a particular processor/board port than to make up
some complex scheme for computing these values that is going to
vary among the different processors.

So, just leave ppc_md.setup_io_mappings, and if a board port chooses
to modify the mappings as an extension of MMU_init, then fine.  You
can achieve the same results by calling setbat() or settlbcam() and
managing those resources yourself, or you can get the advantage of
using io_block_mapping() to do it.  In the end, you have to allow
this to be done, so instead of calling io_block_mapping() I'll just
make all of the board set up functions call the appropriate functions
and update ioremap_bot, just like io_block_mapping() does.

>  - There is _one_ important point to keep in mind, but that has always
> been true: None of this work before MMU_init(), we may want to add some
> BUG_ON() in there. BUG_ON(ioremap_bot == 0) would do the trick. Just in
> case somebody tries to call these from platform_init().

There are various other horrible hacks we do to accommodate this, too 
:-)

> That the only real difference between io_block_mapping() and ioremap()
> are:
>
>  - The former allows you to setup hard code v->p mappings (but I've
> showed several times now that it shouldn't be necessary anymore)

As I have said, it is necessary for the proper alignment and allocation
of VM space so BATs/CAMs work and someone else doesn't multiply
map the space.

>  - The former can use a "BAT" or "CAM" instead of page tables which can
> be of some use for performances.

This is extremely important and something we have always done.
We already have too many performance issues with 2.6 to continually
disregard these features.

>  1) Adding to io_block_mapping() the ability to alloc dynamically the
> virtual space. That would have 0 impact on drivers using ioremap

Yes, it would have a big impact because you can't map BATs/CAMs
to arbitrary addresses.

> ... A special flag to pass to
> __ioremap() that would make it use BATs/CAMs (the first one who says
> that is complicated goes back to school, please !)

It is complicated, and I've spent more time in school than your age :-)
How do you know how many BATs are available?  How big? How
much to allocate?  In real-time embedded systems you need limits
and known resource allocation areas.  Often, these embedded systems
need careful tuning to make everything fit in the address spaces,
something that isn't going to be known or likely to be done correctly.

You need to work on a real production system that has resource
limitations.  Yes, we do count bytes of space used by the kernel, IO,
applications, flash, ram, everything, and they try to make it fit.  
Functions
like these are critical to make it happen.

If you don't want to use them, fine, but please don't be taking away
important features for embedded systems just because you don't
see a use for them or know how to use them correctly.

Anyway, I'm done.  If you want to remove it, then please fix up and test
all boards that use it.  Be prepared to see it emerge again when I
need this feature in embedded systems.

Thanks.


	-- Dan
