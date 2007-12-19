Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C45E3DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 00:35:59 +1100 (EST)
Message-ID: <47691DE6.8050901@ru.mvista.com>
Date: Wed, 19 Dec 2007 16:34:30 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/20] [POWERPC] Wire up PCI on Bamboo board
References: <20071213073845.1D311DE053@ozlabs.org>
In-Reply-To: <20071213073845.1D311DE053@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> This adds the device-tree bits & call to ppc4xx_pci_find_bridges()
> to make PCI work on the Bamboo board
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/boot/dts/bamboo.dts |   40 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> --- linux-work.orig/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 15:56:59.000000000 +1100
> +++ linux-work/arch/powerpc/boot/dts/bamboo.dts	2007-12-10 16:39:51.000000000 +1100
> @@ -239,10 +239,48 @@
>  				zmii-channel = <1>;
>  			};
>  		};
> +
> +		PCI0: pci@ec000000 {
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
> +			primary;
> +			reg = <0 eec00000 8	/* Config space access */
> +			       0 eed80000 4	/* IACK */
> +			       0 eed80000 4	/* Special cycle */
> +			       0 ef480000 40>;	/* Internal registers */

Why ef480000 here? IIRC, the docs say it should be ef400000, while 
ef400040 - ef4fffff are reserved and can mirror local registers.
Thanks,
Valentine.
