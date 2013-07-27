Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 010962C00F9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 10:18:08 +1000 (EST)
Date: Fri, 26 Jul 2013 19:17:57 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 7/8] powerpc/fsl_booke: make sure PAGE_OFFSET map to
 memstart_addr for relocatable kernel
To: Kevin Hao <haokexin@gmail.com>
References: <1372942454-25191-1-git-send-email-haokexin@gmail.com>
 <1372942454-25191-8-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372942454-25191-8-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu Jul  4 07:54:13 2013)
Message-ID: <1374884277.30721.39@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 07:54:13 AM, Kevin Hao wrote:
> @@ -1222,6 +1266,9 @@ _GLOBAL(switch_to_as1)
>  /*
>   * Restore to the address space 0 and also invalidate the tlb entry =20
> created
>   * by switch_to_as1.
> + * r3 - the tlb entry which should be invalidated
> + * r4 - __pa(PAGE_OFFSET in AS0) - pa(PAGE_OFFSET in AS1)
> + * r5 - device tree virtual address
>  */
>  _GLOBAL(restore_to_as0)
>  	mflr	r0
> @@ -1230,7 +1277,15 @@ _GLOBAL(restore_to_as0)
>  0:	mflr	r9
>  	addi	r9,r9,1f - 0b
>=20
> -	mfmsr	r7
> +	/*
> +	 * We may map the PAGE_OFFSET in AS0 to a different physical =20
> address,
> +	 * so we need calculate the right jump and device tree address =20
> based
> +	 * on the offset passed by r4.
> +	*/

Whitespace

> +	subf	r9,r4,r9
> +	subf	r5,r4,r5
> +
> +2:	mfmsr	r7
>  	li	r8,(MSR_IS | MSR_DS)
>  	andc	r7,r7,r8
>=20
> @@ -1249,9 +1304,19 @@ _GLOBAL(restore_to_as0)
>  	mtspr	SPRN_MAS1,r9
>  	tlbwe
>  	isync
> +
> +	cmpwi	r4,0
> +	bne	3f
>  	mtlr	r0
>  	blr
>=20
> +	/*
> +	 * The PAGE_OFFSET will map to a different physical address,
> +	 * jump to _start to do another relocation again.
> +	*/
> +3:	mr	r3,r5
> +	bl	_start
> +
>  /*
>   * We put a few things here that have to be page-aligned. This stuff
>   * goes at the beginning of the data segment, which is page-aligned.
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c =20
> b/arch/powerpc/mm/fsl_booke_mmu.c
> index 8f60ef8..dd283fd 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -224,7 +224,7 @@ void __init adjust_total_lowmem(void)
>=20
>  	i =3D switch_to_as1();
>  	__max_low_memory =3D map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> -	restore_to_as0(i);
> +	restore_to_as0(i, 0, 0);

The device tree virtual address is zero?

>  	pr_info("Memory CAM mapping: ");
>  	for (i =3D 0; i < tlbcam_index - 1; i++)
> @@ -245,30 +245,56 @@ void setup_initial_memory_limit(phys_addr_t =20
> first_memblock_base,
>  }
>=20
>  #ifdef CONFIG_RELOCATABLE
> -notrace void __init relocate_init(phys_addr_t start)
> +int __initdata is_second_reloc;
> +notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
>  {
>  	unsigned long base =3D KERNELBASE;
>=20
> -	/*
> -	 * Relocatable kernel support based on processing of dynamic
> -	 * relocation entries.
> -	 * Compute the virt_phys_offset :
> -	 * virt_phys_offset =3D stext.run - kernstart_addr
> -	 *
> -	 * stext.run =3D (KERNELBASE & ~0xfffffff) + (kernstart_addr & =20
> 0xfffffff)
> -	 * When we relocate, we have :
> -	 *
> -	 *	(kernstart_addr & 0xfffffff) =3D (stext.run & 0xfffffff)
> -	 *
> -	 * hence:
> -	 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> -	 *                              (kernstart_addr & ~0xfffffff)
> -	 *
> -	 */
>  	kernstart_addr =3D start;
> -	start &=3D ~0xfffffff;
> -	base &=3D ~0xfffffff;
> -	virt_phys_offset =3D base - start;
> +	if (!is_second_reloc) {

Since it's at the end of a function and one side is much shorter than =20
the
other, please do:

	if (is_second_reloc) {
		virt_phys_offset =3D PAGE_OFFSET - memstart_addr;
		return;
	}

	/* the rest of the code goes here without having to indent =20
everything */

Otherwise, please use positive logic for if/else constructs.

> +		phys_addr_t size;
> +
> +		/*
> +		 * Relocatable kernel support based on processing of =20
> dynamic
> +		 * relocation entries. Before we get the real =20
> memstart_addr,
> +		 * We will compute the virt_phys_offset like this:
> +		 * virt_phys_offset =3D stext.run - kernstart_addr
> +		 *
> +		 * stext.run =3D (KERNELBASE & ~0xfffffff) +
> +		 *				(kernstart_addr & =20
> 0xfffffff)
> +		 * When we relocate, we have :
> +		 *
> +		 *	(kernstart_addr & 0xfffffff) =3D (stext.run & =20
> 0xfffffff)
> +		 *
> +		 * hence:
> +		 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> +		 *                              (kernstart_addr & =20
> ~0xfffffff)
> +		 *
> +		 */
> +		start &=3D ~0xfffffff;
> +		base &=3D ~0xfffffff;
> +		virt_phys_offset =3D base - start;
> +		early_get_first_memblock_info(__va(dt_ptr), &size);
> +		/*
> +		 * We now get the memstart_addr, then we should check =20
> if this
> +		 * address is the same as what the PAGE_OFFSET map to =20
> now. If
> +		 * not we have to change the map of PAGE_OFFSET to =20
> memstart_addr
> +		 * and do a second relocation.
> +		 */
> +		if (start !=3D memstart_addr) {
> +			unsigned long ram;
> +			int n, offset =3D memstart_addr - start;
> +
> +			is_second_reloc =3D 1;
> +			ram =3D size;
> +			n =3D switch_to_as1();
> +			map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);

Do we really need this much RAM mapped at this point?  Why can't we =20
continue
with the same size TLB entry that we've been using, until the second
relocation?

> +			restore_to_as0(n, offset, __va(dt_ptr));
> +			/* We should never reach here */
> +			panic("Relocation error");

Where is execution supposed to resume?  It looks like you're expecting =20
it
to resume from _start, but why?  And where is this effect of
restore_to_as0() documented?

-Scott=
