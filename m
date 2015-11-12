Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 637F01A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 14:38:56 +1100 (AEDT)
Date: Thu, 12 Nov 2015 14:34:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: paulus@ozlabs.org, linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 mahesh@linux.vnet.ibm.com, michaele@au1.ibm.com, agraf@suse.de,
 kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
Message-ID: <20151112033437.GI5852@voom.redhat.com>
References: <20151111165845.3721.98296.stgit@aravindap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zqjkMoGlbUJ91oFe"
In-Reply-To: <20151111165845.3721.98296.stgit@aravindap>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2015 at 10:28:46PM +0530, Aravinda Prasad wrote:
> This patch modifies KVM to cause a guest exit with
> KVM_EXIT_NMI instead of immediately delivering a 0x200
> interrupt to guest upon machine check exception in
> guest address. Exiting the guest enables QEMU to build
> error log and deliver machine check exception to guest
> OS (either via guest OS registered machine check
> handler or via 0x200 guest OS interrupt vector).
>=20
> This approach simplifies the delivering of machine
> check exception to guest OS compared to the earlier approach
> of KVM directly invoking 0x200 guest interrupt vector.
> In the earlier approach QEMU patched the 0x200 interrupt
> vector during boot. The patched code at 0x200 issued a
> private hcall to pass the control to QEMU to build the
> error log.
>=20
> This design/approach is based on the feedback for the
> QEMU patches to handle machine check exception. Details
> of earlier approach of handling machine check exception
> in QEMU and related discussions can be found at:
>=20
> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>=20
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c            |   12 +++---------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   31 +++++++++++--------------=
------
>  2 files changed, 14 insertions(+), 29 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 2280497..1b1dff0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -859,15 +859,9 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run=
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
> index b98889e..672b4f6 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -147,7 +147,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	addi	r1, r1, 112
>  	ld	r7, HSTATE_HOST_MSR(r13)
> =20
> -	cmpwi	cr1, r12, BOOK3S_INTERRUPT_MACHINE_CHECK
>  	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
>  	beq	11f
>  	cmpwi	cr2, r12, BOOK3S_INTERRUPT_HMI
> @@ -160,7 +159,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtmsrd	r6, 1			/* Clear RI in MSR */
>  	mtsrr0	r8
>  	mtsrr1	r7
> -	beq	cr1, 13f		/* machine check */
>  	RFI
> =20
>  	/* On POWER7, we have external interrupts set to use HSRR0/1 */
> @@ -168,8 +166,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	mtspr	SPRN_HSRR1, r7
>  	ba	0x500
> =20
> -13:	b	machine_check_fwnmi
> -

I don't quite understand the 3 hunks above.  The rest seems to change
the delivery of MCs as I'd expect, but the above seems to change their
detection and the reason for that isn't obvious to me.


>  14:	mtspr	SPRN_HSRR0, r8
>  	mtspr	SPRN_HSRR1, r7
>  	b	hmi_exception_after_realmode
> @@ -2381,24 +2377,19 @@ machine_check_realmode:
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
> +	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest
> +	 * by exiting the guest with KVM_EXIT_NMI exit reason (exit
> +	 * reason set later based on trap). For handled errors
> +	 * (no-fatal), go back to guest execution with current HSRR0
> +	 * instead of exiting the guest. This approach will cause
> +	 * the guest to exit in case of fatal machine check error.
>  	 */
> -	ld	r10, VCPU_PC(r9)
> +	bne	2f	/* Continue guest execution? */
> +	/* If not, exit the guest. SRR0/1 are already set */
> +	b	mc_cont
> +2:	ld	r10, VCPU_PC(r9)
>  	ld	r11, VCPU_MSR(r9)
> -	bne	2f	/* Continue guest execution. */
> -	/* If not, deliver a machine check.  SRR0/1 are already set */
> -	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
> -	ld	r11, VCPU_MSR(r9)
> -	bl	kvmppc_msr_interrupt
> -2:	b	fast_interrupt_c_return
> +	b	fast_interrupt_c_return
> =20
>  /*
>   * Check the reason we woke from nap, and take appropriate action.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zqjkMoGlbUJ91oFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRAjNAAoJEGw4ysog2bOSmyYQAM+I+OVqGejHbCBuR3WV3RR0
nWEcRbpXcTxTzC1LBOIfEopCU10VYbJv4RanXbZZLkbxVJOj/3kcmcAkBrS2GH0Z
1ieiABP5fHACmafXPsRpvRkeeYTm1wsj3Kp+Skny2gG/xIm98WbI1JLkcK7Qikml
u07m23PiXCXYMq+NI4ivqwI2QViks+XdOO1Uin5iCUZmKSwdlbrHZaSkTBfoGlze
qrNnVRJeM4YMSmJglyijXGNkRs85JFuGQaNoaxADTNcXx+iyMqITQA8Vbum0/sKg
s0fwv4gzRjYlGZJmUO/08GbnKwK4ZmQmO0Ebgzb3XFM+GNmhJ4yw8GcOkjbw1QHV
I3mTXxubxy8XLUiA2KECjaTSEgHYJb/bbU7qQgtQ/ANOd7K0UNPlWT2CxTkOWO2D
VZbHkYVMR6tLJ1Opx9rzQ4Y3YamSmUMF/x9snzEn3JxT80iCGmlGZszmflZKmt5T
Ye/RGe6lGzdUTVjjwA8ystneW9Ha9rxxxBaab2xjzMY2v+JvhaZGGIVMtVEJBfcQ
Hu9Fqum9zdYMLjlsa9DkKMleS/fdUiPYZIzxVVTClKHUPmcdTIr5/HTd6w4Yzq85
JVnWZ5oeJv86KDQbEQAKSZzqshiFSyWofh5LSL/zLniHBbbKCePVWRhBNZPYzqrD
VoDuluaB+4Gy+iWfNv0s
=d0oD
-----END PGP SIGNATURE-----

--zqjkMoGlbUJ91oFe--
