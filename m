Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 368421007D3
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 00:04:37 +1100 (EST)
Subject: Re: [RFC PATCH 1/2] KVM: PPC: Book3S HV: Make virtual processor area
 registration more robust
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
Date: Mon, 16 Jan 2012 14:04:29 +0100
Message-Id: <1A57B98F-A4C7-457D-A52A-4F67D5902E32@suse.de>
References: <20111220102142.GB5626@bloggs.ozlabs.ibm.com>
 <20111220102257.GC5626@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 20.12.2011, at 11:22, Paul Mackerras wrote:

> The PAPR API allows three sorts of per-virtual-processor areas to be
> registered (VPA, SLB shadow buffer, and dispatch trace log), and
> furthermore, these can be registered and unregistered for another
> virtual CPU.  Currently we just update the vcpu fields pointing to
> these areas at the time of registration or unregistration.  If this
> is done on another vcpu, there is the possibility that the target vcpu
> is using those fields at the time and could end up using a bogus
> pointer and corrupting memory.
>=20
> This fixes the race by making the target cpu itself do the update, so
> we can be sure that the update happens at a time when the fields =
aren't
> being used.  These are updated from a set of 'next_*' fields, which
> are protected by a spinlock.  (We could have just taken the spinlock
> when using the vpa, slb_shadow or dtl fields, but that would mean
> taking the spinlock on every guest entry and exit.)
>=20
> The code in do_h_register_vpa now takes the spinlock and updates the
> 'next_*' fields.  There is also a set of '*_pending' flags to indicate
> that an update is pending.
>=20
> This also changes 'struct dtl' (which was undefined) to 'struct =
dtl_entry',
> which is what the rest of the kernel uses.
>=20
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> arch/powerpc/include/asm/kvm_host.h |   15 +++-
> arch/powerpc/kvm/book3s_hv.c        |  167 =
+++++++++++++++++++++++++----------
> 2 files changed, 131 insertions(+), 51 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index 1cb6e52..b1126c1 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -82,7 +82,7 @@ struct kvm_vcpu;
>=20
> struct lppaca;
> struct slb_shadow;
> -struct dtl;
> +struct dtl_entry;
>=20
> struct kvm_vm_stat {
> 	u32 remote_tlb_flush;
> @@ -449,9 +449,18 @@ struct kvm_vcpu_arch {
> 	u32 last_inst;
>=20
> 	struct lppaca *vpa;
> +	struct lppaca *next_vpa;
> 	struct slb_shadow *slb_shadow;
> -	struct dtl *dtl;
> -	struct dtl *dtl_end;
> +	struct slb_shadow *next_slb_shadow;
> +	struct dtl_entry *dtl;
> +	struct dtl_entry *dtl_end;
> +	struct dtl_entry *dtl_ptr;
> +	struct dtl_entry *next_dtl;
> +	struct dtl_entry *next_dtl_end;
> +	u8 vpa_pending;
> +	u8 slb_shadow_pending;
> +	u8 dtl_pending;
> +	spinlock_t vpa_update_lock;
>=20
> 	wait_queue_head_t *wqp;
> 	struct kvmppc_vcore *vcore;
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index c11d960..6f6e88d 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -140,7 +140,7 @@ static unsigned long do_h_register_vpa(struct =
kvm_vcpu *vcpu,
> {
> 	struct kvm *kvm =3D vcpu->kvm;
> 	unsigned long len, nb;
> -	void *va;
> +	void *va, *free_va, *tvpa, *dtl, *ss;
> 	struct kvm_vcpu *tvcpu;
> 	int err =3D H_PARAMETER;
>=20
> @@ -152,6 +152,8 @@ static unsigned long do_h_register_vpa(struct =
kvm_vcpu *vcpu,
> 	flags &=3D 7;
> 	if (flags =3D=3D 0 || flags =3D=3D 4)

This could probably use a new variable name. Also, what do 0 and 4 mean? =
Constant defines would be nice here.

> 		return H_PARAMETER;
> +	free_va =3D va =3D NULL;
> +	len =3D 0;
> 	if (flags < 4) {
> 		if (vpa & 0x7f)
> 			return H_PARAMETER;
> @@ -165,65 +167,122 @@ static unsigned long do_h_register_vpa(struct =
kvm_vcpu *vcpu,

[pasted from real source]
>                 va =3D kvmppc_pin_guest_page(kvm, vpa, &nb);

Here you're pinning the page, setting va to that temporarily available =
address.

[...]

> 			len =3D *(unsigned short *)(va + 4);

This is a condition on (flags <=3D 1). We bail out on flags =3D=3D 0 a =
few lines up. Just move this whole thing into the respective function =
handlers.

> 		else
> 			len =3D *(unsigned int *)(va + 4);

va + 4 isn't really descriptive. Is this a defined struct? Why not =
actually define one which you can just read data from? Or at least make =
this a define too. Reading random numbers in code is barely readable.

> +		free_va =3D va;

Now free_va is the temporarily available address.

> 		if (len > nb)
> 			goto out_unpin;
> -		switch (flags) {
> -		case 1:		/* register VPA */
> -			if (len < 640)
> -				goto out_unpin;
> -			if (tvcpu->arch.vpa)
> -				kvmppc_unpin_guest_page(kvm, =
vcpu->arch.vpa);
> -			tvcpu->arch.vpa =3D va;
> -			init_vpa(vcpu, va);
> -			break;
> -		case 2:		/* register DTL */
> -			if (len < 48)
> -				goto out_unpin;
> -			len -=3D len % 48;
> -			if (tvcpu->arch.dtl)
> -				kvmppc_unpin_guest_page(kvm, =
vcpu->arch.dtl);
> -			tvcpu->arch.dtl =3D va;
> -			tvcpu->arch.dtl_end =3D va + len;
> +	}
> +
> +	spin_lock(&tvcpu->arch.vpa_update_lock);
> +
> +	switch (flags) {
> +	case 1:		/* register VPA */

Yeah, these could also use defines :)


> +		if (len < 640)
> 			break;
> -		case 3:		/* register SLB shadow buffer */
> -			if (len < 16)
> -				goto out_unpin;
> -			if (tvcpu->arch.slb_shadow)
> -				kvmppc_unpin_guest_page(kvm, =
vcpu->arch.slb_shadow);
> -			tvcpu->arch.slb_shadow =3D va;
> +		free_va =3D tvcpu->arch.next_vpa;
> +		tvcpu->arch.next_vpa =3D va;

Now you're setting next_vpa to this temporarily available address? But =
next_vpa will be used after va is getting free'd, no? Or is that why you =
have free_va?

Wouldn't it be easier to just map it every time we actually use it and =
only shove the GPA around? We could basically save ourselves a lot of =
the logic here.


Alex
