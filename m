Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0139.outbound.protection.outlook.com [157.56.110.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36D1A1A2757
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2015 05:56:54 +1000 (AEST)
Message-ID: <1441828599.29081.36.camel@freescale.com>
Subject: Re: [PATCH 1/2] fsl: Add binding for RCPM
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
CC: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <jason.jin@freescale.com>, <chenhui.zhao@freescale.com>,
 <yuantian.tang@freescale.com>, <alison.wang@freescale.com>,
 <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date: Wed, 9 Sep 2015 14:56:39 -0500
In-Reply-To: <1441780967-30879-1-git-send-email-dongsheng.wang@freescale.com>
References: <1441780967-30879-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-09-09 at 14:42 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> RCPM is the Run Control and Power Management module performs all
> device-level tasks associated with device run control and power
> management.
> 
> Add this for freescale powerpc platform and layerscape platform.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt 
> b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> new file mode 100644
> index 0000000..284070c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -0,0 +1,64 @@
> +* Run Control and Power Management
> +-------------------------------------------
> +The RCPM performs all device-level tasks associated with device run control
> +and power management.
> +
> +Required properites:
> +  - reg : Offset and length of the register set of RCPM block.
> +  - compatible : Sould contain a chip-specific RCPM block compatible string
> +     and (if applicable) may contain a chassis-version RCPM compatible string.
> +     Chip-specific strings are of the form "fsl,<chip>-rcpm", such as:
> +     * "fsl,p2041-rcpm"
> +     * "fsl,p3041-rcpm"
> +     * "fsl,p4080-rcpm"
> +     * "fsl,p5020-rcpm"
> +     * "fsl,p5040-rcpm"
> +     * "fsl,t4240-rcpm"
> +     * "fsl,b4420-rcpm"
> +     * "fsl,b4860-rcpm"
> +
> +     Chassis-version strings are of the form "fsl,qoriq-rcpm-<version>",
> +     such as:
> +     * "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
> +     * "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
> +     * "fsl,qoriq-rcpm-2.1": for chassis 2.1 rcpm
> +
> +All references to "1.0" and "2.0" refer to the QorIQ chassis version to
> +which the chip complies.
> +Chassis Version              Example Chips
> +---------------              -------------------------------
> +1.0                          p4080, p5020, p5040, p2041, p3041
> +2.0                          t4240, b4860, b4420
> +2.1                          t1040, ls1021
> +
> +Example:
> +The RCPM node for T4240:
> +     rcpm:  global-utilities@e2000{
> +             compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
> +             reg = <0xe2000 0x1000>;
> +     };
> +
> +The RCPM node for P4080:
> +     rcpm:  global-utilities@e2000{
> +             compatible = "fsl,qoriq-rcpm-1.0";
> +             reg = <0xe2000 0x1000>;
> +     };

I would avoid putting the p4080 example in the binding, as we don't want to 
make it look like it's OK to leave out the specific chip compatible.

> +* Freescale RCPM Wakeup Source Device Tree Bindings
> +-------------------------------------------
> +Required rcpm-wakeup property should be added to a device node if the 
> device
> +can be used as a wakeup source.
> +
> +  - rcpm-wakeup: should contain a pointer to the rcpm node and the
> +     corresponding bit of device in the register.

The corresponding bit in *what* register?

-Scott
