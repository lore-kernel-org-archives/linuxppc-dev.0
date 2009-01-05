Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBC17DE171
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jan 2009 03:27:21 +1100 (EST)
Message-Id: <1C3FA775-7C2A-4218-BE14-95FF2DD9F6D2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1231152455-8296-1-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/8313erdb: fix kernel crash
Date: Mon, 5 Jan 2009 10:25:08 -0600
References: <1231152455-8296-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 5, 2009, at 4:47 AM, Li Yang wrote:

> Probe the new mdio node added by b31a1d8b.  Fix kernel panic problem  
> when
> gianfar driver wants to get the of_platform_device of that mdio.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/boot/dts/mpc8313erdb.dts |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/ 
> boot/dts/mpc8313erdb.dts
> index d4df8b6..917d466 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -222,7 +222,7 @@
> 			cell-index = <1>;
> 			device_type = "network";
> 			model = "eTSEC";
> -			compatible = "gianfar";
> +			compatible = "gianfar", "simple-bus";
> 			reg = <0x25000 0x1000>;
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> 			interrupts = <34 0x8 33 0x8 32 0x8>;

This isn't correct at all.  Not sure what the panic is but adding  
"simple-bus" isn't correct.

- k
