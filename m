Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id A2D9E1A025B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 04:26:17 +1100 (AEDT)
Date: Mon, 16 Nov 2015 11:26:11 -0600
From: Rob Herring <robh@kernel.org>
To: Dongsheng Wang <dongsheng.wang@freescale.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Cc: scottwood@freescale.com, stuart.yoder@freescale.com,
 shawnguo@kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, jason.jin@freescale.com,
 Chenhui Zhao <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Subject: Re: [PATCH v4] Documentation: dt: binding: fsl: add devicetree
 binding for describing RCPM
Message-ID: <20151116172611.GA27814@rob-hp-laptop>
References: <1445841852-6830-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445841852-6830-1-git-send-email-dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+Sudeep

On Mon, Oct 26, 2015 at 02:44:12PM +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> RCPM is the Run Control and Power Management module performs all
> device-level tasks associated with device run control and power
> management.
> 
> Add this for freescale powerpc platform and layerscape platform.

[...]

> @@ -0,0 +1,64 @@
> +* Run Control and Power Management
> +-------------------------------------------
> +The RCPM performs all device-level tasks associated with device run control
> +and power management.
> +
> +Required properites:
> +  - reg : Offset and length of the register set of the RCPM block.
> +  - fsl,#rcpm-wakeup-cells : The number of IPPDEXPCR register cells in the
> +	fsl,rcpm-wakeup property.

[...]

> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required fsl,rcpm-wakeup property should be added to a device node if the device
> +can be used as a wakeup source.
> +
> +  - fsl,rcpm-wakeup: Consists of a pointer to the rcpm node and the IPPDEXPCR
> +	register cells. The number of IPPDEXPCR register cells is defined in
> +	"fsl,#rcpm-wakeup-cells" in the rcpm node. The first register cell is
> +	the bit mask that should be set in IPPDEXPCR0, and the second register
> +	cell is for IPPDEXPCR1, and so on.

We just merged a common wakeup source binding[1]. It doesn't really work 
in a similar way to what you have done, but I'd like to see something 
common here. How exactly wakeup is done tends to depend on whether 
interrupts are also wakeup signals or wake-up signally is completely 
separate from interrupts. Depending on that, I think there are 2 options 
here:

- Use the common binding and implement a stacked irqdomain for the 
wakeup controller.

- Extend the common binding to allow a phandle+args value to point to 
the wakeup controller.

Rob

[1] Documentation/devicetree/bindings/power/wakeup-source.txt
