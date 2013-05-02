Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 172DB2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 04:19:41 +1000 (EST)
Date: Thu, 2 May 2013 13:19:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: pci overmapping
To: Sethi Varun-B16395 <B16395@freescale.com>
References: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
 <1367514839.24411.12@snotra>
 <C5ECD7A89D1DC44195F34B25E172658D4D3E5A@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D4D3E5A@039-SN2MPN1-011.039d.mgd.msft.net>
 (from B16395@freescale.com on Thu May  2 13:09:53 2013)
Message-ID: <1367518770.24411.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/02/2013 01:09:53 PM, Sethi Varun-B16395 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, May 02, 2013 10:44 PM
> > To: Yoder Stuart-B08248
> > Cc: galak@kernel.crashing.org; Sethi Varun-B16395; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: pci overmapping
> >
> > On 05/02/2013 12:05:42 PM, Yoder Stuart-B08248 wrote:
> > > Kumar,
> > >
> > > In fsl_pci.c there is a change you made a while back:
> > >   "powerpc/fsl: Setup PCI inbound window based on actual amount of
> > > memory"
> > >
> > > ...and there is this comment in the code:
> > >
> > >     /* PCIe can overmap inbound & outbound since RX & TX are =20
> separated
> > > */
> > >     if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
> > >
> > > You are implying that PCIe can overmap and PCI can't.  Why is
> > > that?   (I'm assuming that 'overmap' means that inbound window
> > > can extend beyond the end of ram.)
> >
> > Shouldn't the concern be whether we're overlapping outbound, not =20
> merely
> > whether we go beyond the end of RAM?
> >
> > And couldn't inbound/outbound overlap be an issue even on PCIe, if
> > there's a PCI bridge underneath it?
> I believe that the overlap problem would be avoided in case of 36 bit =20
> physical support (outbound window address would be high order 36 bit =20
> value), right?

Not necessarily -- it depends on what the bus addresses are, not the =20
host addresses.

-Scott=
