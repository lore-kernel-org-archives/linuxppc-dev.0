Message-ID: <001901c38e7b$0f6ed830$0202a8c0@homevl9biy3v7e>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam> <20031008223518.A10052@home.com> <008c01c38e2d$27feac20$2803050a@JackyLam> <20031009063812.A11979@home.com>
Subject: Re: General porting question
Date: Thu, 9 Oct 2003 23:36:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Almost.
>
> You can not use virt_to_* on the address returned by
> pci_alloc_consistent().

    Why?

    By the way, this problem will only affect the consistency of dma buffer.
In my case, it will only cause wrong output sound. But my card seems don't
consume the dma and doesn't give any interrupt in return. It's fine on PC
and I can receive interrupt if I write to the card's register to force an
interrupt. What other possible porting problem can be here? Really
strange....

>
> You need to hold on to the dma_addr_t returned, perform
> a bus_to_virt(dma_addr_t) and then a virt_to_* will work
> on that address.

    umm....then does   virt_to_phys(bus_to_virt(dma_addr_t))==dma_addr_t
                    or
                bus_to_virt(dma_addr_t)==pci_alloc_consistent() ?
>
> However, I'm not sure of the "PCI related memory space" you
> are referring to.  "PCI memory space" has a distinct meaning
> and the virt_to_*/*_to_bus APIs don't work there.  Those APIs
> are only valid for system memory that is accessible through
> inbound transactions by a PCI bus master.
>
> You can use virt_to_* on an address returned from kmalloc
> or __get_free_pages.

    I also don't understand....Could you or someone "invent" these things
kindly give some brief explaination here (especially for the reason how
consistent_alloc() is implemented)? I think it will benefit many PPC
beginner. Thanks very much.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
