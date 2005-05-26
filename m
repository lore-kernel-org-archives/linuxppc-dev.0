Return-Path: <dan@embeddededge.com>
In-Reply-To: <1117057460.5076.19.camel@gaston>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <80f48eb53b0f876138cde07a997791b6@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 26 May 2005 02:00:11 -0400
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


On May 25, 2005, at 5:44 PM, Benjamin Herrenschmidt wrote:

> This is a VERY BAD habit. Just set KERNELBASE to 0x80000000 if you do
> that, an use io_block_mapping() dynamically the way I explained to 
> alloc
> from the top of the address space.

Well, back when kernelbase was assumed in too many places
to be 0xc0000000, it was the only option.

> Well, The PCI IO space base just need to be in a global that is
> referenced by _IO_BASE, it works fine, no need to hard code a mapping.

Sure you do.  No one ioremap()s PCI IO space.  It has to be hard wired
somewhere.

> PCI memory space doesn't rely on any of this unless your platform code
> is really screwy

To take advantage of BAT or CAM mapping, you need to wire these
entries in conjunction with the way you have configured your PCI
bridges.  You also have to set up the arrays so ioremap() will find 
them.

> Ugh ? Can you explain why it "doesn't have the proper effect" ?

Because you need a way to wire a virtual address mapping to
a physical space before you have any way of allocating virtual space.
It's a chicken/egg problem, since ioremap_bot doesn't have a value
until someone has set it, and you don't know where to set it until
the board set up has determined the mapping from configuration
options.

> No. If you read properly, you'll see that it will _not_ initialize it 
> if
> it is 0, because the test virt < ioremap_bot will never be true (both
> are unsigned long) before MMU_init() is called.

I think we are talking past each other.  The reason for that code
in io_block_mapping() is so you can set multiple BAT/CAM entries,
and the lowest (smallest) wired virtual address becomes the base
of that space.  This way, you can use io_block_mapping() to set
up BATs and CAMs, and get ioremap() to use them if set.

The io_block_mapping() has never been used to request
virtual space, it's purpose is to wire virtual address spaces so
others can use them.  If all you are doing is requesting an
arbitrary virtual address to be allocated, just use ioremap().

> Damn. What I am saying is that it's plain wrong to mess around with the
> space between TASK_SIZE and KERNELBASE and we should tie them together.

Can we do that now?  The reason it wasn't done in the past was because
of the Prep memory map, our PCI configuration, and assumptions of the
macros/functions that managed those spaces.

> I still don't see any reason why we couldn't have io_block_mappingt()
> use the ioremap_bot technique to "allocate" virtual space dynamically 
> at
> the top of the address space. So far, none of your arguments 
> contradicts
> that.

You are missing the point.  The reason for io_block_mapping() isn't
to allocate virtual space for someone, it's to _wire_ a space using an
efficient mapping method so someone else can call ioremap() and
get that wired access.  Based upon various configuration options,
the board set up functions call io_block_mapping() to set up these
spaces.  Then, ioremap() just finds them in the BAT or CAM array
and says, "oh, it's a wired entry, I'll just compute the virtual address
and return that."  Unless someone tells ioremap() there are BATs or
CAMs, it won't use them.


> I don't see how that would be changed/affected in any way by making
> io_block_mapping() capable of dynamically allocating it's virtual
> space...

Ugh.  How do you know how much space is available?  How do you
know what to wire using BATs or CAMs?  Someone has to do that.
The io_block_mapping isn't a replacement to ioremap(), nor is
ioremap() a replacement for io_block_mapping().  They work together
to provide wired virtual address mapping.  In essence, 
io_block_mapping()
tells ioremap() about wired entries.

> ....  but aim to change it so that it allocates it's virtual space

But, it can't.  That's the whole purpose of the function, to determine
how much IO space can be mapped with BATs or CAMs, then to
remove that space from the vmalloc pool and wire it into a contiguous
space that can be covered by large mapping.

This is why it makes no sense to call io_block_mapping() with a zero
for a virtual address and ask it to allocate some arbitrary space.

> You can still eventually use an io_block_mapping() then to "optimize"
> the mappings to some critical HW resources (PIC ?), I just don't want
> thse v->p mapping to be hard coded.

What do you mean by "optimize"?  The whole purpose here is to
force a mapping using a BAT or CAM.  You can't do that with arbitrary
pages from vmalloc space.  You have to force the alignment and
size of the space, and the only way to do that is by simply removing
from the top of the vmalloc pool and giving it to ioremap().

Thanks.

	-- Dan
