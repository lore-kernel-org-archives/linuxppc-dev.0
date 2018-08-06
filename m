Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kvpP1Lr5zDqCD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 10:02:17 +1000 (AEST)
Date: Mon, 6 Aug 2018 18:57:45 -0500
From: Scott Wood <oss@buserror.net>
To: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20180806235745.GA25864@home.buserror.net>
References: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532411985-17725-1-git-send-email-Bharat.Bhushan@nxp.com>
Subject: Re: powerpc/e200: Skip tlb1 entries used for kernel mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2018 at 11:29:45AM +0530, Bharat Bhushan wrote:
> E200 have TLB1 only and it does not have TLB0.
> So TLB1 are used for mapping kernel and user-space both.
> TLB miss handler for E200 does not consider skipping TLBs
> used for kernel mapping. This patch ensures that we skip
> tlb1 entries used for kernel mapping (tlbcam_index).

How much more is needed to get e200 working?  What was this tested on?

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  arch/powerpc/kernel/head_fsl_booke.S | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
> index bf4c602..951fb96 100644
> --- a/arch/powerpc/kernel/head_fsl_booke.S
> +++ b/arch/powerpc/kernel/head_fsl_booke.S
> @@ -801,12 +801,28 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
>  	/* Round robin TLB1 entries assignment */
>  	mfspr	r12, SPRN_MAS0
>  
> +	/* Get first free tlbcam entry */
> +	lis	r11, tlbcam_index@ha
> +	lwz	r11, tlbcam_index@l(r11)

The existing handler already loads tlbcam_index and uses that when
wrapping.  What specifically is causing that to not work (perhaps it's
just a matter of initializing NV when tlbcam_index changes?), and why
does this patch leave that code in place?

> +
> +	/* Extract MAS0(NV) */
> +	andi.	r13, r12, 0xfff
> +	cmpw	0, r13, r11
> +	blt	0, 5f
> +	b	6f
> +5:

Why these two instructions instead of "bge 6f"?  If it's for branch
prediction, does e200 pay attention to static hints?  If it doesn't,
you could move the wrap code out-of-line.

> +	/* When NV is less than first free tlbcam entry, use first free
> +	 * tlbcam entry for ESEL and set NV */
> +	rlwimi	r12, r11, 16, 4, 15
> +	addi	r11, r11, 1
> +	rlwimi	r12, r11, 0, 20, 31
> +	b	7f

The 4-argument form of rlwimi is easier to read.

BTW, The TLB miss handler would be simpler/faster if you reserve the
upper entries rather than the lower entries.  Then you would just have
one value to check (instead of using TLB1CFG[NENTRY]) to see if you wrap
back to zero.

-Scott
