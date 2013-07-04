Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AFA9E2C016F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 16:51:03 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Date: Thu, 4 Jul 2013 06:50:56 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A4A9C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <1372876638.8183.138@snotra> <1B458663-02E9-443C-875C-C5136A14DE34@suse.de>
In-Reply-To: <1B458663-02E9-443C-875C-C5136A14DE34@suse.de>
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
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Wednesday, July 03, 2013 9:40 PM
> To: Wood Scott-B07421
> Cc: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org;
> kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
>=20
>=20
> On 03.07.2013, at 20:37, Scott Wood wrote:
>=20
> > On 07/03/2013 07:42:36 AM, Mihai Caraman wrote:
> >> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> >> returning to guest instead of each sched in. Without this improvement
> >> an interrupt may also claim floting point corrupting guest state.
> >> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> >> ---
> >> arch/powerpc/kvm/booke.c  |    1 +
> >> arch/powerpc/kvm/e500mc.c |    2 --
> >> 2 files changed, 1 insertions(+), 2 deletions(-)
> >> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> >> index 113961f..3cae2e3 100644
> >> --- a/arch/powerpc/kvm/booke.c
> >> +++ b/arch/powerpc/kvm/booke.c
> >> @@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> >> 			r =3D (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
> >> 		} else {
> >> 			kvmppc_lazy_ee_enable();
> >> +			kvmppc_load_guest_fp(vcpu);
> >> 		}
> >> 	}
> >> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> >> index 19c8379..09da1ac 100644
> >> --- a/arch/powerpc/kvm/e500mc.c
> >> +++ b/arch/powerpc/kvm/e500mc.c
> >> @@ -143,8 +143,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu,
> int cpu)
> >> 		kvmppc_e500_tlbil_all(vcpu_e500);
> >> 		__get_cpu_var(last_vcpu_on_cpu) =3D vcpu;
> >> 	}
> >> -
> >> -	kvmppc_load_guest_fp(vcpu);
> >> }
> >> void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> >
> > Can we now remove vcpu->fpu_active, and the comment that says "Kernel
> usage of FP (via
> > enable_kernel_fp()) in this thread must not occur while vcpu-
> >fpu_active is set."?
>=20
> I think so, yes.

Yes, as I already did this for AltiVec.

-Mike
