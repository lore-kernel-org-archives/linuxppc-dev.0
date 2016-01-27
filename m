Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2C691A0054
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 10:54:12 +1100 (AEDT)
Date: Thu, 28 Jan 2016 10:53:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 4/4] KVM: PPC: Add support for 64bit TCE windows
Message-ID: <20160127235329.GC23015@voom.fritz.box>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-5-git-send-email-aik@ozlabs.ru>
 <20160125053727.GE32205@voom.redhat.com>
 <56A83995.1020303@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
In-Reply-To: <56A83995.1020303@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 02:29:25PM +1100, Alexey Kardashevskiy wrote:
> On 01/25/2016 04:37 PM, David Gibson wrote:
> >On Thu, Jan 21, 2016 at 07:15:26PM +1100, Alexey Kardashevskiy wrote:
> >>The existing KVM_CREATE_SPAPR_TCE only supports 32bit windows which is =
not
> >>enough for directly mapped windows as the guest can get more than 4GB.
> >>
> >>This adds KVM_CREATE_SPAPR_TCE_64 ioctl and advertises it
> >>via KVM_CAP_SPAPR_TCE_64 capability.
> >>
> >>Since 64bit windows are to support Dynamic DMA windows (DDW), let's add
> >>@bus_offset and @page_shift which are also required by DDW.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  Documentation/virtual/kvm/api.txt   | 32 ++++++++++++++++++++++++++++=
++++
> >>  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
> >>  arch/powerpc/include/uapi/asm/kvm.h |  9 +++++++++
> >>  arch/powerpc/kvm/book3s_64_vio.c    | 10 +++++++---
> >>  arch/powerpc/kvm/powerpc.c          | 25 ++++++++++++++++++++++++-
> >>  include/uapi/linux/kvm.h            |  2 ++
> >>  6 files changed, 75 insertions(+), 5 deletions(-)
> >>
> >>diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/=
kvm/api.txt
> >>index da39435..d1c5655 100644
> >>--- a/Documentation/virtual/kvm/api.txt
> >>+++ b/Documentation/virtual/kvm/api.txt
> >>@@ -3060,6 +3060,38 @@ an implementation for these despite the in kerne=
l acceleration.
> >>
> >>  This capability is always enabled.
> >>
> >>+4.96 KVM_CREATE_SPAPR_TCE_64
> >>+
> >>+Capability: KVM_CAP_SPAPR_TCE_64
> >>+Architectures: powerpc
> >>+Type: vm ioctl
> >>+Parameters: struct kvm_create_spapr_tce_64 (in)
> >>+Returns: file descriptor for manipulating the created TCE table
> >>+
> >>+This is an extension for KVM_CAP_SPAPR_TCE which only supports 32bit
> >>+windows, described in 4.62 KVM_CREATE_SPAPR_TCE
> >>+
> >>+This capability uses extended struct in ioctl interface:
> >>+
> >>+/* for KVM_CAP_SPAPR_TCE_64 */
> >>+struct kvm_create_spapr_tce_64 {
> >>+	__u64 liobn;
> >>+	__u32 page_shift;
> >>+	__u64 offset;	/* in pages */
> >>+	__u64 size; 	/* in pages */
> >>+	__u32 flags;
> >
> >Best to move page_shift after offset and size, so the structure
> >doesn't get an alignment gap.
>=20
> Agrh. I did this again :-/
>=20
>=20
> >>+};
> >>+
> >>+The aim of extension is to support an additional bigger DMA window with
> >>+a variable page size.
> >>+KVM_CREATE_SPAPR_TCE_64 receives a 64bit window size, an IOMMU page sh=
ift and
> >>+a bus offset of the corresponding DMA window, @size and @offset are nu=
mbers
> >>+of IOMMU pages.
> >>+
> >>+@flags are not used at the moment.
> >>+
> >>+The rest of functionality is identical to KVM_CREATE_SPAPR_TCE.
> >>+
> >>  5. The kvm_run structure
> >>  ------------------------
> >>
> >>diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/=
asm/kvm_ppc.h
> >>index 4cadee5..6e4d1dc 100644
> >>--- a/arch/powerpc/include/asm/kvm_ppc.h
> >>+++ b/arch/powerpc/include/asm/kvm_ppc.h
> >>@@ -165,7 +165,7 @@ extern void kvmppc_map_vrma(struct kvm_vcpu *vcpu,
> >>  extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
> >>
> >>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>-				struct kvm_create_spapr_tce *args);
> >>+				struct kvm_create_spapr_tce_64 *args);
> >>  extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
> >>  		struct kvm_vcpu *vcpu, unsigned long liobn);
> >>  extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> >>diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include=
/uapi/asm/kvm.h
> >>index ab4d473..9c8b4cbc 100644
> >>--- a/arch/powerpc/include/uapi/asm/kvm.h
> >>+++ b/arch/powerpc/include/uapi/asm/kvm.h
> >>@@ -333,6 +333,15 @@ struct kvm_create_spapr_tce {
> >>  	__u32 window_size;
> >>  };
> >>
> >>+/* for KVM_CAP_SPAPR_TCE_64 */
> >>+struct kvm_create_spapr_tce_64 {
> >>+	__u64 liobn;
> >>+	__u32 page_shift;
> >>+	__u64 offset;	/* in pages */
> >>+	__u64 size;	/* in pages */
> >>+	__u32 flags;
> >>+};
> >>+
> >>  /* for KVM_ALLOCATE_RMA */
> >>  struct kvm_allocate_rma {
> >>  	__u64 rma_size;
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s=
_64_vio.c
> >>index 85ee572..5479446 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio.c
> >>@@ -144,20 +144,23 @@ static const struct file_operations kvm_spapr_tce=
_fops =3D {
> >>  };
> >>
> >>  long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>-				   struct kvm_create_spapr_tce *args)
> >>+				   struct kvm_create_spapr_tce_64 *args)
> >>  {
> >>  	struct kvmppc_spapr_tce_table *stt =3D NULL;
> >>  	unsigned long npages, size;
> >>  	int ret =3D -ENOMEM;
> >>  	int i;
> >>
> >>+	if (!args->size)
> >>+		return -EINVAL;
> >>+
> >>  	/* Check this LIOBN hasn't been previously allocated */
> >>  	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> >>  		if (stt->liobn =3D=3D args->liobn)
> >>  			return -EBUSY;
> >>  	}
> >>
> >>-	size =3D args->window_size >> IOMMU_PAGE_SHIFT_4K;
> >>+	size =3D args->size;
> >
> >Doesn't this need some kind of bounds on the allowed size?
>=20
>=20
> kvmppc_account_memlimit() below is some kind of bound, not enough?

