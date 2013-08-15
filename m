Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id EA4F32C0227
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 17:16:29 +1000 (EST)
Subject: Re: [PATCH 03/10] KVM: PPC: reserve a capability and ioctl numbers
 for realmode VFIO
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1375332272-22176-4-git-send-email-aik@ozlabs.ru>
Date: Thu, 15 Aug 2013 09:16:19 +0200
Message-Id: <ED8250FB-B0A8-4C32-A960-20ADB5742D2B@suse.de>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
 <1375332272-22176-4-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.08.2013, at 06:44, Alexey Kardashevskiy wrote:

> This is to reserve a capablity number for upcoming support
> of VFIO-IOMMU DMA operations in real mode.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>=20
> ---
> Changes:
> 2013/07/16:
> * changed the number
>=20
> 2013/07/11:
> * changed order in a file, added comment about a gap in ioctl number
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> include/uapi/linux/kvm.h | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 99c2533..53c3f1f 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
> #define KVM_CAP_IRQ_XICS 92
> #define KVM_CAP_ARM_EL1_32BIT 93
> #define KVM_CAP_SPAPR_MULTITCE 94
> +#define KVM_CAP_SPAPR_TCE_IOMMU 95
>=20
> #ifdef KVM_CAP_IRQ_ROUTING
>=20
> @@ -933,6 +934,9 @@ struct kvm_s390_ucas_mapping {
> #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct =
kvm_arm_device_addr)
> /* Available with KVM_CAP_PPC_RTAS */
> #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct =
kvm_rtas_token_args)
> +/* 0xad and 0xaf are already taken */

so 0xad and 0xaf are already taken? where?

> +/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct =
kvm_create_spapr_tce_iommu)

and why is this one 0xaf then?


Alex

>=20
> /* ioctl for vm fd */
> #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct =
kvm_create_device)
> --=20
> 1.8.3.2
>=20
