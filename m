Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EAFD2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 22:12:00 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec support
Date: Wed, 3 Jul 2013 12:11:52 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3592@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370292868-2697-6-git-send-email-mihai.caraman@freescale.com>
 <1370385622.748.21@snotra>
In-Reply-To: <1370385622.748.21@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Wednesday, June 05, 2013 1:40 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [RFC PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec
> support
>=20
> On 06/03/2013 03:54:27 PM, Mihai Caraman wrote:
> > Add ONE_REG support for AltiVec on Book3E.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> >  arch/powerpc/kvm/booke.c |   32 ++++++++++++++++++++++++++++++++
> >  1 files changed, 32 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index 01eb635..019496d 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1570,6 +1570,22 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu
> > *vcpu, struct kvm_one_reg *reg)
> >  	case KVM_REG_PPC_DEBUG_INST:
> >  		val =3D get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
> >  		break;
> > +#ifdef CONFIG_ALTIVEC
> > +	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
> > +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > +			r =3D -ENXIO;
> > +			break;
> > +		}
> > +		val.vval =3D vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0];
> > +		break;
> > +	case KVM_REG_PPC_VSCR:
> > +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > +			r =3D -ENXIO;
> > +			break;
> > +		}
> > +		val =3D get_reg_val(reg->id, vcpu->arch.vscr.u[3]);
> > +		break;
>=20
> Why u[3]?

AltiVec PEM manual says: "The VSCR has two defined bits, the AltiVec non-Ja=
va
mode (NJ) bit (VSCR[15]) and the AltiVec saturation (SAT) bit (VSCR[31]);
the remaining bits are reserved."

I think this is the reason Paul M. exposed KVM_REG_PPC_VSCR width as 32-bit=
.

-Mike
