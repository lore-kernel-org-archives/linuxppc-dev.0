Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E28A82C01FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:45:00 +1000 (EST)
Subject: Re: [PATCH] powerpc/booke: Eliminate rfi from exception entry path.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120711003454.GA22757@tyr.buserror.net>
Date: Wed, 11 Jul 2012 02:44:52 +0200
Message-Id: <E139BF8E-A72C-4977-8FB9-6EED5803AB9A@suse.de>
References: <20120711003454.GA22757@tyr.buserror.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.07.2012, at 02:34, Scott Wood wrote:

> Unlike classic, we don't really need the MSR change to be atomic with =
the
> branch.  This eliminates a trap as a KVM guest (in the absence of
> hardware hypervisor extensions), where mtmsr is paravirtualized but =
rfi
> is not.  For a virtualized guest without any paravirtualization, this
> eliminates an additional two traps (SRR0/1).
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/kernel/entry_32.S |   16 ++++++++++++++++
> 1 files changed, 16 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/entry_32.S =
b/arch/powerpc/kernel/entry_32.S
> index ba3aeb4..6bb637c 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -193,6 +193,9 @@ transfer_to_handler_cont:
> 	lwz	r11,0(r9)		/* virtual address of handler */
> 	lwz	r9,4(r9)		/* where to go when done */
> #ifdef CONFIG_TRACE_IRQFLAGS
> +#ifdef CONFIG_BOOKE
> +	mtmsr	r10
> +#else
> 	lis	r12,reenable_mmu@h
> 	ori	r12,r12,reenable_mmu@l
> 	mtspr	SPRN_SRR0,r12
> @@ -201,6 +204,7 @@ transfer_to_handler_cont:
> 	RFI
> reenable_mmu:				/* re-enable mmu so we can */
> 	mfmsr	r10
> +#endif /* !CONFIG_BOOKE */
> 	lwz	r12,_MSR(r1)
> 	xor	r10,r10,r12
> 	andi.	r10,r10,MSR_EE		/* Did EE change? */
> @@ -247,11 +251,23 @@ reenable_mmu:				/* =
re-enable mmu so we can */
> 	mtlr	r9
> 	bctr				/* jump to handler */
> #else /* CONFIG_TRACE_IRQFLAGS */
> +#ifdef CONFIG_BOOKE
> +	/*
> +	 * We're not changing address space on Book E, and the extra rfi
> +	 * can hurt when virtualized without hardware support -- whereas
> +	 * mtmsr can be paravirtualized.

We can always paravirtualize RFI as well if it makes sense.


Alex
