Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BG0B1DP6zF3TG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:01:46 +1000 (AEST)
Message-ID: <545f4cb2ca6f8d678798a387ea189bcf152842f9.camel@neuling.org>
Subject: Re: [PATCH] Correct PowerPC VDSO call frame info
From: Michael Neuling <mikey@neuling.org>
To: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 14 Sep 2018 10:01:45 +1000
In-Reply-To: <20180913232704.GL3174@bubble.grove.modra.org>
References: <20180913232704.GL3174@bubble.grove.modra.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan,

Thanks for the patch... A few minor comments...

> Re: [PATCH] Correct PowerPC VDSO call frame info

Our convention is to add powerpc: to the start. ie

  [PATCH] powerpc: Correct VDSO call frame info

or even:=20

  [PATCH] powerpc/vdso: Correct call frame info


On Fri, 2018-09-14 at 08:57 +0930, Alan Modra wrote:
> There is control flow in __kernel_clock_gettime that reaches label 99
> without saving lr in r12.  CFI info however is interpreted by the
> unwinder without reference to control flow: It's a simple matter of
> "Execute all the CFI opcodes up to the current address".  That means
> the unwinder thinks r12 contains the return address at label 99.
> Disabuse it of that notion by resetting CFI for the return address at
> label 99.

Can you expand on CFI =3D=3D Call Frame Information in the commit message. =
 Not a
common term for us mere kernel developers?

> Note that the ".cfi_restore lr" could have gone anywhere from the
> "mtlr r12" a few instructions earlier to the instruction at label 99.
> I put the CFI as late as possible, because in general that's best
> practice (and if possible grouped with other CFI in order to reduce
> the number of CFI opcodes executed when unwinding).  Using r12 as the
> return address is perfectly fine after the "mtlr r12" since r12 on
> that code path still contains the return address.
>=20
> __get_datapage also has a CFI error.  That function temporarily saves
> lr in r0, and reflects that fact with ".cfi_register lr,r0".  A later
> use of r0 means the CFI at that point isn't correct, as r0 no longer
> contains the return address.  Fix that too.

Can you describe the problem this fixes at a high level?  ie This fixes doi=
ng a
stack unwind with gdb when in __kernel_clock_gettime.

Mikey

> Signed-off-by: Alan Modra <amodra@gmail.com>
>=20
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S
> b/arch/powerpc/kernel/vdso32/datapage.S
> index 3745113fcc65..2a7eb5452aba 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -37,6 +37,7 @@ data_page_branch:
>  	mtlr	r0
>  	addi	r3, r3, __kernel_datapage_offset-data_page_branch
>  	lwz	r0,0(r3)
> +  .cfi_restore lr
>  	add	r3,r0,r3
>  	blr
>    .cfi_endproc
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S
> b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index 769c2624e0a6..1e0bc5955a40 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -139,6 +139,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	 */
>  99:
>  	li	r0,__NR_clock_gettime
> +  .cfi_restore lr
>  	sc
>  	blr
>    .cfi_endproc
> diff --git a/arch/powerpc/kernel/vdso64/datapage.S
> b/arch/powerpc/kernel/vdso64/datapage.S
> index abf17feffe40..bf9668691511 100644
> --- a/arch/powerpc/kernel/vdso64/datapage.S
> +++ b/arch/powerpc/kernel/vdso64/datapage.S
> @@ -37,6 +37,7 @@ data_page_branch:
>  	mtlr	r0
>  	addi	r3, r3, __kernel_datapage_offset-data_page_branch
>  	lwz	r0,0(r3)
> +  .cfi_restore lr
>  	add	r3,r0,r3
>  	blr
>    .cfi_endproc
> diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S
> b/arch/powerpc/kernel/vdso64/gettimeofday.S
> index c002adcc694c..a4ed9edfd5f0 100644
> --- a/arch/powerpc/kernel/vdso64/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
> @@ -169,6 +169,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
>  	 */
>  99:
>  	li	r0,__NR_clock_gettime
> +  .cfi_restore lr
>  	sc
>  	blr
>    .cfi_endproc
>=20
