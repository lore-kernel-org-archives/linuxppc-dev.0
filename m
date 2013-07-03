Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E2E82C007B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:31:26 +1000 (EST)
Date: Wed, 3 Jul 2013 13:31:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec support
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3592@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B02008@freescale.com on Wed Jul  3 07:11:52 2013)
Message-ID: <1372876276.8183.136@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

On 07/03/2013 07:11:52 AM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, June 05, 2013 1:40 AM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> > Subject: Re: [RFC PATCH 5/6] KVM: PPC: Book3E: Add ONE_REG AltiVec
> > support
> >
> > On 06/03/2013 03:54:27 PM, Mihai Caraman wrote:
> > > Add ONE_REG support for AltiVec on Book3E.
> > >
> > > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > > ---
> > >  arch/powerpc/kvm/booke.c |   32 ++++++++++++++++++++++++++++++++
> > >  1 files changed, 32 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > > index 01eb635..019496d 100644
> > > --- a/arch/powerpc/kvm/booke.c
> > > +++ b/arch/powerpc/kvm/booke.c
> > > @@ -1570,6 +1570,22 @@ int kvm_vcpu_ioctl_get_one_reg(struct =20
> kvm_vcpu
> > > *vcpu, struct kvm_one_reg *reg)
> > >  	case KVM_REG_PPC_DEBUG_INST:
> > >  		val =3D get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
> > >  		break;
> > > +#ifdef CONFIG_ALTIVEC
> > > +	case KVM_REG_PPC_VR0 ... KVM_REG_PPC_VR31:
> > > +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > > +			r =3D -ENXIO;
> > > +			break;
> > > +		}
> > > +		val.vval =3D vcpu->arch.vr[reg->id - KVM_REG_PPC_VR0];
> > > +		break;
> > > +	case KVM_REG_PPC_VSCR:
> > > +		if (!cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > > +			r =3D -ENXIO;
> > > +			break;
> > > +		}
> > > +		val =3D get_reg_val(reg->id, vcpu->arch.vscr.u[3]);
> > > +		break;
> >
> > Why u[3]?
>=20
> AltiVec PEM manual says: "The VSCR has two defined bits, the AltiVec =20
> non-Java
> mode (NJ) bit (VSCR[15]) and the AltiVec saturation (SAT) bit =20
> (VSCR[31]);
> the remaining bits are reserved."
>=20
> I think this is the reason Paul M. exposed KVM_REG_PPC_VSCR width as =20
> 32-bit.

Ugh.  It's documented as a 32-bit register in the ISA, but it can only =20
be accessed via a vector register (seems like an odd design choice, but =20
whatever).  And the kernel chose to represent it as a 128-bit vector, =20
while KVM chose to represent it as the register (not the access =20
thereto) is architected.  It would have been nice to be consistent...  =20
At least put in a comment explaining this.

-Scott=
