Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (sg2ehsobe004.messaging.microsoft.com
	[207.46.51.78]) by ozlabs.org (Postfix) with ESMTP id 6E95AB7088
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Nov 2009 12:14:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into generic,
	of and platform driver, added support for DS570
Date: Mon, 9 Nov 2009 16:59:05 -0800
In-Reply-To: <fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
References: <4AC0C699.2070506@mocean-labs.com>
	<fa686aa40911091321w187fe85fl4e6d9f36f5966f34@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	=?iso-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@mocean-labs.com>
Message-ID: <c539e2ef-5677-45b4-ae52-d8c62c4cc6ba@SG2EHSMHS018.ehs.local>
Cc: John Linn <linnj@xilinx.com>, spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>,
	dbrownell@users.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linuxppc-dev-bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org [=
mailto:linuxppc-dev-
> bounces+stephen=3Dneuendorffer.name@lists.ozlabs.org] On Behalf Of Grant =
Likely
> Sent: Monday, November 09, 2009 1:22 PM
> To: Richard R=F6jfors
> Cc: spi-devel-general@lists.sourceforge.net; Andrew Morton; dbrownell@use=
rs.sourceforge.net; John
> Linn; linuxppc-dev@ozlabs.org
> Subject: Re: [spi-devel-general] [PATCH v4] xilinx_spi: Splitted into gen=
eric, of and platform
> driver, added support for DS570
> =

> Oops, I replied to the original version, but missed the subsequent
> versions.  Looks like some of my comments still apply though.
> Overall, the patch changes too many things all at once.  You should
> look at splitting it up.  At the very least the io accessor changes
> should be done in a separate patch.
> =

> On Mon, Sep 28, 2009 at 7:22 AM, Richard R=F6jfors
> <richard.rojfors@mocean-labs.com> wrote:
> > @@ -227,6 +227,21 @@ config SPI_XILINX
> > =A0 =A0 =A0 =A0 =A0See the "OPB Serial Peripheral Interface (SPI) (v1.0=
0e)"
> > =A0 =A0 =A0 =A0 =A0Product Specification document (DS464) for hardware =
details.
> >
> > + =A0 =A0 =A0 =A0 Or for the DS570, see "XPS Serial Peripheral Interfac=
e (SPI) (v2.00b)"
> > +
> > +config SPI_XILINX_OF
> > + =A0 =A0 =A0 tristate "Xilinx SPI controller OF device"
> > + =A0 =A0 =A0 depends on SPI_XILINX && XILINX_VIRTEX
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This is the OF driver for the SPI controller IP from =
the Xilinx EDK.
> > +
> > +config SPI_XILINX_PLTFM
> > + =A0 =A0 =A0 tristate "Xilinx SPI controller platform device"
> > + =A0 =A0 =A0 depends on SPI_XILINX
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This is the platform driver for the SPI controller IP=

> > + =A0 =A0 =A0 =A0 from the Xilinx EDK.
> > +
> =

> Personally, I don't think it is necessary to present these options to
> the user.  I think they can be auto-selected depending on CONFIG_OF
> and CONFIG_PLATFORM.

And in any event, OF should work for MICROBLAZE, too...

Steve
 =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
