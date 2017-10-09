Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9hSB6hT4zDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 00:49:29 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sandipan Das' <sandipan@linux.vnet.ibm.com>, "mpe@ellerman.id.au"
 <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
 "paulus@samba.org" <paulus@samba.org>, "anton@samba.org" <anton@samba.org>
Subject: RE: [PATCH] powerpc/lib/sstep: Fix count leading zeros instructions
Date: Mon, 9 Oct 2017 13:49:26 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD008D92D@AcuExch.aculab.com>
References: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
In-Reply-To: <20171009110726.28551-1-sandipan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sandipan Das
> Sent: 09 October 2017 12:07
> According to the GCC documentation, the behaviour of __builtin_clz()
> and __builtin_clzl() is undefined if the value of the input argument
> is zero. Without handling this special case, these builtins have been
> used for emulating the following instructions:
>   * Count Leading Zeros Word (cntlzw[.])
>   * Count Leading Zeros Doubleword (cntlzd[.])
>=20
> This fixes the emulated behaviour of these instructions by adding an
> additional check for this special case.

Presumably the result is undefined because the underlying cpu
instruction is used - and it's return value is implementation defined.

Here you are emulating the cpu instruction - so executing one will
give the same answer as it the 'real' one were execucted.

Indeed it might be worth an asm statement that definitely executes
the cpu instruction?

	David

>=20
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/lib/sstep.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 0f7e41bd7e88..ebbc0b92650c 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1717,11 +1717,19 @@ int analyse_instr(struct instruction_op *op, cons=
t struct pt_regs *regs,
>   * Logical instructions
>   */
>  		case 26:	/* cntlzw */
> -			op->val =3D __builtin_clz((unsigned int) regs->gpr[rd]);
> +			val =3D (unsigned int) regs->gpr[rd];
> +			if (val =3D=3D 0)
> +				op->val =3D 32;
> +			else
> +				op->val =3D __builtin_clz(val);
>  			goto logical_done;
>  #ifdef __powerpc64__
>  		case 58:	/* cntlzd */
> -			op->val =3D __builtin_clzl(regs->gpr[rd]);
> +			val =3D regs->gpr[rd];
> +			if (val =3D=3D 0)
> +				op->val =3D 64;
> +			else
> +				op->val =3D __builtin_clzl(val);
>  			goto logical_done;
>  #endif
>  		case 28:	/* and */
> --
> 2.13.6
