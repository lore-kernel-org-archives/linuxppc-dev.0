From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14979.52033.305824.136422@gargle.gargle.HOWL>
Date: Fri, 9 Feb 2001 21:49:37 +1100 (EST)
To: David Edelsohn <dje@watson.ibm.com>
Cc: Dan Malek <dan@mvista.com>, Gabriel Paubert <paubert@iram.es>,
        tom_gall@vnet.ibm.com, linuxppc-commit@hq.fsmlabs.com,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <200102081900.OAA25574@mal-ach.watson.ibm.com>
References: <paulus@linuxcare.com.au>
	<14977.60657.871016.955014@diego.linuxcare.com.au>
	<200102081900.OAA25574@mal-ach.watson.ibm.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David,

> 	The POWER and PowerPC architectures specifically were designed
> with the larger "virtual" address space in mind.  Yes, a single context
> cannot see more than 32-bit address space at a time, but an operating
> system can utilize that for more efficent access to a larger address
> space.

I'm pretty partisan towards the PowerPC architecture and my preference
would always be to say that the PowerPC way is the best way.  But I
don't feel that I can say that the 32-bit PowerPC architecture
achieves this goal effectively.

The 64-bit PPC architecture is another story; there the "logical"
address space is big enough that you can have pointers for all your
data objects.  And the PPC MMU supports a full 64-bit logical address
with hardware TLB reloads, unlike alpha etc. which only give you a
virtual address space of 44 bits or so.  So in the rest of this I am
talking about the 32-bit PPC architecture only.

Anyway, the only way you have to access different parts of this large
"virtual" address space is to change segment registers.  And there are
only 16 of them - fewer in practice because you need some fixed ones
for kernel code and data, I/O, etc.  Which means that they are a
scarce resource which needs to be managed; you then need routines to
allocate and free segment registers, you probably need to refcount
them, and you have a problem tracking the lifetime of pointers that
you construct, you need to check for crossings over a segment
boundary, etc.

Maybe I'm unduly pessimistic - maybe there is a way for an operating
system to "utilize that for more efficent access to a larger address
space" as you say.  But I don't see it.

An interesting experiment for someone to try would be to somehow use a
set of segment registers (maybe the 4 from 0x80000000 to 0xb0000000)
to implement the HIGHMEM stuff.  It may be that that is a simple
enough situation that the software overhead is manageable.  One of the
questions to answer will be whether it is OK to limit each task to
having at most 3 highmem pages mapped in at any one time (I am
thinking we would need to reserve 1 segment register for kmap_atomic).
And then of course we would need to measure the performance to see how
much difference it makes.

> 	For instance, the rotating VSIDs are blowing away internally
> cached information about mappings and forcing the processor to recreate
> translations more often than necessary.  That causes a performance
> degradation.  Pre-heating the TLB can be good under certain circumstances.

How is "blowing away internally cached information" worse than doing
tlbie's?  We only rotate VSIDs when we have to flush mappings from the
MMU/hashtable.  And searching for and invalidating HPTEs takes
significant time itself.

For a flush_tlb_mm, where we have to invalidate all the mappings for
an entire address space, there is no question; changing the VSIDs is
faster than searching through the hash table, invalidating all the
relevant HPTEs, and doing tlbia (or the equivalent).  For a
flush_tlb_range, it depends on the size of the range; we can argue
about the threshold we use but I don't think there could be any
argument that for a very large range it is faster to change VSIDs.

> 	As I have mentioned before, the current design appears to be
> generating many hash table misses because it allocates a new VSID rather
> than unmapping multiple pages from the page table.  This also means that
> it cannot be exploiting the dirty bit in the page/hash table entry and
> presumably encounters double misses on write faults.

On a write access after a read access to a clean page, yes.  There is
only one fault taken if the first access is a write, or if the page is
already marked dirty when the first read access happens.

> 	One really needs to consider the design model for the PowerPC
> architecture and some of the microarchitecture optimizations utilizing the
> greater chip area in newer PowerPC processor implementations to know how
> to structure the PowerPC Linux VMM for best performance.  One needs to
> consider these issues when arguing for a design to defer work (like TLB
> entries) as well as considering the details of *how* the deferral is
> implemented (VSID shuffling) relative to the perceived benefit.

Well you clearly know more than me in this area, and we would
appreciate hearing whatever you are allowed to tell us :).  It sounds
like recent PPCs are being optimized for the way that AIX or similar
OS's use the MMU.  (Anyway, aren't all IBM's recent PPCs 64-bit?)

But in the end it's only the benchmarks that can tell us which
approach is the fastest.  And I suspect that sometimes the hardware
engineers don't take full account of the software overhead involved in
using the hardware features they provide. :)

I guess my response here boils down to two questions:

- how can an OS effectively make use of the segment registers to
  access different parts of the "virtual" address space when there are
  so few of them?

- how can it be faster to do a lengthy HPTE search-and-destroy
  operation plus a lot of tlbie's, instead of just changing the
  segment registers?

Paul.

--
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
