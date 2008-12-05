Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46D25DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 22:08:45 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB5B83Dk023509
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2008 04:08:03 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB5B8dvV072996
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2008 04:08:39 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB5B8dZp015549
	for <linuxppc-dev@ozlabs.org>; Fri, 5 Dec 2008 04:08:39 -0700
Date: Fri, 5 Dec 2008 06:08:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts
	file
Message-ID: <20081205060835.46c6df7a@zod.rchland.ibm.com>
In-Reply-To: <1228457332-523-1-git-send-email-sr@denx.de>
References: <1228457332-523-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri,  5 Dec 2008 07:08:52 +0100
Stefan Roese <sr@denx.de> wrote:

> With this patch the L2 cache is enabled on Canyonlands to increase the
> overall performance. There is a known cache coherency issue with the L2
> cache, but this is related to the high bandwidth (HB) PLB segment where
> the memory address is 0x8.xxxx.xxxx (low bandwidth PLB segment is mapped
> to 0x0.xxxx.xxxx). Since this HB address is currently unused it is safe
> to enable the L2 cache.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index 79fe412..0d77482 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -104,6 +104,16 @@
>  		dcr-reg = <0x00c 0x002>;
>  	};
> 
> +	L2C0: l2c {
> +		compatible = "ibm,l2-cache-460ex", "ibm,l2-cache";
> +		dcr-reg = <0x020 0x008		/* Internal SRAM DCR's */
> +			   0x030 0x008>;	/* L2 cache DCR's */
> +		cache-line-size = <32>;		/* 32 bytes */
> +		cache-size = <262144>;		/* L2, 256K */
> +		interrupt-parent = <&UIC1>;
> +		interrupts = <11 1>;
> +	};

Shouldn't there also be a next-level-cache property added to the cpu
node that references this?

josh
