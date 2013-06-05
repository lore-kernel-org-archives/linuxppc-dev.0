Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 11EE62C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 06:59:56 +1000 (EST)
Date: Wed, 5 Jun 2013 15:59:42 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF44F178@039-SN2MPN1-011.039d.mgd.msft.net>
 (from B02008@freescale.com on Wed Jun  5 04:14:21 2013)
Message-ID: <1370465982.26139.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2013 04:14:21 AM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, June 05, 2013 1:54 AM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> > Subject: Re: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
> >
> > On 06/03/2013 03:54:28 PM, Mihai Caraman wrote:
> > > Adopt AltiVec approach to increase laziness by calling
> > > kvmppc_load_guest_fp()
> > > just before returning to guest instaed of each sched in.
> > >
> > > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> >
> > If you did this *before* adding Altivec it would have saved a =20
> question
> > in an earlier patch. :-)
>=20
> I kept asking myself about the order and in the end I decided that =20
> this is
> an improvement originated from AltiVec work. FPU may be further =20
> cleaned up
> (get rid of active state, etc).
>=20
> >
> > > ---
> > >  arch/powerpc/kvm/booke.c  |    1 +
> > >  arch/powerpc/kvm/e500mc.c |    2 --
> > >  2 files changed, 1 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > > index 019496d..5382238 100644
> > > --- a/arch/powerpc/kvm/booke.c
> > > +++ b/arch/powerpc/kvm/booke.c
> > > @@ -1258,6 +1258,7 @@ int kvmppc_handle_exit(struct kvm_run *run,
> > > struct kvm_vcpu *vcpu,
> > >  		} else {
> > >  			kvmppc_lazy_ee_enable();
> > >  			kvmppc_load_guest_altivec(vcpu);
> > > +			kvmppc_load_guest_fp(vcpu);
> > >  		}
> > >  	}
> > >
> >
> > You should probably do these before kvmppc_lazy_ee_enable().
>=20
> Why? I wanted to look like part of lightweight_exit.

We want to minimize the portion of the code that runs with interrupts =20
disabled while telling tracers that interrupts are enabled.  We want to =20
minimize the C code run with lazy EE in an inconsistent state.

The same applies to kvm_vcpu_run()...

> > Actually, I don't think this is a good idea at all.  As I understand
> > it, you're not supposed to take kernel ownersship of floating point =20
> in
> > non-atomic context, because an interrupt could itself call
> > enable_kernel_fp().
>=20
> So lightweight_exit isn't executed in atomic context?

Ignore this, I misread what the patch was doing.  I thought you were =20
doing the opposite you did. :-P

As such, this patch appears to fix the thing I was complaining about -- =20
before, we could have taken an interrupt after kvmppc_core_vcpu_load(), =20
and that interrupt could have claimed the floating point (unlikely with =20
the kernel as is, but you never know what could happen in the future or =20
out-of-tree...).

> Will be lazyee fixes including  kvmppc_fix_ee_before_entry() in 3.10?
> 64-bit Book3E KVM is unreliable without them. Should we disable e5500 =20
> too
> for 3.10?

I hope so...  I meant to ask Gleb to take them while Alex was away, but =20
I forgot about them. :-P

Alex, are you back from vacation yet?

-Scott=
