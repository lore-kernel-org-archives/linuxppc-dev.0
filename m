Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5745A2C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 00:43:47 +1000 (EST)
Subject: Re: [PATCH -V2] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1380787123-32646-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 4 Oct 2013 16:43:41 +0200
Message-Id: <85675099-BA83-4F23-BA9E-02BF8173067C@suse.de>
References: <1380787123-32646-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.10.2013, at 09:58, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
> kvm_vcpu structs from kvm_vcpu_cache").
>=20
> arch/powerpc/kvm/book3s_pr.c: In function 'kvmppc_core_vcpu_create':
> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct =
kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
>=20
> Acked-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, squashed into the offending commit in kvm-ppc-queue.


Alex

> ---
> arch/powerpc/kvm/book3s_pr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
> index 8941885..6075dbd 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1179,7 +1179,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct =
kvm *kvm, unsigned int id)
>=20
> #ifdef CONFIG_KVM_BOOK3S_32
> 	vcpu->arch.shadow_vcpu =3D
> -		kzalloc(sizeof(*vcpu_book3s->shadow_vcpu), GFP_KERNEL);
> +		kzalloc(sizeof(*vcpu->arch.shadow_vcpu), GFP_KERNEL);
> 	if (!vcpu->arch.shadow_vcpu)
> 		goto free_vcpu3s;
> #endif
> --=20
> 1.8.1.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
