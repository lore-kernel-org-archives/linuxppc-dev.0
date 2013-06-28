Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A42D2C031C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2013 12:19:16 +1000 (EST)
Date: Thu, 27 Jun 2013 21:19:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the
 kdump kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1372298434-20220-3-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Wed Jun 26 21:00:34 2013)
Message-ID: <1372385946.8183.64@snotra>
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

On 06/26/2013 09:00:34 PM, Kevin Hao wrote:
> diff --git a/arch/powerpc/include/asm/mmu-book3e.h =20
> b/arch/powerpc/include/asm/mmu-book3e.h
> index 936db36..bf422db 100644
> --- a/arch/powerpc/include/asm/mmu-book3e.h
> +++ b/arch/powerpc/include/asm/mmu-book3e.h
> @@ -214,6 +214,11 @@
>  #define TLBILX_T_CLASS2			6
>  #define TLBILX_T_CLASS3			7
>=20
> +#ifdef CONFIG_PPC32
> +/* The max size that one tlb can map in a 32bit kernel. */
> +#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
> +#endif

That comment is not true for all chips.

> @@ -177,11 +178,34 @@ unsigned long map_mem_in_cams(unsigned long =20
> ram, int max_cam_idx)
>  	unsigned long virt =3D PAGE_OFFSET;
>  	phys_addr_t phys =3D memstart_addr;
>  	unsigned long amount_mapped =3D 0;
> -
> +	unsigned long cam_sz;
> +
> +#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC32)
> +	/*
> +	 * For a relocatable kernel, we would not map from =20
> memstart_addr.
> +	 * We first align to PPC_PIN_SIZE (256M), then map the =20
> PAGE_OFFSET
> +	 * from there.
> +	 */
> +	phys &=3D ~(PPC_PIN_SIZE - 1);
> +	ram +=3D memstart_addr & (PPC_PIN_SIZE - 1);

You should not map anything before memstart_addr.  If memstart_addr =20
isn't 256M-aligned, you'll have to either use smaller pages or consider =20
that region to be "high"mem (assuming Linux supports highmem existing =20
below lowmem -- I'm skeptical).

> +	/*
> +	 * For a kdump kernel, we may use a memory area reserved by the =20
> boot
> +	 * kernel by using a kernel option like this =20
> 'crashkernel=3D32M@64M'.
> +	 * In this case, the ram is 96M. The kernel will try to map the =20
> first
> +	 * 64M in the first tlb entry. The kernel will definitely get =20
> stuck,
> +	 * since the kernel is running above the 64M. So we have to =20
> make sure
> +	 * that the first tlb cover the current kernel running address =20
> at least.
> +	 */

Maybe we should be running from AS1 when we set this up, to avoid =20
problems replacing an entry while it's in use?

Pardon my ignorance about how kdump/kexec works, but I'm a bit confused =20
by exactly what the situation is with crashkernel.  How do we know that =20
we are the crash kernel, and that we should limit our RAM usage to that =20
area?  I'm wondering if this code is assuming that the crashkernel area =20
is from where the kernel starts to the end of RAM.

> +	while (1) {
> +		cam_sz =3D calc_cam_sz(ram, virt, phys);
> +		if (cam_sz + phys > PHYSICAL_START + _end - _stext)
> +			break;
> +		ram =3D 1 << (ilog2(ram) + 1);
> +	}

The ram that was passed in is as much as you have.  Don't map more.

What happens if (e.g.) memstart_addr is 512M, with a size of 512M, and =20
the kernel starts at 768M?  Increasing the size will never get you a =20
mapping that covers kernstart, because calc_cam_sz will never return =20
more than 256M.

When does memory below the rounded-down kernel start get mapped?

-Scott=
