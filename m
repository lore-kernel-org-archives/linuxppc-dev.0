Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id C0D642C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:40:35 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372876638.8183.138@snotra>
Date: Wed, 3 Jul 2013 20:40:30 +0200
Message-Id: <1B458663-02E9-443C-875C-C5136A14DE34@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
 <1372876638.8183.138@snotra>
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


On 03.07.2013, at 20:37, Scott Wood wrote:

> On 07/03/2013 07:42:36 AM, Mihai Caraman wrote:
>> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
>> returning to guest instead of each sched in. Without this improvement
>> an interrupt may also claim floting point corrupting guest state.
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>> arch/powerpc/kvm/booke.c  |    1 +
>> arch/powerpc/kvm/e500mc.c |    2 --
>> 2 files changed, 1 insertions(+), 2 deletions(-)
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 113961f..3cae2e3 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>> 			r =3D (s << 2) | RESUME_HOST | (r & =
RESUME_FLAG_NV);
>> 		} else {
>> 			kvmppc_lazy_ee_enable();
>> +			kvmppc_load_guest_fp(vcpu);
>> 		}
>> 	}
>> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
>> index 19c8379..09da1ac 100644
>> --- a/arch/powerpc/kvm/e500mc.c
>> +++ b/arch/powerpc/kvm/e500mc.c
>> @@ -143,8 +143,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, =
int cpu)
>> 		kvmppc_e500_tlbil_all(vcpu_e500);
>> 		__get_cpu_var(last_vcpu_on_cpu) =3D vcpu;
>> 	}
>> -
>> -	kvmppc_load_guest_fp(vcpu);
>> }
>> void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
>=20
> Can we now remove vcpu->fpu_active, and the comment that says "Kernel =
usage of FP (via
> enable_kernel_fp()) in this thread must not occur while =
vcpu->fpu_active is set."?

I think so, yes.


Alex
