Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4DAB2C0340
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 06:05:59 +1000 (EST)
Date: Wed, 29 May 2013 15:05:49 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <1369763138.18630.3@snotra> <51A53E20.3020205@ozlabs.ru>
 <1369784115.18630.27@snotra> <51A547F0.8090406@ozlabs.ru>
In-Reply-To: <51A547F0.8090406@ozlabs.ru> (from aik@ozlabs.ru on Tue May 28
 19:12:32 2013)
Message-ID: <1369857949.18630.42@snotra>
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

On 05/28/2013 07:12:32 PM, Alexey Kardashevskiy wrote:
> On 05/29/2013 09:35 AM, Scott Wood wrote:
> > On 05/28/2013 06:30:40 PM, Alexey Kardashevskiy wrote:
> >> >> >>> @@ -939,6 +940,9 @@ struct kvm_s390_ucas_mapping {
> >> >> >>> #define KVM_GET_DEVICE_ATTR      _IOW(KVMIO,  0xe2, struct
> >> >> >>> kvm_device_attr)
> >> >> >>> #define KVM_HAS_DEVICE_ATTR      _IOW(KVMIO,  0xe3, struct
> >> >> >>> kvm_device_attr)
> >> >> >>>
> >> >> >>> +/* ioctl for SPAPR TCE IOMMU */
> >> >> >>> +#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xe4, =20
> struct
> >> >> >>> kvm_create_spapr_tce_iommu)
> >> >> >>
> >> >> >> Shouldn't this go under the vm ioctl section?
> >> >>
> >> >>
> >> >> The KVM_CREATE_SPAPR_TCE_IOMMU ioctl (the version for emulated
> >> devices) is
> >> >> in this section so I decided to keep them together. Wrong?
> >> >
> >> > You decided to keep KVM_CREATE_SPAPR_TCE_IOMMU together with
> >> > KVM_CREATE_SPAPR_TCE_IOMMU?
> >>
> >> Yes.
> >
> > Sigh.  That's the same thing repeated.  There's only one IOCTL.  =20
> Nothing is
> > being "kept together".
>=20
> Sorry, I meant this ioctl - KVM_CREATE_SPAPR_TCE.

But you didn't put it in the same section as KVM_CREATE_SPAPR_TCE.  =20
0xe0 begins a different section.

-Scott=
