Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 89248DDF54
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 12:25:37 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so326478rvf
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 19:25:36 -0700 (PDT)
Message-ID: <fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
Date: Wed, 10 Oct 2007 20:25:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"Grant Likely" <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
In-Reply-To: <20071011013817.GB14873@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> On Wed, Oct 10, 2007 at 03:38:02PM -0500, Josh Boyer wrote:
> > On Mon, 2007-10-08 at 01:53 -0600, Grant Likely wrote:
> > > From: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > > ---
> > >
> > > This is a first draft, please review and comment.
> >
> > I'll start off with the fact that I hardly consider myself a DT expert,
> > so take what I say with a grain of salt.
> >
> > > On a side node, I think booting-without-of.txt could get really unwieldly
> > > in the near future.  Perhaps the device tree bindings should be organized
> > > differently and separated from the functional description of device tree
> > > usage.  Thoughts?
> > >
> > > Cheers,
> > > g.
> > >
> > >  Documentation/powerpc/booting-without-of.txt |   58 ++++++++++++++++++++++++++
> > >  1 files changed, 58 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> > > index 20e0e6c..a6d6056 100644
> > > --- a/Documentation/powerpc/booting-without-of.txt
> > > +++ b/Documentation/powerpc/booting-without-of.txt
> > > @@ -1850,6 +1850,64 @@ platforms are moved over to use the flattened-device-tree model.
> > >
> > >     More devices will be defined as this spec matures.
> > >
> > > +   l) Xilinx ML300 Framebuffer
> > > +
> > > +   Simple framebuffer device from the ML300 reference design (also on the
> > > +   ML403 reference design as well as others).
> > > +
> > > +   Required properties:
> > > +    - compatible : Must include "xilinx,ml300-fb"
> >
> > Similarly, "xilinx,ml403-fb" will be required for ML403 correct?  Or do
> > they share exact identical implementations?
> >
> > > +    - reg : offset and length of the framebuffer register set
> > > +
> > > +   Optional properties:
> > > +    - resolution : <xres yres> pixel resolution of framebuffer.  Some
> > > +                   implementations use a different resolution.  Default
> > > +                   is <d#640 d#480>
> > > +    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
> > > +                        Default is <d#1024 d#480>.
> > > +    - rotate-display : rotate display 180 degrees.
> > > +    - display-number : Logical number of display
> > > +
> > > +   m) Xilinx SystemACE
> > > +
> > > +   The Xilinx SystemACE device is used to program FPGAs from an FPGA
> > > +   bitstream stored on a CF card.  It can also be used as a generic CF
> > > +   interface device.
> > > +
> > > +   Required properties:
> > > +    - compatible : Must include "xilinx,sysace"
> > > +    - reg : offset and length of SystemACE register set
> > > +
> > > +   Recommended properties:
> > > +    - interrupt-parent, interrupts : Connection of device irq signal.
> > > +
> > > +   Optional properties:
> > > +    - number : logical number of the SystemACE device based at 0.
> >
> > "number" seems a bit to generic to me.  logical-number seems a bit more
> > descriptive.
>
> We've used 'cell-index' for similar purposes on other 4xx.

Unfortunately, 'cell' has been used in the sense of a logic cell in an
SoC.  In the case of the SystemACE, it is an external chip.

What about "device-number"?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
