Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 862902C032C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 03:46:08 +1000 (EST)
Date: Tue, 28 May 2013 12:45:38 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <51A2C888.4050704@ozlabs.ru> (from aik@ozlabs.ru on Sun May 26
 21:44:24 2013)
Message-ID: <1369763138.18630.3@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/26/2013 09:44:24 PM, Alexey Kardashevskiy wrote:
> On 05/25/2013 12:45 PM, David Gibson wrote:
> > On Wed, May 22, 2013 at 04:06:57PM -0500, Scott Wood wrote:
> >> On 05/20/2013 10:06:46 PM, Alexey Kardashevskiy wrote:
> >>> diff --git a/arch/powerpc/kvm/powerpc.c =20
> b/arch/powerpc/kvm/powerpc.c
> >>> index 8465c2a..da6bf61 100644
> >>> --- a/arch/powerpc/kvm/powerpc.c
> >>> @@ -396,6 +396,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> >>> +++ b/arch/powerpc/kvm/powerpc.c
> >>> 		break;
> >>> #endif
> >>> 	case KVM_CAP_SPAPR_MULTITCE:
> >>> +	case KVM_CAP_SPAPR_TCE_IOMMU:
> >>> 		r =3D 1;
> >>> 		break;
> >>> 	default:
> >>
> >> Don't advertise SPAPR capabilities if it's not book3s -- and
> >> probably there's some additional limitation that would be
> >> appropriate.
> >
> > So, in the case of MULTITCE, that's not quite right.  PR KVM can
> > emulate a PAPR system on a BookE machine, and there's no reason not =20
> to
> > allow TCE acceleration as well.  We can't make it dependent on PAPR
> > mode being selected, because that's enabled per-vcpu, whereas these
> > capabilities are queried on the VM before the vcpus are created.
> >
> > CAP_SPAPR_TCE_IOMMU should be dependent on the presence of suitable
> > host side hardware (i.e. a PAPR style IOMMU), though.
>=20
>=20
> The capability says that the ioctl is supported. If there is no IOMMU =20
> group
> registered, than it will fail with a reasonable error and nobody gets =20
> hurt.
> What is the problem?

You could say that about a lot of the capabilities that just advertise =20
the existence of new ioctls. :-)

Sometimes it's nice to know in advance whether it's supported, before =20
actually requesting that something happen.

> >>> @@ -939,6 +940,9 @@ struct kvm_s390_ucas_mapping {
> >>> #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct
> >>> kvm_device_attr)
> >>> #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct
> >>> kvm_device_attr)
> >>>
> >>> +/* ioctl for SPAPR TCE IOMMU */
> >>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xe4, struct
> >>> kvm_create_spapr_tce_iommu)
> >>
> >> Shouldn't this go under the vm ioctl section?
>=20
>=20
> The KVM_CREATE_SPAPR_TCE_IOMMU ioctl (the version for emulated =20
> devices) is
> in this section so I decided to keep them together. Wrong?

You decided to keep KVM_CREATE_SPAPR_TCE_IOMMU together with =20
KVM_CREATE_SPAPR_TCE_IOMMU?

-Scott=
