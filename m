Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id CC3A02C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 05:09:28 +1100 (EST)
Date: Thu, 13 Mar 2014 18:09:16 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v9 5/6] dma: mpc512x: add device tree binding document
Message-ID: <20140313180916.GF25870@e106331-lin.cambridge.arm.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
 <1394624875-24411-6-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1394624875-24411-6-git-send-email-a13xp0p0v88@gmail.com>
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

On Wed, Mar 12, 2014 at 11:47:54AM +0000, Alexander Popov wrote:
> From: Gerhard Sittig <gsi@denx.de>
> 
> introduce a device tree binding document for the MPC512x DMA controller
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> [ a13xp0p0v88@gmail.com: turn this into a separate patch ]
> ---
>  .../devicetree/bindings/dma/mpc512x-dma.txt        | 55 ++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> 
> diff --git a/Documentation/devicetree/bindings/dma/mpc512x-dma.txt b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> new file mode 100644
> index 0000000..a4867d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> @@ -0,0 +1,55 @@
> +* Freescale MPC512x DMA Controller
> +
> +The DMA controller in the Freescale MPC512x SoC can move blocks of
> +memory contents between memory and peripherals or memory to memory.
> +
> +Refer to the "Generic DMA Controller and DMA request bindings" description
> +in the dma.txt file for a more detailled discussion of the binding.  The
> +MPC512x DMA engine binding follows the common scheme, but doesn't provide
> +support for the optional channels and requests counters (those values are
> +derived from the detected hardware features) and has a fixed client
> +specifier length of 1 integer cell (the value is the DMA channel, since
> +the DMA controller uses a fixed assignment of request lines per channel).
> +
> +
> +DMA controller node properties:
> +
> +Required properties:
> +- compatible:		should be "fsl,mpc5121-dma"
> +- reg:			address and size of the DMA controller's register set
> +- interrupts:		interrupt spec for the DMA controller
> +
> +Optional properties:
> +- #dma-cells:		must be <1>, describes the number of integer cells
> +			needed to specify the 'dmas' property in client nodes,
> +			strongly recommended since common client helper code
> +			uses this property

Describe what you expect this cell to contain, not the #dma-cells
binding in general. The DMA bindings already cover that.

What are valid value that clients may use, and what do they mean?

> +
> +Example:
> +
> +	dma0: dma@14000 {
> +		compatible = "fsl,mpc5121-dma";
> +		reg = <0x14000 0x1800>;
> +		interrupts = <65 0x8>;
> +		#dma-cells = <1>;
> +	};
> +
> +
> +Client node properties:
> +
> +Required properties:
> +- dmas:			list of DMA specifiers, consisting each of a handle
> +			for the DMA controller and integer cells to specify
> +			the channel used within the DMA controller
> +- dma-names:		list of identifier strings for the DMA specifiers,
> +			client device driver code uses these strings to
> +			have DMA channels looked up at the controller

List the exact names you expect, or the dma-names property is useless.

Thanks,
Mark.

> +
> +Example:
> +
> +	sdhc@1500 {
> +		compatible = "fsl,mpc5121-sdhc";
> +		/* ... */
> +		dmas = <&dma0 30>;
> +		dma-names = "rx-tx";
> +	};
> -- 
> 1.8.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
