Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ABEA0DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 07:11:19 +1000 (EST)
Message-ID: <46E1BE41.5070603@freescale.com>
Date: Fri, 07 Sep 2007 16:10:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 3/5] Add DMA of-node to mpc8641hpcn board dts
References: <11891624353752-git-send-email-wei.zhang@freescale.com>	<1189162437484-git-send-email-wei.zhang@freescale.com>	<11891624382764-git-send-email-wei.zhang@freescale.com>
	<11891624391565-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11891624391565-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei wrote:
> This patch adds DMA of-node to MPC8641HPCN board dts.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   40 ++++++++++++++++++++++++++++++++
>  1 files changed, 40 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 5d82709..e0175a4 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -433,5 +433,45 @@
>  			device_type = "open-pic";
>  			big-endian;
>  		};
> +
> +		dma@21000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,dma";
> +			reg = <21300 4>;
> +			ranges = <0 21100 200>;
> +			dma-channel@0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;

The channels aren't buses; only the parent dma node needs #address-cells 
and #size-cells.

-Scott
