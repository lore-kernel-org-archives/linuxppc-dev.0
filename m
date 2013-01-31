Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE3642C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 02:00:20 +1100 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 4/5] KVM: PPC: e500: Emulate EPTCFG register
Date: Thu, 31 Jan 2013 14:58:41 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF2F7754@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1359552584-17861-1-git-send-email-mihai.caraman@freescale.com>
 <1359552584-17861-5-git-send-email-mihai.caraman@freescale.com>
 <911274D3-9188-45A5-81B0-643F5DB21653@suse.de>
In-Reply-To: <911274D3-9188-45A5-81B0-643F5DB21653@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, January 31, 2013 3:31 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH 4/5] KVM: PPC: e500: Emulate EPTCFG register
>=20
>=20
> On 30.01.2013, at 14:29, Mihai Caraman wrote:
>=20
> > EPTCFG register defined by E.PT is accessed unconditionally by Linux
> guests
> > in the presence of MAV 2.0. Emulate EPTCFG register now.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/include/asm/kvm_host.h |    1 +
> > arch/powerpc/kvm/e500.h             |    6 ++++++
> > arch/powerpc/kvm/e500_emulate.c     |    9 +++++++++
> > arch/powerpc/kvm/e500_mmu.c         |    5 +++++
> > 4 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_host.h
> b/arch/powerpc/include/asm/kvm_host.h
> > index 88fcfe6..f480b20 100644
> > --- a/arch/powerpc/include/asm/kvm_host.h
> > +++ b/arch/powerpc/include/asm/kvm_host.h
> > @@ -503,6 +503,7 @@ struct kvm_vcpu_arch {
> > 	u32 tlbcfg[4];
> > 	u32 tlbps[4];
> > 	u32 mmucfg;
> > +	u32 eptcfg;
>=20
> This too needs to be settable through SW_TLB.
>=20
> > 	u32 epr;
> > 	struct kvmppc_booke_debug_reg dbg_reg;
> > #endif
> > diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> > index b9f76d8..983eb95 100644
> > --- a/arch/powerpc/kvm/e500.h
> > +++ b/arch/powerpc/kvm/e500.h
> > @@ -308,4 +308,10 @@ static inline unsigned int has_mmu_v2(const struct
> kvm_vcpu *vcpu)
> > 	return ((vcpu->arch.mmucfg & MMUCFG_MAVN) =3D=3D MMUCFG_MAVN_V2);
> > }
> >
> > +static inline unsigned int supports_page_tables(const struct kvm_vcpu
> *vcpu)
>=20
> bool again. Can we generalize this a bit more? How about a small
> framework that allows us to differentiate across e.XX features?=20

I thought you will ask for it :)

-Mike
