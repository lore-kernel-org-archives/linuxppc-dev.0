Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xFD3f3MyMzDqy5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 02:43:22 +1000 (AEST)
Date: Sat, 22 Jul 2017 18:43:14 +0200
Message-ID: <20170722184314.Horde.gxxJYSiYc2SSqQhjpzVdwQ1@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 02/24] powerpc/mm: Pre-filter SRR1 bits before
 do_page_fault()
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-2-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-2-benh@kernel.crashing.org>
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

> By filtering the relevant SRR1 bits in the assembly rather than
> in do_page_fault() itself, we avoid a conditional branch (since we
> already come from different path for data and instruction faults).
>
> This will allow more simplifications later
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/head_32.S  |  2 +-
>  arch/powerpc/kernel/head_8xx.S |  4 ++--
>  arch/powerpc/mm/fault.c        | 14 ++------------
>  3 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.=
S
> index a5301248b098..f11d1cd6e314 100644
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -409,7 +409,7 @@ InstructionAccess:
>  	mr	r4,r12			/* SRR0 is fault address */
>  	bl	hash_page
>  1:	mr	r4,r12
> -	mr	r5,r9
> +	andis.	r5,r9,0x4820		/* Filter relevant SRR1 bits */
>  	EXC_XFER_LITE(0x400, handle_page_fault)
>
>  /* External interrupt */
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8x=
x.S
> index c032fe8c2d26..da3afa2c1658 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -569,8 +569,8 @@ _ENTRY(DTLBMiss_jmp)
>  InstructionTLBError:
>  	EXCEPTION_PROLOG
>  	mr	r4,r12
> -	mr	r5,r9
> -	andis.	r10,r5,0x4000
> +	andis.	r5,r9,0x4820		/* Filter relevant SRR1 bits */
> +	andis.	r10,r9,0x4000
>  	beq+	1f
>  	tlbie	r4
>  itlbie:
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index faddc87d0205..f04bc9f6b134 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -203,23 +203,13 @@ static int __do_page_fault(struct pt_regs=20=20
>=20*regs, unsigned long address,
>  	unsigned int flags =3D FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
>  	int code =3D SEGV_MAPERR;
>  	int is_write =3D 0;
> -	int trap =3D TRAP(regs);
> - 	int is_exec =3D trap =3D=3D 0x400;
> + 	int is_exec =3D TRAP(regs) =3D=3D 0x400;

Don't we have a tab/space issue here ?

>  	int is_user =3D user_mode(regs);
>  	int fault;
>  	int rc =3D 0, store_update_sp =3D 0;
>
>  #if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> -	/*
> -	 * Fortunately the bit assignments in SRR1 for an instruction
> -	 * fault and DSISR for a data fault are mostly the same for the
> -	 * bits we are interested in.  But there are some bits which
> -	 * indicate errors in DSISR but can validly be set in SRR1.
> -	 */
> -	if (is_exec)
> -		error_code &=3D 0x48200000;
> -	else
> -		is_write =3D error_code & DSISR_ISSTORE;
> +	is_write =3D error_code & DSISR_ISSTORE;
>  #else
>  	is_write =3D error_code & ESR_DST;
>  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> --
> 2.13.3
