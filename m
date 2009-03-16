Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id D8181DDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 02:02:36 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH v4] powerpc/mm: e300c2/c3/c4 TLB errata workaround
Date: Mon, 16 Mar 2009 16:02:32 +0100
References: <1237208538-32597-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1237208538-32597-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200903161602.33218.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ok, I was analysing your code (which seems much more compact than mine):

On Monday 16 March 2009 14:02:18 Kumar Gala wrote:
>[...]
> --- a/arch/powerpc/kernel/head_32.S
> +++ b/arch/powerpc/kernel/head_32.S
> @@ -587,9 +587,19 @@ DataLoadTLBMiss:
>  	ori	r1,r1,0xe04		/* clear out reserved bits */
>  	andc	r1,r0,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
>  	mtspr	SPRN_RPA,r1
> +	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
> +	mtcrf	0x80,r2
> +BEGIN_MMU_FTR_SECTION
> +	li	r0,1
> +	lwz	r1,sw_way_lru@l(0)
> +	rlwinm	r3,r3,19,25,29		/* Get Address bits 19:15 */

This should be 'rlwinm	r3,r3,17,27,31' now, since you address bits, not ints.
Note that you are trashing r3 (SPRN_DMISS) here!

> +	slw	r0,r0,r3
> +	xor	r1,r0,r1
> +	srw	r0,r1,r3
> +	stw	r1,sw_way_lru@l(0)
> +	rlwimi	r2,r0,31-14,14,14
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
>  	tlbld	r3

And now you load r3 into the tlb, is this right? It doesn't seem right to 
me....

> -	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
> -	mtcrf	0x80,r3
>  	rfi
>  DataAddressInvalid:
>  	mfspr	r3,SPRN_SRR1
> @@ -652,11 +662,25 @@ DataStoreTLBMiss:
>  	li	r1,0xe05		/* clear out reserved bits & PP lsb */
>  	andc	r1,r0,r1		/* PP = user? 2: 0 */
>  	mtspr	SPRN_RPA,r1
> +	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
> +	mtcrf	0x80,r2
> +BEGIN_MMU_FTR_SECTION
> +	li	r0,1
> +	lwz	r1,sw_way_lru@l(0)
> +	rlwinm	r3,r3,19,25,29		/* Get Address bits 19:15 */
> +	slw	r0,r0,r3
> +	xor	r1,r0,r1
> +	srw	r0,r1,r3
> +	stw	r1,sw_way_lru@l(0)
> +	rlwimi	r2,r0,31-14,14,14
> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
>  	tlbld	r3

Same thing here, r3 is trashed.

> -	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
> -	mtcrf	0x80,r3
>  	rfi
>
> +	.balign	L1_CACHE_BYTES
> +sw_way_lru:
> +	.long 0
> +

Ok, I'll try to do it like this, but with lru stored in SPRG6

Best regards,

-- 
David Jander
Protonic Holland.
