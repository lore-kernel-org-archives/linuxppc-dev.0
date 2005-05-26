Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <80f48eb53b0f876138cde07a997791b6@embeddededge.com>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 16:41:09 +1000
Message-Id: <1117089669.9076.105.camel@gaston>
Mime-Version: 1.0
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


> > Well, The PCI IO space base just need to be in a global that is
> > referenced by _IO_BASE, it works fine, no need to hard code a mapping.
> 
> Sure you do.  No one ioremap()s PCI IO space.  It has to be hard wired
> somewhere.

And how does pmac do ? and chrp ? It's ioremap'ed by the host bridge
init code, and _IO_BASE is set to that value. That even works with
multiple domains using pointer arithmetic.

> To take advantage of BAT or CAM mapping, you need to wire these
> entries in conjunction with the way you have configured your PCI
> bridges.  You also have to set up the arrays so ioremap() will find 
> them.

io_block_mapping() as a way to set a BAT/CAM to speed up access to some
PCI resources make sense, and ioremap() can I think already find out
whether this is BAT-mapped or not. I don't see any way that can prevent
what I proposed.

> > Ugh ? Can you explain why it "doesn't have the proper effect" ?
> 
> Because you need a way to wire a virtual address mapping to
> a physical space before you have any way of allocating virtual space.

No, no, no.

> It's a chicken/egg problem, since ioremap_bot doesn't have a value
> until someone has set it, and you don't know where to set it until
> the board set up has determined the mapping from configuration
> options.

No.

ioremap_bot is set by MMU_init() and nowhere else, and to a constant
value (depending on HIGHMEM) and thus can perfectly be initialized
statically instead. It is _NOT_ intialized by io_block_mappingt() as I
explained already.


> > No. If you read properly, you'll see that it will _not_ initialize it 
> > if
> > it is 0, because the test virt < ioremap_bot will never be true (both
> > are unsigned long) before MMU_init() is called.
> 
> I think we are talking past each other.  The reason for that code
> in io_block_mapping() is so you can set multiple BAT/CAM entries,
> and the lowest (smallest) wired virtual address becomes the base
> of that space.  This way, you can use io_block_mapping() to set
> up BATs and CAMs, and get ioremap() to use them if set.

Ugh ??? Damn, you don't seem to understand that code at all.

But first, let's clear things up since you are mixing several different
things at least here. Let's make a list of _facts_ :

 - ioremap_bot. This is the "top" of the vmalloc space, and it can be
"pushed down" to make room for early allocations of virtual space (for
things like early ioremap) before full initialisation. This is
initialized by MMU_init(), which is called _after_ machine_init(), but
as I noted, it could/should be initialized statically instead. It is
initialized before ppc_md.setup_io_mappings() is called as well.

 - io_block_mapping() will push-down ioremap_bot as well if the mapping
requests a virtual address above KERNELBASE and below the current
ioremap_bot value. This is obviously necessary or further unrelated
vmalloc/ioremap's may be "allocated" to virtual addresses overlapping
the io_block_mapping() which is wrong. 

So there is nothing, I mean absolutely _nothing_ that prevents us from
"improving" io_block_mapping() so that it can request virtual space by
pushing ioremap_bot down the way ioremap() does when called early.

 - Both io_block_mapping() and ioremap() can/will call map_page(). The
former on CPUs without BATs or CAMs (or running out of them), the later
if the mapping requested is for a physical address that wasn't already
covered by a BAT or CAM. The only requirement for map_page() to work is
to be able to do pte_alloc_kernel(), which is implemented such that
when !mem_init_done, it does an early_get_page() which works using the
mem_pieces mecanism when bootmem hasn't be initialized yet ... That
means that both io_block_mapping() and ioremap() both _WORK_ at any time
after MMU_init(), or more specifically, from the time
ppc_md.setup_io_mappings() has been called. ioremap will simply allocate
virtual space by pushing ioremap_bot down, and I'm simply proposing to
add this ability to io_block_mapping() too. That will _not_ change
anything to the fact that io_block_mapping's done on BATs/CAMs will be
"recorded" in the array and thus futher ioremap's will be able to use
that etc etc etc...

 - There is _one_ important point to keep in mind, but that has always
been true: None of this work before MMU_init(), we may want to add some
BUG_ON() in there. BUG_ON(ioremap_bot == 0) would do the trick. Just in
case somebody tries to call these from platform_init().

So now, putting all the above together, what do we see ?

That the only real difference between io_block_mapping() and ioremap()
are:

 - The former allows you to setup hard code v->p mappings (but I've
showed several times now that it shouldn't be necessary anymore)

 - The former can use a "BAT" or "CAM" instead of page tables which can
be of some use for performances.

Now, what about:

 1) Adding to io_block_mapping() the ability to alloc dynamically the
