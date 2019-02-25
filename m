Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D92DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:12:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEB42087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ja4gf13m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEB42087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477nx1sCTzDq7h
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:12:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rm25lzzDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ja4gf13m"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rl72j5z9sNG; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067011;
 bh=1vYiQlwSwou3yEWB186oJMC8sZ0FXYH05zCzCfloz1g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ja4gf13m3kK0HVDbTp/GOHnQQAHpvkW8h7ecYcKPpLJ5XLIhWIQOQ//EX0FYHzcu6
 r4AGqYqUhrlW3ocQEh6vYLhvFjudziOMuJmoqiW+PVQb+qkiJkkMVDKAf7VCy+2PfN
 0Bkc5INPS0Q3rnjEi8NPgCETV+OVZ4z79xBu0N5g=
Date: Mon, 25 Feb 2019 14:31:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 10/16] KVM: PPC: Book3S HV: XIVE: add get/set
 accessors for the VP XIVE state
Message-ID: <20190225033144.GN7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-11-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-11-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:34PM +0100, C=E9dric Le Goater wrote:
> At a VCPU level, the state of the thread interrupt management
> registers needs to be collected. These registers are cached under the
> 'xive_saved_state.w01' field of the VCPU when the VPCU context is
> pulled from the HW thread. An OPAL call retrieves the backup of the
> IPB register in the underlying XIVE NVT structure and merges it in the
> KVM state.
>=20
> The structures of the interface between QEMU and KVM provisions some
> extra room (two u64) for further extensions if more state needs to be
> transferred back to QEMU.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h         | 11 +++
>  arch/powerpc/include/uapi/asm/kvm.h        |  2 +
>  arch/powerpc/kvm/book3s.c                  | 24 +++++++
>  arch/powerpc/kvm/book3s_xive_native.c      | 82 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt | 19 +++++
>  5 files changed, 138 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/as=
m/kvm_ppc.h
> index 1e61877fe147..664c65051612 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -272,6 +272,7 @@ union kvmppc_one_reg {
>  		u64	addr;
>  		u64	length;
>  	}	vpaval;
> +	u64	xive_timaval[4];

This is doubling the size of the userspace visible one_reg union.  Is
that safe?

