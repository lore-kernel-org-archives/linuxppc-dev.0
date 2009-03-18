Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 96B2BDDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 00:21:26 +1100 (EST)
Message-Id: <D688018D-6CE0-4627-B813-FC552B1A6E83@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2 2/2] powerpc/83xx: Move gianfar mdio nodes under the
	ethernet nodes
Date: Wed, 18 Mar 2009 08:21:18 -0500
References: <20090317185902.GB4055@oksana.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 17, 2009, at 1:59 PM, Anton Vorontsov wrote:

> Currently it doesn't matter where the mdio nodes are placed, but with
> power management support (i.e. when sleep = <> properties will take
> effect), mdio nodes placement will become important: mdio controller
> is a part of the ethernet block, so the mdio nodes should be placed
> correctly. Otherwise we may wrongly assume that MDIO controllers are
> available during sleep.
>
> Suggested-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Changes since RFC:
> - Don't use compatible = "simple-bus" for gianfar nodes.
>
> arch/powerpc/boot/dts/mpc8315erdb.dts     |   80 +++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8349emitx.dts    |   69 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8349emitxgp.dts  |   42 ++++++++-------
> arch/powerpc/boot/dts/mpc834x_mds.dts     |   81 +++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8377_mds.dts     |   80 +++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8377_rdb.dts     |   67 ++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8378_mds.dts     |   80 +++++++++++++++ 
> +-------------
> arch/powerpc/boot/dts/mpc8378_rdb.dts     |   69 +++++++++++++ 
> +-----------
> arch/powerpc/boot/dts/mpc8379_mds.dts     |   79 +++++++++++++++ 
> +------------
> arch/powerpc/boot/dts/mpc8379_rdb.dts     |   66 ++++++++++++ 
> +----------
> arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
> arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_mds.c |    1 +
> arch/powerpc/platforms/83xx/mpc837x_rdb.c |    1 +
> 14 files changed, 398 insertions(+), 319 deletions(-)

If we do this we should also fixup all the 85xx & 86xx .dts

> diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/ 
> boot/dts/mpc8315erdb.dts
> index 88d691c..c0d5b34 100644
> --- a/arch/powerpc/boot/dts/mpc8315erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
> @@ -190,66 +190,74 @@
> 			phy_type = "utmi";
> 		};

[snip]

>
> 		enet0: ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> 			cell-index = <0>;
> 			device_type = "network";
> 			model = "eTSEC";
> 			compatible = "gianfar";
> 			reg = <0x24000 0x1000>;
> +			ranges;

Can this be proper?
			ranges = <0x0 0x24520 0x20>;
>
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> 			interrupts = <32 0x8 33 0x8 34 0x8>;
> 			interrupt-parent = <&ipic>;
> 			tbi-handle = <&tbi0>;
> 			phy-handle = < &phy0 >;
> +
> +			mdio@24520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-mdio";
> +				reg = <0x24520 0x20>;

update here for ranges change.

>
> +
> +				phy0: ethernet-phy@0 {
> +					interrupt-parent = <&ipic>;
> +					interrupts = <20 0x8>;
> +					reg = <0x0>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				phy1: ethernet-phy@1 {
> +					interrupt-parent = <&ipic>;
> +					interrupts = <19 0x8>;
> +					reg = <0x1>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				tbi0: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> 		};

- k
