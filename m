Date: Tue, 10 Dec 2002 10:49:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, joakim.tjernlund@lumentis.se,
	Matt Porter <porter@cox.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
Message-ID: <20021210174911.GB14786@opus.bloom.county>
References: <20021206085909.B17918@home.com> <IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se> <15857.15826.513311.884408@argo.ozlabs.ibm.com> <3DF45D05.5030003@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3DF45D05.5030003@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Dec 09, 2002 at 11:06:13AM +0200, Pantelis Antoniou wrote:

[snip]
> Since I'm the one that started this thread let me make a few points.
>
> 1. The comment that consistent_alloc is tied to the PCI bus is valid,
> since the dma_handle is returned by a call to virt_to_bus(), with
> the virt_to_bus() being:
>
> /*
> * The PCI bus is inherently Little-Endian.  The PowerPC is being
> * run Big-Endian.  Thus all values which cross the [PCI] barrier
> * must be endian-adjusted.  Also, the local DRAM has a different
> * address from the PCI point of view, thus buffer addresses also
> * have to be modified [mapped] appropriately.
> */
> extern inline unsigned long virt_to_bus(volatile void * address)
> {
> #ifndef CONFIG_APUS
>        if (address == (void *)0)
>                return 0;
>        return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
> #else
>        return iopa ((unsigned long) address);
> #endif
> }

This is typically used by PCI, but look at the code for the !CONFIG_APUS
(ie just about every machine, including all 8xx) case.  This is the
iopa, that if classes haven't made me even more incoherent, that has
been mentioned throught the thread.

> Also the consistent_sync() takes as a direction argument values like
> PCI_DMA_FROMDEVICE.

This is unfortunate, but 'expected' for now.  These constants really
have nothing to do with PCI DMA, but DMA in general.  There was a hope
of fixing that in 2.5, but I don't recall if it happened (it might
have) yet.

> It has something obviously to do with a PCI bus. My board, and I believe
> most of the boards with a 8xx do not have a PCI bus.
>
> Is it possible to modify consistent_alloc to be something more
> generic?

It is already generic, it's just not obvious :(

> 2. I have a requirement to have my drivers loaded as modules.
> m8xx_cpm_hostalloc has a very simplistic implementation, which
> makes it unsuitable for something like that. I have some patches
> that fix both m8xx_cpm_hostalloc and 8xx_cpm_dpalloc by implementing
> a proper heap, with free space management and coalescing.
> What is the proper way to push them, and to whom?

<buck passing mode=on>Dan Malek still knows the most about the
8xx-specific portions of the kernel, so he should really speak up here
when he gets a moment</buck passing>

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
