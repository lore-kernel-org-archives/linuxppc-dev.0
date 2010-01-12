Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60AD4B6EEA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 13:40:56 +1100 (EST)
Subject: Re: [PATCH] 8xx: fix user space TLB walk in dcbX fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
In-Reply-To: <1262969186-18462-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1262969186-18462-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2010 13:40:45 +1100
Message-ID: <1263264045.724.183.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-01-08 at 17:46 +0100, Joakim Tjernlund wrote:
> The newly added fixup for buggy dcbX insn's has
> a bug that always trigger a kernel TLB walk so a user space
> dcbX insn will cause a Kernel Machine Check if it hits DTLB error.
> 
> Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> ---
> 
> I found this problem in 2.4 and forward ported it to 2.6. I
> cannot test it so I cannot be 100% sure I got it right.
> 
>  arch/powerpc/kernel/head_8xx.S |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Do you have something to make sure that TASK_SIZE is never bigger than
2G ? Else userspace could be all the way to 0xbfffffff ...

Cheers,
Ben.

> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index ce327c5..91bef6e 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -542,11 +542,11 @@ DARFixed:/* Return from dcbx instruction bug workaround, r10 holds value of DAR
>  FixupDAR:/* Entry point for dcbx workaround. */
>  	/* fetch instruction from memory. */
>  	mfspr	r10, SPRN_SRR0
> +	andis.	r11, r10, 0x8000	/* Address >= 0x80000000 */
>  	DO_8xx_CPU6(0x3780, r3)
>  	mtspr	SPRN_MD_EPN, r10
>  	mfspr	r11, SPRN_M_TWB	/* Get level 1 table entry address */
> -	cmplwi	cr0, r11, 0x0800
> -	blt-	3f		/* Branch if user space */
> +	beq-	3f		/* Branch if user space */
>  	lis	r11, (swapper_pg_dir-PAGE_OFFSET)@h
>  	ori	r11, r11, (swapper_pg_dir-PAGE_OFFSET)@l
>  	rlwimi	r11, r10, 32-20, 0xffc /* r11 = r11&~0xffc|(r10>>20)&0xffc */
