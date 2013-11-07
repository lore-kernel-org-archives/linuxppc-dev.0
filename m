Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 1C7B82C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 20:54:30 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH v2 1/2] powerpc/kvm: fix rare but potential deadlock scene
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Thu, 7 Nov 2013 10:54:23 +0100
Message-Id: <7536FFB1-D186-42AC-9DF5-A46A72CB8F1D@suse.de>
References: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.11.2013, at 07:22, Liu Ping Fan <kernelfans@gmail.com> wrote:

> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
> realmode, so it can trigger the deadlock.
>=20
> Suppose the following scene:
>=20
> Two physical cpuM, cpuN, two VM instances A, B, each VM has a group of =
vcpus.
>=20
> If on cpuM, vcpu_A_1 holds bitlock X (HPTE_V_HVLOCK), then is switched =
out,
> and on cpuN, vcpu_A_2 try to lock X in realmode, then cpuN will be =
caught in
> realmode for a long time.
>=20
> What makes things even worse if the following happens,
>  On cpuM, bitlockX is hold, on cpuN, Y is hold.
>  vcpu_B_2 try to lock Y on cpuM in realmode
>  vcpu_A_2 try to lock X on cpuN in realmode
>=20
> Oops! deadlock happens
>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Very nice catch :).

I think it makes a lot of sense to document the fact that =
kvmppc_hv_find_lock_hpte() should be called with preemption disabled in =
a comment above the function, so that next time when someone potentially =
calls it, he knows that he needs to put preempt_disable() around it.

Thanks a lot for finding this pretty subtle issue. May I ask how you got =
there? Did you actually see systems deadlock because of this?


Alex

> ---
> arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 043eec8..dbc1478 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -474,10 +474,13 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct =
kvm_vcpu *vcpu, gva_t eaddr,
> 	}
>=20
> 	/* Find the HPTE in the hash table */
> +	preempt_disable();
> 	index =3D kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
> 					 HPTE_V_VALID | HPTE_V_ABSENT);
> -	if (index < 0)
> +	if (index < 0) {
> +		preempt_enable();
> 		return -ENOENT;
> +	}
> 	hptep =3D (unsigned long *)(kvm->arch.hpt_virt + (index << 4));
> 	v =3D hptep[0] & ~HPTE_V_HVLOCK;
> 	gr =3D kvm->arch.revmap[index].guest_rpte;
> @@ -485,6 +488,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct =
kvm_vcpu *vcpu, gva_t eaddr,
> 	/* Unlock the HPTE */
> 	asm volatile("lwsync" : : : "memory");
> 	hptep[0] =3D v;
> +	preempt_enable();
>=20
> 	gpte->eaddr =3D eaddr;
> 	gpte->vpage =3D ((v & HPTE_V_AVPN) << 4) | ((eaddr >> 12) & =
0xfff);
> --=20
> 1.8.1.4
>=20