>  };
> =20
>  struct kvmppc_ops {
> @@ -604,6 +605,10 @@ extern int kvmppc_xive_native_connect_vcpu(struct kv=
m_device *dev,
>  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
>  extern void kvmppc_xive_native_init_module(void);
>  extern void kvmppc_xive_native_exit_module(void);
> +extern int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
> +				     union kvmppc_one_reg *val);
> +extern int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
> +				     union kvmppc_one_reg *val);
> =20
>  #else
>  static inline int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 ser=
ver,
> @@ -636,6 +641,12 @@ static inline int kvmppc_xive_native_connect_vcpu(st=
ruct kvm_device *dev,
>  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu=
) { }
>  static inline void kvmppc_xive_native_init_module(void) { }
>  static inline void kvmppc_xive_native_exit_module(void) { }
> +static inline int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu,
> +					    union kvmppc_one_reg *val)
> +{ return 0; }
> +static inline int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu,
> +					    union kvmppc_one_reg *val)
> +{ return -ENOENT; }
> =20
>  #endif /* CONFIG_KVM_XIVE */
> =20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index cd78ad1020fe..42d4ef93ec2d 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -480,6 +480,8 @@ struct kvm_ppc_cpu_char {
>  #define  KVM_REG_PPC_ICP_PPRI_SHIFT	16	/* pending irq priority */
>  #define  KVM_REG_PPC_ICP_PPRI_MASK	0xff
> =20
> +#define KVM_REG_PPC_VP_STATE	(KVM_REG_PPC | KVM_REG_SIZE_U256 | 0x8d)
> +
>  /* Device control API: PPC-specific devices */
>  #define KVM_DEV_MPIC_GRP_MISC		1
>  #define   KVM_DEV_MPIC_BASE_ADDR	0	/* 64-bit */
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 96d43f091255..f85a9211f30c 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -641,6 +641,18 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
>  				*val =3D get_reg_val(id, kvmppc_xics_get_icp(vcpu));
>  			break;
>  #endif /* CONFIG_KVM_XICS */
> +#ifdef CONFIG_KVM_XIVE
> +		case KVM_REG_PPC_VP_STATE:
> +			if (!vcpu->arch.xive_vcpu) {
> +				r =3D -ENXIO;
> +				break;
> +			}
> +			if (xive_enabled())
> +				r =3D kvmppc_xive_native_get_vp(vcpu, val);
> +			else
> +				r =3D -ENXIO;
> +			break;
> +#endif /* CONFIG_KVM_XIVE */
>  		case KVM_REG_PPC_FSCR:
>  			*val =3D get_reg_val(id, vcpu->arch.fscr);
>  			break;
> @@ -714,6 +726,18 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
>  				r =3D kvmppc_xics_set_icp(vcpu, set_reg_val(id, *val));
>  			break;
>  #endif /* CONFIG_KVM_XICS */
> +#ifdef CONFIG_KVM_XIVE
> +		case KVM_REG_PPC_VP_STATE:
> +			if (!vcpu->arch.xive_vcpu) {
> +				r =3D -ENXIO;
> +				break;
> +			}
> +			if (xive_enabled())
> +				r =3D kvmppc_xive_native_set_vp(vcpu, val);
> +			else
> +				r =3D -ENXIO;
> +			break;
> +#endif /* CONFIG_KVM_XIVE */
>  		case KVM_REG_PPC_FSCR:
>  			vcpu->arch.fscr =3D set_reg_val(id, *val);
>  			break;
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 3debc876d5a0..132bff52d70a 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -845,6 +845,88 @@ static int kvmppc_xive_native_create(struct kvm_devi=
ce *dev, u32 type)
>  	return ret;
>  }
> =20
> +/*
> + * Interrupt Pending Buffer (IPB) offset
> + */
> +#define TM_IPB_SHIFT 40
> +#define TM_IPB_MASK  (((u64) 0xFF) << TM_IPB_SHIFT)
> +
> +int kvmppc_xive_native_get_vp(struct kvm_vcpu *vcpu, union kvmppc_one_re=
g *val)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	u64 opal_state;
> +	int rc;
> +
> +	if (!kvmppc_xive_enabled(vcpu))
> +		return -EPERM;
> +
> +	if (!xc)
> +		return -ENOENT;
> +
> +	/* Thread context registers. We only care about IPB and CPPR */
> +	val->xive_timaval[0] =3D vcpu->arch.xive_saved_state.w01;
> +
> +	/*
> +	 * Return the OS CAM line to print out the VP identifier in
> +	 * the QEMU monitor. This is not restored.
> +	 */
> +	val->xive_timaval[1] =3D vcpu->arch.xive_cam_word;

I'm pretty dubious about this mixing of vital state information with
what's basically debug information.  Doubly so since it requires
changing the ABI to increase the one_reg union's size.

Might be better to have this control only return the 0th and 2nd u64s
=66rom the TIMA, with the CAM debug information returned via some other
mechanism.

> +
> +	/* Get the VP state from OPAL */
> +	rc =3D xive_native_get_vp_state(xc->vp_id, &opal_state);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Capture the backup of IPB register in the NVT structure and
> +	 * merge it in our KVM VP state.
> +	 */
> +	val->xive_timaval[0] |=3D cpu_to_be64(opal_state & TM_IPB_MASK);
> +
> +	pr_devel("%s NSR=3D%02x CPPR=3D%02x IBP=3D%02x PIPR=3D%02x w01=3D%016ll=
x w2=3D%08x opal=3D%016llx\n",
> +		 __func__,
> +		 vcpu->arch.xive_saved_state.nsr,
> +		 vcpu->arch.xive_saved_state.cppr,
> +		 vcpu->arch.xive_saved_state.ipb,
> +		 vcpu->arch.xive_saved_state.pipr,
> +		 vcpu->arch.xive_saved_state.w01,
> +		 (u32) vcpu->arch.xive_cam_word, opal_state);

Hrm.. except you don't seem to be using the last half of the timaval
field anyway.


