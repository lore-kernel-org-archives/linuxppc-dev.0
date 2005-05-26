Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <4a9d31a2d06786004054e2119aafd35d@embeddededge.com>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
	<1117057460.5076.19.camel@gaston>
	<80f48eb53b0f876138cde07a997791b6@embeddededge.com>
	<1117089669.9076.105.camel@gaston>
	<4a9d31a2d06786004054e2119aafd35d@embeddededge.com>
Content-Type: text/plain
Date: Fri, 27 May 2005 08:10:20 +1000
Message-Id: <1117145420.9076.144.camel@gaston>
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


> > ioremap_bot is set by MMU_init() and nowhere else, and to a constant
> > value (depending on HIGHMEM) and thus can perfectly be initialized
> > statically instead. It is _NOT_ intialized by io_block_mappingt() as I
> > explained already.
> 
> I'm only going to say this once more with an example.  A call to
> io_block_mapping() may change ioremap_bot.   If ioremap_bot
> is set to say 0xf0000000, and someone says ".. I need to allocate
> more VM and phys space to my IO to make sure my devices are
> covered "  will do an io_block_mapping(0xe0000000, 0xe0000000, size, 
> flags)
> This will then push ioremap_bot down to 0xe0000000 to ensure
> calls made to ioremap() won't multiply map this space if the Linux
> VM has not been initialized.

Damn, thanks for repeating what I've been explaining for 3 mails.
(Sorry, I admit, my wording above shouldn't have been "ioremap_bot is
set" but "ioremap_bot is initialized").

io_block_mapping() does _nothing_ much different than ioremap in that
regard, it just "pushes it down" to avoid further conflicts. That is
100% compatible to dynamically allocating.

> >  - io_block_mapping() will push-down ioremap_bot as well if the mapping
> > requests a virtual address above KERNELBASE and below the current
> > ioremap_bot value. This is obviously necessary or further unrelated
> > vmalloc/ioremap's may be "allocated" to virtual addresses overlapping
> > the io_block_mapping() which is wrong.
> 
> So, why are you telling me I don't understand the code when this is
> what I've been trying to tell you for the last several days? :-)

That is what _I_ have been trying to tell you, dammit ! That and the
fact that ioremap does the exact same thing :)

> The io_block_mapping() is used in conjunction with setting up BATs or
> CAMs that have size and alignment restrictions.  The io_block_mapping
> is not a memory allocator and isn't intended to be used as a substitute
> for ioremap().  If code is doing that, fix that and stop blaming a 
> useful set up function.

Ugh ? This is out of topic. Dynamically allocating the virtual space
doesn't in any way prevent setting up BAT or CAMs ...

> Somewhere, someone has to know all of these alignment concerns.

Yup, and io_block_mapping() does know, and that doesn't prevent it to
allocate virtual addresses dynamically. How many times should I repeat
the same thing before you get it ? In French maybe ?

> I think it's just easier to use a simple call to io_block_mapping with 
> the values you want for a particular processor/board port than to make up
> some complex scheme for computing these values that is going to
> vary among the different processors.

More complex scheme ? Ugh ... A mask ! that is complex ?!?! In fact, you
move the complexity to the writer of the support code :)

> So, just leave ppc_md.setup_io_mappings, and if a board port chooses
> to modify the mappings as an extension of MMU_init, then fine.  You
> can achieve the same results by calling setbat() or settlbcam() and
> managing those resources yourself, or you can get the advantage of
> using io_block_mapping() to do it.  In the end, you have to allow
> this to be done, so instead of calling io_block_mapping() I'll just
> make all of the board set up functions call the appropriate functions
> and update ioremap_bot, just like io_block_mapping() does.

Ugh ? I can't make any sense of the above. It looks like you are trying
hard not to understand what I'm saying and proposing.

> >  - There is _one_ important point to keep in mind, but that has always
> > been true: None of this work before MMU_init(), we may want to add some
> > BUG_ON() in there. BUG_ON(ioremap_bot == 0) would do the trick. Just in
> > case somebody tries to call these from platform_init().
> 
> There are various other horrible hacks we do to accommodate this, too 
> :-)

No, there are not. It doesn't work. Calling io_block_mapping or ioremap
before MMU_init() will screw you up. Period. 

> > That the only real difference between io_block_mapping() and ioremap()
> > are:
> >
> >  - The former allows you to setup hard code v->p mappings (but I've
> > showed several times now that it shouldn't be necessary anymore)
> 
> As I have said, it is necessary for the proper alignment and allocation
> of VM space so BATs/CAMs work and someone else doesn't multiply
> map the space.
> 
No it's not. First you are AGAIN mixing two different things.
Alignement, and multiple allocation of the virtual space.

 - Alignement can be dealt very easily. First, top-align the size (we
have to do that anyway), and then, do ioremap_bot -= size; and finally,
down-align ioremap_bot, and miracle ! you get your new virtual address !

 - Multiple allocation of virtual space: that is a non issue since we
are moving ioremap_bot down. That's also what ioremap does. There is NO
problem here, unless you try calling them before MMU_init() of course.

> >  - The former can use a "BAT" or "CAM" instead of page tables which can
> > be of some use for performances.
> 
> This is extremely important and something we have always done.
> We already have too many performance issues with 2.6 to continually
> disregard these features.

Nobody is disregarding that feature. You are again trying very hard not
to understand what I'm saying

> >  1) Adding to io_block_mapping() the ability to alloc dynamically the
> > virtual space. That would have 0 impact on drivers using ioremap
> 
> Yes, it would have a big impact because you can't map BATs/CAMs
> to arbitrary addresses.

Who is talking about arbitrary addresses ? It's just a matter of
aligning down properly ioremap_bot.

> > ... A special flag to pass to
> > __ioremap() that would make it use BATs/CAMs (the first one who says
> > that is complicated goes back to school, please !)
> 
> It is complicated, and I've spent more time in school than your age :-)

Maybe too much ? :)

> How do you know how many BATs are available?

We do, we have an index in the array, and we can even scan the array for
valid bits if we want to.

> How big? How much to allocate?  

The first size that fits the requested argument to ioremap, again, very
easy.

> In real-time embedded systems you need limits and known resource allocation areas.

Ugh ?

> Often, these embedded systems need careful tuning to make everything fit in the address
> spaces, something that isn't going to be known or likely to be done correctly.

Heh, again, ioremap_bot starts nicely aligned, so if you do your BAT
allocation (with either io_block_mapping() as I suggested or with a
modified ioremap) first thing first in setup_io_mappings(), they'll get
nicely aligned near the top of your address space and you won't "lose"
anything.

> You need to work on a real production system that has resource
> limitations.  Yes, we do count bytes of space used by the kernel, IO,
> applications, flash, ram, everything, and they try to make it fit.  
> Functions
> like these are critical to make it happen.

Bla bla bla bla... I've heard that way too much. It's the magical excuse
against anything.

> If you don't want to use them, fine, but please don't be taking away
> important features for embedded systems just because you don't
> see a use for them or know how to use them correctly.

No, it's not an "important" feature, and it can be safely removed
without problem. 

> Anyway, I'm done.  If you want to remove it, then please fix up and test
> all boards that use it.  Be prepared to see it emerge again when I
> need this feature in embedded systems.

No, you won't need it unless you do things wrong.

Ben.
