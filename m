Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68A1E1A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 14:17:17 +1000 (AEST)
Message-ID: <1435292192.6524.16.camel@freescale.com>
Subject: Re: [PATCH v4] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Yuantian.Tang@freescale.com
CC: b07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Chenhui Zhao
 <chenhui.zhao@freescale.com>
Date: Thu, 25 Jun 2015 23:16:32 -0500
In-Reply-To: <1435046827-7683-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1435046827-7683-1-git-send-email-Yuantian.Tang@freescale.com>
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

On Tue, 2015-06-23 at 16:07 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> There is a RCPM (Run Control/Power Management) in Freescale QorIQ
> series processors. The device performs tasks associated with device
> run control and power management.
> 
> The driver implements some features: mask/unmask irq, enter/exit low
> power states, freeze time base, etc.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> ---
> v4:
>       - refine bindings document
> v3:
>       - added static and __init modifier to fsl_rcpm_init
> v2:
>       - fix code style issues
>       - refine compatible string match part
> 
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  42 +++
>  arch/powerpc/include/asm/fsl_guts.h                | 105 +++++++
>  arch/powerpc/include/asm/fsl_pm.h                  |  48 +++
>  arch/powerpc/platforms/85xx/Kconfig                |   1 +
>  arch/powerpc/sysdev/Kconfig                        |   5 +
>  arch/powerpc/sysdev/Makefile                       |   1 +
>  arch/powerpc/sysdev/fsl_rcpm.c                     | 338 
> +++++++++++++++++++++
>  7 files changed, 540 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/rcpm.txt
>  create mode 100644 arch/powerpc/include/asm/fsl_pm.h
>  create mode 100644 arch/powerpc/sysdev/fsl_rcpm.c
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt 
> b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> new file mode 100644
> index 0000000..1f58018
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -0,0 +1,42 @@
> +* Run Control and Power Management
> +
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
> +     Chassis-version RCPM strings include:
> +     * "fsl,qoriq-rcpm-1.0": for chassis 1.0 rcpm
> +     * "fsl,qoriq-rcpm-2.0": for chassis 2.0 rcpm
> +
> +All references to "1.0" and "2.0" refer to the QorIQ chassis version to
> +which the chip complies.
> +Chassis Version              Example Chips
> +---------------              -------------------------------
> +1.0                                  p4080, p5020, p5040, p2041, p3041
> +2.0                                  t4240, b4860, t1040, b4420

I don't think it's accurate to call t1040 chassis 2.0.

-Scott
