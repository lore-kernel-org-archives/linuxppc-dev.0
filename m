Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25153B6F8E
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 22:42:05 +1000 (EST)
Subject: Re: [PATCH] powerpc/book3e: Fix extlb size
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <a0ae014cf06639bb9aea24149c24e51acbaf2598.1301984934.git.michael@ellerman.id.au>
Date: Tue, 5 Apr 2011 07:41:57 -0500
Message-Id: <F4D669C2-BAD4-4B79-BE24-FB5AD2961160@kernel.crashing.org>
References: <a0ae014cf06639bb9aea24149c24e51acbaf2598.1301984934.git.michael@ellerman.id.au>
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 5, 2011, at 1:28 AM, Michael Ellerman wrote:

> The calculation of the size for the exception save area of the TLB
> miss handler is wrong, luckily it's too big not too small.
>=20
> Rework it to make it a bit clearer, and also correct. We want 3 save
> areas, each EX_TLB_SIZE _bytes_.

Where does the 3 come from?  I have a guess, and think its possible we =
(FSL) want 4?

>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> arch/powerpc/include/asm/paca.h |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h =
b/arch/powerpc/include/asm/paca.h
> index ec57540..f7aa4fd 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -106,7 +106,7 @@ struct paca_struct {
> 	pgd_t *pgd;			/* Current PGD */
> 	pgd_t *kernel_pgd;		/* Kernel PGD */
> 	u64 exgen[8] __attribute__((aligned(0x80)));
> -	u64 extlb[EX_TLB_SIZE*3] __attribute__((aligned(0x80)));
> +	u64 extlb[3][EX_TLB_SIZE / sizeof(u64)] =
__attribute__((aligned(0x80)));
> 	u64 exmc[8];		/* used for machine checks */
> 	u64 excrit[8];		/* used for crit interrupts */
> 	u64 exdbg[8];		/* used for debug interrupts */
> --=20
> 1.7.1
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
