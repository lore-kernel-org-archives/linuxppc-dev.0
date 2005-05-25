Return-Path: <dan@embeddededge.com>
In-Reply-To: <1117004659.6395.103.camel@gaston>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
	<1117004659.6395.103.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b9ca52306a8b84cc1e03ac72c65316cf@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Wed, 25 May 2005 12:36:30 -0400
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


On May 25, 2005, at 3:04 AM, Benjamin Herrenschmidt wrote:

>> Can one of you explain why this is necessary.  I believe it I just 
>> dont
>> understand.  I think this is one of the abuses of io_block_mapping().
>> People, myself included, realize some of the caveats implied by 
>> calling
>> io_block_mapping().
>
> Well, there are 2 different things here. io_block_mapping "moving"
> ioremap_bot, and my idea of having io_block_mapping "using" it...

It's more complicated than that.  The basic Linux kernel VM map is
kernel_base (usually 0xc0000000), kernel text, kernel data, VM guard,
VM alloc space, then ioremap space.

However, there are "holes" in the VM space that are completely
unused, and this is a precious resource.  The io_block_mapping()
gives us the ability to stick things into those holes.  Usually, we
would configure a system with a 2G user space, then use 
io_block_mapping()
to allocate the space between 0x80000000 and 0xc0000000.
The ioremap() isn't going to do this, unless we really make this
smarter.  On many systems, this was also the mapping for the
PCI space, so things like virt_to_xxx() were based on the assumptions
of this mapping.  So, if a board port wanted to use the option of
user task space configuration, it would have to also manage these
fixed address spaces accordingly.

This is not as simple as making io_block_mapping() use ioremap VM
space.  We have to find a way of managing all of the free kernel VM
space and ensuring all of the mapping APIs for IO know about and
utilize all of this space.

> Now, my idea is that I dislike the io_block_mapping() interface because
> we have to provide the virtual address. Which means, it forces us to
> create hard coded v->p mappings, and I consider hard coding virtual
> addresses a bad thing (for lots of reasons, including the TASK_SIZE
> one).

Then, you better get in line behind me for arguing for much better
VM space management in general :-)  Linux is horrible in this regard,
and the replies I get are " ...  for efficiency you have to know the use
of the spaces and the proper APIs to manage them ..."


> Thus, I think we could "extend" io_block_mapping() to be able to take
> "0" for virt, and return a virtual address.

But, no one would use that because it doesn't have the proper effect.
If this could be done, we would already be using ioremap().

> Dan's point about io_block_mapping() supposedly "initializing"
> ioremap_bot is bogus, unless I misunderstood him.

I never said that, but if you look at the code, it's exactly what it 
does :-)
Any mappings done between the top of user space and bottom of
the kernel are simply forced and ignored by any Linux VM.  The
io_block_mapping() is used to allocate BATs and CAMs and make
them available for ioremap() of devices.  It allows us to map various
devices into the ioremap space, take advantage of the efficiency of
BATs or large page mappings, and still have devices use the ioremap()
to find them.

As I keep saying, somehow you have to lay out the virtual to physical
mapping of devices using the efficiency of BATs and CAMs, and still
make the ioremap() interface work.  The device driver just calls 
ioremap(),
but if you have a smart board set up function, it can set up an 
efficient
mapping using BATs or CAMs rather than 4k pages requiring TLB
exceptions.

We can either make ioremap() really complex with knowledge of all of
these board configuration options so it can set up the BATs and CAMs,
or we set it all up using some functions (like io_block_mapping) in the
board set up and keep ioremap() a simple function.

The current implementation of io_block_mapping does two very important
functions.  One is this set up of efficient mapping for ioremap(), and 
the
other is to utilize the kernel VM space that isn't managed by Linux.
We are currently moving lots of the code to make use of ioremap() rather
than assuming prior mapping, which is a nice thing, but it's costing us
in terms of performance and resource utilization.

Thanks.


	-- Dan
