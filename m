Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 83C2CB6FA5
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2012 01:06:04 +1100 (EST)
Subject: Re: [PATCH v2 3/3] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1325754412-29963-2-git-send-email-yu.liu@freescale.com>
Date: Mon, 9 Jan 2012 15:05:59 +0100
Message-Id: <16F03517-3881-4004-BEBB-3F2FB7556AA8@suse.de>
References: <1325754412-29963-1-git-send-email-yu.liu@freescale.com>
 <1325754412-29963-2-git-send-email-yu.liu@freescale.com>
To: Liu Yu <yu.liu@freescale.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 scottwood@freescale.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.01.2012, at 10:06, Liu Yu wrote:

> If the guest hypervisor node contains "has-idle" property.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v2:
> 1. move the idle code into assembly.
> 2. move the part that check "has-idle" into epapr code.
>=20
> arch/powerpc/include/asm/epapr_hcalls.h |    1 +
> arch/powerpc/include/asm/machdep.h      |    5 +++++
> arch/powerpc/kernel/epapr_para.c        |    4 ++++
> arch/powerpc/kernel/idle_e500.S         |   17 +++++++++++++++++
> arch/powerpc/kernel/kvm.c               |   24 =
++++++++++++++++++++++++
> 5 files changed, 51 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/epapr_hcalls.h =
b/arch/powerpc/include/asm/epapr_hcalls.h
> index c4b86e4..566805e 100644
> --- a/arch/powerpc/include/asm/epapr_hcalls.h
> +++ b/arch/powerpc/include/asm/epapr_hcalls.h
> @@ -150,6 +150,7 @@
>=20
> extern u32 *epapr_hcall_insts;
> extern int epapr_hcall_insts_len;
> +extern bool epapr_hcall_has_idle;
>=20
> static inline void epapr_get_hcall_insts(u32 **instp, int *lenp)
> {
> diff --git a/arch/powerpc/include/asm/machdep.h =
b/arch/powerpc/include/asm/machdep.h
> index 47cacdd..7e56abf 100644
> --- a/arch/powerpc/include/asm/machdep.h
> +++ b/arch/powerpc/include/asm/machdep.h
> @@ -255,6 +255,11 @@ extern void power4_idle(void);
> extern void power7_idle(void);
> extern void ppc6xx_idle(void);
> extern void book3e_idle(void);
> +#ifdef CONFIG_KVM_GUEST
> +extern void e500_ev_idle(unsigned long *, unsigned long *, unsigned =
long,
> +                         unsigned long (*)(unsigned long *, unsigned =
long *,
> +                                          unsigned long));
> +#endif
>=20
> /*
>  * ppc_md contains a copy of the machine description structure for the
> diff --git a/arch/powerpc/kernel/epapr_para.c =
b/arch/powerpc/kernel/epapr_para.c
> index 714dcb3..1f37ddf 100644
> --- a/arch/powerpc/kernel/epapr_para.c
> +++ b/arch/powerpc/kernel/epapr_para.c
> @@ -22,6 +22,7 @@
>=20
> u32 *epapr_hcall_insts;
> int epapr_hcall_insts_len;
> +bool epapr_hcall_has_idle;
>=20
> static int __init epapr_para_init(void)
> {
> @@ -39,6 +40,9 @@ static int __init epapr_para_init(void)
> 		epapr_hcall_insts_len =3D len;
> 	}
>=20
> +	if (of_get_property(hyper_node, "has-idle", NULL))
> +		epapr_hcall_has_idle =3D true;
> +
> 	return 0;
> }
>=20
> diff --git a/arch/powerpc/kernel/idle_e500.S =
b/arch/powerpc/kernel/idle_e500.S
> index 3e2b95c..6ea95f0 100644
> --- a/arch/powerpc/kernel/idle_e500.S
> +++ b/arch/powerpc/kernel/idle_e500.S
> @@ -85,6 +85,23 @@ =
END_FTR_SECTION_IFSET(CPU_FTR_L2CSR|CPU_FTR_CAN_NAP)
> 2:	b	2b
> #endif /* !E500MC */
>=20
> +#ifdef CONFIG_KVM_GUEST
> +/*
> + * r3 contains the pointer to in[8]
> + * r4 contains the pointer to out[8]
> + * r5 contains the hcall vendor and nr
> + * r6 contains the handler which send hcall
> + */
> +_GLOBAL(e500_ev_idle)

How is that specific to e500? Isn't it just the generic epapr =
implementation?

> +	rlwinm	r7,r1,0,0,31-THREAD_SHIFT	/* current thread_info =
*/
> +	lwz	r8,TI_LOCAL_FLAGS(r7)	/* set napping bit */
> +	ori	r8,r8,_TLF_NAPPING	/* so when we take an exception =
*/
> +	stw	r8,TI_LOCAL_FLAGS(r7)	/* it will return to our caller =
*/
> +	wrteei	1

Except for this part of course :). But I'm sure we can generalize this.

> +	mtctr	r6
> +	bctr
> +#endif /* KVM_GUEST */
> +
> /*
>  * Return from NAP/DOZE mode, restore some CPU specific registers,
>  * r2 containing physical address of current.
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 82a9137..8952e12 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -29,6 +29,7 @@
> #include <asm/cacheflush.h>
> #include <asm/disassemble.h>
> #include <asm/epapr_hcalls.h>
> +#include <asm/machdep.h>
>=20
> #define KVM_MAGIC_PAGE		(-4096L)
> #define magic_var(x) KVM_MAGIC_PAGE + offsetof(struct =
kvm_vcpu_arch_shared, x)
> @@ -578,6 +579,25 @@ static __init void kvm_free_tmp(void)
> 	}
> }
>=20
> +static void kvm_hcall_idle(void)
> +{
> +#ifdef CONFIG_KVM_E500
> +	ulong in[8];
> +	ulong out[8];
> +
> +	e500_ev_idle(in, out, HC_VENDOR_EPAPR | HC_EV_IDLE, =
kvm_hypercall);
> +#endif

... because then the ifdef goes away here too

> +}
> +
> +static bool kvm_para_has_idle(void)
> +{
> +#ifdef CONFIG_BOOKE
> +	return epapr_hcall_has_idle;
> +#else
> +	return false;
> +#endif

... this also shouldn't be an ifdef

> +}
> +
> static int __init kvm_guest_init(void)
> {
> 	if (!kvm_para_available())
> @@ -594,6 +614,10 @@ static int __init kvm_guest_init(void)
> 	powersave_nap =3D 1;
> #endif
>=20
> +	/* Install hcall based power_save for guest kernel */
> +	if (kvm_para_has_idle())
> +		ppc_md.power_save =3D kvm_hcall_idle;

The way it's now it would break kernels with this patch if we ever =
choose to implement hcall_idle for non-e500. Please make the code =
generic :)


Alex
