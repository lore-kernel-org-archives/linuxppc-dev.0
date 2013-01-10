Return-Path: <B37400@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 568352C032C
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2013 20:24:28 +1100 (EST)
From: Singh Sandeep-B37400 <B37400@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] Added device tree binding for TDM and TDM phy
Date: Thu, 10 Jan 2013 09:24:21 +0000
Message-ID: <3F1D9DCAAB49B94D88DBE05911FA4E6E69E4F0@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1357133120-2271-1-git-send-email-Sandeep@freescale.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E69CEB8@039-SN1MPN1-005.039d.mgd.msft.net>
 <1357776425.18196.18@snotra>
In-Reply-To: <1357776425.18196.18@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org"
 <devicetree-discuss@lists.ozlabs.org>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>
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
> Sent: Thursday, January 10, 2013 5:37 AM
> To: Singh Sandeep-B37400
> Cc: devicetree-discuss@lists.ozlabs.org; linuxppc-dev@ozlabs.org; Aggrwal
> Poonam-B10812
> Subject: Re: [PATCH] Added device tree binding for TDM and TDM phy
>=20
> On 01/09/2013 01:10:24 AM, Singh Sandeep-B37400 wrote:
> > A gentle reminder.
> > Any comments are appreciated.
> >
> > Regards,
> > Sandeep
> >
> > > -----Original Message-----
> > > From: Singh Sandeep-B37400
> > > Sent: Wednesday, January 02, 2013 6:55 PM
> > > To: devicetree-discuss@lists.ozlabs.org; linuxppc-dev@ozlabs.org
> > > Cc: Singh Sandeep-B37400; Aggrwal Poonam-B10812
> > > Subject: [PATCH] Added device tree binding for TDM and TDM phy
> > >
> > > This controller is available on many Freescale SOCs like MPC8315,
> > P1020,
> > > P1010 and P1022
> > >
> > > Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
> > > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> > > ---
> > >  .../devicetree/bindings/powerpc/fsl/fsl-tdm.txt    |   63
> > > ++++++++++++++++++++
> > >  .../devicetree/bindings/powerpc/fsl/tdm-phy.txt    |   38
> > ++++++++++++
> > >  2 files changed, 101 insertions(+), 0 deletions(-)  create mode
> > 100644
> > > Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
> > >  create mode 100644
> > Documentation/devicetree/bindings/powerpc/fsl/tdm-
> > > phy.txt
> > >
> > > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
> > > b/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
> > > new file mode 100644
> > > index 0000000..ceb2ef1
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fsl-tdm.txt
> > > @@ -0,0 +1,63 @@
> > > +TDM Device Tree Binding
> > > +
> > > +NOTE: The bindings described in this document are preliminary and
> > > +subject to change.
> > > +
> > > +TDM (Time Division Multiplexing)
> > > +
> > > +Description:
> > > +
> > > +The TDM is full duplex serial port designed to allow various
> > devices
> > > +including digital signal processors (DSPs) to communicate with a
> > > +variety of serial devices including industry standard framers,
> > codecs,
> > > other DSPs and microprocessors.
> > > +
> > > +The below properties describe the device tree bindings for
> > Freescale
> > > +TDM controller. This TDM controller is available on various
> > Freescale
> > > +Processors like MPC8315, P1020, P1022 and P1010.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible
> > > +    Value type: <string>
> > > +    Definition: Should contain "fsl,tdm1.0".
> > > +
> > > +- reg
> > > +    Definition: A standard property. The first reg specifier
> > describes
> > > the TDM
> > > +    registers, and the second describes the TDM DMAC registers.
> > > +
> > > +- tdm_tx_clk
> > > +    Value type: <u32 or u64>
> > > +    Definition: This specifies the value of transmit clock. It
> > should
> > > not
> > > +    exceed 50Mhz.
> > > +
> > > +- tdm_rx_clk
> > > +    Value type: <u32 or u64>
> > > +    Definition: This specifies the value of receive clock. Its
> > value
> > > could be
> > > +    zero, in which case tdm will operate in shared mode. Its value
> > > should not
> > > +    exceed 50Mhz.
>=20
> Please don't use underscores in property names, and use the vendor
> prefix: "fsl,tdm-tx-clk" and "fsl,tdm-rx-clk".

Ok.

>=20
> > > diff --git
> > a/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt
> > > b/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt
> > > new file mode 100644
> > > index 0000000..2563934
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/powerpc/fsl/tdm-phy.txt
> > > @@ -0,0 +1,38 @@
> > > +TDM PHY Device Tree Binding
> > > +
> > > +NOTE: The bindings described in this document are preliminary and
> > > +subject to change.
> > > +
> > > +Description:
> > > +TDM PHY is the terminal interface of TDM subsystem. It is
> > typically a
> > > +line control device like E1/T1 framer or SLIC. A TDM device can
> > have
> > > +multiple TDM PHYs.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible
> > > +    Value type: <string>
> > > +    Definition: Should contain generic compatibility like
> > "tdm-phy-slic"
> > > or
> > > +    "tdm-phy-e1" or "tdm-phy-t1".
>=20
> Does this "generic" string (plus the other properties) tell you all you
> need to know about the device?  If there are other possible "generic"
> compatibles, they should be listed or else different people will make up
> different strings for the same thing.

This property will describe the type of device, and will help TDM framework
to know if it is E1/T1/SLIC device. Further details can be extracted from o=
ther
compatible strings.
There are only three generic compatibles field types, which are already men=
tioned
in definition. Do I need to make this thing more clear.
>=20
> -Scott
