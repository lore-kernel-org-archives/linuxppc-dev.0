Return-Path: <dan@embeddedalley.com>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216]) by ozlabs.org (Postfix) with SMTP id 5AC7FDDE49
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 09:27:31 +1100 (EST)
In-Reply-To: <1171143649.20494.31.camel@localhost.localdomain>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
	<712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
	<1171075021.20494.0.camel@localhost.localdomain>
	<6CDAEEF1-B0ED-42E6-AA2C-6FD1CFCF462C@embeddedalley.com>
	<1171143649.20494.31.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8D2A12A2-EB11-497C-AF4C-FDD95088E968@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: Discussion about iopa()
Date: Sat, 10 Feb 2007 17:27:28 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 10, 2007, at 4:40 PM, Benjamin Herrenschmidt wrote:

> I still think that it's preferable to simply obtain the physical  
> address
> along with the virtual one when allocating/creating an object (and  
> thus
> have the allocator for those object types, like rheap for MURAM,  
> return
> it, the same way the coherent dma allocator does).

I'd agree, but we don't have any functions to deal with this.
It's been an issue ever since I ported the first 8xx many
years ago.  The arguments range from "it's too specialized"
or "fit it under something else" that isn't appropriate, or
it's yet another resource allocator with it's own set of
management APIs (which I think is silly, but seems to be
the way of Linux).  Worse, we just hack something to
"fix another day", which never happens :-)


> There's also another issue with iopa that isn't obvious at first look:
> It's racy vs. page tables being disposed on SMP machines

Considering it was done before any SMP support,
and was ignored when support was added, that's
not really an argument to not use it but rather to fix it.

> ....   though just saying "just
> sucks" is neither useful nor constructive.

About in line  with "I don't like it" :-)

> .....  If you think that some
> aspects of linux kernel memory handling should be done differently,  
> you
> are much welcome to propose alternatives

They have always been ignored, and never
accepted as small changes over time.  It seems
to be an all or nothing approach that I just
don't have the time to invest.

> Now, I don't completely agree with you that there are "fundamental"
> limitations in the way memory is managed.

Sure there are, but it's not for discussion here.

> ...  First let's get off the
> subject of "VM"

It's all about VM and the implicit connection Linux
makes between physical memory and virtual
addresses that makes this a problem.  There are
special allocators for the different types of "memory",
different ways of setting/finding any attributes (if
you can at all), and the pre-knowledge you need
about the address spaces so you can call proper
support functions.  There is no separation of
VM objects and what backs them, orthogonal
operations (to do something as simple as get
a physical address behind a virtual one regardless
of the backing store), the ridiculous need for something
like highmem and the yet another way to manage
that, the inability to have a separate kernel and
user VM space if I choose, the minimal support and
horrible hacks for 32-bit systems with greater than
32-bit physical addresses, the list goes on and on.....


> ....  as this is commonly used to represent the memory
> management of user processes which isn't what we are talking about  
> (and
> doesnt' suffer from any of the "limitations" you mention anyway.
>
> What we are talking about here is the management of the kernel memory
> address space.

I see.....  I now understand.....

Thanks.

	-- Dan