virtual space. That would have 0 impact on drivers using ioremap (they
would still "benefit" from the speed up if they happen to map something
already covered by a BAT/CAM). _IO_BASE can already be a variable. Only
a few platforms hard-coding other things may need to be changed (but
that is step 1, no worry...)

 2) Getting rid of remaining hard coded mappings (heh, slowly, not all
at once, but that shouldn't be terribly difficult) and finally deprecate
the usage of io_block_mapping() with a hard coded virtual address.

 3) Heh, no more of these ? Cool ... Now the only remaining use of
io_block_mapping() is to setup those "fast" blocks to speed up some IOs.
Can we think about something like ... ahem... A special flag to pass to
__ioremap() that would make it use BATs/CAMs (the first one who says
that is complicated goes back to school, please !)

 4) ppc_md.setup_io_mappings is just a few instructions & 2 printk's
away from setup_arch(). (The common setup_arch). ppc_md.setup_arch() is
not that far away neither: ocp_init is done before, and xmon/kgdb stuff.
Do we really need that early callback _that_ early still ? can't
setup_arch() be early enough ?

> The io_block_mapping() has never been used to request
> virtual space, it's purpose is to wire virtual address spaces so
> others can use them.  If all you are doing is requesting an
> arbitrary virtual address to be allocated, just use ioremap().

No, this is not the _purpose_ of io_block_mapping(), though it's what it
does. It's purpose was lost in history :) There should be no reason ever
to want to wire virtual space. Which means the only purpose left here is
to setup mappings that are "faster" than normal page tables for critical
things.

> > Damn. What I am saying is that it's plain wrong to mess around with the
> > space between TASK_SIZE and KERNELBASE and we should tie them together.
> 
> Can we do that now?  The reason it wasn't done in the past was because
> of the Prep memory map, our PCI configuration, and assumptions of the
> macros/functions that managed those spaces.

PowerMac did that kind of cruft too, I fixed it in about 15 minutes a
few years ago. It's just a matter of killing those constants that
contain a virtual address and use variables instead. It's not like PCI
IO space or config space was a performance sensitive thing anyway :)

> You are missing the point.  The reason for io_block_mapping() isn't
> to allocate virtual space for someone, it's to _wire_ a space using an
> efficient mapping method so someone else can call ioremap() and
> get that wired access.  

But it can do that without wiring the virtual space ! That is my point.
That someone else will call ioremap with a physical address, ioremap
will figure out that it matches one of the BATs/CAMs and will return the
appropriate virtual address where this BAT/CAM is virtually mapped.
Wether that actual virtual address was hard-coded when
io_block_mapping() was called, or allocated dynamically by moving
ioremap_bot is totally irrelevant and doesn't change anything to the
effect on the driver calling ioremap.

> Based upon various configuration options,
> the board set up functions call io_block_mapping() to set up these
> spaces.  Then, ioremap() just finds them in the BAT or CAM array
> and says, "oh, it's a wired entry, I'll just compute the virtual address
> and return that."  Unless someone tells ioremap() there are BATs or
> CAMs, it won't use them.

And ? How does that invalidate any of my previous statements ?
> 
> > I don't see how that would be changed/affected in any way by making
> > io_block_mapping() capable of dynamically allocating it's virtual
> > space...
> 
> Ugh.  How do you know how much space is available?  How do you
> know what to wire using BATs or CAMs?  Someone has to do that.

Good, good, I'm not totally dismissing the usefulness of wiring some
memory using BATs and CAMs, just the fact that the virtual address is
hard coded. I don't see what is the problem with available space. That
space will be taken anyway. Since io_block_mapping() tend to be the
first thing done, it will get nicely aligned chunks of memory form
ioremap_bot, and there will be no wastage. Doesn't need to be hard coded
to obtain that result.
 
> The io_block_mapping isn't a replacement to ioremap(), nor is
> ioremap() a replacement for io_block_mapping().  They work together
> to provide wired virtual address mapping.  In essence, 
> io_block_mapping()
> tells ioremap() about wired entries.

Oh well, I've already explained what I think above, no need to repeat
myself again.

> > ....  but aim to change it so that it allocates it's virtual space
> 
> But, it can't.

But it CAN.

> That's the whole purpose of the function, to determine
> how much IO space can be mapped with BATs or CAMs, then to
> remove that space from the vmalloc pool and wire it into a contiguous
> space that can be covered by large mapping.

And what prevent the virtual address of that space to be calculated
instead of hard coded ?

> This is why it makes no sense to call io_block_mapping() with a zero
> for a virtual address and ask it to allocate some arbitrary space.

No, you don't make sense.

> What do you mean by "optimize"?  The whole purpose here is to
> force a mapping using a BAT or CAM.  You can't do that with arbitrary
> pages from vmalloc space.  You have to force the alignment and
> size of the space, and the only way to do that is by simply removing
> from the top of the vmalloc pool and giving it to ioremap().

Just having io_block_mapping() moving down ioremap_bot (with appropriate
alignement of course) would just do the trick :) Again, no need for the
caller to hard code that address.

Ben.
