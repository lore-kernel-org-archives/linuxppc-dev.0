Return-Path: <dgibson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjxF518NmzDq9p
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 14:00:57 +1000 (AEST)
Date: Mon, 11 Apr 2016 14:02:05 +1000
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, Gleb Natapov
 <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf
 <agraf@suse.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul
 Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, thuth@redhat.com
Subject: Re: [PATCH v2] kvm-pr: manage single-step mode
Message-ID: <20160411140205.19d9a35e@voom.fritz.box>
In-Reply-To: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
References: <1460131500-19560-1-git-send-email-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/19rz8KN1z.i9N2w3GwyXxU4"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/19rz8KN1z.i9N2w3GwyXxU4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  8 Apr 2016 18:05:00 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Until now, when we connect gdb to the QEMU gdb-server, the
> single-step mode is not managed.
>=20
> This patch adds this, only for kvm-pr:
>=20
> If KVM_GUESTDBG_SINGLESTEP is set, we enable single-step trace bit in the
> MSR (MSR_SE) just before the __kvmppc_vcpu_run(), and disable it just aft=
er.
> In kvmppc_handle_exit_pr, instead of routing the interrupt to
> the guest, we return to host, with KVM_EXIT_DEBUG reason.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2: split BOOK3S_INTERRUPT_MACHINE_CHECK and BOOK3S_INTERRUPT_TRACE
>=20
>  arch/powerpc/kvm/book3s_pr.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 95bceca..8129b0d 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -882,6 +882,24 @@ void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr)
>  }
>  #endif
> =20
> +static void kvmppc_setup_debug(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> +		u64 msr =3D kvmppc_get_msr(vcpu);
> +
> +		kvmppc_set_msr(vcpu, msr | MSR_SE);
> +	}
> +}
> +
> +static void kvmppc_clear_debug(struct kvm_vcpu *vcpu)
> +{
> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> +		u64 msr =3D kvmppc_get_msr(vcpu);
> +
> +		kvmppc_set_msr(vcpu, msr & ~MSR_SE);
> +	}
> +}
> +
>  int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  			  unsigned int exit_nr)
>  {
> @@ -1207,10 +1225,18 @@ program_interrupt:
>  		break;
>  #endif
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> -	case BOOK3S_INTERRUPT_TRACE:
>  		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
>  		r =3D RESUME_GUEST;
>  		break;
> +	case BOOK3S_INTERRUPT_TRACE:
> +		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
> +			run->exit_reason =3D KVM_EXIT_DEBUG;
> +			r =3D RESUME_HOST;
> +		} else {
> +			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
> +			r =3D RESUME_GUEST;
> +		}
> +		break;
>  	default:
>  	{
>  		ulong shadow_srr1 =3D vcpu->arch.shadow_srr1;
> @@ -1479,6 +1505,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_r=
un, struct kvm_vcpu *vcpu)
>  		goto out;
>  	}
> =20
> +	kvmppc_setup_debug(vcpu);
> +
>  	/*
>  	 * Interrupts could be timers for the guest which we have to inject
>  	 * again, so let's postpone them until we're in the guest and if we
> @@ -1501,6 +1529,8 @@ static int kvmppc_vcpu_run_pr(struct kvm_run *kvm_r=
un, struct kvm_vcpu *vcpu)
> =20
>  	ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
> =20
> +	kvmppc_clear_debug(vcpu);
> +
>  	/* No need for kvm_guest_exit. It's done in handle_exit.
>  	   We also get here with interrupts enabled. */
> =20
> --=20
> 2.5.5
>=20


--=20
David Gibson <dgibson@redhat.com>
Senior Software Engineer, Virtualization, Red Hat

--Sig_/19rz8KN1z.i9N2w3GwyXxU4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXCyG9AAoJEGw4ysog2bOSIugQAMv3se8KI9uHF2oMBkkJ7vPO
B967ONL78thaEGbqVicRhMHscetua0vnIKyKGagAhdORIkSM+BQcJLCv92eJVHj2
gzI2vzJCMgZUE69VeGxXm7leM9gAMpcDoyvIrtRd5Yw4cCtDxji6tMuGifuVs8R3
hx2B0lv5NR0DbSMpURHa2SFiB8PvXjDJ/GkGMW5qLIyD9IunxAqvpmst+Y3GkTMb
cfcueU04GP2sjOzdX64LTx6tsak62AKCZuIsWKUPaaW9ha0q12wkZecdJO9RSihH
OQYweryL1vnM+KkyV8/DGc8Y2Nn3SfCUuHFMCU2Xzwm+0T64E/1Pil7VMnFkc0su
K7nMWj0YLg78oetxed1IdZNfj0g9KnRZXsBRcg7k6r5X1C6j77EL4ElSz6RM9DWv
FAytHvapuR+RYQ5yFbZvhM0dHuVaY9EMIik2XmI6g32zhuTBCIb5xC/F82Bu+AGy
OpYswgvG7lNlJ5dK4KA+ONDkXxhl8njnt1TLMxVTRBvT3+TedDah5/Eqb561OAww
4nLaUUY26PJrhMWIh8/PXMc+b217/OZggiRRkbu5qbYRe3u2WjHnZeazcpQLXhnt
N17tkxkI4GdhtRzO1Bct8kJH6GPt/Yx/jskpwXpgeoM6Mb5civD8dBcbQM4RrCsG
gbtGIltfqTN1+e1dyW60
=vNgW
-----END PGP SIGNATURE-----

--Sig_/19rz8KN1z.i9N2w3GwyXxU4--
