Date: Thu, 25 Sep 2003 12:56:53 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Roland Dreier <roland@topspin.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Any restrictions on DMA address boundry?
Message-ID: <20030925125653.A16002@home.com>
References: <52oex8kb07.fsf@topspin.com> <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0309251306450.12966-100000@spider.ancor.com>; from Bret.Indrelee@qlogic.com on Thu, Sep 25, 2003 at 01:15:15PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 25, 2003 at 01:15:15PM -0500, Bret Indrelee wrote:
> I've read through the old thread about short DMAs, but still there are
> things that aren't clear to me.
>
> What exactly is the issue?

The issue is confined to processors which do not support hardware
snooping of the external bus.  In this case, management of the
caches is performed in software.  Software cache management is
has a granularity of the processor's cache line size.  When a
buffer is allocated using the allowed methods (as defined in
DMA-mapping.txt) to obtain memory for use in DMA, there is
no guarantee that the buffer is cacheline aligned.  Imagine
one buffer allocated for internal driver management and another
buffer allocated for inbound DMA transactions from a bus
master.  They can share the same cacheline.  Inbound DMA
read transaction occurs, the usual streaming DMA API call is
made, and the platform-specific implementation invalidates the
entire cacheline.  This could corrupt the contents of the
allocated management buffer that is being accessed by the CPU
only.

> As I understand it, if there is a DMA to the same cache line as something
> that the CPU is referencing, you've got a cache problem.

On a certain type of processors, yes.

> Does it matter what type of transfer the PCI device is doing? If it
> always does 32-bit burst memory write transfers instead of memory
> write & invalidate does that make a difference?
>
> Right now, I'm interested in the PPC and x86 compatible (Pentium,
> Pentium 4, Geode) systems, trying to understand the differences and
> requirements of each.

Which PPCs?  Classic PPC != PPC8xx != PPC40x != Book E PPC. :)

PPC8xx and PPC4xx require software cache coherency.  If you want
your products to work on PPC44x (I hope you do, they are targetted
at markets where qlogic storage controllers are used) ensuring that
your DMA buffers are cacheline aligned at the head/tail is
important.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
