Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A3CA714010B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 11:07:46 +1000 (EST)
Message-ID: <1398118262.1694.188.camel@snotra.buserror.net>
Subject: Re: [PATCH 4/6] powerpc/corenet: Create the dts components for the
 DPAA FMan
From: Scott Wood <scottwood@freescale.com>
To: Shruti Kanetkar <Shruti@Freescale.com>
Date: Mon, 21 Apr 2014 17:11:02 -0500
In-Reply-To: <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-4-git-send-email-Shruti@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
> +fman@400000 {
> +	mdio@f1000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-xmdio";
> +		reg = <0xf1000 0x1000>;
> +	};
> +};

I'd like to see a complete fman binding before we start adding pieces.

> +fman@400000 {
> +	mdio0: mdio@e1120 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "fsl,fman-mdio";
> +		reg = <0xe1120 0xee0>;
> +	};
> +};

What is the difference between "fsl,fman-mdio" and "fsl,fman-xmdio"?  I
don't see the latter on the list of compatibles in patch 3/6.

Within each category, is the exact fman version discoverable from the
mdio registers?

> diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
> new file mode 100644
> index 0000000..ced5786
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1.dtsi
> @@ -0,0 +1,52 @@
> +/*
> + * QorIQ FMan v3 device tree stub [ controller @ offset 0x500000 ]
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *       notice, this list of conditions and the following disclaimer in the
> + *       documentation and/or other materials provided with the distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote products
> + *       derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> +*/
> +
> +fman@500000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "simple-bus";

Why is this simple-bus?

> +
> +	/* mdio nodes for fman v3 @ 0x500000 */
> +	mdio@fc000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xfc000 0x1000>;
> +	};
> +
> +	mdio@fd000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0xfd000 0x1000>;
> +	};
> +};

Where's the compatible?  Why is this file different from all the others?

-Scott
