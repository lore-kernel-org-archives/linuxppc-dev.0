From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14976.30150.97137.755604@tango.linuxcare.com.au>
Date: Wed, 7 Feb 2001 09:08:06 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
        linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow
In-Reply-To: <3A806D89.16B31EA0@mvista.com>
References: <3A6CCBDC.3D7B722A@mvista.com>
	<Pine.HPX.4.10.10101231050450.3872-100000@gra-ux1.iram.es>
	<14975.55035.835724.234984@tango.linuxcare.com.au>
	<3A806D89.16B31EA0@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> The PowerPC gives us the ability to utilize a huge virtual address
> space, and with newer processors a larger physical address space.
> Although on 32-bit processors we can't see all of this at once, it
> is there for us to use.  The only difference between a 32- and 64-bit
> PowerPC kernel implementation is that on the 64-bit you get to see
> all of the VM space all of the time, while the 32-bit system is
> scurrying around behind the scenes ensuring what you need to see
> is currently mapped.

I'm not sure what "scurrying around behind the scenes" you're talking
about.

Are you saying that when two tasks both have an object mapped, we
should be using the same virtual address in PPC terms (i.e. the 52 or
80-bit intermediate VA), and set up the segment registers for the 2
tasks with the same VSIDs?  I think that would be a really really bad
idea (for a start it limits the number of objects you can map to
around 10 or so).  Doing that would reduce the number of hash table
entries slightly but believe me, hash table space is not a problem.

> We are currently using VSIDs as a lazy TLB reloader, not for
> a large VM space context manager.  There shouldn't be any need

You're intent on solving a problem that doesn't exist, just because
the hardware can solve it.  On a 32-bit system, linux processes don't
want and indeed have no notion of a large VM space, if by large you
mean more than a few gigabytes.

And saying "lazy TLB reloader" is misleading.  Lazy TLB reloading is
what you do when your MMU doesn't have any support for MMU contexts,
in order to try to minimize TLB flushes.  Fortunately Linux knows
about MMUs that support MMU contexts.

> for CONFIG_HIGHMEM on PowerPC, and we should be able to map huge
> PCI spaces we see on the multiple bridge CPCI systems without
> any worry of running out of VM space.

On a 32-bit PPC you can't ever see more than 4GB of virtual address
space at once without changing mappings.  We really don't want to go
down the path of trying to use the segment registers like the bank
registers you used to get on 16-bit systems 25 years ago.  For
example, if we mapped in the highmem pages like this, it would
drastically limit the number of highmem pages that we could have
mapped in at once.

> The reason this is hard to realize today is we have built up a
> system with the assumption there is only a 32-bit virtual space,
> half of it consumed by a user task.  When I saw the VM changes
> happening during 2.3, I saw hoping we could take the opportunity
> to improve PowerPC performance with better MMU management.  Maybe
> someday I can work on it.

Let me know when you've rewritten the whole of the Linux generic MM
layer. :-)

The reason for having the user task space visible in the kernel is so
that copy_to_user/copy_from_user can go fast, without having to set up
any mappings or do any more than a range-check on the address.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Putting Open Source to work.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
