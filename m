Message-ID: <3A7082DF.CD7E8B61@mvista.com>
Date: Thu, 25 Jan 2001 14:47:43 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
References: <Pine.GSO.4.10.10101251858330.22965-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> The problem is the ia32 guys want to address 64GByte, what requires a
> 64bit physical address, what nobody can handle on 32bit Systems.

Heh....64Gbyte is nothing, just a few more bits beyond 32....you
don't need 64-bits for this.  In fact, I had a revelation last
night where I thought we could even do this quite transparently
on PowerPCs with VSIDs or even context registers, anything that
implictly gives us a few more bits of virtual address.  Later
on that.....

Of course, the quick solution today would be to just move the
kernel virtual address to a lower address.........no need for
highmem config at all.  It wouldn't give you the 64Gbyte, but it
would solve the immediate problem of 1G real memory.

> Please be careful with what you're doing, otherwise you have to rewrite it
> again for the real 2.5.

All I am doing is cleaning up a bunch of the PowerPC MM initialization
and mapping functions.  Just getting rid of ifdefs, duplication of
code and stuff like that.  I suspect we will be rewriting in 2.5,
and there is no sense to do it multiple times for different PPC
processor variants.

> For what exactly do you need such generic virt_to_phys? AFAIK 2.5 will go
> more page oriented, so drivers get a set of pages to work on.

All of the embedded PowerPC, and the new high end PowerPC all work
with page mapped TLBs.  The 'middle' processors, 6xx/7xx/74xx have
the BAT register enhancement that appears to be going away.  On the
embedded processors, all I/O is mapped through page tables, which
usually don't have 1:1 mapping.  The existing virt_to_phys and such
with just the arithmetic adjustment don't work on those.  Some
systems have big holes in the physical space, including physical
addresses that map "under" the fixed kernel virtual addresses.  You
have to get to those via page tables as well.

I don't know what you mean by more "page oriented" as that is the
way it works now.  We just use BATs in some cases for efficiency, but
you don't have to.

> ..... That will
> mean bounce buffer management will be moved into the drivers.

Oh geeze.......This kind of stuff should be very generic and even
be hidden.  If drivers want to know for some performance reason
that's OK, but they shouldn't have to know.

> ....... Either everything is done with pages or one
> has to store a virtual/physical address pair. Doing a generic conversion
> functions for the latter is often slower, so it's currently expected that
> drivers just store it themselves.

Oh great, yet another technology path we think we are inventing again.
I hope whoever gets blessed by Linus to work on this takes a serious
look at over 20 years of research and implementation by others.  Oh
well, I'll just hack my little mapping functions :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
