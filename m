Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 318AF1A005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:23:00 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:18:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH kernel 8/9] KVM: PPC: Add in-kernel handling for VFIO
Message-ID: <20160310051828.GU22546@voom.fritz.box>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-9-git-send-email-aik@ozlabs.ru>
 <20160308110812.GC22546@voom.fritz.box> <56DFE2F7.80300@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RGwttE/plSABi47o"
In-Reply-To: <56DFE2F7.80300@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RGwttE/plSABi47o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 07:46:47PM +1100, Alexey Kardashevskiy wrote:
> On 03/08/2016 10:08 PM, David Gibson wrote:
> >On Mon, Mar 07, 2016 at 02:41:16PM +1100, Alexey Kardashevskiy wrote:
> >>This allows the host kernel to handle H_PUT_TCE, H_PUT_TCE_INDIRECT
> >>and H_STUFF_TCE requests targeted an IOMMU TCE table used for VFIO
> >>without passing them to user space which saves time on switching
> >>to user space and back.
> >>
> >>Both real and virtual modes are supported. The kernel tries to
> >>handle a TCE request in the real mode, if fails it passes the request
> >>to the virtual mode to complete the operation. If it a virtual mode
> >>handler fails, the request is passed to user space; this is not expected
> >>to happen ever though.
> >
> >Well... not expect to happen with a qemu which uses this.  Presumably
> >it will fall back to userspace routinely if you have an old qemu that
> >doesn't add the liobn mappings.
>=20
>=20
> Ah. Ok, thanks, I'll add this to the commit log.

Ok.

> >>The first user of this is VFIO on POWER. Trampolines to the VFIO extern=
al
> >>user API functions are required for this patch.
> >
> >I'm not sure what you mean by "trampoline" here.
>=20
> For example, look at kvm_vfio_group_get_external_user. It calls
> symbol_get(vfio_group_get_external_user) and then calls a function via the
> returned pointer.
>=20
> Is there a better word for this?

Uh.. probably although I don't immediately know what.  "Trampoline"
usually refers to code on the stack used for bouncing places, which
isn't what this resembles.

> >>This uses a VFIO KVM device to associate a logical bus number (LIOBN)
> >>with an VFIO IOMMU group fd and enable in-kernel handling of map/unmap
> >>requests.
> >
> >Group fd?  Or container fd?  The group fd wouldn't make a lot of
> >sense.
>=20
>=20
> Group. KVM has no idea about containers.

That's not going to fly.  Having a liobn registered against just one
group in a container makes no sense at all.  Conceptually, if not
physically, the container shares a single set of TCE tables.  If
handling that means teaching KVM the concept of containers, then so be
it.

Btw, I'm not sure yet if extending the existing vfio kvm device to
make the vfio<->kvm linkages makes sense.  I think the reason some x86
machines need that is quite different from how we're using it for
Power.  I haven't got a clear enough picture yet to be sure either
way.

The other option that would seem likely to me would be a "bind VFIO
container" ioctl() on the fd associated with a kernel accelerated TCE table.

