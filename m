Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8B4BE1A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 11:43:11 +1100 (AEDT)
Date: Mon, 25 Jan 2016 11:18:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 5/6] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
Message-ID: <20160125001806.GE27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-6-git-send-email-aik@ozlabs.ru>
 <20160125001236.GD27454@voom.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Th5JPit8I3Q6/gDv"
In-Reply-To: <20160125001236.GD27454@voom.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Th5JPit8I3Q6/gDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 11:12:36AM +1100, David Gibson wrote:
> On Thu, Jan 21, 2016 at 06:39:36PM +1100, Alexey Kardashevskiy wrote:
> > Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
> > will validate TCE (not to have unexpected bits) and IO address
> > (to be within the DMA window boundaries).
> >=20
> > This introduces helpers to validate TCE and IO address. The helpers are
> > exported as they compile into vmlinux (to work in realmode) and will be
> > used later by KVM kernel module in virtual mode.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v2:
> > * added note to the commit log about why new helpers are exported
> > * did not add a note that xxx_validate() validate TCEs for KVM (not for
> > host kernel DMA) as the helper names and file location tell what are
> > they for
> > ---
> >  arch/powerpc/include/asm/kvm_ppc.h  |  4 ++
> >  arch/powerpc/kvm/book3s_64_vio_hv.c | 92 +++++++++++++++++++++++++++++=
+++-----
> >  2 files changed, 84 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/=
asm/kvm_ppc.h
> > index 2241d53..9513911 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -166,6 +166,10 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu=
 *vcpu);
> > =20
> >  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >  				struct kvm_create_spapr_tce *args);
> > +extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> > +		unsigned long ioba, unsigned long npages);
> > +extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
> > +		unsigned long tce);
> >  extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liob=
n,
> >  			     unsigned long ioba, unsigned long tce);
> >  extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liob=
n,
> > diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/boo=
k3s_64_vio_hv.c
> > index e142171..8cd3a95 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> > @@ -36,6 +36,7 @@
> >  #include <asm/kvm_host.h>
> >  #include <asm/udbg.h>
> >  #include <asm/iommu.h>
> > +#include <asm/tce.h>
> > =20
> >  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> > =20
> > @@ -64,18 +65,90 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_t=
able(struct kvm_vcpu *vcpu,
> >   * WARNING: This will be called in real-mode on HV KVM and virtual
> >   *          mode on PR KVM
> >   */
> > -static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> > +long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> >  		unsigned long ioba, unsigned long npages)
> >  {
> > -	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> > +	unsigned long mask =3D IOMMU_PAGE_MASK_4K;
> >  	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> >  	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> > =20
> > -	if ((ioba & mask) || (idx + npages > size))
> > +	if ((ioba & ~mask) || (idx + npages > size))
> >  		return H_PARAMETER;
> > =20
> >  	return H_SUCCESS;
> >  }
> > +EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
> > +
> > +/*
> > + * Validates TCE address.
> > + * At the moment flags and page mask are validated.
> > + * As the host kernel does not access those addresses (just puts them
> > + * to the table and user space is supposed to process them), we can sk=
ip
> > + * checking other things (such as TCE is a guest RAM address or the pa=
ge
> > + * was actually allocated).
> > + *
> > + * WARNING: This will be called in real-mode on HV KVM and virtual
> > + *          mode on PR KVM
> > + */
> > +long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt,
> >  unsigned long tce)
>=20
> It would be nice to write this in terms of kvmppc_ioba_validate() above.

Duh, sorry.  Realised shortly afterwards that's nonsense.  One is
looking at the IOBA, the other at the real address.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Th5JPit8I3Q6/gDv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpWm+AAoJEGw4ysog2bOSylkP/3xRihQO0S6cqlM/amAJ5Kub
rkwruSYv3CX5A1rWlv21c80ds930ceZjYLOCbTEfOp0iJDHJUEcc1gtAJBNkcTJd
myk8rcLNQkcuJ2TYzzKacEVys25JLoVt6XHS/fegHgoAIZKTQ+7Qmnad3tdGd3TQ
DxwCHAKpXq8cMGK0176Omm+GqPchVLbM24/RjWp8UDl4fJJ7EMvInHf4yZbl7WF6
t2K+8kPAxCVj6qDQ8xlgMX/9KjtMh+wUoqDALFHY598M1swZZrN4TkHkFihH8k8K
K84671/dvK3gIJiPpE8vY1K8WmbiP57+TckoK//eiE4msj89S3q2L8m+lb/AY8rL
zDQUjLj4bLWXJssLs7766+I6nYHCYOEE4x6me9bke+MTOfAei+yz3Y7BIa+XMSYP
wckVTS9ooDdXSpaUVpK3cUGk4ZqczcRmjenSAlB3fBWxPAnZZeS4Cx67OEbviY0Q
mggS6SQDravYw/XfUYSBpNCw6MxzU+Kkg0IVBoxVE93wz6RAbG9vsC0/j2nR9GHD
vI7TmwxshXZisf1m1ZlrlG/prMgq7AvjFIKgpKIiHkowbYGzbR8e8ATGHO4/WBfN
u0lxFqemWQez5R88OTLw0ONcvW0pF5q594ON9tXCUy6jUmtPmLFAfd1cuBLI/+ma
67nul0Q4VFi/M0RefQV5
=hJVW
-----END PGP SIGNATURE-----

--Th5JPit8I3Q6/gDv--
