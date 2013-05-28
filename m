Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7FAA72C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 02:33:09 +1000 (EST)
Date: Tue, 28 May 2013 11:32:53 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20130525024524.GA6112@boomeroo.fritz.box> (from
 david@gibson.dropbear.id.au on Fri May 24 21:45:24 2013)
Message-ID: <1369758773.18630.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/24/2013 09:45:24 PM, David Gibson wrote:
> On Wed, May 22, 2013 at 04:06:57PM -0500, Scott Wood wrote:
> > On 05/20/2013 10:06:46 PM, Alexey Kardashevskiy wrote:
> > >diff --git a/arch/powerpc/kvm/powerpc.c =20
> b/arch/powerpc/kvm/powerpc.c
> > >index 8465c2a..da6bf61 100644
> > >--- a/arch/powerpc/kvm/powerpc.c
> > >@@ -396,6 +396,7 @@ int kvm_dev_ioctl_check_extension(long ext)
> > >+++ b/arch/powerpc/kvm/powerpc.c
> > > 		break;
> > > #endif
> > > 	case KVM_CAP_SPAPR_MULTITCE:
> > >+	case KVM_CAP_SPAPR_TCE_IOMMU:
> > > 		r =3D 1;
> > > 		break;
> > > 	default:
> >
> > Don't advertise SPAPR capabilities if it's not book3s -- and
> > probably there's some additional limitation that would be
> > appropriate.
>=20
> So, in the case of MULTITCE, that's not quite right.  PR KVM can
> emulate a PAPR system on a BookE machine, and there's no reason not to
> allow TCE acceleration as well.

That might (or might not; consider things like Altivec versus SPE =20
opcode conflict, whether unimplemented SPRs trap, behavior of =20
unprivileged SPRs/instructions, etc) be true in theory, but it's not =20
currently a supported configuration.  BookE KVM does not support =20
emulating a different CPU than the host.  In the unlikely case that =20
ever changes to the point of allowing PAPR guests on a BookE host, then =20
we can revisit how to properly determine whether the capability is =20
supported, but for now the capability will never be valid in the =20
CONFIG_BOOKE case (though I'd rather see it depend on an appropriate =20
book3s symbol than depend on !BOOKE).

Or we could just leave it as is, and let it indicate whether the host =20
kernel supports the feature in general, with the user needing to =20
understand when it's applicable...  I'm a bit confused by the =20
documentation, however -- the MULTITCE capability was documented in the =20
"capabilities that can be enabled" section, but I don't see where it =20
can be enabled.

-Scott=
