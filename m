Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxr9j14BKzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 16:55:53 +1000 (AEST)
Date: Wed, 20 Sep 2017 16:46:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Neuling <mikey@neuling.org>
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 benh@kernel.crashing.org, pbonzini@redhat.com
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Check for updated HDSISR on P9 HDSI
 exception
Message-ID: <20170920064611.GN5520@umbus.fritz.box>
References: <20170915052614.8231-1-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="A2x6GFCQWVc4i5ud"
In-Reply-To: <20170915052614.8231-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--A2x6GFCQWVc4i5ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2017 at 03:26:14PM +1000, Michael Neuling wrote:
> On POWER9 DD2.1 and below, sometimes on a Hypervisor Data Storage
> Interrupt (HDSI) the HDSISR is not be updated at all.
>=20
> To work around this we put a canary value into the HDSISR before
> returning to a guest and then check for this canary when we take a
> HDSI. If we find the canary on a HDSI, we know the hardware didn't
> update the HDSISR. In this case we return to the guest to retake the
> HDSI which should correctly update the HDSISR the second time HDSI
> entry.
>=20
> After talking to Paulus we've applied this workaround to all POWER9
> CPUs. The workaround of returning to the guest shouldn't ever be
> triggered on well behaving CPU. The extra instructions should have
> negligible performance impact.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Paolo,

Any chance you can take this directly into your staging tree.  This is
a workaround for a potentially serious hardware bug, and we want to
get it into the downstream release ASAP.  However, Paulus is away for
a couple of weeks, so we can't count on him staging it in the kvm-ppc
tree soon.

> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/b=
ook3s_hv_rmhandlers.S
> index 663a4a861e..70dca60569 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1118,6 +1118,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  BEGIN_FTR_SECTION
>  	mtspr	SPRN_PPR, r0
>  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> +
> +/* Move canary into DSISR to check for later */
> +BEGIN_FTR_SECTION
> +	li	r0, 0x7fff
> +	mtspr	SPRN_HDSISR, r0
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +
>  	ld	r0, VCPU_GPR(R0)(r4)
>  	ld	r4, VCPU_GPR(R4)(r4)
> =20
> @@ -1947,9 +1954,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
>  kvmppc_hdsi:
>  	ld	r3, VCPU_KVM(r9)
>  	lbz	r0, KVM_RADIX(r3)
> -	cmpwi	r0, 0
>  	mfspr	r4, SPRN_HDAR
>  	mfspr	r6, SPRN_HDSISR
> +BEGIN_FTR_SECTION
> +	/* Look for DSISR canary. If we find it, retry instruction */
> +	cmpdi	r6, 0x7fff
> +	beq	6f
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +	cmpwi	r0, 0
>  	bne	.Lradix_hdsi		/* on radix, just save DAR/DSISR/ASDR */
>  	/* HPTE not found fault or protection fault? */
>  	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A2x6GFCQWVc4i5ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnCDq0ACgkQbDjKyiDZ
s5Jx1RAAxNLMiu9TJyW9ZE5RMGNkasKtneB+8JmEVixv97qXJrHZLD/00f6qMN/h
WNv9GjrWAXFQnhbXDIOoSlQpGXrHUgaeQ2I++lsvj3XmOY+CBfeTWSkleW38QL1B
/uGSj8z+wLsN+88Taw6THezXiFC/1ZMIDpHVR54Rj5b+lcz/07W80bIu2SCAEcFt
VAc/RoBo8HdzB0ZkDtvqcEYHfHDHZi20ch1bmM0uLTlxA94sHPQLH3vVa4X/9NsM
hwtfFaFKtVUvV1R8xZ75iAk0OrI8tnOtNhFCcfkiAQxCRjULXsA2eea2+vsZwFLS
FkZPoJamtIRcBPL1DCAIybgtFSpQcjEpfS1OkmucgSCc4wsWa631ehOh5kZir8JX
QzsHYrHKISb0LTVzEFTNYqUV+MQxwvuYpRnWNYF8gNmfcOVLwW4E5dY7nVQ2JBoT
1P+tSNUxzohx6enu6mmCWxmzRcqyeGxArq6Vw5Eazky95j4y2hd3gMQ/sBR17FQd
IDmkMIYM8Pfc9eKV5afZ6g/nMtWfaB39TFroH3aFglhDyRhVwhVcYq8TeuvadL1U
Xq8i+rlzB/RGasC6QZAxfOKU/8O36RDYBYkHlyVLZoCQxfZMG4HCYvMXx8lcwSkT
X2kbv1P1WjBkALgHLdcAS/u+Dexem9RuHgOWjuzq70t8OOPTVGc=
=o4XU
-----END PGP SIGNATURE-----

--A2x6GFCQWVc4i5ud--