> >>To make use of the feature, the user space has to create a guest view
> >>of the TCE table via KVM_CAP_SPAPR_TCE/KVM_CAP_SPAPR_TCE_64 and
> >>then associate a LIOBN with this table via VFIO KVM device,
> >>a KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN property (which is added in
> >>the next patch).
> >>
> >>Tests show that this patch increases transmission speed from 220MB/s
> >>to 750..1020MB/s on 10Gb network (Chelsea CXGB3 10Gb ethernet card).
> >
> >Is that with or without DDW (i.e. with or without a 64-bit DMA window)?
>=20
>=20
> Without DDW, I should have mentioned this. The patch is from the times wh=
en
> there was no DDW :(

Ok.

> >>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>---
> >>  arch/powerpc/kvm/book3s_64_vio.c    | 184 +++++++++++++++++++++++++++=
++++++++
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c | 186 +++++++++++++++++++++++++++=
+++++++++
> >>  2 files changed, 370 insertions(+)
> >>
> >>diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s=
_64_vio.c
> >>index 7965fc7..9417d12 100644
> >>--- a/arch/powerpc/kvm/book3s_64_vio.c
> >>+++ b/arch/powerpc/kvm/book3s_64_vio.c
> >>@@ -33,6 +33,7 @@
> >>  #include <asm/kvm_ppc.h>
> >>  #include <asm/kvm_book3s.h>
> >>  #include <asm/mmu-hash64.h>
> >>+#include <asm/mmu_context.h>
> >>  #include <asm/hvcall.h>
> >>  #include <asm/synch.h>
> >>  #include <asm/ppc-opcode.h>
> >>@@ -317,11 +318,161 @@ fail:
> >>  	return ret;
> >>  }
> >>
> >>+static long kvmppc_tce_iommu_mapped_dec(struct iommu_table *tbl,
> >>+		unsigned long entry)
> >>+{
> >>+	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >>+	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> >>+	unsigned long *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> >>+
> >>+	if (!pua)
> >>+		return H_HARDWARE;
> >>+
> >>+	mem =3D mm_iommu_lookup(*pua, pgsize);
> >>+	if (!mem)
> >>+		return H_HARDWARE;
> >>+
> >>+	mm_iommu_mapped_dec(mem);
> >>+
> >>+	*pua =3D 0;
> >>+
> >>+	return H_SUCCESS;
> >>+}
> >>+
> >>+static long kvmppc_tce_iommu_unmap(struct iommu_table *tbl,
> >>+		unsigned long entry)
> >>+{
> >>+	enum dma_data_direction dir =3D DMA_NONE;
> >>+	unsigned long hpa =3D 0;
> >>+
> >>+	if (iommu_tce_xchg(tbl, entry, &hpa, &dir))
> >>+		return H_HARDWARE;
> >>+
> >>+	if (dir =3D=3D DMA_NONE)
> >>+		return H_SUCCESS;
> >>+
> >>+	return kvmppc_tce_iommu_mapped_dec(tbl, entry);
> >>+}
> >>+
> >>+long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
> >>+		unsigned long entry, unsigned long gpa,
> >>+		enum dma_data_direction dir)
> >>+{
> >>+	long ret;
> >>+	unsigned long hpa, ua, *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entr=
y);
> >>+	struct mm_iommu_table_group_mem_t *mem;
> >>+
> >>+	if (!pua)
> >>+		return H_HARDWARE;
> >
> >H_HARDWARE?  Or H_PARAMETER?  This essentially means the guest has
> >supplied a bad physical address, doesn't it?
>=20
> Well, may be. I'll change. If it not H_TOO_HARD, it does not make any
> difference after all :)
>=20
>=20
>=20
> >>+	if (kvmppc_gpa_to_ua(kvm, gpa, &ua, NULL))
> >>+		return H_HARDWARE;
> >>+
> >>+	mem =3D mm_iommu_lookup(ua, 1ULL << tbl->it_page_shift);
> >>+	if (!mem)
> >>+		return H_HARDWARE;
> >>+
> >>+	if (mm_iommu_ua_to_hpa(mem, ua, &hpa))
> >>+		return H_HARDWARE;
> >>+
> >>+	if (mm_iommu_mapped_inc(mem))
> >>+		return H_HARDWARE;
> >>+
> >>+	ret =3D iommu_tce_xchg(tbl, entry, &hpa, &dir);
> >>+	if (ret) {
> >>+		mm_iommu_mapped_dec(mem);
> >>+		return H_TOO_HARD;
> >>+	}
> >>+
> >>+	if (dir !=3D DMA_NONE)
> >>+		kvmppc_tce_iommu_mapped_dec(tbl, entry);
> >>+
> >>+	*pua =3D ua;
> >
> >IIUC this means you have a copy of the UA for every group attached to
> >the TCE table, but they'll all be the same. Any way to avoid that
> >duplication?
>=20
> It is for every container, not a group. On P8, I allow multiple groups to=
 go
> to the same container, that means that a container has one or two
> iommu_table, and each iommu_table has this "ua" list but since tables are
> different (window size, page size, content), these "ua" arrays are also
> different.

Erm.. but h_put_tce iterates h_put_tce_iommu through all the groups
attached to the stt, and each one seems to update pua.

Or is that what the if (kg->tbl =3D=3D tbltmp) continue; is supposed to
avoid?  In which case what ensures that the stt->groups list is
ordered by tbl pointer?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RGwttE/plSABi47o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4QOkAAoJEGw4ysog2bOSkUAP/1WrBpKLZnIrlGLzzayX3pTV
40XbfdL6n3xzTtJBVRjiNMOIXp7C5X8Q9/Nw5DjXUti7bhonErW4xYsXNkSET8gD
PPr//2eyJl2+A92gwzPyniJO07Cx0ULn3LoigXvXP5R3ZmD/Y9MdKZ7py6Ow/f8T
z9DsNmQdAJraXqlF81ubrnxGYiyZyKHQ+VGZ2zDEWZkeiXYoEpQQrymhb4KBMOY/
wXkuSu6nEZkasYKupGh/3nQNLnLbtlwd8l6j/6z6aCRqPoqzERtpruvc6p+i5hus
dSSnnULHGSfTh2eJOiCyWW0Od2yR0k9f0mt4hyEQ7KMxn3MuQ1QWeXziZE1lNYEA
CoQhR2bFh44RdSyGpGjbqv2K8vTAVmXk00iOMFnNCKAmqKM/ZkW+5/kYHcc97SM1
Crjc/lgKAv9LgDTls4o2RLuwEBMVuoi/vJg03Or1ZRHeppKLnfEd1oA9m22rlDyE
xVMm7beQNrL7D1yTK1BLpc01aCdHbIFqNRCSzGAyM5aDr4sTJht8foPFLrrG1z9q
QCnBVOSMJIGdyO7dCIJuToKNo8z5mU/8ZKrmNYa/R6vRxH7lgILxOKGCz7597Y6Q
5S0X5feE8ynFxVebsP1P5P24BYuTH8hnuIk/CHiBPr8Bw/JbvPg/PBQmxZ13TtzN
kkH0EpUNNq7B+JGCYjI6
=VgLt
-----END PGP SIGNATURE-----

--RGwttE/plSABi47o--
