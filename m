Return-Path: <srs0=namw=4e=suse.de=msuchanek@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDrPP4cdKzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 20:57:29 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDrPP3wn2z8sv9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 20:57:29 +1000 (AEST)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wDrPN5Jbqz9s8H
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2017 20:57:28 +1000 (AEST)
Date: Fri, 28 Apr 2017 12:57:23 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v6 10/19] powerpc/mm/hash: Use context ids 1-4 for the
 kernel
Message-ID: <20170428125723.58860091@kitsune.suse.cz>
In-Reply-To: <1490875447-4016-10-git-send-email-mpe@ellerman.id.au>
References: <1490875447-4016-1-git-send-email-mpe@ellerman.id.au>
 <1490875447-4016-10-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

just a nit:

On Thu, 30 Mar 2017 23:03:58 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Currently we use the top 4 context ids (0x7fffc-0x7ffff) for the
> kernel. Kernel VSIDs are built using these top context values and
> effective the segement ID. In subsequent patches we want to increase
> the max effective address to 512TB. We will achieve that by
> increasing the effective segment IDs there by increasing virtual
> address range.
> 
> We will be switching to a 68bit virtual address in the following
> patch. But platforms like Power4 and Power5 only support a 65 bit
> virtual address. We will handle that by limiting the context bits to
> 16 instead of 19 on those platforms. That means the max context id
> will have a different value on different platforms.
> 
> So that we don't have to deal with the kernel context ids changing
> between different platforms, move the kernel context ids down to use
> context ids 1-4.
> 
> We can't use segment 0 of context-id 0, because that maps to VSID 0,
> which we want to keep as invalid, so we avoid context-id 0 entirely.
> Similarly we can't use the last segment of the maximum context, so we
> avoid it too.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> [mpe: Switch from 0-3 to 1-4 so VSID=0 remains invalid]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h | 60
> ++++++++++++++++-----------
> arch/powerpc/mm/mmu_context_book3s64.c        |  2 +-
> arch/powerpc/mm/slb_low.S                     | 20 +++------ 3 files
> changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> b/arch/powerpc/include/asm/book3s/64/mmu-hash.h index
> 52d8d1e4b772..a5ab6f5b8a7f 100644 ---
> a/arch/powerpc/include/asm/book3s/64/mmu-hash.h +++
> b/arch/powerpc/include/asm/book3s/64/mmu-hash.h @@ -491,13 +491,14 @@
> extern void slb_set_size(u16 size);
>   * We first generate a 37-bit "proto-VSID". Proto-VSIDs are generated
>   * from mmu context id and effective segment id of the address.
>   *
> - * For user processes max context id is limited to ((1ul << 19) - 5)
> - * for kernel space, we use the top 4 context ids to map address as
> below
> + * For user processes max context id is limited to MAX_USER_CONTEXT.
> +
> + * For kernel space, we use context ids 1-5 to map address as below:
This appears wrong.

>   * NOTE: each context only support 64TB now.
> - * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> - * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> - * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> - * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
> + * 0x00001 -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> + * 0x00002 -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> + * 0x00003 -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> + * 0x00004 -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
>   *
>   * The proto-VSIDs are then scrambled into real VSIDs with the
>   * multiplicative hash:
> @@ -511,15 +512,13 @@ extern void slb_set_size(u16 size);
>   * robust scattering in the hash table (at least based on some
> initial
>   * results).
>   *
> - * We also consider VSID 0 special. We use VSID 0 for slb entries
> mapping
> - * bad address. This enables us to consolidate bad address handling
> in
> - * hash_page.
> + * We use VSID 0 to indicate an invalid VSID. The means we can't use
> context id
> + * 0, because a context id of 0 and an EA of 0 gives a proto-VSID of
> 0, which
> + * will produce a VSID of 0.
>   *
>   * We also need to avoid the last segment of the last context,
> because that
>   * would give a protovsid of 0x1fffffffff. That will result in a
> VSID 0
> - * because of the modulo operation in vsid scramble. But the vmemmap
> - * (which is what uses region 0xf) will never be close to 64TB in
> size
> - * (it's 56 bytes per page of system memory).
> + * because of the modulo operation in vsid scramble.
>   */
>  
>  #define CONTEXT_BITS		19
> @@ -532,12 +531,19 @@ extern void slb_set_size(u16 size);
>  /*
>   * 256MB segment
>   * The proto-VSID space has 2^(CONTEX_BITS + ESID_BITS) - 1 segments
> - * available for user + kernel mapping. The top 4 contexts are used
> for
> - * kernel mapping. Each segment contains 2^28 bytes. Each
> - * context maps 2^46 bytes (64TB) so we can support 2^19-1 contexts
> - * (19 == 37 + 28 - 46).
> + * available for user + kernel mapping. VSID 0 is reserved as
> invalid, contexts
> + * 1-4 are used for kernel mapping. Each segment contains 2^28
> bytes. Each
> + * context maps 2^46 bytes (64TB).
> + *
> + * We also need to avoid the last segment of the last context,
> because that
> + * would give a protovsid of 0x1fffffffff. That will result in a
> VSID 0
> + * because of the modulo operation in vsid scramble.
>   */
> -#define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 5)
> +#define MAX_USER_CONTEXT	((ASM_CONST(1) << CONTEXT_BITS) - 2)
> +#define MIN_USER_CONTEXT	(5)
> +
> +/* Would be nice to use KERNEL_REGION_ID here */
> +#define KERNEL_REGION_CONTEXT_OFFSET	(0xc - 1)
>  
>  /*
>   * This should be computed such that protovosid * vsid_mulitplier
> @@ -671,21 +677,25 @@ static inline unsigned long get_vsid(unsigned
> long context, unsigned long ea, 
>  /*
>   * This is only valid for addresses >= PAGE_OFFSET
> - *
> - * For kernel space, we use the top 4 context ids to map address as
> below
> - * 0x7fffc -  [ 0xc000000000000000 - 0xc0003fffffffffff ]
> - * 0x7fffd -  [ 0xd000000000000000 - 0xd0003fffffffffff ]
> - * 0x7fffe -  [ 0xe000000000000000 - 0xe0003fffffffffff ]
> - * 0x7ffff -  [ 0xf000000000000000 - 0xf0003fffffffffff ]
>   */
>  static inline unsigned long get_kernel_vsid(unsigned long ea, int
> ssize) {
>  	unsigned long context;
>  
>  	/*
> -	 * kernel take the top 4 context from the available range
> +	 * For kernel space, we use context ids 1-4 to map the
> address space as
and this appears right - or at least consistent with the commit
message ... and the rest of the comment.

Thanks

Michal
