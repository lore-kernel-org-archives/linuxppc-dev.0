Return-Path: <B16395@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A17542C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 15:29:32 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: pci overmapping
Date: Fri, 3 May 2013 05:29:23 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D4D54AA@039-SN2MPN1-011.039d.mgd.msft.net>
References: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
 <1367514839.24411.12@snotra>
 <C5ECD7A89D1DC44195F34B25E172658D4D3E5A@039-SN2MPN1-011.039d.mgd.msft.net>
 <1367518770.24411.13@snotra>
In-Reply-To: <1367518770.24411.13@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Yoder Stuart-B08248 <B08248@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> Sent: Thursday, May 02, 2013 11:50 PM
> To: Sethi Varun-B16395
> Cc: Wood Scott-B07421; Yoder Stuart-B08248; galak@kernel.crashing.org;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: pci overmapping
>=20
> On 05/02/2013 01:09:53 PM, Sethi Varun-B16395 wrote:
> >
> >
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Thursday, May 02, 2013 10:44 PM
> > > To: Yoder Stuart-B08248
> > > Cc: galak@kernel.crashing.org; Sethi Varun-B16395; linuxppc-
> > > dev@lists.ozlabs.org
> > > Subject: Re: pci overmapping
> > >
> > > On 05/02/2013 12:05:42 PM, Yoder Stuart-B08248 wrote:
> > > > Kumar,
> > > >
> > > > In fsl_pci.c there is a change you made a while back:
> > > >   "powerpc/fsl: Setup PCI inbound window based on actual amount of
> > > > memory"
> > > >
> > > > ...and there is this comment in the code:
> > > >
> > > >     /* PCIe can overmap inbound & outbound since RX & TX are
> > separated
> > > > */
> > > >     if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> > > >
> > > > You are implying that PCIe can overmap and PCI can't.  Why is
> > > > that?   (I'm assuming that 'overmap' means that inbound window
> > > > can extend beyond the end of ram.)
> > >
> > > Shouldn't the concern be whether we're overlapping outbound, not
> > merely
> > > whether we go beyond the end of RAM?
> > >
> > > And couldn't inbound/outbound overlap be an issue even on PCIe, if
> > > there's a PCI bridge underneath it?
> > I believe that the overlap problem would be avoided in case of 36 bit
> > physical support (outbound window address would be high order 36 bit
> > value), right?
>=20
> Not necessarily -- it depends on what the bus addresses are, not the host
> addresses.
The fsl_pci code already checks for the overlap condition. The inbound wind=
ow range is set to the minimum of memory end address or the start of pci ou=
tbound address. In our case, the guest memory end address (host physical ad=
dress derived from the huge tlb page) is less than the pci outbound start a=
ddress. But, it could be the other way round as well. In both cases if the =
inbound memory can't map the end of RAM address (for the guest), the fsl_pc=
i driver would enable swiotlb.

For the first case where end of memory is < start of pci outbound address, =
we can avoid enabling swiotlb (when end address is not a power of two) by o=
ver committing the inbound address window.

-Varun
