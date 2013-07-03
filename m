Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id BC3202C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:39:27 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372873477.8183.134@snotra>
Date: Wed, 3 Jul 2013 20:39:22 +0200
Message-Id: <84AE642A-5FD5-4C93-A384-39D482555B29@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <1372871922.8183.133@snotra> <BFF1818E-A595-4122-8A57-DBD3A6A0B21C@suse.de>
 <1372873477.8183.134@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 03.07.2013, at 19:44, Scott Wood wrote:

> On 07/03/2013 12:23:16 PM, Alexander Graf wrote:
>> On 03.07.2013, at 19:18, Scott Wood wrote:
>> > On 07/03/2013 07:42:36 AM, Mihai Caraman wrote:
>> >> Increase FPU laziness by calling kvmppc_load_guest_fp() just =
before
>> >> returning to guest instead of each sched in. Without this =
improvement
>> >> an interrupt may also claim floting point corrupting guest state.
>> >> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> >> ---
>> >> arch/powerpc/kvm/booke.c  |    1 +
>> >> arch/powerpc/kvm/e500mc.c |    2 --
>> >> 2 files changed, 1 insertions(+), 2 deletions(-)
>> >> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> >> index 113961f..3cae2e3 100644
>> >> --- a/arch/powerpc/kvm/booke.c
>> >> +++ b/arch/powerpc/kvm/booke.c
>> >> @@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>> >> 			r =3D (s << 2) | RESUME_HOST | (r & =
RESUME_FLAG_NV);
>> >> 		} else {
>> >> 			kvmppc_lazy_ee_enable();
>> >> +			kvmppc_load_guest_fp(vcpu);
>> >> 		}
>> >
>> > This should go before the kvmppc_lazy_ee_enable().
>> Why? What difference does that make? We're running with interrupts =
disabled here, right?
>=20
> Yes, and we want to minimize the code we run where we have interrupts =
disabled but the lazy ee state says they're enabled.  So =
kvmppc_lazy_ee_enable() should be the last thing we do before entering =
asm code.
>=20
> See http://patchwork.ozlabs.org/patch/249565/

Ah, cool. So we should add a comment saying that this should be the last =
thing before entering asm code then :). That way we make sure nobody =
else repeats the same mistake.


Alex
