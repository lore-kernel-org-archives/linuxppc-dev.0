Return-Path: <srs0=9597=2p=mindchasers.com=ppc@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc79r5STYzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:09:04 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vc79r4w2nz8tDD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:09:04 +1100 (AEDT)
Received: from smtp.webfaction.com (mail6.webfaction.com [74.55.86.74])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vc79r1JMMz9s2P
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2017 16:09:04 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/mm: Fix page table dump build on non-Book3S
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1480582800-28597-1-git-send-email-mpe@ellerman.id.au>
From: "Robert E. Cochran" <ppc@mindchasers.com>
Message-ID: <e0d44bac-65ff-fca4-437c-42872eff8842@mindchasers.com>
Date: Sun, 5 Mar 2017 23:38:54 -0500
MIME-Version: 1.0
In-Reply-To: <1480582800-28597-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/01/2016 04:00 AM, Michael Ellerman wrote:
> In the recent commit 1515ab932156 ("powerpc/mm: Dump hash table") we
> added code to dump the hage page table. Currently this can be selected
> to build on any platform. However it breaks the build if we're building
> for a non-Book3S platform, because none of the hash page table related
> defines and so on exist. So restrict it to building only on Book3S.
>
> Similarly in commit 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
> we added code to dump the Linux page tables, which uses some constants
> which are only defined on Book3S - so guard those with an #ifdef.


Hello,

I was just building the mainline 4.11-rc1 tonight on an NXP P1010 / 
e500v2 with CONFIG_PPC_PTDUMP set.

I received a bunch of errors from dump_linuxpagetables.c  (as you can 
see below).

I realize now that CONFIG_PPC_PTDUMP  isn't for the e500, but I thought 
someone might want to know that enabling it causes the build of an 
e500v2 to fail.

Bob

   CC      arch/powerpc/mm/dump_linuxpagetables.o
../arch/powerpc/mm/dump_linuxpagetables.c: In function 'walk_pagetables':
../arch/powerpc/mm/dump_linuxpagetables.c:369:10: error: 
'KERN_VIRT_START' undeclared (first use in this function)
    addr = KERN_VIRT_START + i * PGDIR_SIZE;
           ^~~~~~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:369:10: note: each undeclared 
identifier is reported only once for each function it appears in
../arch/powerpc/mm/dump_linuxpagetables.c: In function 'populate_markers':
../arch/powerpc/mm/dump_linuxpagetables.c:383:37: error: 'ISA_IO_BASE' 
undeclared (first use in this function)
   address_markers[3].start_address = ISA_IO_BASE;
                                      ^~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:384:37: error: 'ISA_IO_END' 
undeclared (first use in this function)
   address_markers[4].start_address = ISA_IO_END;
                                      ^~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:385:37: error: 'PHB_IO_BASE' 
undeclared (first use in this function)
   address_markers[5].start_address = PHB_IO_BASE;
                                      ^~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:386:37: error: 'PHB_IO_END' 
undeclared (first use in this function)
   address_markers[6].start_address = PHB_IO_END;
                                      ^~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:387:37: error: 'IOREMAP_BASE' 
undeclared (first use in this function)
   address_markers[7].start_address = IOREMAP_BASE;
                                      ^~~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:388:37: error: 'IOREMAP_END' 
undeclared (first use in this function)
   address_markers[8].start_address = IOREMAP_END;
                                      ^~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c:392:38: error: 'VMEMMAP_BASE' 
undeclared (first use in this function)
   address_markers[9].start_address =  VMEMMAP_BASE;
                                       ^~~~~~~~~~~~
../arch/powerpc/mm/dump_linuxpagetables.c: In function 'ptdump_show':
../arch/powerpc/mm/dump_linuxpagetables.c:400:20: error: 
'KERN_VIRT_START' undeclared (first use in this function)
    .start_address = KERN_VIRT_START,
                     ^~~~~~~~~~~~~~~
../scripts/Makefile.build:294: recipe for target 
'arch/powerpc/mm/dump_linuxpagetables.o' failed
make[2]: *** [arch/powerpc/mm/dump_linuxpagetables.o] Error 1
/build/linux/Makefile:1002: recipe for target 'arch/powerpc/mm' failed
make[1]: *** [arch/powerpc/mm] Error 2
make[1]: Leaving directory '/build/linux/build_p1010'
Makefile:152: recipe for target 'sub-make' failed
make: *** [sub-make] Error 2




>
> Fixes: 1515ab932156 ("powerpc/mm: Dump hash table")
> Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/Kconfig.debug             | 4 ++++
>   arch/powerpc/mm/Makefile               | 4 ++--
>   arch/powerpc/mm/dump_linuxpagetables.c | 2 ++
>   3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 20cf770611ec..949258d412d0 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -366,4 +366,8 @@ config PPC_PTDUMP
>   
>   	  If you are unsure, say N.
>   
> +config PPC_HTDUMP
> +	def_bool y
> +	depends on PPC_PTDUMP && PPC_BOOK3S
> +
>   endmenu
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index f4ffe1f68ce9..5784682d7b63 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -42,5 +42,5 @@ obj-$(CONFIG_NOT_COHERENT_CACHE) += dma-noncoherent.o
>   obj-$(CONFIG_HIGHMEM)		+= highmem.o
>   obj-$(CONFIG_PPC_COPRO_BASE)	+= copro_fault.o
>   obj-$(CONFIG_SPAPR_TCE_IOMMU)	+= mmu_context_iommu.o
> -obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o \
> -				   dump_hashpagetable.o
> +obj-$(CONFIG_PPC_PTDUMP)	+= dump_linuxpagetables.o
> +obj-$(CONFIG_PPC_HTDUMP)	+= dump_hashpagetable.o
> diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
> index d242bc79ae64..49abaf4dc8e3 100644
> --- a/arch/powerpc/mm/dump_linuxpagetables.c
> +++ b/arch/powerpc/mm/dump_linuxpagetables.c
> @@ -159,6 +159,7 @@ static const struct flag_info flag_array[] = {
>   		.set	= "no cache",
>   		.clear	= "        ",
>   	}, {
> +#ifdef CONFIG_PPC_BOOK3S_64
>   		.mask	= H_PAGE_BUSY,
>   		.val	= H_PAGE_BUSY,
>   		.set	= "busy",
> @@ -183,6 +184,7 @@ static const struct flag_info flag_array[] = {
>   		.val	= H_PAGE_F_SECOND,
>   		.set	= "f_second",
>   	}, {
> +#endif
>   		.mask	= _PAGE_SPECIAL,
>   		.val	= _PAGE_SPECIAL,
>   		.set	= "special",
