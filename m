MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16554.45801.852216.765803@cargo.ozlabs.ibm.com>
Date: Wed, 19 May 2004 11:05:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Memory layout question
In-Reply-To: <Pine.LNX.4.33.0405161456020.1169-100000@lux32.if.fh-landshut.de>
References: <Pine.LNX.4.33.0405161456020.1169-100000@lux32.if.fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oliver Korpilla writes:

> This seems to work fine and dandy on the x86, and there seems to be
> something wrong on the PowerPC.

Well, first, what source tree are you using?  What kernel version?

> Actually the addresses returned by allocate_resource seem to come from
> system memory, because ioremap_nocache logs a debug statement that is only
> triggered if the remapping is below the high_memory bound. (And there
> already seems to be a virtual address associated with it - physical
> 0x40000000 is RAM 0xc<whatever> - kernel space, I guess)

That sounds truly weird.  What is the whole message that gets printed?
I suggest you add a printk to __ioremap to print the values of
high_memory and virt_to_phys(high_memory).

> But the address returned is 0x40000000 !! Isn't that the 2nd GB of address
> space? My board only has 512 MB of storage, and is only upgradable to 1GB,
> so shouldn't an address starting at 0x40000000 physically never be a
> memory address and never be below the high_memory bound?

You would think so.

> Can I even dereference an I/O memory pointer on the PowerPC? (It can be
> done on x86) I know, I know, I _should_ use readb and friends, but can it
> be done? Or _must_ I strictly use the macros because it won't work the
> other way round?

You can in fact dereference the return value from __ioremap, but it is
generally not a good idea unless you know that what you are accessing
is well-behaved memory.  PowerPC processors can reorder loads and
stores unless you put barriers in to prevent that, and read/write[bwl]
include barriers for that reason.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
