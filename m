Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id DC7272C007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 23:45:15 +1000 (EST)
Subject: Re: [PATCH 3/6] KVM: PPC: Book3E: Increase FPU laziness
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 3 Jul 2013 15:45:11 +0200
Message-Id: <4A7356DD-BD24-49B3-AB17-B3237F71CF88@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-4-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.2013, at 14:42, Mihai Caraman wrote:

> Increase FPU laziness by calling kvmppc_load_guest_fp() just before
> returning to guest instead of each sched in. Without this improvement
> an interrupt may also claim floting point corrupting guest state.

Not sure I follow. Could you please describe exactly what's happening?


Alex

>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c  |    1 +
> arch/powerpc/kvm/e500mc.c |    2 --
> 2 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 113961f..3cae2e3 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1204,6 +1204,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 			r =3D (s << 2) | RESUME_HOST | (r & =
RESUME_FLAG_NV);
> 		} else {
> 			kvmppc_lazy_ee_enable();
> +			kvmppc_load_guest_fp(vcpu);
> 		}
> 	}
>=20
> diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
> index 19c8379..09da1ac 100644
> --- a/arch/powerpc/kvm/e500mc.c
> +++ b/arch/powerpc/kvm/e500mc.c
> @@ -143,8 +143,6 @@ void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, =
int cpu)
> 		kvmppc_e500_tlbil_all(vcpu_e500);
> 		__get_cpu_var(last_vcpu_on_cpu) =3D vcpu;
> 	}
> -
> -	kvmppc_load_guest_fp(vcpu);
> }
>=20
> void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> --=20
> 1.7.3.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
