Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 9AF382C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 23:37:37 +1100 (EST)
References: <1384178898-24673-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1384178898-24673-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <059527B7-DB8B-4A91-AE3B-3ACA834EEFA4@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: book3s: PR: Enable Little Endian PR guest
Date: Tue, 12 Nov 2013 07:37:24 -0500
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 11.11.2013 um 09:08 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.i=
bm.com>:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This patch make sure we inherit the LE bit correctly in different case
> so that we can run Little Endian distro in PR mode
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This is not how real hardware works, is it? Could you please point me to the=
 bits in the ISA that indicate that we should preserve the LE bit anywhere? :=
)

Alex

> ---
>=20
> This patch depends on the below two changes
> 1)  [PATCH v5 0/6] KVM: PPC: Book3S: MMIO support for Little Endian guests=
 (kvm-ppc)
>        http://mid.gmane.org/1383672128-26795-1-git-send-email-clg@fr.ibm.c=
om
> 2) [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
>       http://mid.gmane.org/1384178577-23721-1-git-send-email-aneesh.kumar@=
linux.vnet.ibm.com
>=20
> arch/powerpc/kvm/book3s_64_mmu.c | 2 +-
> arch/powerpc/kvm/book3s_pr.c     | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64=
_mmu.c
> index 83da1f8..d339096 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -38,7 +38,7 @@
>=20
> static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
> {
> -    kvmppc_set_msr(vcpu, MSR_SF);
> +    kvmppc_set_msr(vcpu, MSR_SF | (vcpu->arch.shared->msr & MSR_LE));
> }
>=20
> static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index a7fe87a..cf9362c 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -226,7 +226,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *=
vcpu)
>    ulong smsr =3D vcpu->arch.shared->msr;
>=20
>    /* Guest MSR values */
> -    smsr &=3D MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE;
> +    smsr &=3D MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
>    /* Process MSR values */
>    smsr |=3D MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
>    /* External providers the guest reserved */
> --=20
> 1.8.3.2
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
