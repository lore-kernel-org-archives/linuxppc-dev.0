Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 067FE2C064D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 05:58:47 +1000 (EST)
Date: Thu, 27 Jun 2013 14:58:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1372298434-20220-2-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Wed Jun 26 21:00:33 2013)
Message-ID: <1372363114.8183.54@snotra>
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

On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> This is based on the codes in the head_44x.S. Since we always align to
> 256M before mapping the PAGE_OFFSET for a relocatable kernel, we also
> change the init tlb map to 256M size.

Why 256M?

This tightens the alignment requirement for dynamic memstart.  And what =20
about boards with less than 256 MiB of RAM?

> @@ -176,6 +176,8 @@ skpinv:	addi	r6,r6,1				=20
> /* Increment */
>  /* 7. Jump to KERNELBASE mapping */
>  	lis	r6,(KERNELBASE & ~0xfff)@h
>  	ori	r6,r6,(KERNELBASE & ~0xfff)@l
> +	rlwinm	r7,r25,0,4,31
> +	add	r6,r7,r6

Please consider using the more readable form of rlwinm/rlwimi:

	rlwinm	r7,r25,0,0x0fffffff

>  #elif defined(ENTRY_MAPPING_KEXEC_SETUP)
>  /*
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =20
> b/arch/powerpc/kernel/head_fsl_booke.S
> index d10a7ca..c3b4c8e53 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -83,10 +83,43 @@ _ENTRY(_start);
>  	andc	r31,r20,r18		/* r31 =3D page base */
>  	or	r31,r31,r19		/* r31 =3D devtree phys addr */
>  	mfspr	r30,SPRN_MAS7
> -
> -	li	r25,0			/* phys kernel start (low) */
>  	li	r24,0			/* CPU number */
> -	li	r23,0			/* phys kernel start (high) */
> +
> +#ifdef CONFIG_RELOCATABLE
> +	bl	0f				/* Get our runtime =20
> address */
> +0:	mflr	r3				/* Make it accessible */
> +	addis	r3,r3,(_stext - 0b)@ha
> +	addi	r3,r3,(_stext - 0b)@l 	/* Get our current runtime base =20
> */
> +
> +	/* Translate _stext address to physical, save in r23/r25 */
> +	tlbsx	0,r3			/* must succeed */
> +
> +	mfspr	r16,SPRN_MAS1
> +	mfspr	r20,SPRN_MAS3
> +	rlwinm	r17,r16,25,0x1f		/* r17 =3D log2(page size) */
> +	li	r18,1024
> +	slw	r18,r18,r17		/* r18 =3D page size */
> +	addi	r18,r18,-1
> +	and	r19,r3,r18		/* r19 =3D page offset */
> +	andc	r25,r20,r18		/* r25 =3D page base */
> +	or	r25,r25,r19		/* r25 =3D _stext phys addr */
> +	mfspr	r23,SPRN_MAS7

This duplicates the code for finding the device tree physical =20
address... maybe factor it out into a function?

> @@ -197,7 +230,58 @@ _ENTRY(__early_start)
>=20
>  	bl	early_init
>=20
> -#ifdef CONFIG_DYNAMIC_MEMSTART
> +#ifdef CONFIG_RELOCATABLE
> +	/*
> +	 * Relocatable kernel support based on processing of dynamic
> +	 * relocation entries.
> +	 *
> +	 * r25/r23 will contain RPN/ERPN for the start address of memory

The start of memory or the start of the kernel?

> +	 */
> +	lis	r3,kernstart_addr@ha
> +	la	r3,kernstart_addr@l(r3)
> +
> +#ifdef CONFIG_PHYS_64BIT
> +	stw	r23,0(r3)
> +	stw	r25,4(r3)
> +#else
> +	stw	r25,0(r3)
> +#endif

This part looks the same for relocatable and dynamic memstart -- can =20
you avoid duplicating?

> +	/*
> +	 * Compute the virt_phys_offset :
> +	 * virt_phys_offset =3D stext.run - kernstart_addr
> +	 *
> +	 * stext.run =3D (KERNELBASE & ~0xfffffff) + (kernstart_addr & =20
> 0xfffffff)
> +	 * When we relocate, we have :
> +	 *
> +	 *	(kernstart_addr & 0xfffffff) =3D (stext.run & 0xfffffff)
> +	 *
> +	 * hence:
> +	 *  virt_phys_offset =3D (KERNELBASE & ~0xfffffff) -
> +	 *                              (kernstart_addr & ~0xfffffff)
> +	 *
> +	 */
> +
> +	/* KERNELBASE&~0xfffffff =3D> (r4,r5) */

> +	li	r4, 0		/* higer 32bit */
> +	lis	r5,KERNELBASE@h

Please be consistent with whitespace.

-Scott=
