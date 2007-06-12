Return-Path: <pterry@micromemory.com>
Received: from mail.micromemory.com
	(ip67-95-226-82.z226-95-67.customer.algx.net [67.95.226.82])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CD3BDDDF3
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 08:58:42 +1000 (EST)
Received: from [192.168.0.90] by micromemory.com (MDaemon PRO v9.5.6)
	with ESMTP id md50000421439.msg
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 15:58:36 -0700
Subject: Re: [PATCH 2/5] Add RapidIO sector to MPC8641HPCN board dts file.
From: Phil Terry <pterry@micromemory.com>
To: wei.zhang@freescale.com
In-Reply-To: <11816389401714-git-send-email-wei.zhang@freescale.com>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<11816389401714-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 15:58:32 -0700
Message-Id: <1181689112.9736.29.camel@pterry-fc6.micromemory.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Reply-To: pterry@micromemory.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-06-12 at 17:02 +0800, Zhang Wei wrote:
> Add RapidIO sector to the MPC8641HPCN board dts file.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 04626b1..e2ce06e 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -329,6 +329,19 @@
>  				>;
>  		};
>  
> +		srio@c0000 {
> +			device_type = "rapidio";
> +			compatible = "fsl,rapidio-v1.0";
> +			#address-cells = <2>;
> +			reg = <c0000 20000>;
> +			ranges = <0 0 c0000000 20000000>;

Don't understand the range setup... The code uses c0000000 as the start
and 20000000 as the size for the rapidio law. So whats the 0 0 for? 
At first I thought address-cells 2 means that the range numbers are
pairs expressing 64-bit numbers, eg start 0 0, size c0000000 20000000
but thats not right...

Sorry if I'm asking stupid questions....

And thanks for the patch, just what I need.

BTW do you have any notes/documentation on the space allocation routines
intended use. I'm trying to work it out but I don't see any actual users
of it yet... I need something like it for my distributed DMA driver,
hence the interest.

Cheers
Phil

> +			interrupt-parent = <&mpic>;
> +			/* err_irq bell_outb_irq bell_inb_irq
> +						msg1_tx_irq msg1_rx_irq
> +						msg2_tx_irq msg2_rx_irq */
> +			interrupts = <30 2 31 2 32 2 35 2 36 2 37 2 38 2>;
> +		};
> +
>  		mpic: pic@40000 {
>  			clock-frequency = <0>;
>  			interrupt-controller;
