Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408pZQ6q9HzF1vZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 20:22:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Implement cross-endian emulation of larx and
 stcx instructions
In-Reply-To: <20170904053402.GB16532@fergus.ozlabs.ibm.com>
References: <20170904053402.GB16532@fergus.ozlabs.ibm.com>
Date: Mon, 26 Mar 2018 20:22:17 +1100
Message-ID: <87a7uvkx86.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index fb9f58b..0590417 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -2755,8 +2761,11 @@ int emulate_loadstore(struct pt_regs *regs, struct=
 instruction_op *op)
>  			regs->dar =3D ea;
>  			break;
>  		}
> -		if (size < 16)
> -			regs->gpr[op->reg] =3D val;
> +		if (size < 16) {
> +			if (unlikely(cross_endian))
> +				val =3D byterev_8(val);

This doesn't build on 32-bit (pmac32_defconfig):

  arch/powerpc/lib/sstep.c: In function =E2=80=98emulate_loadstore=E2=80=99:
  arch/powerpc/lib/sstep.c:2789:11: error: implicit declaration of function=
 =E2=80=98byterev_8=E2=80=99;did you mean =E2=80=98byterev_4=E2=80=99? [-We=
rror=3Dimplicit-function-declaration]
       val =3D byterev_8(val);
             ^~~~~~~~~
             byterev_4

cheers
