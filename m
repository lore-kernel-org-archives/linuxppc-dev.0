Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D01B11A05D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 10:45:52 +1100 (AEDT)
Date: Mon, 25 Jan 2016 10:43:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 1/6] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE
 handlers
Message-ID: <20160124234329.GA27454@voom.redhat.com>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
 <20160122004245.GL27454@voom.redhat.com>
 <56A18D13.9050908@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FCPLy5NpE1Kdjj9y"
In-Reply-To: <56A18D13.9050908@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FCPLy5NpE1Kdjj9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 12:59:47PM +1100, Alexey Kardashevskiy wrote:
> On 01/22/2016 11:42 AM, David Gibson wrote:
> >On Thu, Jan 21, 2016 at 06:39:32PM +1100, Alexey Kardashevskiy wrote:
> >>This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have following
> >>patches applied nicer.
> >>
> >>This moves the ioba boundaries check to a helper and adds a check for
> >>least bits which have to be zeros.
> >>
> >>The patch is pretty mechanical (only check for least ioba bits is added)
> >>so no change in behaviour is expected.
> >>
> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >
> >Concept looks good, but there are a couple of nits.
> >
> >>---
> >>Changelog:
> >>v2:
> >>* compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
> >>* made error reporting cleaner
> >>---
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c | 111 +++++++++++++++++++++++----=
---------
> >>  1 file changed, 72 insertions(+), 39 deletions(-)
> >>
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/boo=
k3s_64_vio_hv.c
> >>index 89e96b3..862f9a2 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> >>@@ -35,71 +35,104 @@
> >>  #include <asm/ppc-opcode.h>
> >>  #include <asm/kvm_host.h>
> >>  #include <asm/udbg.h>
> >>+#include <asm/iommu.h>
> >>
> >>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
> >>
> >>+/*
> >>+ * Finds a TCE table descriptor by LIOBN.
> >>+ *
> >>+ * WARNING: This will be called in real or virtual mode on HV KVM and =
virtual
> >>+ *          mode on PR KVM
> >>+ */
> >>+static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcp=
u *vcpu,
> >>+		unsigned long liobn)
> >>+{
> >>+	struct kvm *kvm =3D vcpu->kvm;
> >>+	struct kvmppc_spapr_tce_table *stt;
> >>+
> >>+	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
> >
> >list_for_each_entry_lockless?  According to the comments in the
> >header, that's for RCU protected lists, whereas this one is just
> >protected by the lock in the kvm structure.  This is replacing a plain
> >list_for_each_entry().
>=20
> My bad, the next patch should have done this
> s/list_for_each_entry/list_for_each_entry_lockless/

Ah, yes.  I hadn't yet looked at the second patch.

> >>+		if (stt->liobn =3D=3D liobn)
> >>+			return stt;
> >>+
> >>+	return NULL;
> >>+}
> >>+
> >>+/*
> >>+ * Validates IO address.
> >>+ *
> >>+ * WARNING: This will be called in real-mode on HV KVM and virtual
> >>+ *          mode on PR KVM
> >>+ */
> >>+static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
> >>+		unsigned long ioba, unsigned long npages)
> >>+{
> >>+	unsigned long mask =3D (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
> >>+	unsigned long idx =3D ioba >> IOMMU_PAGE_SHIFT_4K;
> >>+	unsigned long size =3D stt->window_size >> IOMMU_PAGE_SHIFT_4K;
> >>+
> >>+	if ((ioba & mask) || (idx + npages > size))
> >
> >It doesn't matter for the current callers, but you should check for
> >overflow in idx + npages as well.
>=20
>=20
> npages can be only 1..512 and this is checked in H_PUT_TCE/etc handlers.
> idx is 52bit long max.
> And this is not going to change because H_PUT_TCE_INDIRECT will always be
> limited by 512 (or one 4K page).

Ah, ok.

> Do I still need the overflow check here?

Hm, I guess it's not essential.  I'd still prefer to see it though,
since it's good practice in general.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FCPLy5NpE1Kdjj9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWpWGhAAoJEGw4ysog2bOS7wYQAMIUTa3leyb+yby7w1Z+IPON
QR8hRgU4nn5Ca3VKOg6rGKOCNyTYA46VaTRi9GuRg9s5c78ZCaFpuZGnt671ViL1
IePiPPbj3gAfSOAw7vvKAQsuupiKDYTBuN/+D7b8DQS5SsUv73v4OguXx6jUCpsg
IE2f18OEaPn4Z6YfWoHPva0ZaHWBh7fAVDc77eGGc4S2veKivAR2cFxGe0UtVN/H
2edZExPaeuRkUWgeirtADVSl/nKzVTp2A5UwnJJ/am9rfG9Wgzi1o40V+hGLHfzd
6d4B7ydlp8Zjo48pQIWKLcJrqa7u/ylpxwrxEN3b5bv9yOrnBO125przJSxXBaE4
BNOEzUu24oZIk4+P14uPSJ9HB9F+G5la1CB+bw6dvqg+JntFTynebafNsEmjPtT6
50CYLPkpWIiNyLBh4i8hq7ZpRMEtTBX3p0pBKUns1jCe02zow3oUgIr+a2Paimbv
F9TSPkxFB8qRcphz+ubk1WyISlkdErFZnU8/H6EAnIdImzzgI9ZwYb/CNjyB/7bF
t9TH2LWeArPsxEjCgVebiUVjVdQM1ZXwYm0LVGpZo8cB1utr3LPli31mUlDbfErg
BxSJ6hxKTH6hvoa/5HkQ9lUpQSCqA2pSf5QIkFPh517E9XP1n0lH5Ou70VEj+h6/
V+Q2i8iOzpk/Cwbt5vi0
=lbDF
-----END PGP SIGNATURE-----

--FCPLy5NpE1Kdjj9y--
