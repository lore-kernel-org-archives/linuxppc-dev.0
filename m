Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8F082C009F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 03:44:48 +1000 (EST)
Date: Wed, 3 Jul 2013 12:44:37 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
To: Alexander Graf <agraf@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <1372871922.8183.133@snotra> <BFF1818E-A595-4122-8A57-DBD3A6A0B21C@suse.de>
In-Reply-To: <BFF1818E-A595-4122-8A57-DBD3A6A0B21C@suse.de> (from
 agraf@suse.de on Wed Jul  3 12:23:16 2013)
Message-ID: <1372873477.8183.134@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 12:23:16 PM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 19:18, Scott Wood wrote:
>=20
> > On 07/03/2013 07:42:36 AM, Mihai Caraman wrote:
> >> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> >> returning to guest instead of each sched in. Without this =20
> improvement
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
> >> @@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
> >> 			r =3D (s << 2) | RESUME_HOST | (r & =20
> RESUME_FLAG_NV);
> >> 		} else {
> >> 			kvmppc_lazy_ee_enable();
> >> +			kvmppc_load_guest_fp(vcpu);
> >> 		}
> >
> > This should go before the kvmppc_lazy_ee_enable().
>=20
> Why? What difference does that make? We're running with interrupts =20
> disabled here, right?

Yes, and we want to minimize the code we run where we have interrupts =20
disabled but the lazy ee state says they're enabled.  So =20
kvmppc_lazy_ee_enable() should be the last thing we do before entering =20
asm code.

See http://patchwork.ozlabs.org/patch/249565/

-Scott=