Ah, yes, that should be enough.

Sorry, missed that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWqVh5AAoJEGw4ysog2bOSGGEQAIX2IEB7mFzjMybTr23mRBXY
lHLvKJKYPBi6yFoL9et/w4BAnptexlKCz+5F2Toqgij0C6Sin6Hsw7eWYh3bkn2/
0SB39NN/UHP1m1GRNQQqZJRNdhSIm+gQLmtMsRk5hz5aG/3NrPaS7G4jnWpjJvBb
ODXh4lylnzPVTP30XQqabSxMaJC8fI99g7kQuAk7pIT1KdyILNTB2eq9MDIQ1CUB
KM6RT+BSCzXHVnvDeLQMjFEuV8YBgWMPM8S9BH+JxB9g1gn/1gUA1mubpvA9zBnD
iUcXIm9ZBg9EG/hEdWOuQnVj7TDMwrpbwUSkkHbmwgPedezoE1I1yvnh/WAvP0sR
dU/n/kMGm9MxiCUNRkmKXCO7VoCSGXHE8JPptk3tG0XmZueRZGVsHmh6+qWv4dud
6v3Brav5Wy56qWuS9DF0TUrLTzV9KZJ5Y9W0KvJkVz7TTJxxRSIVJqEwmL1JcGUO
mPM+pBfvMR/XFOVS6Xx1/KowuvC1mu4nF2Rp4nMoJrtHtypUU1P98amCD8c7YkWf
aFR81K9UXqQcQPWf0TSvBJ6claMlZb4YzgjBJmn3vcMjFOPTJ4SYNRfq3H6MOuhT
BMRavkM8/HG0J1xNuZOEWWkb6yar3gJxCJ9pnax0uyig0xale7mvpLxkZ0A4Pd13
heyr3z2ppaAMHX8pcKZR
=srUp
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
