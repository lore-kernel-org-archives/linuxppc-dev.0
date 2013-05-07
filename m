Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 May 2013 16:02:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 5/6] KVM: PPC: Add support for IOMMU in-kernel handling
Message-ID: <20130507060240.GQ13692@truffula.fritz.box>
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
 <1367825157-27231-6-git-send-email-aik@ozlabs.ru>
 <20130507052933.GP13692@truffula.fritz.box>
 <51889663.5060909@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ItYuPQ2o89VkWXjV"
In-Reply-To: <51889663.5060909@ozlabs.ru>
Cc: kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ItYuPQ2o89VkWXjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2013 at 03:51:31PM +1000, Alexey Kardashevskiy wrote:
> On 05/07/2013 03:29 PM, David Gibson wrote:
> > On Mon, May 06, 2013 at 05:25:56PM +1000, Alexey Kardashevskiy wrote:
> >> This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> >> and H_STUFF_TCE requests without passing them to QEMU, which should
> >> save time on switching to QEMU and back.
> >>
> >> Both real and virtual modes are supported - whenever the kernel
> >> fails to handle TCE request, it passes it to the virtual mode.
> >> If it the virtual mode handlers fail, then the request is passed
> >> to the user mode, for example, to QEMU.
> >>
> >> This adds a new KVM_CAP_SPAPR_TCE_IOMMU ioctl to asssociate
> >> a virtual PCI bus ID (LIOBN) with an IOMMU group, which enables
> >> in-kernel handling of IOMMU map/unmap.
> >>
> >> This adds a special case for huge pages (16MB).  The reference
> >> counting cannot be easily done for such pages in real mode (when
> >> MMU is off) so we added a list of huge pages.  It is populated in
> >> virtual mode and get_page is called just once per a huge page.
> >> Real mode handlers check if the requested page is huge and in the list,
> >> then no reference counting is done, otherwise an exit to virtual mode
> >> happens.  The list is released at KVM exit.  At the moment the fastest
> >> card available for tests uses up to 9 huge pages so walking through th=
is
> >> list is not very expensive.  However this can change and we may want
> >> to optimize this.
> >>
> >> This also adds the virt_only parameter to the KVM module
> >> for debug and performance check purposes.
> >>
> >> Tests show that this patch increases transmission speed from 220MB/s
> >> to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
> >>
> >> Cc: David Gibson <david@gibson.dropbear.id.au>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> Signed-off-by: Paul Mackerras <paulus@samba.org>
> >> ---
> >>  Documentation/virtual/kvm/api.txt   |   28 ++++
> >>  arch/powerpc/include/asm/kvm_host.h |    2 +
> >>  arch/powerpc/include/asm/kvm_ppc.h  |    2 +
> >>  arch/powerpc/include/uapi/asm/kvm.h |    7 +
> >>  arch/powerpc/kvm/book3s_64_vio.c    |  242 ++++++++++++++++++++++++++=
++++++++-
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c |  192 +++++++++++++++++++++++++++
> >>  arch/powerpc/kvm/powerpc.c          |   12 ++
> >>  include/uapi/linux/kvm.h            |    2 +
> >>  8 files changed, 485 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual=
/kvm/api.txt
> >> index f621cd6..2039767 100644
> >> --- a/Documentation/virtual/kvm/api.txt
> >> +++ b/Documentation/virtual/kvm/api.txt
> >> @@ -2127,6 +2127,34 @@ written, then `n_invalid' invalid entries, inva=
lidating any previously
> >>  valid entries found.
> >> =20
> >> =20
> >> +4.79 KVM_CREATE_SPAPR_TCE_IOMMU
> >> +
> >> +Capability: KVM_CAP_SPAPR_TCE_IOMMU
> >> +Architectures: powerpc
> >> +Type: vm ioctl
> >> +Parameters: struct kvm_create_spapr_tce_iommu (in)
> >> +Returns: 0 on success, -1 on error
> >> +
> >> +This creates a link between IOMMU group and a hardware TCE (translati=
on
> >> +control entry) table. This link lets the host kernel know what IOMMU
> >> +group (i.e. TCE table) to use for the LIOBN number passed with
> >> +H_PUT_TCE, H_PUT_TCE_INDIRECT, H_STUFF_TCE hypercalls.
> >> +
> >> +/* for KVM_CAP_SPAPR_TCE_IOMMU */
> >> +struct kvm_create_spapr_tce_iommu {
> >> +	__u64 liobn;
> >> +	__u32 iommu_id;
> >=20
> > Wouldn't it be more in keeping=20
>=20
>=20
> pardon?

Sorry, I was going to suggest a change, but then realised it wasn't
actually any better than what you have now.

> >> +	__u32 flags;
> >> +};
> >> +
> >> +No flag is supported at the moment.
> >> +
> >> +When the guest issues TCE call on a liobn for which a TCE table has b=
een
> >> +registered, the kernel will handle it in real mode, updating the hard=
ware
> >> +TCE table. TCE table calls for other liobns will cause a vm exit and =
must
> >> +be handled by userspace.
> >> +
> >> +
> >>  5. The kvm_run structure
> >>  ------------------------
> >> =20
> >> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/includ=
e/asm/kvm_host.h
> >> index 36ceb0d..2b70cbc 100644
> >> --- a/arch/powerpc/include/asm/kvm_host.h
> >> +++ b/arch/powerpc/include/asm/kvm_host.h
> >> @@ -178,6 +178,8 @@ struct kvmppc_spapr_tce_table {
> >>  	struct kvm *kvm;
> >>  	u64 liobn;
> >>  	u32 window_size;
> >> +	bool virtmode_only;
> >=20
> > I see this is now initialized from the global parameter, but I think
> > it would be better to just check the global (debug) parameter
> > directly, rather than duplicating it here.
>=20
>=20
> The global parameter is in kvm.ko and the struct above is in the real mode
> part which cannot go to the module.

Ah, ok.  I'm half inclined to just drop the virtmode_only thing
entirely.

> >> +	struct iommu_group *grp;    /* used for IOMMU groups */
> >>  	struct page *pages[0];
> >>  };
> >> =20
> >> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include=
/asm/kvm_ppc.h
> >> index d501246..bdfa140 100644
> >> --- a/arch/powerpc/include/asm/kvm_ppc.h
> >> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> >> @@ -139,6 +139,8 @@ extern void kvmppc_xics_free(struct kvm *kvm);
> >> =20
> >>  extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  				struct kvm_create_spapr_tce *args);
> >> +extern long kvm_vm_ioctl_create_spapr_tce_iommu(struct kvm *kvm,
> >> +				struct kvm_create_spapr_tce_iommu *args);
> >>  extern struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(
> >>  		struct kvm_vcpu *vcpu, unsigned long liobn);
> >>  extern long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *=
stt,
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/includ=
e/uapi/asm/kvm.h
> >> index 681b314..b67d44b 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -291,6 +291,13 @@ struct kvm_create_spapr_tce {
> >>  	__u32 window_size;
> >>  };
> >> =20
> >> +/* for KVM_CAP_SPAPR_TCE_IOMMU */
> >> +struct kvm_create_spapr_tce_iommu {
> >> +	__u64 liobn;
> >> +	__u32 iommu_id;
> >> +	__u32 flags;
> >> +};
> >> +
> >>  /* for KVM_ALLOCATE_RMA */
> >>  struct kvm_allocate_rma {
> >>  	__u64 rma_size;
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3=
s_64_vio.c
> >> index 643ac1e..98cf949 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >> @@ -27,6 +27,9 @@
> >>  #include <linux/hugetlb.h>
> >>  #include <linux/list.h>
> >>  #include <linux/anon_inodes.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/iommu.h>
> >> +#include <linux/module.h>
> >> =20
> >>  #include <asm/tlbflush.h>
> >>  #include <asm/kvm_ppc.h>
> >> @@ -38,10 +41,19 @@
> >>  #include <asm/kvm_host.h>
> >>  #include <asm/udbg.h>
> >>  #include <asm/iommu.h>
> >> +#include <asm/tce.h>
> >> +
> >> +#define DRIVER_VERSION	"0.1"
> >> +#define DRIVER_AUTHOR	"Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>"
> >> +#define DRIVER_DESC	"POWERPC KVM driver"
> >=20
> > Really?
>=20
>=20
> What is wrong here?

Well, it seems entirely unrelated to the rest of the changes, and not
obviously accurate.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ItYuPQ2o89VkWXjV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlGImQAACgkQaILKxv3ab8Y8UACfdJrr/IAqfwRmhj6ZmSh5KrFd
UnsAnR9tmg6sCFPi2DRduzJuR8Lxexvf
=5Isi
-----END PGP SIGNATURE-----

--ItYuPQ2o89VkWXjV--
