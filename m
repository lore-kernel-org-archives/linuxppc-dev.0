Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 707A4DE331
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 15:55:22 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n064tDTP009539
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 21:55:18 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n064tB6h023032
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Jan 2009 22:55:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use inc
	file
Date: Tue, 6 Jan 2009 12:55:10 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E50421CE@zch01exm26.fsl.freescale.net>
In-Reply-To: <1231174331.27460.10.camel@localhost.localdomain>
References: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
	<0A1FE637C2C7E148B9573BB60CC630E5041F58@zch01exm26.fsl.freescale.net>
	<163A79D0-237C-4513-948A-6460AB497ACC@freescale.com>
	<1231174331.27460.10.camel@localhost.localdomain>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Hollis Blanchard" <hollisb@us.ibm.com>,
	"Gala Kumar-B11780" <kumar.gala@freescale.com>
Cc: Wood Scott-B07421 <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Piepho Trent-B16872 <tpiepho@freescale.com>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org=20
> [mailto:kvm-ppc-owner@vger.kernel.org] On Behalf Of Hollis Blanchard
> Sent: Tuesday, January 06, 2009 12:52 AM
> To: Gala Kumar-B11780
> Cc: Liu Yu-B13201; kvm-ppc@vger.kernel.org;=20
> linuxppc-dev@ozlabs.org; Piepho Trent-B16872; Wood Scott-B07421
> Subject: Re: [PATCH v2] powerpc/fsl-booke: declare=20
> tlbcam_index for use inc file
>=20
> On Mon, 2009-01-05 at 10:26 -0600, Kumar Gala wrote:
> > I'll pick this up, but wondering about this patch vs=20
> Trent's changes =20
> > to remove this.
>=20
> Please do not pick up this patch; if you ack it, let us push=20
> it through
> kvm.git. Otherwise we need to wait for it to travel from kumar.git ->
> benh.git -> linus.git -> kvm.git before KVM will build.
>=20
> If you're referring to http://patchwork.ozlabs.org/patch/12882/, that
> patch removes a different variable (num_tlbcam_entries). tlbcam_index,
> referenced below, still exists.

Since v2 has removed the num_tlbcam_entries declare, this patch has no
conflict with Trent's changes.

>=20
> > How is KVM on fsl-booke using this value?
>=20
> I'll let Yu answer that in more detail, but in
> http://git.kernel.org/?p=3Dlinux/kernel/git/avi/kvm.git;a=3Dblob_p
lain;f=3Darch/powerpc/kvm/e500_tlb.c;hb=3DHEAD it looks like he's =
storing >
guest TLB1 mappings in the real TLB1, alongside the host TLB1=20
> mappings. Accordingly, he needs to know where the host=20
> mappings are to avoid clobbering them.

Yes, just like Hollis described.
KVM only read tlbcam_index to know which entries are used by host.
And kvm assumes the value is fixed and will never change it.

>=20
> > On Jan 4, 2009, at 12:57 AM, Liu Yu wrote:
> >=20
> > > Hi Kumar,
> > >
> > > Can I get your ack?
> > > So that I can submit this patch through KVM tree.
> > >
> > >
> > >> -----Original Message-----
> > >> From: Liu Yu-B13201
> > >> Sent: Friday, December 19, 2008 10:35 AM
> > >> To: kvm-ppc@vger.kernel.org; linuxppc-dev@ozlabs.org
> > >> Cc: hollisb@us.ibm.com; Gala Kumar-B11780; Piepho
> > >> Trent-B16872; Wood Scott-B07421; Liu Yu-B13201
> > >> Subject: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index
> > >> for use in c file
> > >>
> > >> KVM on E500 platform currently utilize TLB1 entries without
> > >> bothering host,
> > >> that is using unused TLB1 entries.
> > >>
> > >> So, KVM needs to read tlbcam_index to know exactly
> > >> which TLB1 entry is unused by host.
> > >>
> > >> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> > >> ---
> > >> [v2]
> > >> Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG
> > >> in KVM instead.
> > >>
> > >> arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
> > >> 1 files changed, 2 insertions(+), 0 deletions(-)
> > >>
> > >> diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h
> > >> b/arch/powerpc/include/asm/mmu-fsl-booke.h
> > >> index 925d93c..c86af6c 100644
> > >> --- a/arch/powerpc/include/asm/mmu-fsl-booke.h
> > >> +++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
> > >> @@ -73,6 +73,8 @@
> > >>
> > >> #ifndef __ASSEMBLY__
> > >>
> > >> +extern unsigned int tlbcam_index;
> > >> +
> > >> typedef struct {
> > >> 	unsigned long id;
> > >> 	unsigned long vdso_base;
> > >> --=20
> > >> 1.5.4
> > >>
> > >>
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe=20
> kvm-ppc" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >=20
> --=20
> Hollis Blanchard
> IBM Linux Technology Center
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
