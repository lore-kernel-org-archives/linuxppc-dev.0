Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound7-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E28EBDDF11
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 08:39:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for Xilinx
	uart	16550.
Date: Wed, 2 Apr 2008 14:39:17 -0700
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C05FC4762@XCO-EXCHVS1.xlnx.xilinx.com>
References: <689CB232690D8D4E97DA6C76DA098E6C05FC4762@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "John Linn" <linnj@xilinx.com>, "Grant Likely" <grant.likely@secretlab.ca>,
	<sshtylyov@ru.mvista.com>
Message-Id: <20080402213919.C261F5E007F@mail91-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I don't think big-endian has the same context as reg-shift/reg-offset.
The OpenPOC is fundamentally a 32 bit device, but ns16550 is not...  If
we were talking about a 32 bit device, then I'd probably agree with you,
but in this case, the reg-shift (and to some extent) reg-offset have
been used before and probably make more sense, I think.

Steve

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
> Sent: Wednesday, April 02, 2008 1:20 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca
> Subject: Re: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for
Xilinx uart 16550.
>=20
> Hello.
>=20
> John Linn wrote:
>=20
> > The Xilinx 16550 uart core is not a standard 16550 because it uses
> > word-based addressing rather than byte-based addressing. With
> > additional properties it is compatible with the open firmware
> > 'ns16550' compatible binding.
>=20
> > This code updates the of_serial driver to handle the reg-offset
> > and reg-shift properties to enable this core to be used.
>=20
> > Signed-off-by: John Linn <john.linn@xilinx.com>
>=20
> > diff --git a/Documentation/powerpc/booting-without-of.txt
b/Documentation/powerpc/booting-without-
> of.txt
> > index 87f4d84..af112d9 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -2539,6 +2539,17 @@ platforms are moved over to use the
flattened-device-tree model.
> >                        differ between different families.  May be
> >                        'virtex2p', 'virtex4', or 'virtex5'.
> >
> > +      iv) Xilinx Uart 16550
> > +
> > +      Xilinx UART 16550 devices are very similar to the NS16550
such that they
> > +      use the ns16550 binding with properties to specify register
spacing and
> > +      an offset from the base address.
> > +
> > +      Requred properties:
> > +       - clock-frequency : Frequency of the clock input
> > +       - reg-offset : A value of 3 is required
>=20
>     I'm proposing you to use the already existing "big-endian"
property ISO
> "reg-offset" (used in the  nodes describing OpenPIC, for example).
>=20
> WBR, Sergei
