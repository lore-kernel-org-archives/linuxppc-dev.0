Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D8E31A0359
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 01:49:37 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 07:49:35 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 14E0F3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:49:22 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HEnL3Z22413380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:49:21 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HEnLOP029156
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 07:49:21 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC 2/4] powerpc/mm: Add comments to the vmemmap layout
In-Reply-To: <1455711179-20357-2-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1455711179-20357-2-git-send-email-khandual@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 20:19:17 +0530
Message-ID: <87egcbz91u.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> Add some explaination to the layout of vmemmap virtual address
> space and how physical page mapping is only used for valid PFNs
> present at any point on the system.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


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
> + * for the system physical memory are stored under the vmemmap sparse
> + * memory model. All possible struct pages are logically stored in a
> + * sequence in this virtual address space irrespective of the fact
> + * whether any given PFN is valid or even the memory section is valid
> + * or not. During boot and memory hotplug add operation when new memory
> + * sections are added, real physical allocation and hash table bolting
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
> + *
> + * VMEMMAP_BASE (0xf000000000000000) region has a total range of 64TB but
> + * then it uses NR_MEM_SECTIONS * PAGES_PER_SECTION * sizeof(page struct)
> + * amount of virtual memory from it.
> + */
>  #define vmemmap			((struct page *)VMEMMAP_BASE)
>
>  /* Advertise special mapping type for AGP */
> -- 
> 2.1.0
