Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxhBy01trzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 04:55:53 +1000 (AEST)
Date: Mon, 03 Apr 2017 20:55:48 +0200
Message-ID: <20170403205548.Horde.yvekJnoFaOaIi2_bvtIsLA2@messagerie.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Anton Blanchard <anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Avoid taking a data miss on every userspace
 instruction miss
In-Reply-To: <20170403064102.23245-1-anton@ozlabs.org>
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

Anton Blanchard <anton@ozlabs.org> a =C3=A9crit=C2=A0:

> From: Anton Blanchard <anton@samba.org>
>
> Early on in do_page_fault() we call store_updates_sp(), regardless of
> the type of exception. For an instruction miss this doesn't make
> sense, because we only use this information to detect if a data miss
> is the result of a stack expansion instruction or not.
>
> Worse still, it results in a data miss within every userspace
> instruction miss handler, because we try and load the very instruction
> we are about to install a pte for!
>
> A simple exec microbenchmark runs 6% faster on POWER8 with this fix:
>
>  #include <stdlib.h>
>  #include <stdio.h>
>  #include <unistd.h>
>
> int main(int argc, char *argv[])
> {
> 	unsigned long left =3D atol(argv[1]);
> 	char leftstr[16];
>
> 	if (left-- =3D=3D 0)
> 		return 0;
>
> 	sprintf(leftstr, "%ld", left);
> 	execlp(argv[0], argv[0], leftstr, NULL);
> 	perror("exec failed\n");
>
> 	return 0;
> }
>
> Pass the number of iterations on the command line (eg 10000) and time
> how long it takes to execute.
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/mm/fault.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index fd6484fc2fa9..3a7d580fdc59 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -287,7 +287,7 @@ int do_page_fault(struct pt_regs *regs, unsigned=20=
=20
>=20long address,
>  	 * can result in fault, which will cause a deadlock when called with
>  	 * mmap_sem held
>  	 */
> -	if (user_mode(regs))
> +	if (!is_exec && user_mode(regs))

Shouldn't it also check 'is_write' ?
If it is a store, is_write should be set, shouldn't it ?

Christophe

>  		store_update_sp =3D store_updates_sp(regs);
>
>  	if (user_mode(regs))
> --
> 2.11.0
