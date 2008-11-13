Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 823ABDDE01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 22:45:47 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mADBjFYj013197
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 04:45:15 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mADBjf7K148968
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 04:45:41 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mADBjC76009576
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 04:45:12 -0700
Date: Thu, 13 Nov 2008 06:45:33 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Yuri Tikhonov <yur@emcraft.com>
Subject: Re: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
Message-ID: <20081113064533.77eccc1b@zod.rchland.ibm.com>
In-Reply-To: <200811131149.14715.yur@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 13 Nov 2008 11:49:14 +0300
Yuri Tikhonov <yur@emcraft.com> wrote:

> Hello,
> 
> This patch extends DMA ranges for PCI(X) to 4GB, so that it could
> work on Katmais with 4GB RAM installed.
> 
> Add new nodes for the PPC440SPe DMA, XOR engines to
> be used in the PPC440SPe ADMA driver, and the SysACE
> controller, which connects Compact Flash to Katmai.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
> ---
> +		DMA0: dma0 {
> +			interrupt-parent = <&DMA0>;
> +			interrupts = <0 1>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <
> +				0 &UIC0 0x14 4
> +				1 &UIC1 0x16 4>;
> +		};
> +		DMA1: dma1 {
> +			interrupt-parent = <&DMA1>;
> +			interrupts = <0 1>;
> +			#interrupt-cells = <1>;
> +			#address-cells = <0>;
> +			#size-cells = <0>;
> +			interrupt-map = <
> +				0 &UIC0 0x16 4
> +				1 &UIC1 0x16 4>;
> +		};
> +		xor {
> +			interrupt-parent = <&UIC1>;
> +			interrupts = <0x1f 4>;
> +		};

You have no compatible property in these 3 nodes.  How are drivers
supposed to bind to them?

You also have no reg or dcr-reg properties.  What exactly are these
nodes for?

> +		sysacecf@4fe000000 {
> +			compatible = "xlnx,opb-sysace-1.00.b";

Odd.  This isn't a xilinx board by any means.  This should probably
look something like:

	compatible = "amcc,sysace-440spe", "xlnx,opb-sysace-1.00.b";

Though I'm curious about it in general.  The xilinx bindings have the
versioning numbers on them to match particular bit-streams in the FPGAs
if I remember correctly.  Does that really apply here?

josh
