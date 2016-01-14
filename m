Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D2C71A0C86
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 11:05:23 +1100 (AEDT)
Date: Thu, 14 Jan 2016 11:06:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 paulus@ozlabs.org, linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, kvm@vger.kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH v3 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
Message-ID: <20160114000614.GD22925@voom.redhat.com>
References: <20160113070759.20248.86252.stgit@aravindap>
 <20160113070809.20248.80811.stgit@aravindap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8WKGInOJRMBXYFEc"
In-Reply-To: <20160113070809.20248.80811.stgit@aravindap>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--8WKGInOJRMBXYFEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 12:38:09PM +0530, Aravinda Prasad wrote:
> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
> exit reasons upon a machine check exception (MCE) in
> the guest address space if the KVM_CAP_PPC_FWNMI
> capability is enabled (instead of delivering 0x200
> interrupt to guest). This enables QEMU to build error
> log and deliver machine check exception to guest via
> guest registered machine check handler.
>=20
> This approach simplifies the delivering of machine
> check exception to guest OS compared to the earlier
> approach of KVM directly invoking 0x200 guest interrupt
> vector. In the earlier approach QEMU was enhanced to
> patch the 0x200 interrupt vector during boot. The
> patched code at 0x200 issued a private hcall to pass
> the control to QEMU to build the error log.
>=20
> This design/approach is based on the feedback for the
> QEMU patches to handle machine check exception. Details
> of earlier approach of handling machine check exception
> in QEMU and related discussions can be found at:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_hv.c            |   12 ++------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   48 +++++++++++++++----------=
------
>  2 files changed, 26 insertions(+), 34 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index a7352b5..4fa03d0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -858,15 +858,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run=
, struct kvm_vcpu *vcpu,
>  		r =3D RESUME_GUEST;
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> -		/*
> -		 * Deliver a machine check interrupt to the guest.
> -		 * We have to do this, even if the host has handled the
> -		 * machine check, because machine checks use SRR0/1 and
> -		 * the interrupt might have trashed guest state in them.
> -		 */
> -		kvmppc_book3s_queue_irqprio(vcpu,
> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> -		r =3D RESUME_GUEST;
> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> +		run->exit_reason =3D KVM_EXIT_NMI;
> +		r =3D RESUME_HOST;
>  		break;
>  	case BOOK3S_INTERRUPT_PROGRAM:
>  	{
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 3c6badc..84e32a3 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -133,21 +133,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	stb	r0, HSTATE_HWTHREAD_REQ(r13)
> =20
>  	/*
> -	 * For external and machine check interrupts, we need
> -	 * to call the Linux handler to process the interrupt.
> -	 * We do that by jumping to absolute address 0x500 for
> -	 * external interrupts, or the machine_check_fwnmi label
> -	 * for machine checks (since firmware might have patched
> -	 * the vector area at 0x200).  The [h]rfid at the end of the
> -	 * handler will return to the book3s_hv_interrupts.S code.
> -	 * For other interrupts we do the rfid to get back
> -	 * to the book3s_hv_interrupts.S code here.
> +	 * For external interrupts we need to call the Linux
> +	 * handler to process the interrupt. We do that by jumping
> +	 * to absolute address 0x500 for external interrupts.
> +	 * The [h]rfid at the end of the handler will return to
> +	 * the book3s_hv_interrupts.S code. For other interrupts
> +	 * we do the rfid to get back to the book3s_hv_interrupts.S
> +	 * code here.
>  	 */
>  	ld	r8, 112+PPC_LR_STKOFF(r1)
>  	addi	r1, r1, 112
>  	ld	r7, HSTATE_HOST_MSR(r13)
> =20
> -	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
>  	beq	11f
>  	cmpwi	r12, BOOK3S_INTERRUPT_H_DOORBELL
> @@ -162,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtmsrd	r6, 1			/* Clear RI in MSR */
>  	mtsrr0	r8
>  	mtsrr1	r7
> -	beq	cr1, 13f		/* machine check */
>  	RFI
> =20
>  	/* On POWER7, we have external interrupts set to use HSRR0/1 */
> @@ -170,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_HSRR1, r7
>  	ba	0x500
> =20
> -13:	b	machine_check_fwnmi
> -
>  14:	mtspr	SPRN_HSRR0, r8
>  	mtspr	SPRN_HSRR1, r7
>  	b	hmi_exception_after_realmode
> @@ -2390,15 +2384,13 @@ machine_check_realmode:
>  	ld	r9, HSTATE_KVM_VCPU(r13)
>  	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	/*
> -	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest through
> -	 * machine check interrupt (set HSRR0 to 0x200). And for handled
> -	 * errors (no-fatal), just go back to guest execution with current
> -	 * HSRR0 instead of exiting guest. This new approach will inject
> -	 * machine check to guest for fatal error causing guest to crash.
> -	 *
> -	 * The old code used to return to host for unhandled errors which
> -	 * was causing guest to hang with soft lockups inside guest and
> -	 * makes it difficult to recover guest instance.
> +	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
> +	 * through machine check interrupt (set HSRR0 to 0x200) or by
> +	 * exiting the guest with KVM_EXIT_NMI exit reason if guest is
> +	 * FWNMI capable. For handled errors (no-fatal), just go back
> +	 * to guest execution with current HSRR0. This new approach
> +	 * injects machine check errors in guest address space to guest
> +	 * enabling guest kernel to suitably handle such errors.
>  	 *
>  	 * if we receive machine check with MSR(RI=3D0) then deliver it to
>  	 * guest as machine check causing guest to crash.
> @@ -2408,11 +2400,17 @@ machine_check_realmode:
>  	beq	1f			/* Deliver a machine check to guest */
>  	ld	r10, VCPU_PC(r9)
>  	cmpdi	r3, 0		/* Did we handle MCE ? */
> -	bne	2f	/* Continue guest execution. */
> +	bne	3f	/* Continue guest execution. */
>  	/* If not, deliver a machine check.  SRR0/1 are already set */
> -1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
> +1:  /* Check if guest is capable of handling NMI exit */
> +	ld  r3, VCPU_KVM(r9)
> +	lbz  r3, KVM_FWNMI(r3)
> +	cmpdi   r3, 1       /* FWNMI capable? */
> +	bne 2f
> +	b   mc_cont
> +2:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	bl	kvmppc_msr_interrupt
> -2:	b	fast_interrupt_c_return
> +3:	b	fast_interrupt_c_return
> =20
>  /*
>   * Check the reason we woke from nap, and take appropriate action.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8WKGInOJRMBXYFEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWluZ2AAoJEGw4ysog2bOSBxQP/RN8PkuE1fabiqxnjIe662WU
nKbwECGhiW0JI/zt9CM7KnaRmXG2/w/+aT+lZOIONP6muWIY+8lu9t+glFQcucW9
p4mUODCy6AAbB+FL2MyyuT2wi1uV5o1tQwih94HFIHBFYe2kg7Bp8GpuOwCd7Suk
z0QdWa5oWb7Mhv3wnKDWnTHKSzFeCFmHeVdIpCf8qyMvNSgUA1dqpKPKORx43UTj
BC6xAs5ByLDKaz+M9b+EfV9SPzubvY9gAheSwj4zz6oWeW+TiR+uBCuokUTcf8dc
5RF0uUzOU2ctbS21vA6xYnlSdWOa7oz/fxuPXskyv4lTxXfVuz138sZd48txGTjx
kZC5VQKwZM8pH5Qc7PoOF4yiue2KJDpZXRRIcOEuPiUsJcKYChuj9p/mKEAPvTay
Sv3T+577u7WhvGwcOgyXMkFkPcl4VNL5gWPShiC+jkN4d7WZH2sxaRSnIN2io/IB
iCcavk5jK3YO0wQhwg+ams3Omsx0DhZiURp5Ua0wjweQx+3kVCm4wKBok5TtO5Du
IwsyCVehMgruK5wVtakzUZTqiBd3i7Bne0Pe5yw9ApMC/33abnRCxZ11tol+qmor
plTMMCpHCX4i53VnmnqEB+R9Yl+cWOhx1pUUHV6krl5LxMutrTkYamk9DheEhPTA
Aoj7kq7hWe6qRDywjlBW
=38Xd
-----END PGP SIGNATURE-----

--8WKGInOJRMBXYFEc--
