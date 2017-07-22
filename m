Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xFD0h3f8ZzDqy5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 02:41:07 +1000 (AEST)
Date: Sat, 22 Jul 2017 18:40:58 +0200
Message-ID: <20170722184058.Horde.Y2X8hGdhXLwnxJXZApQEhQ1@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/24] powerpc/mm: Move out definition of CPU specific
 is_write bits
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-7-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-7-benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> a =C3=A9crit=C2=A0:

> Define a common page_fault_is_write() helper and use it
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/mm/fault.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index f257965b54b5..26ec0dd4f419 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -183,6 +183,16 @@ static int mm_fault_error(struct pt_regs *regs,=20=
=20
>=20unsigned long addr, int fault)
>  }
>
>  /*
> + * Define the correct "is_write" bit in error_code based
> + * on the processor family
> + */
> +#if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +#define page_fault_is_write(__err)	((__err) & ESR_DST)
> +#else
> +#define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
> +#endif

Doesn't linux kernel codying style make preference to static inline=20=20
functions=20instead of macros ?

> +
> +/*
>   * For 600- and 800-family processors, the error_code parameter is DSISR
>   * for a data fault, SRR1 for an instruction fault. For 400-family=20=20
>=20processors
>   * the error_code parameter is ESR for a data fault, 0 for an instructio=
n
> @@ -202,18 +212,12 @@ static int __do_page_fault(struct pt_regs=20=20
>=20*regs, unsigned long address,
>  	struct mm_struct *mm =3D current->mm;
>  	unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>  	int code =3D SEGV_MAPERR;
> -	int is_write =3D 0;
>   	int is_exec =3D TRAP(regs) =3D=3D 0x400;
>  	int is_user =3D user_mode(regs);
> +	int is_write =3D page_fault_is_write(error_code);
>  	int fault;
>  	int rc =3D 0, store_update_sp =3D 0;
>
> -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> -	is_write =3D error_code & DSISR_ISSTORE;
> -#else
> -	is_write =3D error_code & ESR_DST;
> -#endif /* CONFIG_4xx || CONFIG_BOOKE */
> -
>  #ifdef CONFIG_PPC_ICSWX
>  	/*
>  	 * we need to do this early because this "data storage
> --
> 2.13.3
