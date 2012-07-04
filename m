Return-Path: <B02008@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FCF42C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 00:14:13 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [RFC PATCH 02/17] KVM: PPC64: booke: Add EPCR support in
 mtspr/mfspr emulation
Date: Wed, 4 Jul 2012 14:14:03 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15A48E@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-3-git-send-email-mihai.caraman@freescale.com>
 <868ABA98-C55B-435B-BC09-01DC4067A3BE@suse.de>
In-Reply-To: <868ABA98-C55B-435B-BC09-01DC4067A3BE@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Wednesday, July 04, 2012 4:22 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [RFC PATCH 02/17] KVM: PPC64: booke: Add EPCR support in
> mtspr/mfspr emulation
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
> > Add EPCR support in booke mtspr/mfspr emulation. EPCR register is
> defined
> > only for 64-bit and HV categories, so it shoud be available only on 64-
> bit
> > virtual processors. Undefine the support for 32-bit builds.
> > Define a reusable setter function for vcpu's EPCR.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/kvm/booke.c         |   12 +++++++++++-
> > arch/powerpc/kvm/booke.h         |    6 ++++++
> > arch/powerpc/kvm/booke_emulate.c |   13 ++++++++++++-
> > 3 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 72f13f4..f9fa260 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -13,7 +13,7 @@
> >  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
> USA.
> >  *
> >  * Copyright IBM Corp. 2007
> > - * Copyright 2010-2011 Freescale Semiconductor, Inc.
> > + * Copyright 2010-2012 Freescale Semiconductor, Inc.
> >  *
> >  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> >  *          Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> > @@ -1243,6 +1243,16 @@ void kvmppc_core_commit_memory_region(struct kvm
> *kvm,
> > {
> > }
> >
> > +#ifdef CONFIG_64BIT
> > +void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
> > +{
> > +	vcpu->arch.epcr =3D new_epcr;
> > +	vcpu->arch.shadow_epcr &=3D ~SPRN_EPCR_GICM;
> > +	if (vcpu->arch.epcr  & SPRN_EPCR_ICM)
> > +		vcpu->arch.shadow_epcr |=3D SPRN_EPCR_GICM;
>=20
> Why would the setter be #ifdef CONFIG_64BIT? EPCR exists on e500mc too,
> no? Please only #ifdef the GICM bits out.

kvmppc_set_epcr deals with guest EPCR and EPCR does not exist on a virtual =
e500mc
as detailed in patch's comment. All callers are also guarded by #ifdef CONF=
IG_64BIT,
my assumption was that we will not support a virtual core with 64-bit categ=
ory
on a 32-bit host.

>=20
>=20
> Alex
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
