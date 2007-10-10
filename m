Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.229])
	by ozlabs.org (Postfix) with ESMTP id DF7F4DE155
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 02:39:42 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so200620nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 09:39:40 -0700 (PDT)
Message-ID: <fa686aa40710100939h2f1a4ca6h4d9cd6e87e258e94@mail.gmail.com>
Date: Wed, 10 Oct 2007 10:39:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: linuxppc-dev@ozlabs.org, "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	"David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
In-Reply-To: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anybody have any comments on this?  Segher?  David?

Cheers,
g.

On 10/8/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
> This is a first draft, please review and comment.
>
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
>  VII - Specifying interrupt information for devices
>  ===================================================
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
