Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F32FA2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 07:19:41 +1100 (EST)
Message-ID: <1389385170.24905.19.camel@snotra.buserror.net>
Subject: Re: [PATCH v8] clk: corenet: Adds the clock binding
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian <Yuantian.Tang@freescale.com>
Date: Fri, 10 Jan 2014 14:19:30 -0600
In-Reply-To: <1389320944-2574-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1389320944-2574-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, b07421@freescale.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-01-10 at 10:29 +0800, Tang Yuantian wrote:
> +- reg: Offset and length of the clock register set

"offset" into what?  The containing node is not within the scope of this
binding.

I know that plenty of other bindings are worded this way, and I wouldn't
hold up acceptance if this were the only issue, but it ought to be fixed
to say something like "reg: resource zero represents the clock register
set".

> +Recommended properties:
> +- clock-frequency: Input system clock frequency. Must be present
> +	if the device has sub-nodes.

Why only "if the device has sub-nodes"?

> +       * "fsl,qoriq-sysclk-1.0": for input system clock (v1.0).
> +               It takes parent's clock as its clock.
> +       * "fsl,qoriq-sysclk-2.0": for input system clock (v2.0).
> +               It takes parent's clock as its clock.

s/parent's clock/parent's clock-frequency/ since the parent isn't
actually exposing a clock as per the clock bindings.

> +Example for clock block and clock provider:
> +/ {
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +		ranges = <0x0 0xe1000 0x1000>;
> +		clock-frequency = <0>;

It'd be better to show a real clock-frequency here -- this is an example
for the node as the OS sees it, not what goes in the dts as an input to
U-Boot.

-Scott
