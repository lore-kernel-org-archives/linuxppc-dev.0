Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAD6D2C0211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 15:57:03 +1000 (EST)
Subject: Re: linux-next: manual merge of the kvm-ppc tree with the powerpc tree
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20120712135735.7678a50ffb107e3094af27b8@canb.auug.org.au>
Date: Thu, 12 Jul 2012 07:56:46 +0200
Message-Id: <B6C6F6EC-BDD9-41DC-9677-4B7A4A52BDF0@suse.de>
References: <20120712135735.7678a50ffb107e3094af27b8@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Bharat Bhushan <r65777@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.07.2012, at 05:57, Stephen Rothwell wrote:

> Hi Alexander,
>=20
> Today's linux-next merge of the kvm-ppc tree got a conflict in
> arch/powerpc/kvm/booke_interrupts.S between commit c75df6f96c59
> ("powerpc: Fix usage of register macros getting ready for %r0 change")
> from the powerpc tree and commit fc372c0843b8 ("booke: Added crit/mc
> exception handler for e500v2") from the kvm-ppc tree.
>=20
> I fixed it up (see below - could do with checking) and can carry the =
fix
> as necessary.

Hrm. Ben already warned me that this will happen, so I did a test merge =
a few days ago. Back then I also had to change 2 other bits that were =
not conflicting, to get to code to actually compile.

Could you please do an s/VCPU_GPR(r/VCPU_GPR/R/g in =
arch/powerpc/kvm/booke_interrupts.S? I'd check if you actually need it =
myself, but the tree doesn't seem to be pushed out yet :).


Alex

> --=20
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
>=20
> diff --cc arch/powerpc/kvm/booke_interrupts.S
> index 8fd4b2a,09456c4..0000000
> --- a/arch/powerpc/kvm/booke_interrupts.S
> +++ b/arch/powerpc/kvm/booke_interrupts.S
> @@@ -52,16 -53,21 +52,21 @@@
>                         (1<<BOOKE_INTERRUPT_PROGRAM) | \
>                         (1<<BOOKE_INTERRUPT_DTLB_MISS))
>=20
> - .macro KVM_HANDLER ivor_nr
> + .macro KVM_HANDLER ivor_nr scratch srr0
>  _GLOBAL(kvmppc_handler_\ivor_nr)
>  	/* Get pointer to vcpu and record exit number. */
> - 	mtspr	SPRN_SPRG_WSCRATCH0, r4
> + 	mtspr	\scratch , r4
>  	mfspr	r4, SPRN_SPRG_RVCPU
> -	stw	r3, VCPU_GPR(r3)(r4)
> -	stw	r5, VCPU_GPR(r5)(r4)
> -	stw	r6, VCPU_GPR(r6)(r4)
> ++	stw	r3, VCPU_GPR(R3)(r4)
> +	stw	r5, VCPU_GPR(R5)(r4)
> +	stw	r6, VCPU_GPR(R6)(r4)
> + 	mfspr	r3, \scratch
>  	mfctr	r5
> - 	lis	r6, kvmppc_resume_host@h
> -	stw	r3, VCPU_GPR(r4)(r4)
> ++	stw	r3, VCPU_GPR(R4)(r4)
>  	stw	r5, VCPU_CTR(r4)
> + 	mfspr	r3, \srr0
> + 	lis	r6, kvmppc_resume_host@h
> + 	stw	r3, VCPU_PC(r4)
>  	li	r5, \ivor_nr
>  	ori	r6, r6, kvmppc_resume_host@l
>  	mtctr	r6
> @@@ -99,12 -104,11 +103,11 @@@ _GLOBAL(kvmppc_handler_len
>   *  r5: KVM exit number
>   */
>  _GLOBAL(kvmppc_resume_host)
> - 	stw	r3, VCPU_GPR(R3)(r4)
>  	mfcr	r3
>  	stw	r3, VCPU_CR(r4)
> -	stw	r7, VCPU_GPR(r7)(r4)
> -	stw	r8, VCPU_GPR(r8)(r4)
> -	stw	r9, VCPU_GPR(r9)(r4)
> +	stw	r7, VCPU_GPR(R7)(r4)
> +	stw	r8, VCPU_GPR(R8)(r4)
> +	stw	r9, VCPU_GPR(R9)(r4)
>=20
>  	li	r6, 1
>  	slw	r6, r6, r5
