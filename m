Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32982DDE10
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:53:24 +1100 (EST)
Message-Id: <316F2CE0-79D8-4996-9938-315C9A103CDA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20071215162331.GA24999@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Date: Tue, 18 Dec 2007 09:53:08 -0600
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 15, 2007, at 10:23 AM, Anton Vorontsov wrote:

>
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <14 8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <0x3100 0x100>;
> +			interrupts = <16 8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +		};
> +

In addition to David's comments.  I've added cell-index:

                 i2c@3000 {
                         #address-cells = <1>;
                         #size-cells = <0>;
                         cell-index = <0>;
                         compatible = "fsl-i2c";
                         reg = <3000 100>;
                         interrupts = <e 8>;
                         interrupt-parent = < &ipic >;
                         dfsrr;
                 };

                 i2c@3100 {
                         #address-cells = <1>;
                         #size-cells = <0>;
                         cell-index = <1>;
                         compatible = "fsl-i2c";
                         reg = <3100 100>;
                         interrupts = <f 8>;
                         interrupt-parent = < &ipic >;
                         dfsrr;
                 };
