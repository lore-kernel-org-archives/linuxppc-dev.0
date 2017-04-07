Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w007j2hkrzDqKG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 23:01:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, christophe.leroy@c-s.fr
Subject: Re: [PATCH V4] powerpc/hugetlb: Add ABI defines for supported HugeTLB
 page sizes
In-Reply-To: <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
References: <5fb76b92-2988-1207-2bed-814a96e6a51a@linux.vnet.ibm.com>
 <20170407035539.21688-1-khandual@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 23:01:03 +1000
Message-ID: <87lgrcgynk.fsf@concordia.ellerman.id.au>
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

> This just adds user space exported ABI definitions for 2MB, 16MB, 1GB,
> 16GB non default huge page sizes to be used with mmap() system call.

I updated this for you to include all the sizes.

> diff --git a/arch/powerpc/include/uapi/asm/mman.h b/arch/powerpc/include/uapi/asm/mman.h
> index 03c06ba..ebe99c7 100644
> --- a/arch/powerpc/include/uapi/asm/mman.h
> +++ b/arch/powerpc/include/uapi/asm/mman.h
> @@ -29,4 +29,18 @@
>  #define MAP_STACK	0x20000		/* give out an address that is best suited for process/thread stacks */
>  #define MAP_HUGETLB	0x40000		/* create a huge page mapping */
>  
> +/*
> + * These constant defines should be used for creating the
> + * 'flags' argument (26:31 bit positions) for mmap() system
> + * call should the caller decide to use non default HugeTLB
> + * page size.
> + */

And I reworded the comment the make it clearer (I think) that most users
shouldn't need to use these, and should just use the default size:

/*
 * When MAP_HUGETLB is set bits [26:31] encode the log2 of the huge page size.
 * A value of zero indicates that the default huge page size should be used.
 * To use a non-default huge page size, one of these defines can be used, or the
 * size can be encoded by hand. Note that on most systems only a subset, or
 * possibly none, of these sizes will be available.
 */


Also do you want to send a patch to the man page?

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man2/mmap.2#n248

cheers
