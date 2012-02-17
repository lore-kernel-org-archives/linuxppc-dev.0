Return-Path: <B13201@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2876FB6FB9
 for <linuxppc-dev@ozlabs.org>; Fri, 17 Feb 2012 13:14:26 +1100 (EST)
From: Liu Yu-B13201 <B13201@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH v4 2/3] KVM: PPC: epapr: Add idle hcall support for host
Date: Fri, 17 Feb 2012 02:13:43 +0000
Message-ID: <4CA99838F21AB847ACC344051E2317090571EB39@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1329384365-4028-1-git-send-email-yu.liu@freescale.com>
 <1329384365-4028-2-git-send-email-yu.liu@freescale.com>
 <F0023B33-6AF3-4805-B50E-2ED285F8B1B0@suse.de>
In-Reply-To: <F0023B33-6AF3-4805-B50E-2ED285F8B1B0@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "<linuxppc-dev@ozlabs.org>" <linuxppc-dev@ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Thursday, February 16, 2012 6:20 PM
> To: Liu Yu-B13201
> Cc: <kvm-ppc@vger.kernel.org>; <kvm@vger.kernel.org>; <linuxppc-
> dev@ozlabs.org>; Wood Scott-B07421; Liu Yu-B13201
> Subject: Re: [PATCH v4 2/3] KVM: PPC: epapr: Add idle hcall support for
> host
>=20
>=20
>=20
> On 16.02.2012, at 10:26, Liu Yu <yu.liu@freescale.com> wrote:
>=20
> > And add a new flag definition in kvm_ppc_pvinfo to indicate whether
> > host support EV_IDLE hcall.
> >
> > Signed-off-by: Liu Yu <yu.liu@freescale.com>
> > ---
> > v4:
> > no change
> >
> > arch/powerpc/include/asm/kvm_para.h |   14 ++++++++++++--
> > arch/powerpc/kvm/powerpc.c          |    8 ++++++++
> > include/linux/kvm.h                 |    2 ++
> > 3 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/kvm_para.h
> > b/arch/powerpc/include/asm/kvm_para.h
> > index 7b754e7..81a34c9 100644
> > --- a/arch/powerpc/include/asm/kvm_para.h
> > +++ b/arch/powerpc/include/asm/kvm_para.h
> > @@ -75,9 +75,19 @@ struct kvm_vcpu_arch_shared { };
> >
> > #define KVM_SC_MAGIC_R0        0x4b564d21 /* "KVM!" */
> > -#define HC_VENDOR_KVM        (42 << 16)
> > +
> > +#include <asm/epapr_hcalls.h>
> > +
> > +/* ePAPR Hypercall Vendor ID */
> > +#define HC_VENDOR_EPAPR        (EV_EPAPR_VENDOR_ID << 16)
> > +#define HC_VENDOR_KVM        (EV_KVM_VENDOR_ID << 16)
> > +
> > +/* ePAPR Hypercall Token */
> > +#define HC_EV_IDLE        EV_IDLE
> > +
> > +/* ePAPR Hypercall Return Codes */
> > #define HC_EV_SUCCESS        0
> > -#define HC_EV_UNIMPLEMENTED    12
> > +#define HC_EV_UNIMPLEMENTED    EV_UNIMPLEMENTED
> >
> > #define KVM_FEATURE_MAGIC_PAGE    1
> >
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index 0e21d15..03ebd5d 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -81,6 +81,10 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
> >
> >        /* Second return value is in r4 */
> >        break;
> > +    case HC_VENDOR_EPAPR | HC_EV_IDLE:
> > +        r =3D HC_EV_SUCCESS;
> > +        kvm_vcpu_block(vcpu);
> > +        break;
> >    default:
> >        r =3D HC_EV_UNIMPLEMENTED;
> >        break;
> > @@ -746,6 +750,10 @@ static int kvm_vm_ioctl_get_pvinfo(struct
> kvm_ppc_pvinfo *pvinfo)
> >    pvinfo->hcall[2] =3D inst_sc;
> >    pvinfo->hcall[3] =3D inst_nop;
> >
> > +#ifdef CONFIG_BOOKE
> > +    pvinfo->flags |=3D KVM_PPC_PVINFO_FLAGS_EV_IDLE; #endif
> > +
> >    return 0;
> > }>=20
>
> Why limit it to booke? The less ifdefs our code has, the better :)

The code here tells userspace that kvm support ev_idle.
But I'm not sure if the ev_idle code works for other platforms.

So I think we should keep the ifdef until other platform test the code :)

Thanks,
Yu
