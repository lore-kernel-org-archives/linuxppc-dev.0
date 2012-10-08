Return-Path: <B02008@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 422A32C031A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2012 00:06:44 +1100 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2 EPN
 mask for 64-bit
Date: Mon, 8 Oct 2012 13:06:32 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF20D198@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-6-git-send-email-mihai.caraman@freescale.com>
 <D3F90478-D3C9-4699-ADFD-CE752D9A569F@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF15B15F@039-SN2MPN1-013.039d.mgd.msft.net>
 <0A87124F-B5D0-475C-A33C-A1F36C1B56D9@suse.de>
In-Reply-To: <0A87124F-B5D0-475C-A33C-A1F36C1B56D9@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
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

> -----Original Message-----
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Monday, October 08, 2012 1:11 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2
> EPN mask for 64-bit
>=20
>=20
> On 05.07.2012, at 13:14, Caraman Mihai Claudiu-B02008 wrote:
>=20
> >
> >
> >> -----Original Message-----
> >> From: Alexander Graf [mailto:agraf@suse.de]
> >> Sent: Wednesday, July 04, 2012 4:50 PM
> >> To: Caraman Mihai Claudiu-B02008
> >> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> >> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> >> Subject: Re: [Qemu-ppc] [RFC PATCH 05/17] KVM: PPC: booke: Extend MAS2
> >> EPN mask for 64-bit
> >>
> >>
> >> On 25.06.2012, at 14:26, Mihai Caraman wrote:
> >>
> >>> Extend MAS2 EPN mask for 64-bit hosts, to retain most significant
> bits.
> >>> Change get tlb eaddr to use this mask.
> >>
> >> Please see section 6.11.4.8 in the PowerISA 2.06b:
> >>
> >> MMU behavior is largely unaffected by whether the thread is in 32-bit
> >> computation mode (MSRCM=3D0) or 64- bit computation mode (MSRCM=3D1). =
The
> >> only differ- ences occur in the EPN field of the TLB entry and the EPN
> >> field of MAS2. The differences are summarized here.
> >>
> >> 	*  Executing a tlbwe instruction in 32-bit mode will set bits 0:31
> >> of the TLB EPN field to zero unless MAS0ATSEL is set, in which case
> those
> >> bits are not written to zero.
> >> 	*  In 32-bit implementations, MAS2U can be used to read or write
> >> EPN0:31 of MAS2.
> >>
> >> So if MSR.CM is not set tlbwe should mask the upper 32 bits out -
> which
> >> can happen regardless of CONFIG_64BIT.
> >
> > MAS2_EPN reflects EPN field of MAS2 aka bits 0:51 (for MAV =3D 1.0)
> according
> > to section 6.10.3.10 in the PowerISA 2.06b.
> >
> > MAS2_EPN is not used in tlbwe execution emulation, we have MAS2_VAL
> define
> > for this case.
>=20
> So tlbe->mas2 is guaranteed to have the upper bits be 0 when MSR.CM=3D0?

We chose to mask out mas2 upper bits on tlbwe emulation so gtlbe->mas2 will
respect this but vcpu->arch.shared->mas2 will not. tlb entry selection does=
 not
require this treatment since EPN upper bits are not taken into consideratio=
n anyway.

>=20
> >
> >> Also, we need to implement MAS2U, to potentially make the upper 32bits
> of
> >> MAS2 available, right? But that one isn't as important as the first
> bit.
> >
> > MAS2U is guest privileged why does it need special care?
>=20
> Maybe it's mapped to the upper bits of GMAS2 automatically?

GMAS2?

>=20
> > Freescale core Manuals and EREF does not mention MAS2U so I think I our
> case
> > it is not implemented.
>=20
> Please check with a simple mfspr() test on real hw to see if it really
> isn't implemented.

I will try this with SPR number 0x277.

-Mike
