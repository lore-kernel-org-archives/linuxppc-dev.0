Message-ID: <3DF45D05.5030003@intracom.gr>
Date: Mon, 09 Dec 2002 11:06:13 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Paul Mackerras <paulus@au1.ibm.com>
Cc: joakim.tjernlund@lumentis.se, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <20021206085909.B17918@home.com>	<IGEFJKJNHJDCBKALBJLLCEJGFIAA.joakim.tjernlund@lumentis.se> <15857.15826.513311.884408@argo.ozlabs.ibm.com>
In-Reply-To: <15857.15826.513311.884408@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Mackerras wrote:

>Joakim Tjernlund writes:
>
>
>>m8xx_cpm_hostalloc() does not keep the DMA handle and __pa() does not work
>>on addresses returned by m8xx_cpm_hostalloc(). I just found that out the
>>hard way when upgrading from MV 2.4.2 to linuxppc_2_4_devel 2.4.20. My SPI driver
>>hung as soon you tried to read something.
>>
>
>Then m8xx_cpm_hostalloc should be changed so it returns the DMA
>address along with the virtual address (of the uncached mapping).
>
>An alternative which will work, at least at present, is to use iopa()
>on the virtual address.  However, that assumes that DMA bus addresses
>are identical to CPU physical addresses.  That is true at the moment
>on all embedded PPC platforms that I know of currently, but there is
>no guarantee that it will always be true.  That is why I think it is
>better to make a practice of saving the DMA address that you get back
>from consistent_alloc and using that.
>
>Paul.
>
>
>
>
>
Since I'm the one that started this thread let me make a few points.

1. The comment that consistent_alloc is tied to the PCI bus is valid,
since the dma_handle is returned by a call to virt_to_bus(), with
the virt_to_bus() being:

/*
 * The PCI bus is inherently Little-Endian.  The PowerPC is being
 * run Big-Endian.  Thus all values which cross the [PCI] barrier
 * must be endian-adjusted.  Also, the local DRAM has a different
 * address from the PCI point of view, thus buffer addresses also
 * have to be modified [mapped] appropriately.
 */
extern inline unsigned long virt_to_bus(volatile void * address)
{
#ifndef CONFIG_APUS
        if (address == (void *)0)
                return 0;
        return (unsigned long)address - KERNELBASE + PCI_DRAM_OFFSET;
#else
        return iopa ((unsigned long) address);
#endif
}

Also the consistent_sync() takes as a direction argument values like
PCI_DMA_FROMDEVICE.

It has something obviously to do with a PCI bus. My board, and I believe most of the boards with a 8xx do not have a PCI bus.

Is it possible to modify consistent_alloc to be something more
generic?

2. I have a requirement to have my drivers loaded as modules.
m8xx_cpm_hostalloc has a very simplistic implementation, which
makes it unsuitable for something like that. I have some patches
that fix both m8xx_cpm_hostalloc and 8xx_cpm_dpalloc by implementing
a proper heap, with free space management and coalescing.
What is the proper way to push them, and to whom?

3. I have already posted my QMC driver, and I'm in the process
of writting some documentation and usage scenarios.
Could someone please have a look and get back to me.
I'm open to suggestions, and I would very much like to have it
included in the tree.
I know it is not perfect but still as it stands there are no QMC
drivers in the tree.

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
