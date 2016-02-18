Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6682A1A04B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 01:22:57 +1100 (AEDT)
Message-ID: <1455805370.5284.13.camel@ellerman.id.au>
Subject: Re: [RFC 2/4] powerpc/mm: Add comments to the vmemmap layout
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Fri, 19 Feb 2016 01:22:50 +1100
In-Reply-To: <1455711179-20357-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-2-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-17 at 17:42 +0530, Anshuman Khandual wrote:

> Add some explaination to the layout of vmemmap virtual address
> space and how physical page mapping is only used for valid PFNs
> present at any point on the system.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 41 ++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 8d1c41d..9db4a86 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -26,6 +26,47 @@
>  #define IOREMAP_BASE	(PHB_IO_END)
>  #define IOREMAP_END	(KERN_VIRT_START + KERN_VIRT_SIZE)
>  
> +/*
> + * Starting address of the virtual address space where all page structs

This is so far from the variable it's referring to that it's not clear what it
refers to. So you should say "vmemmap is the starting ..."

> + * for the system physical memory are stored under the vmemmap sparse
                                              ^
					      , when using the SPARSEMEM_VMEMMAP
> + * memory model. All possible struct pages are logically stored in a
> + * sequence in this virtual address space irrespective of the fact
> + * whether any given PFN is valid or even the memory section is valid
> + * or not.

I know what you mean but I think that could be worded better. But it's too late
for me to reword it :)

The key point is that we allocate space for a page struct for each PFN that
could be present in the system, including holes in the address space (hence
sparse). That has the nice property of meaning there is a constant relationship
between the address of a struct page and it's PFN.

> + * During boot and memory hotplug add operation when new memory
                  ^                               ^
		  or				  ,
> + * sections are added, real physical allocation and hash table bolting
                                                  ^
						  of struct pages

> + * will be performed. This saves precious physical memory when the system
> + * really does not have valid PFNs in some address ranges.


> + *
> + *  vmemmap +--------------+
> + *     +    |  page struct +----------+  PFN is valid
> + *     |    +--------------+          |
> + *     |    |  page struct |          |  PFN is invalid
> + *     |    +--------------+          |
> + *     |    |  page struct +------+   |
> + *     |    +--------------+      |   |
> + *     |    |  page struct |      |   |
> + *     |    +--------------+      |   |
> + *     |    |  page struct |      |   |
> + *     |    +--------------+      |   |
> + *     |    |  page struct +--+   |   |
> + *     |    +--------------+  |   |   |
> + *     |    |  page struct |  |   |   |       +-------------+
> + *     |    +--------------+  |   |   +-----> |     PFN     |
> + *     |    |  page struct |  |   |           +-------------+
> + *     |    +--------------+  |   +---------> |     PFN     |
> + *     |    |  page struct |  |               +-------------+
> + *     |    +--------------+  +-------------> |     PFN     |
> + *     |    |  page struct |                  +-------------+
> + *     |    +--------------+           +----> |     PFN     |
> + *     |    |  page struct |           |      +-------------+
> + *     |    +--------------+           |    Bolted in hash table
> + *     |    |  page struct +-----------+
> + *     v    +--------------+


The things on the right are not PFNs, they're struct pages. Each one
corresponds to a PFN, but that relationship is derived from the vmemap layout,
not the physical layout.

I think it's more like:

	f000000000000000		  c000000000000000 (and also 0x0)
vmemmap +--------------+                  +--------------+
   +    |  page struct | +--------------> |  page struct |
   |    +--------------+                  +--------------+
   |    |  page struct | +--------------> |  page struct |
   |    +--------------+ |                +--------------+
   |    |  page struct | +       +------> |  page struct |
   |    +--------------+         |        +--------------+
   |    |  page struct |         |   +--> |  page struct |
   |    +--------------+         |   |    +--------------+
   |    |  page struct |         |   |
   |    +--------------+         |   |
   |    |  page struct |         |   |
   |    +--------------+         |   |
   |    |  page struct |         |   |
   |    +--------------+         |   |
   |    |  page struct |         |   |
   |    +--------------+         |   |
   |    |  page struct | +-------+   |
   |    +--------------+             |
   |    |  page struct | +-----------+
   |    +--------------+
   |    |  page struct | No mapping
   |    +--------------+
   |    |  page struct | No mapping
   v    +--------------+



Then there's the relationship between struct pages and PFNs:


                           page_to_pfn
                           +--------->
  vmemmap +--------------+             +-------------+
     +    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |              |
     |    +--------------+
     |    |              |
     |    +--------------+
     |    |              |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |              |
     |    +--------------+
     |    |              |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     |    +--------------+             +-------------+
     |    |  page struct | +---------> |     PFN     |
     v    +--------------+             +-------------+



cheers
