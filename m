Message-ID: <40EA74FA.5070608@fh-landshut.de>
Date: Tue, 06 Jul 2004 11:46:34 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC7455 DMA buffer strangeness
References: <Pine.LNX.4.58.0407051018590.388@corpster2>	 <1089102844.937.57.camel@localhost>  <40EA6739.2040408@fh-landshut.de> <1089106451.937.85.camel@localhost>
In-Reply-To: <1089106451.937.85.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Adrian!

Perhaps it is easier, if I explain what I want to do, why and perhaps to find  a
solution to that:

I have two kinds to access data on the VME bus via the Tundra Universe 2 PCI-VME
bridge:
1) Master Windows:
I want to access VME bus locations via memory pointer. The memory pointer is
dereferenced, translated by the MMU to a physical address, a cycle is generated
on the PCI (the physical address is from a I/O resource), the cycle is answered
by the Universe device (which is programmed to answer for the range of PCI
addresses defining the Master Window with a range of VME bus addresses). This
does only work since the pgprot_noncached() stuff is in my mmap() hook - and it
does work correctly.
2.) DMA:
A DMA buffer gets allocated with pci_alloc_consistent(), mapped to user space
via the mmap() hook, written to (only the write goes wrong on the 7455) and the
actual transfer (involving writing to the bridge registers) is triggered by an
ioctl().

 > It's certainly possible that part of the page has ended up in cache.
 >
 > Why are you trying to turn off cache coherency? This should all work if
 > your userspace mapping is cache coherent.

So - after your explanations - it seems like I do have a conflict of interest
there: using pgprot_noncached() kills coherency in my mmap() hook, so this maybe
a reason for DMA failing. pgprot_noncached is needed for Master Windows, so I
need it there.

First I will try out removing the pgprot_noncached() and try to test DMA again.
I'll let you know the results. If DMA works fine then, I need to devise a way to
differentiate between Master Window and DMA mmap() calls and treat them different.

If not, I'm really stumped... :(

Thanks,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