> +
> +	return 0;
> +}
> +
> +int kvmppc_xive_native_set_vp(struct kvm_vcpu *vcpu, union kvmppc_one_re=
g *val)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	struct kvmppc_xive *xive =3D vcpu->kvm->arch.xive;
> +
> +	pr_devel("%s w01=3D%016llx vp=3D%016llx\n", __func__,
> +		 val->xive_timaval[0], val->xive_timaval[1]);
> +
> +	if (!kvmppc_xive_enabled(vcpu))
> +		return -EPERM;
> +
> +	if (!xc || !xive)
> +		return -ENOENT;
> +
> +	/* We can't update the state of a "pushed" VCPU	 */
> +	if (WARN_ON(vcpu->arch.xive_pushed))

What prevents userspace from tripping this WARN_ON()?

> +		return -EIO;

EBUSY might be more appropriate here.

> +
> +	/*
> +	 * Restore the thread context registers. IPB and CPPR should
> +	 * be the only ones that matter.
> +	 */
> +	vcpu->arch.xive_saved_state.w01 =3D val->xive_timaval[0];
> +
> +	/*
> +	 * There is no need to restore the XIVE internal state (IPB
> +	 * stored in the NVT) as the IPB register was merged in KVM VP
> +	 * state when captured.
> +	 */
> +	return 0;
> +}
> +
>  static int xive_native_debug_show(struct seq_file *m, void *private)
>  {
>  	struct kvmppc_xive *xive =3D m->private;
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index a26be635cff9..1b8957c50c53 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -102,6 +102,25 @@ the legacy interrupt mode, referred as XICS (POWER7/=
8).
>      -EINVAL: Not initialized source number, invalid priority or
>               invalid CPU number.
> =20
> +* VCPU state
> +
> +  The XIVE IC maintains VP interrupt state in an internal structure
> +  called the NVT. When a VP is not dispatched on a HW processor
> +  thread, this structure can be updated by HW if the VP is the target
> +  of an event notification.
> +
> +  It is important for migration to capture the cached IPB from the NVT
> +  as it synthesizes the priorities of the pending interrupts. We
> +  capture a bit more to report debug information.
> +
> +  KVM_REG_PPC_VP_STATE (4 * 64bits)
> +  bits:     |  63  ....  32  |  31  ....  0  |
> +  values:   |   TIMA word0   |   TIMA word1  |
> +  bits:     | 127       ..........       64  |
> +  values:   |         VP CAM Line            |
> +  bits:     | 255       ..........      128  |
> +  values:   |            unused              |
> +
>  * Migration:
> =20
>    Saving the state of a VM using the XIVE native exploitation mode

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzYZ0ACgkQbDjKyiDZ
s5JCQQ/9F6UP4/CVijU3rdstCY+HgyGOCQCKr6AK+/XBKqmDwsfYNaYCwq2uJZEs
XvO6PixB9UzViPbACnk+ZNyQm2ii+gRDdqSyu61XvG/Z0WajbCpHTfP/PlhwV7LR
w+Zb3ZurJUDbCNpNFSAJruthYJRzjLpfrtIDV08gHjebzy/dgY7tmEQgixWCMsl2
SiHeoaU4Nd6Eds/uzNxtaoWUXMYipNazZDSDixUD9cc5kcI/d533NzU/Nm4RWKCA
yp/qhgkIsLH2OZCrad/KaOClsob1Nu5owEAVa/hT6djhsqqq4N39TB9qG2YYVsoQ
0slWBNSW5PhQ2hjop/hbdnhMFhATg6YrFm9w045qiL3l3xf4j9ZjrWcZSZ6NnVBg
XuL/5b0yZ0ptTL41zXgSNDwAcPQP7ihPDeeji7YdcGU9orv42w9pzl72xYxd/RNL
B3VRBjLm19Uc9GuiL1i/tqIpnz30OF62ORiYsteX/ynP+2MV3fIZC1KQP3VCVXo/
YNhVfolRSbh1gmaUB6Aou28QnBdnb1xh1bRfUMbHi7/PGYYbn7YJl5jh3YJ8+5x7
MnMbbHRcIlV60kG6iUjvaRjjLubIksZ1Hnays2tgwgso6Xuij766PHrRDPo6/DHJ
1qDbd/hMtV49Y1WacibfNsVpNPQvDJWzgyMSBTfww8OEDK+DLlA=
=Fg4K
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--
