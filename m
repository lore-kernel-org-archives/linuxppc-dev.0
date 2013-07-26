Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F1FB32C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 09:37:18 +1000 (EST)
Date: Fri, 26 Jul 2013 18:37:10 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 4/8] powerpc/fsl_booke: set the tlb entry for the
 kernel address in AS1
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1372942454-25191-5-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Thu Jul  4 07:54:10 2013)
Message-ID: <1374881830.30721.38@snotra>
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

On 07/04/2013 07:54:10 AM, Kevin Hao wrote:
> We use the tlb1 entries to map low mem to the kernel space. In the
> current code, it assumes that the first tlb entry would cover the
> kernel image. But this is not true for some special cases, such as
> when we run a relocatable kernel above the 256M or set
> CONFIG_KERNEL_START above 256M. So we choose to switch to address
> space 1 before setting these tlb entries.

If you're doing this, then I see even less reason to use such a large =20
boot TLB1 entry.

> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> A new patch in v2.
>=20
>  arch/powerpc/kernel/head_fsl_booke.S | 81 =20
> ++++++++++++++++++++++++++++++++++++
>  arch/powerpc/mm/fsl_booke_mmu.c      |  2 +
>  arch/powerpc/mm/mmu_decl.h           |  2 +
>  3 files changed, 85 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S =20
> b/arch/powerpc/kernel/head_fsl_booke.S
> index 134064d..0cbfe95 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -1172,6 +1172,87 @@ __secondary_hold_acknowledge:
>  #endif
>=20
>  /*
> + * Create a tbl entry

s/tbl/tlb/

> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c =20
> b/arch/powerpc/mm/fsl_booke_mmu.c
> index 5fe271c..8f60ef8 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -222,7 +222,9 @@ void __init adjust_total_lowmem(void)
>  	/* adjust lowmem size to __max_low_memory */
>  	ram =3D min((phys_addr_t)__max_low_memory, =20
> (phys_addr_t)total_lowmem);
>=20
> +	i =3D switch_to_as1();
>  	__max_low_memory =3D map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM);
> +	restore_to_as0(i);

Wouldn't it be simpler to just run out of AS1 from the end of =20
fsl_booke_entry_mapping.S, similar to what U-Boot does?  With ESEL =20
being changed to something non-conflicting, of course.

-Scott=
