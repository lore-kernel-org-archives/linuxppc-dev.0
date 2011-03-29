Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8390BB6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 20:31:44 +1100 (EST)
Subject: Re: [PATCH 2/4] KVM: PPC: booke: Wrap __kvmppc_vcpu_run()
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110328192556.GA11104@schlenkerla.am.freescale.net>
Date: Tue, 29 Mar 2011 11:31:38 +0200
Message-Id: <3A85D702-7EA1-48A2-B285-D4507CC48DBC@suse.de>
References: <20110328192556.GA11104@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.03.2011, at 21:25, Scott Wood wrote:

> From: yu liu <yu.liu@freescale.com>
>=20
> We need to save/restore SPE environment on e500 core.
> Wrap __kvmppc_vcpu_run() so that we can put the SPE code in
> e500.c.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_ppc.h  |    1 +
> arch/powerpc/kvm/44x.c              |    5 +++++
> arch/powerpc/kvm/book3s.c           |    1 -
> arch/powerpc/kvm/booke_interrupts.S |    2 +-
> arch/powerpc/kvm/e500.c             |    5 +++++
> 5 files changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h =
b/arch/powerpc/include/asm/kvm_ppc.h
> index ecb3bc7..4e7a1be 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -42,6 +42,7 @@ enum emulation_result {
> 	EMULATE_AGAIN,        /* something went wrong. go again */
> };
>=20
> +extern int __kvmppc_vcpu_entry(struct kvm_run *kvm_run, struct =
kvm_vcpu *vcpu);
> extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu =
*vcpu);
> extern char kvmppc_handlers_start[];
> extern unsigned long kvmppc_handler_len;
> diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
> index 74d0e74..3d2e7d2 100644
> --- a/arch/powerpc/kvm/44x.c
> +++ b/arch/powerpc/kvm/44x.c
> @@ -147,6 +147,11 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
> 	kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
> }
>=20
> +int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> +{
> +	return __kvmppc_vcpu_entry(kvm_run, vcpu);

440 calls _entry on _run

> +}
> +
> static int __init kvmppc_44x_init(void)
> {
> 	int r;
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index c961de4..fb12853 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -1379,7 +1379,6 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu =
*vcpu)
> 	vfree(vcpu_book3s);
> }
>=20
> -extern int __kvmppc_vcpu_entry(struct kvm_run *kvm_run, struct =
kvm_vcpu *vcpu);

BookS loses its _entry reference?

> int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> {
> 	int ret;
> diff --git a/arch/powerpc/kvm/booke_interrupts.S =
b/arch/powerpc/kvm/booke_interrupts.S
> index 1cc471f..ab29f5f 100644
> --- a/arch/powerpc/kvm/booke_interrupts.S
> +++ b/arch/powerpc/kvm/booke_interrupts.S
> @@ -293,7 +293,7 @@ heavyweight_exit:
>  *  r3: kvm_run pointer
>  *  r4: vcpu pointer
>  */
> -_GLOBAL(__kvmppc_vcpu_run)
> +_GLOBAL(__kvmppc_vcpu_entry)

BookE calls _run _entry now

> 	stwu	r1, -HOST_STACK_SIZE(r1)
> 	stw	r1, VCPU_HOST_STACK(r4)	/* Save stack pointer to vcpu. =
*/
>=20
> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
> index e3768ee..e762634 100644
> --- a/arch/powerpc/kvm/e500.c
> +++ b/arch/powerpc/kvm/e500.c
> @@ -70,6 +70,11 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
> 	return 0;
> }
>=20
> +int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> +{
> +	return __kvmppc_vcpu_entry(kvm_run, vcpu);
> +}

e500 calls _entry on _run


So you're basically adding a C wrapper around _entry. That's fine for =
me, but what is the BookS change about?


Alex
