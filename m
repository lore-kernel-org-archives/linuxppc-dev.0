Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7FABB2C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 03:49:12 +1100 (EST)
Date: Thu, 31 Jan 2013 10:48:24 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
 initialization earlier
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF2F7861@039-SN2MPN1-012.039d.mgd.msft.net>
 (from B02008@freescale.com on Thu Jan 31 09:26:20 2013)
Message-ID: <1359650904.31540.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alexander Graf <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2013 09:26:20 AM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Alexander Graf [mailto:agraf@suse.de]
> > Sent: Thursday, January 31, 2013 4:58 PM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG register
> > initialization earlier
> >
> >
> > On 31.01.2013, at 15:56, Caraman Mihai Claudiu-B02008 wrote:
> >
> > >> -----Original Message-----
> > >> From: Alexander Graf [mailto:agraf@suse.de]
> > >> Sent: Thursday, January 31, 2013 3:21 PM
> > >> To: Caraman Mihai Claudiu-B02008
> > >> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > >> dev@lists.ozlabs.org
> > >> Subject: Re: [PATCH 1/5] KVM: PPC: e500: Move VCPU's MMUCFG =20
> register
> > >> initialization earlier
> > >>
> > >>
> > >> On 30.01.2013, at 14:29, Mihai Caraman wrote:
> > >>
> > >>> VCPU's MMUCFG register initialization should not depend on
> > >> KVM_CAP_SW_TLB
> > >>> ioctl call. Move it earlier into tlb initalization phase.
> > >>
> > >> Quite the contrary. The fact that there is an mfspr() in =20
> e500_mmu.c
> > >> already tells us that the code is broken. The TLB guest code =20
> should
> > only
> > >> depend on input from the SW_TLB configuration. It's completely
> > orthogonal
> > >> to the host capabilities.
> > >
> > > Then we have the same issue for TLBnCFG registers which need to be
> > configured
> > > via SW_TLB ioctl. What is the purpose of guest tlb initalization =20
> in
> > e500_mmu.c
> > > if we rely on SW_TLB?
> >
> > It's to provide a fallback to user space that doesn't implement =20
> SW_TLB
> > configuration yet.
>=20
> Do we have such a case now or is it just hypothetical? For the =20
> fallback we
> need to initialize the MMUCFG register which I intended to say in the =20
> commit
> message.

I don't think we need to support a fallback for e6500, since there's =20
nothing to be backwards compatible with.

As for use case, I don't see us ever supporting the guest being a =20
different CPU than the host.  Page sizes probably aren't a problem, but =20
there are other barriers.

The main reasons that TLBnCFG are settable through SW_TLB are:
1. The guest TLB can be enlarged as a performance hack (like in Topaz, =20
though QEMU doesn't currently do this),
2. The legacy default in KVM is based on the e500v1 TLB0 size, which is =20
half of what e500v2/e500mc have, and
3. QEMU needs to know the exact geometry of the TLB so that it can =20
interpret the shared data properly.

#3 seems like a compelling reason here, to avoid silent weirdness if =20
there's a slight mismatch between what QEMU thinks it's modelling and =20
what we're actually running on.

-Scott=
