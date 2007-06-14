Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CFD1DDECF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 23:26:28 +1000 (EST)
In-Reply-To: <1181726022.13195.28.camel@localhost.localdomain>
References: <989B956029373F45A0B8AF0297081890D2AC84@zch01exm26.fsl.freescale.net>
	<4470838fec2256a98e512486f8486605@kernel.crashing.org>
	<1181726022.13195.28.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AA6BF215-4802-41C7-A789-6B8BCA911062@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Thu, 14 Jun 2007 08:26:54 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 13, 2007, at 4:13 AM, Zang Roy-r61911 wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
>
> Fix the reset bug on 8548CDS board.
> Begin from MPC8548 with e500 v2 core, a new reset
> control register is added.
> This register is used for the cpu reset.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Pick up this one :-(
>
>  arch/powerpc/boot/dts/mpc8548cds.dts |    6 ++++++
>  arch/powerpc/platforms/85xx/misc.c   |   32 +++++++++++++++++++++++ 
> +++++++++
>  2 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/ 
> boot/dts/mpc8548cds.dts
> index ad96381..0550a3c 100644
> --- a/arch/powerpc/boot/dts/mpc8548cds.dts
> +++ b/arch/powerpc/boot/dts/mpc8548cds.dts
> @@ -177,6 +177,12 @@
>  			interrupt-parent = <&mpic>;
>  		};
>
> +		global-utilities@e0000 {	//global utilities reg
> +			compatible = "fsl,mpc8548-guts";
> +			reg = <e0000 1000>;
> +			fsl,has-rstcr;
> +		};
> +
>  		pci1: pci@8000 {
>  			interrupt-map-mask = <1f800 0 0 7>;
>  			interrupt-map = <

Now that we resolved this can you work up a second patch to update  
Documentation/powerpc/booting-without-of.txt for this node.

- k
