Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 376D6100824
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 21:19:28 +1100 (EST)
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
In-Reply-To: <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <F0023B33-6AF3-4805-B50E-2ED285F8B1B0@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v4 2/3] KVM: PPC: epapr: Add idle hcall support for host
Date: Thu, 16 Feb 2012 11:20:05 +0100
To: Liu Yu <yu.liu@freescale.com>
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 Liu Yu <yu.liu@freescale.com>, "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 "<B07421@freescale.com>" <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:

> And add a new flag definition in kvm_ppc_pvinfo to indicate
> whether host support EV_IDLE hcall.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> v4:
> no change
>=20
> arch/powerpc/include/asm/kvm_para.h |   14 ++++++++++++--
> arch/powerpc/kvm/powerpc.c          |    8 ++++++++
> include/linux/kvm.h                 |    2 ++
> 3 files changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_para.h b/arch/powerpc/include/as=
m/kvm_para.h
> index 7b754e7..81a34c9 100644
> --- a/arch/powerpc/include/asm/kvm_para.h
> +++ b/arch/powerpc/include/asm/kvm_para.h
> @@ -75,9 +75,19 @@ struct kvm_vcpu_arch_shared {
> };
>=20
> #define KVM_SC_MAGIC_R0        0x4b564d21 /* "KVM!" */
> -#define HC_VENDOR_KVM        (42 << 16)
> +
> +#include <asm/epapr_hcalls.h>
> +
> +/* ePAPR Hypercall Vendor ID */
> +#define HC_VENDOR_EPAPR        (EV_EPAPR_VENDOR_ID << 16)
> +#define HC_VENDOR_KVM        (EV_KVM_VENDOR_ID << 16)
> +
> +/* ePAPR Hypercall Token */
> +#define HC_EV_IDLE        EV_IDLE
> +
> +/* ePAPR Hypercall Return Codes */
> #define HC_EV_SUCCESS        0
> -#define HC_EV_UNIMPLEMENTED    12
> +#define HC_EV_UNIMPLEMENTED    EV_UNIMPLEMENTED
>=20
> #define KVM_FEATURE_MAGIC_PAGE    1
>=20
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 0e21d15..03ebd5d 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -81,6 +81,10 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
>=20
>        /* Second return value is in r4 */
>        break;
> +    case HC_VENDOR_EPAPR | HC_EV_IDLE:
> +        r =3D HC_EV_SUCCESS;
> +        kvm_vcpu_block(vcpu);
> +        break;
>    default:
>        r =3D HC_EV_UNIMPLEMENTED;
>        break;
> @@ -746,6 +750,10 @@ static int kvm_vm_ioctl_get_pvinfo(struct kvm_ppc_pvi=
nfo *pvinfo)
>    pvinfo->hcall[2] =3D inst_sc;
>    pvinfo->hcall[3] =3D inst_nop;
>=20
> +#ifdef CONFIG_BOOKE

Why limit it to booke? The less ifdefs our code has, the better :)

Alex

> +    pvinfo->flags |=3D KVM_PPC_PVINFO_FLAGS_EV_IDLE;
> +#endif
> +
>    return 0;
> }
>=20
> diff --git a/include/linux/kvm.h b/include/linux/kvm.h
> index acbe429..6b2c70e 100644
> --- a/include/linux/kvm.h
> +++ b/include/linux/kvm.h
> @@ -449,6 +449,8 @@ struct kvm_ppc_pvinfo {
>    __u8  pad[108];
> };
>=20
> +#define KVM_PPC_PVINFO_FLAGS_EV_IDLE   (1<<0)
> +
> #define KVMIO 0xAE
>=20
> /* machine type bits, to be used as argument to KVM_CREATE_VM */
> --=20
> 1.7.0.4
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
