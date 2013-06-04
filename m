Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 70ADE2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 08:54:03 +1000 (EST)
Date: Tue, 4 Jun 2013 17:53:52 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 6/6] KVM: PPC: Book3E: Enhance FPU laziness
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1370292868-2697-7-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:28 2013)
Message-ID: <1370386432.748.22@snotra>
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

On 06/03/2013 03:54:28 PM, Mihai Caraman wrote:
> Adopt AltiVec approach to increase laziness by calling =20
> kvmppc_load_guest_fp()
> just before returning to guest instaed of each sched in.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

If you did this *before* adding Altivec it would have saved a question =20
in an earlier patch. :-)

> ---
>  arch/powerpc/kvm/booke.c  |    1 +
>  arch/powerpc/kvm/e500mc.c |    2 --
>  2 files changed, 1 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 019496d..5382238 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1258,6 +1258,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =20
> struct kvm_vcpu *vcpu,
>  		} else {
>  			kvmppc_lazy_ee_enable();
>  			kvmppc_load_guest_altivec(vcpu);
> +			kvmppc_load_guest_fp(vcpu);
>  		}
>  	}
>=20

You should probably do these before kvmppc_lazy_ee_enable().

Actually, I don't think this is a good idea at all.  As I understand =20
it, you're not supposed to take kernel ownersship of floating point in =20
non-atomic context, because an interrupt could itself call =20
enable_kernel_fp().

Do you have benchmarks showing it's even worthwhile?

-Scott=
