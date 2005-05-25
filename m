Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <0015d371e12596fecdefd971b4fb1e5a@freescale.com>
References: <1117000809.6395.92.camel@gaston>
	<0015d371e12596fecdefd971b4fb1e5a@freescale.com>
Content-Type: text/plain
Date: Wed, 25 May 2005 17:04:19 +1000
Message-Id: <1117004659.6395.103.camel@gaston>
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


> Can one of you explain why this is necessary.  I believe it I just dont 
> understand.  I think this is one of the abuses of io_block_mapping().  
> People, myself included, realize some of the caveats implied by calling 
> io_block_mapping().

Well, there are 2 different things here. io_block_mapping "moving"
ioremap_bot, and my idea of having io_block_mapping "using" it...

So basically, the vmalloc/ioremap space starts at the end of the memory
linear mapping, and ends at ... ioremap_bot :)

This value is initially set to the "top" of the space useable for
vmalloc/ioremap. It's possible however to do "early" ioremap's (that is
before the vmalloc subsystem is initialized, and thus before we can
dynamically allocate virtual regions). In this case, ioremap just moves
ioremap_bot down and uses the space between the new and the previous
value.

In order to avoid having "block" mappings done by io_block_mapping()
collide with ioremap/vmalloc space, io_block_mapping() also has this bit
of code:

	if (virt > KERNELBASE && virt < ioremap_bot)
		ioremap_bot = ioremap_base = virt;

Which will "move down" ioremap_bot as well if a block mapping ends up in
the kernel area.

Now, my idea is that I dislike the io_block_mapping() interface because
we have to provide the virtual address. Which means, it forces us to
create hard coded v->p mappings, and I consider hard coding virtual
addresses a bad thing (for lots of reasons, including the TASK_SIZE
one).

Thus, I think we could "extend" io_block_mapping() to be able to take
"0" for virt, and return a virtual address. That would be 100%
compatible with existing code. When taking "0" for virt,
io_block_mapping would just allocate virtual space like early
ioremap_bot does, by moving ioremap_bot downward (with appropriate
aligment restrictions). By returning the actual virtual address used, it
makes possible for the caller to know it :)

That way, io_block_mapping() _can_ be used without hard coding virtual
addresses, which would then be documented as the "preferred" thing to
do, and would avoid some of the headaches.

Now, there may be a slight issue with when is ioremap_bot initialized...

It is in bss, so it is 0 by default (which isn't really suitable). It's
only initialized in MMU_init(). Thus there is a problem using it before
MMU_init(). Does that ever happen ? If it does, things are broken, since
the test "virt < ioremap_bot" will always be false anyway, and thus
io_block_mapping() will "fail" to move down ioremap_bot, thus
potentially letting the kernel allocate vmalloc/ioremap space that
overlap the block mapping.

Dan's point about io_block_mapping() supposedly "initializing"
ioremap_bot is bogus, unless I misunderstood him.

Ben.
