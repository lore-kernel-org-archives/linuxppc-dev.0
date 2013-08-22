Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 2D1BD2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 02:48:04 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Copy the pvr value after memset
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1377171519-25900-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 17:47:55 +0100
Message-Id: <1D289C1C-5A04-4E44-9CBE-774059EF6442@suse.de>
References: <1377171519-25900-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 22.08.2013, at 12:38, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> Otherwise we would clear the pvr value
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Thanks, applied to kvm-ppc-queue. Next time please do whitespace changes =
in a separate patch.


Alex

> ---
> arch/powerpc/kvm/book3s_hv.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index 2efa9dd..dd1b72c 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -680,13 +680,12 @@ static int kvmppc_handle_exit(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> }
>=20
> int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
> -                                  struct kvm_sregs *sregs)
> +				  struct kvm_sregs *sregs)
> {
> 	int i;
>=20
> -	sregs->pvr =3D vcpu->arch.pvr;
> -
> 	memset(sregs, 0, sizeof(struct kvm_sregs));
> +	sregs->pvr =3D vcpu->arch.pvr;
> 	for (i =3D 0; i < vcpu->arch.slb_max; i++) {
> 		sregs->u.s.ppc64.slb[i].slbe =3D =
vcpu->arch.slb[i].orige;
> 		sregs->u.s.ppc64.slb[i].slbv =3D =
vcpu->arch.slb[i].origv;
> @@ -696,7 +695,7 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu =
*vcpu,
> }
>=20
> int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
> -                                  struct kvm_sregs *sregs)
> +				  struct kvm_sregs *sregs)
> {
> 	int i, j;
>=20
> --=20
> 1.8.1.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
