Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
	<b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
Content-Type: text/plain
Date: Thu, 26 May 2005 07:44:20 +1000
Message-Id: <1117057460.5076.19.camel@gaston>
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


> However, there are "holes" in the VM space that are completely
> unused, and this is a precious resource.  The io_block_mapping()
> gives us the ability to stick things into those holes.  Usually, we
> would configure a system with a 2G user space, then use 
> io_block_mapping()
> to allocate the space between 0x80000000 and 0xc0000000.

This is a VERY BAD habit. Just set KERNELBASE to 0x80000000 if you do
that, an use io_block_mapping() dynamically the way I explained to alloc
from the top of the address space.

> The ioremap() isn't going to do this, unless we really make this
> smarter.  On many systems, this was also the mapping for the
> PCI space, so things like virt_to_xxx() were based on the assumptions
> of this mapping.  So, if a board port wanted to use the option of
> user task space configuration, it would have to also manage these
> fixed address spaces accordingly.

Well, The PCI IO space base just need to be in a global that is
referenced by _IO_BASE, it works fine, no need to hard code a mapping.
PCI memory space doesn't rely on any of this unless your platform code
is really screwy

> This is not as simple as making io_block_mapping() use ioremap VM
> space.  We have to find a way of managing all of the free kernel VM
> space and ensuring all of the mapping APIs for IO know about and
> utilize all of this space.

I'm not sure I understand your last sentence. As I explained, all we
need is to add to io_block_mapping() the _ability_ to allocate via
ioremap_bot. (I agree that it's a bit early to _deprecate it
completely_). That way, I don't break any existing setup. Then, we can
start adapting platforms (and making sure new ones) use a proper
mecanism instead of hard coding v->p mappings.

> Then, you better get in line behind me for arguing for much better
> VM space management in general :-)  Linux is horrible in this regard,
> and the replies I get are " ...  for efficiency you have to know the use
> of the spaces and the proper APIs to manage them ..."

That is out of topic. I'm talking about a specific issue, you are making
vague generalities.

> But, no one would use that because it doesn't have the proper effect.
> If this could be done, we would already be using ioremap().

Ugh ? Can you explain why it "doesn't have the proper effect" ?

> > Dan's point about io_block_mapping() supposedly "initializing"
> > ioremap_bot is bogus, unless I misunderstood him.
> 
> I never said that, but if you look at the code, it's exactly what it 
> does :-)

No. If you read properly, you'll see that it will _not_ initialize it if
it is 0, because the test virt < ioremap_bot will never be true (both
are unsigned long) before MMU_init() is called.

> Any mappings done between the top of user space and bottom of
> the kernel are simply forced and ignored by any Linux VM.  The
> io_block_mapping() is used to allocate BATs and CAMs and make
> them available for ioremap() of devices.  It allows us to map various
> devices into the ioremap space, take advantage of the efficiency of
> BATs or large page mappings, and still have devices use the ioremap()
> to find them.

Damn. What I am saying is that it's plain wrong to mess around with the
space between TASK_SIZE and KERNELBASE and we should tie them together.
I still don't see any reason why we couldn't have io_block_mappingt()
use the ioremap_bot technique to "allocate" virtual space dynamically at
the top of the address space. So far, none of your arguments contradicts
that.
 
> As I keep saying, somehow you have to lay out the virtual to physical
> mapping of devices using the efficiency of BATs and CAMs, and still
> make the ioremap() interface work.  The device driver just calls 
> ioremap(),
> but if you have a smart board set up function, it can set up an 
> efficient
> mapping using BATs or CAMs rather than 4k pages requiring TLB
> exceptions.

I don't see how that would be changed/affected in any way by making
io_block_mapping() capable of dynamically allocating it's virtual
space...

> We can either make ioremap() really complex with knowledge of all of
> these board configuration options so it can set up the BATs and CAMs,
> or we set it all up using some functions (like io_block_mapping) in the
> board set up and keep ioremap() a simple function.

I am not arguing that. Did you actually read my last mail ? I'm
effectively given up deprecating io_block_mapping() completely at this
point, but aim to change it so that it allocates it's virtual space
instead of hard-coding it using the ioremap_bot technique, which can
work at any time during boot, as early as you want.

> The current implementation of io_block_mapping does two very important
> functions.  One is this set up of efficient mapping for ioremap(), and 
> the
> other is to utilize the kernel VM space that isn't managed by Linux.

It isn't managed by Linux not because linux is bad, but because the
platforms do a stupid setup. Just move down KERNELBASE and linux will
happily manage that space for ioremap. 

> We are currently moving lots of the code to make use of ioremap() rather
> than assuming prior mapping, which is a nice thing, but it's costing us
> in terms of performance and resource utilization.

You can still eventually use an io_block_mapping() then to "optimize"
the mappings to some critical HW resources (PIC ?), I just don't want
thse v->p mapping to be hard coded.

Ben.
