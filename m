Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 55F63DDF91
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 06:39:25 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9AKelmD026141
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:40:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9AKdG0E560524
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:39:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9AKd6nf016565
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 16:39:06 -0400
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 15:38:02 -0500
Message-Id: <1192048682.5534.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-10-08 at 01:53 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> This is a first draft, please review and comment.

I'll start off with the fact that I hardly consider myself a DT expert,
so take what I say with a grain of salt.

> On a side node, I think booting-without-of.txt could get really unwieldly
> in the near future.  Perhaps the device tree bindings should be organized
> differently and separated from the functional description of device tree
> usage.  Thoughts?
> 
> Cheers,
> g.
> 
>  Documentation/powerpc/booting-without-of.txt |   58 ++++++++++++++++++++++++++
>  1 files changed, 58 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> index 20e0e6c..a6d6056 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1850,6 +1850,64 @@ platforms are moved over to use the flattened-device-tree model.
> 
>     More devices will be defined as this spec matures.
> 
> +   l) Xilinx ML300 Framebuffer
> +
> +   Simple framebuffer device from the ML300 reference design (also on the
> +   ML403 reference design as well as others).
> +
> +   Required properties:
> +    - compatible : Must include "xilinx,ml300-fb"

Similarly, "xilinx,ml403-fb" will be required for ML403 correct?  Or do
they share exact identical implementations?

> +    - reg : offset and length of the framebuffer register set
> +
> +   Optional properties:
> +    - resolution : <xres yres> pixel resolution of framebuffer.  Some
> +                   implementations use a different resolution.  Default
> +                   is <d#640 d#480>
> +    - virt-resolution : <xvirt yvirt> Size of framebuffer in memory.
> +                        Default is <d#1024 d#480>.
> +    - rotate-display : rotate display 180 degrees.
> +    - display-number : Logical number of display
> +
> +   m) Xilinx SystemACE
> +
> +   The Xilinx SystemACE device is used to program FPGAs from an FPGA
> +   bitstream stored on a CF card.  It can also be used as a generic CF
> +   interface device.
> +
> +   Required properties:
> +    - compatible : Must include "xilinx,sysace"
> +    - reg : offset and length of SystemACE register set
> +
> +   Recommended properties:
> +    - interrupt-parent, interrupts : Connection of device irq signal.
> +
> +   Optional properties:
> +    - number : logical number of the SystemACE device based at 0.

"number" seems a bit to generic to me.  logical-number seems a bit more
descriptive.

> +    - 8-bit (empty) : Set this property if the SystemACE must be in 8 bit mode
> +
> +   n) Xilinx EMAC and Xilinx TEMAC
> +
> +   Xilinx Ethernet devices.  Uses common properties from other Ethernet
> +   devices with the following constraints:
> +   
> +   Required properties:
> +    - compatible : Must include one of: "xilinx,plb-temac",
> +                   "xilinx,plb-emac", "xilinx-opb-emac"

I think you mean "xilinx,opb-emac" on that last one.

> +    - dma-mode : Must be one of "none", "simple", "sg" (sg == scatter gather)
> +
> +   o) Xilinx Uartlite
> +
> +   Xilinx uartlite devices are simple fixed speed serial ports.  Uartlite
> +   ports should be described in a node with the following properties.
> +
> +   Requred properties:
> +    - compatible : Must include "xilinx,uartlite"
> +    - reg : offset and length of uartlite register set
> +
> +    Recommended properties:
> +    - port-number : logical port number of uartlite device based at 0.
> +    - interrupt-parent, interrupts : Connection of device irq signal.
> +

josh
