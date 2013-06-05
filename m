Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C71B2C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 19:14:54 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
Date: Wed, 5 Jun 2013 09:14:21 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF44F178@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-7-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:28 2013)
 <1370386432.748.22@snotra>
In-Reply-To: <1370386432.748.22@snotra>
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
> From: Wood Scott-B07421
> Sent: Wednesday, June 05, 2013 1:54 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
>=20
> On 06/03/2013 03:54:28 PM, Mihai Caraman wrote:
> > Adopt AltiVec approach to increase laziness by calling
> > kvmppc_load_guest_fp()
> > just before returning to guest instaed of each sched in.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>=20
> If you did this *before* adding Altivec it would have saved a question
> in an earlier patch. :-)

I kept asking myself about the order and in the end I decided that this is
an improvement originated from AltiVec work. FPU may be further cleaned up
(get rid of active state, etc).=20

>=20
> > ---
> >  arch/powerpc/kvm/booke.c  |    1 +
> >  arch/powerpc/kvm/e500mc.c |    2 --
> >  2 files changed, 1 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 019496d..5382238 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1258,6 +1258,7 @@ int kvmppc_handle_exit(struct kvm_run *run,
> > struct kvm_vcpu *vcpu,
> >  		} else {
> >  			kvmppc_lazy_ee_enable();
> >  			kvmppc_load_guest_altivec(vcpu);
> > +			kvmppc_load_guest_fp(vcpu);
> >  		}
> >  	}
> >
>=20
> You should probably do these before kvmppc_lazy_ee_enable().

Why? I wanted to look like part of lightweight_exit.

>=20
> Actually, I don't think this is a good idea at all.  As I understand
> it, you're not supposed to take kernel ownersship of floating point in
> non-atomic context, because an interrupt could itself call
> enable_kernel_fp().

So lightweight_exit isn't executed in atomic context?

Will be lazyee fixes including  kvmppc_fix_ee_before_entry() in 3.10?
64-bit Book3E KVM is unreliable without them. Should we disable e5500 too
for 3.10?
=20
> Do you have benchmarks showing it's even worthwhile?

No yet but isn't this the whole idea of FPU/AltiVec laziness that the kerne=
l
is struggling to achieve? Without it when returning to host (if another pro=
cess
got unit ownership in handle_exit) we restore and save the unit state for n=
othing.
This multiplies when the ownership goes back and forth between handle_exit =
and other
processes.

Do you have in mid a specific AltiVec benchmark? I have a stress applicatio=
n that do
consecutive vector assignments which proved to be very good at finding stat=
e
corruptions. If I combine this application on the host with a guest that st=
ays longer
on handle_exit (running a tlb or emulation intensive application) I might h=
ave good
data to support my case.

-Mike



>=20
> -Scott
