Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 598D4DDF18
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:41:31 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id l9B1fT5c024038
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:41:29 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9B1j4eN225176
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:45:05 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9B1fEP1007702
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 11:41:14 +1000
Date: Thu, 11 Oct 2007 11:38:17 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
Message-ID: <20071011013817.GB14873@localhost.localdomain>
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1192048682.5534.92.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 10, 2007 at 03:38:02PM -0500, Josh Boyer wrote:
> On Mon, 2007-10-08 at 01:53 -0600, Grant Likely wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> > 
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > ---
> > 
> > This is a first draft, please review and comment.
> 
> I'll start off with the fact that I hardly consider myself a DT expert,
> so take what I say with a grain of salt.
> 
> > On a side node, I think booting-without-of.txt could get really unwieldly
> > in the near future.  Perhaps the device tree bindings should be organized
> > differently and separated from the functional description of device tree
> > usage.  Thoughts?
> > 
> > Cheers,
> > g.
> > 
> >  Documentation/powerpc/booting-without-of.txt |   58 ++++++++++++++++++++++++++
> >  1 files changed, 58 insertions(+), 0 deletions(-)
> > 
> > diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> > index 20e0e6c..a6d6056 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1850,6 +1850,64 @@ platforms are moved over to use the flattened-device-tree model.
> > 
> >     More devices will be defined as this spec matures.
> > 
> > +   l) Xilinx ML300 Framebuffer
> > +
> > +   Simple framebuffer device from the ML300 reference design (also on the
> > +   ML403 reference design as well as others).
> > +
> > +   Required properties:
> > +    - compatible : Must include "xilinx,ml300-fb"
> 
> Similarly, "xilinx,ml403-fb" will be required for ML403 correct?  Or do
> they share exact identical implementations?
> 
> > +    - reg : offset and length of the framebuffer register set
> > +
> > +   Optional properties:
> > +    - resolution : <xres yres> pixel resolution of framebuffer.  Some
> > +                   implementations use a different resolution.  Default
> > +                   is <d#640 d#480>
> > +    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
> > +                        Default is <d#1024 d#480>.
> > +    - rotate-display : rotate display 180 degrees.
> > +    - display-number : Logical number of display
> > +
> > +   m) Xilinx SystemACE
> > +
> > +   The Xilinx SystemACE device is used to program FPGAs from an FPGA
> > +   bitstream stored on a CF card.  It can also be used as a generic CF
> > +   interface device.
> > +
> > +   Required properties:
> > +    - compatible : Must include "xilinx,sysace"
> > +    - reg : offset and length of SystemACE register set
> > +
> > +   Recommended properties:
> > +    - interrupt-parent, interrupts : Connection of device irq signal.
> > +
> > +   Optional properties:
> > +    - number : logical number of the SystemACE device based at 0.
> 
> "number" seems a bit to generic to me.  logical-number seems a bit more
> descriptive.

We've used 'cell-index' for similar purposes on other 4xx.

> 
> > +    - 8-bit (empty) : Set this property if the SystemACE must be in 8 bit mode
> > +
> > +   n) Xilinx EMAC and Xilinx TEMAC
> > +
> > +   Xilinx Ethernet devices.  Uses common properties from other Ethernet
> > +   devices with the following constraints:
> > +   
> > +   Required properties:
> > +    - compatible : Must include one of: "xilinx,plb-temac",
> > +                   "xilinx,plb-emac", "xilinx-opb-emac"
> 
> I think you mean "xilinx,opb-emac" on that last one.
> 
> > +    - dma-mode : Must be one of "none", "simple", "sg" (sg == scatter gather)
> > +
> > +   o) Xilinx Uartlite
> > +
> > +   Xilinx uartlite devices are simple fixed speed serial ports.  Uartlite
> > +   ports should be described in a node with the following properties.
> > +
> > +   Requred properties:
> > +    - compatible : Must include "xilinx,uartlite"
> > +    - reg : offset and length of uartlite register set
> > +
> > +    Recommended properties:
> > +    - port-number : logical port number of uartlite device based at 0.
> > +    - interrupt-parent, interrupts : Connection of device irq signal.
> > +
> 
> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
