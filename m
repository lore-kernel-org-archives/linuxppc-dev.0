Message-ID: <39EBE0E7.B9313EEE@mvista.com>
Date: Tue, 17 Oct 2000 01:17:27 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Tilmann Bitterberg <tibit-ibm@bitterberg.de>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
References: <Pine.LNX.4.21.0010161220230.1783-200000@karl.rchland.ibm.com> <14827.56089.260884.298273@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> ....  I personally think that the code in ioremap which
> assigns virt = phys for phys >= ioremap_base should go away.

Right, but that is just the most recent implementation for something
we have to admit exists and we integrate into your HIGHMEM and other
changes.  We have to allow, somehow, mapping of board control registers
or other resources that must be used prior to page tables or other
VM initialization.  Right now we map things in BATs or large TLB
entries and then use the code above (or some other variation) to
ensure the mapping sticks throughout the kernel lifetime.  I don't
think it has to be virt == phys (which is just convenient for assembly
set up), but the mapping has to remain consistent even after the kernel
VM has been initialized.  The reason virt == phys is convenient is
because we often access this space with and without the MMU enabled.
We would have to add some code in the places this is done to further
convert addresses, when right now we just write the functions without
any MMU assumptions.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
