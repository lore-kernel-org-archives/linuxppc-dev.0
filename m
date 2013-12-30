Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AEC232C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Dec 2013 20:13:00 +1100 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -V2] POWERPC: BOOK3S: KVM: Use the saved dsisr and dar
 values on book3s 64
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1388383469-6411-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 30 Dec 2013 10:12:53 +0100
Message-Id: <493C27B7-3DAF-418E-A53B-7FCB1BBBEB3F@suse.de>
References: <1388383469-6411-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 30.12.2013 um 07:04 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet=
.ibm.com>:
>=20
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Although it's optional IBM POWER cpus always had DAR value set on
> alignment interrupt. So don't try to compute these values.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> arch/powerpc/kvm/book3s_emulate.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_e=
mulate.c
> index 502a47ac4453..d8e2d079483d 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -599,6 +599,19 @@ unprivileged:
>=20
> u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, unsigned int inst)
> {
> +#ifdef CONFIG_PPC_BOOK3S_64
> +    return vcpu->arch.fault_dsisr;

This is still wrong when you virtualize a 750 on a 970 for example.

Alex

> +#else
> +    /*
> +     * Mac OS X has some applications - namely the Finder - that require
> +     * alignment interrupts to work properly. So we need to implement the=
m.
> +
> +     * But the spec for 970 and 750 also looks different. While 750 requi=
res
> +     * the DSISR and DAR fields to reflect some instruction bits (DSISR) a=
nd
> +     * the fault address (DAR), the 970 declares this as an optional feat=
ure.
> +     * So we need to reconstruct DSISR and DAR manually.
> +     */
> +
>    u32 dsisr =3D 0;
>=20
>    /*
> @@ -637,10 +650,24 @@ u32 kvmppc_alignment_dsisr(struct kvm_vcpu *vcpu, un=
signed int inst)
>    dsisr |=3D (inst >> 16) & 0x03ff; /* bits 22:31 */
>=20
>    return dsisr;
> +#endif
> }
>=20
> ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
> {
> +#ifdef CONFIG_PPC_BOOK3S_64
> +    return vcpu->arch.fault_dar;
> +#else
> +    /*
> +     * Mac OS X has some applications - namely the Finder - that require
> +     * alignment interrupts to work properly. So we need to implement the=
m.
> +
> +     * But the spec for 970 and 750 also looks different. While 750 requi=
res
> +     * the DSISR and DAR fields to reflect some instruction bits (DSISR) a=
nd
> +     * the fault address (DAR), the 970 declares this as an optional feat=
ure.
> +     * So we need to reconstruct DSISR and DAR manually.
> +     */
> +
>    ulong dar =3D 0;
>    ulong ra =3D get_ra(inst);
>    ulong rb =3D get_rb(inst);
> @@ -665,4 +692,5 @@ ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsi=
gned int inst)
>    }
>=20
>    return dar;
> +#endif
> }
> --=20
> 1.8.3.2
>=20
