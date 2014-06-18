Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id E00A31A033C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 23:53:35 +1000 (EST)
Date: Wed, 18 Jun 2014 14:37:30 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH v2 1/3] dmaengine: mpc512x: add device tree binding
 document
Message-ID: <20140618133730.GB11895@leverpostej>
References: <1403088492-15241-1-git-send-email-a13xp0p0v88@gmail.com>
 <1403088492-15241-2-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403088492-15241-2-git-send-email-a13xp0p0v88@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 18, 2014 at 11:48:10AM +0100, Alexander Popov wrote:
> Introduce a device tree binding document for the MPC512x DMA controller
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> ---
>  .../devicetree/bindings/dma/mpc512x-dma.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> new file mode 100644
> index 0000000..95e2ca0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> @@ -0,0 +1,31 @@
> +* Freescale MPC512x and MPC8308 DMA Controller
> +
> +The DMA controller in Freescale MPC512x and MPC8308 SoCs can move
> +blocks of memory contents between memory and peripherals or
> +from memory to memory.
> +
> +Refer to "Generic DMA Controller and DMA request bindings" in
> +the dma/dma.txt file for a more detailed description of binding.
> +
> +Required properties:
> +- compatible: should be "fsl,mpc5121-dma" or "fsl,mpc8308-dma";
> +- reg: should contain the DMA controller registers location and length;
> +- interrupt for the DMA controller: syntax of interrupt client node
> +	is described in interrupt-controller/interrupts.txt file.
> +
> +Optional properties:
> +- #dma-cells: the length of the DMA specifier, must be <1>.
> +	Each channel of this DMA controller has a peripheral request line,
> +	the assignment is fixed in hardware. This one cell
> +	in dmas property of a client device represents the channel number.

Surely this is required to be able to refer to DMA channels on the
device?

Mark.
