Date: Thu, 9 Oct 2003 09:37:20 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: General porting question
Message-ID: <20031009093720.A13184@home.com>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam> <20031008223518.A10052@home.com> <008c01c38e2d$27feac20$2803050a@JackyLam> <20031009063812.A11979@home.com> <001901c38e7b$0f6ed830$0202a8c0@homevl9biy3v7e>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001901c38e7b$0f6ed830$0202a8c0@homevl9biy3v7e>; from jackylam@astri.org on Thu, Oct 09, 2003 at 11:36:07PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 09, 2003 at 11:36:07PM +0800, Jacky Lam wrote:
>
> > Almost.
> >
> > You can not use virt_to_* on the address returned by
> > pci_alloc_consistent().
>
>     Why?

Because virt_to_*() is only defined for staticly mapped kernel virtual
addresses...consistent_alloc() is not guaranteed to return a staticly
mapped kernel virtual address so you can't use virt_to_*().  It is not
a generic address translation API.

>     By the way, this problem will only affect the consistency of dma buffer.
> In my case, it will only cause wrong output sound. But my card seems don't
> consume the dma and doesn't give any interrupt in return. It's fine on PC
> and I can receive interrupt if I write to the card's register to force an
> interrupt. What other possible porting problem can be here? Really
> strange....

Endianness issues as another person pointed out.  You still have to
solve these address munging issues.

> > You need to hold on to the dma_addr_t returned, perform
> > a bus_to_virt(dma_addr_t) and then a virt_to_* will work
> > on that address.
>
>     umm....then does   virt_to_phys(bus_to_virt(dma_addr_t))==dma_addr_t

No, dma_addr_t is not necessary they same as the physical address.
Your platform may have physical addresses mapped 1:1 with bus (PCI)
addresses but that is not always the case (PReP, many peer-to-peer
PCI systems. etc).

>                     or
>                 bus_to_virt(dma_addr_t)==pci_alloc_consistent() ?

No, the virtual address you get by doing a bus_to_virt(dma_addr_t)
is != to the address that will be returned by pci_alloc_consistent()
(on 4xx/8xx).

> > However, I'm not sure of the "PCI related memory space" you
> > are referring to.  "PCI memory space" has a distinct meaning
> > and the virt_to_*/*_to_bus APIs don't work there.  Those APIs
> > are only valid for system memory that is accessible through
> > inbound transactions by a PCI bus master.
> >
> > You can use virt_to_* on an address returned from kmalloc
> > or __get_free_pages.
>
>     I also don't understand....Could you or someone "invent" these things
> kindly give some brief explaination here (especially for the reason how
> consistent_alloc() is implemented)? I think it will benefit many PPC
> beginner. Thanks very much.

*consistent_alloc() has a "special" implementation for 4xx/8xx because
they do not snoop memory access by external bus masters.  In order to
allocate "consistent" memory it is necessary to create a cache inhibited
mapping to system memory in the vmalloc area.  Virtual addresses in
the vmalloc area cannot be translated using the virt_to_* APIs.

There are a number of threads on this topic if you check the archives.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
