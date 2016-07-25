Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryNCC4vT3zDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:57:43 +1000 (AEST)
Message-ID: <1469408263.5642.84.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: do not use r13 for tabort_syscall
From: Michael Neuling <mikey@neuling.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Mon, 25 Jul 2016 10:57:43 +1000
In-Reply-To: <1469172468-12892-1-git-send-email-npiggin@gmail.com>
References: <1469172468-12892-1-git-send-email-npiggin@gmail.com>
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

On Fri, 2016-07-22 at 17:27 +1000, Nicholas Piggin wrote:
> tabort_syscall runs with RI=3D1, so a nested recoverable machine
> check will load the paca into r13 and overwrite what we loaded
> it with, because exceptions returning to privileged mode do not
> restore r13.
>=20
> This has survived testing with sc instruction inside transaction
> (bare sc, not glibc syscall because glibc can tabort before sc).
> Verified the transaction is failing failing with with
> TM_CAUSE_SYSCALL.
>=20
> Signed-off-by: Nick Piggin <npiggin@gmail.com>

Thanks.

This looks good, but should probably be cc: stable from when the syscall tm
abort went in.

There are some random whitespace changes in here too, which if we avoid
will make the patch smaller (and easier to read).

Mikey

> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
>=20
> ---
>=20
> =C2=A0arch/powerpc/kernel/entry_64.S | 20 ++++++++++----------
> =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_64.S
> b/arch/powerpc/kernel/entry_64.S
> index 73e461a..387dee3 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -368,13 +368,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> =C2=A0tabort_syscall:
> =C2=A0	/* Firstly we need to enable TM in the kernel */
> =C2=A0	mfmsr	r10
> -	li	r13, 1
> -	rldimi	r10, r13, MSR_TM_LG, 63-MSR_TM_LG
> -	mtmsrd	r10, 0
> +	li	r9,1
> +	rldimi	r10,r9,MSR_TM_LG,63-MSR_TM_LG
> +	mtmsrd	r10,0
> =C2=A0
> =C2=A0	/* tabort, this dooms the transaction, nothing else */
> -	li	r13, (TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
> -	TABORT(R13)
> +	li	r9,(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT)
> +	TABORT(R9)
> =C2=A0
> =C2=A0	/*
> =C2=A0	=C2=A0* Return directly to userspace. We have corrupted user regis=
ter
> state,
> @@ -382,11 +382,11 @@ tabort_syscall:
> =C2=A0	=C2=A0* resume after the tbegin of the aborted transaction with th=
e
> =C2=A0	=C2=A0* checkpointed register state.
> =C2=A0	=C2=A0*/
> -	li	r13, MSR_RI
> -	andc	r10, r10, r13
> -	mtmsrd	r10, 1
> -	mtspr	SPRN_SRR0, r11
> -	mtspr	SPRN_SRR1, r12
> +	li	r9,MSR_RI
> +	andc	r10,r10,r9
> +	mtmsrd	r10,1
> +	mtspr	SPRN_SRR0,r11
> +	mtspr	SPRN_SRR1,r12
> =C2=A0
> =C2=A0	rfid
> =C2=A0	b	.	/* prevent speculative execution */
