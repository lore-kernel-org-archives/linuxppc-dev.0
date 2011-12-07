Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0CB5A1007D5
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Dec 2011 18:34:45 +1100 (EST)
Message-ID: <1323243268.660.71.camel@pasglop>
Subject: Re: [PATCH net-next v6 4/4] powerpc: tqm8548/tqm8xx: add and update
 CAN device nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Date: Wed, 07 Dec 2011 18:34:28 +1100
In-Reply-To: <1322732481-2255-5-git-send-email-wg@grandegger.com>
References: <1322732481-2255-1-git-send-email-wg@grandegger.com>
 <1322732481-2255-5-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org, socketcan-users@lists.berlios.de,
 linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 10:41 +0100, Wolfgang Grandegger wrote:
> This patch enables or updates support for the CC770 and AN82527
> CAN controller on the TQM8548 and TQM8xx boards.

I'm a bit confused by the net-next prefix here. Those patches seem to
be only touching arch/powerpc and seem to be sent primarily toward
netdev with a net-next prefix.

Also there have been at least 3 versions in a couple of days already
without comments nor indication of what was changed...

Can you clarify things a bit please ? It looks like they really should
go to linuxppc-dev (and you can probably drop a bunch of other lists) or
am I missing an important piece of the puzzle ? (Such as patch 1/4 and
2/4 ...)

Let me know if I should just remove them from powerpc patchwork.

Cheers,
Ben.

> CC: devicetree-discuss@lists.ozlabs.org
> CC: linuxppc-dev@ozlabs.org
> CC: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
>  arch/powerpc/boot/dts/tqm8548-bigflash.dts |   19 ++++++++++++++-----
>  arch/powerpc/boot/dts/tqm8548.dts          |   19 ++++++++++++++-----
>  arch/powerpc/boot/dts/tqm8xx.dts           |   25 +++++++++++++++++++++++++
>  3 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> index 9452c3c..d918752 100644
> --- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> +++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
> @@ -352,7 +352,7 @@
>  		ranges = <
>  			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
>  			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
> -			2 0x0 0xa3000000 0x00008000	// CAN (2 x i82527)
> +			2 0x0 0xa3000000 0x00008000	// CAN (2 x CC770)
>  			3 0x0 0xa3010000 0x00008000	// NAND FLASH
>  
>  		>;
> @@ -393,18 +393,27 @@
>  		};
>  
>  		/* Note: CAN support needs be enabled in U-Boot */
> -		can0@2,0 {
> -			compatible = "intel,82527"; // Bosch CC770
> +		can@2,0 {
> +			compatible = "bosch,cc770"; // Bosch CC770
>  			reg = <2 0x0 0x100>;
>  			interrupts = <4 1>;
>  			interrupt-parent = <&mpic>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
> +			bosch,clock-out-frequency = <16000000>;
>  		};
>  
> -		can1@2,100 {
> -			compatible = "intel,82527"; // Bosch CC770
> +		can@2,100 {
> +			compatible = "bosch,cc770"; // Bosch CC770
>  			reg = <2 0x100 0x100>;
>  			interrupts = <4 1>;
>  			interrupt-parent = <&mpic>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
>  		};
>  
>  		/* Note: NAND support needs to be enabled in U-Boot */
> diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
> index 619776f..988d887 100644
> --- a/arch/powerpc/boot/dts/tqm8548.dts
> +++ b/arch/powerpc/boot/dts/tqm8548.dts
> @@ -352,7 +352,7 @@
>  		ranges = <
>  			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
>  			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
> -			2 0x0 0xe3000000 0x00008000	// CAN (2 x i82527)
> +			2 0x0 0xe3000000 0x00008000	// CAN (2 x CC770)
>  			3 0x0 0xe3010000 0x00008000	// NAND FLASH
>  
>  		>;
> @@ -393,18 +393,27 @@
>  		};
>  
>  		/* Note: CAN support needs be enabled in U-Boot */
> -		can0@2,0 {
> -			compatible = "intel,82527"; // Bosch CC770
> +		can@2,0 {
> +			compatible = "bosch,cc770"; // Bosch CC770
>  			reg = <2 0x0 0x100>;
>  			interrupts = <4 1>;
>  			interrupt-parent = <&mpic>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
> +			bosch,clock-out-frequency = <16000000>;
>  		};
>  
> -		can1@2,100 {
> -			compatible = "intel,82527"; // Bosch CC770
> +		can@2,100 {
> +			compatible = "bosch,cc770"; // Bosch CC770
>  			reg = <2 0x100 0x100>;
>  			interrupts = <4 1>;
>  			interrupt-parent = <&mpic>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
>  		};
>  
>  		/* Note: NAND support needs to be enabled in U-Boot */
> diff --git a/arch/powerpc/boot/dts/tqm8xx.dts b/arch/powerpc/boot/dts/tqm8xx.dts
> index f6da7ec..c3dba25 100644
> --- a/arch/powerpc/boot/dts/tqm8xx.dts
> +++ b/arch/powerpc/boot/dts/tqm8xx.dts
> @@ -57,6 +57,7 @@
>  
>  		ranges = <
>  			0x0 0x0 0x40000000 0x800000
> +			0x3 0x0 0xc0000000 0x200
>  		>;
>  
>  		flash@0,0 {
> @@ -67,6 +68,30 @@
>  			bank-width = <4>;
>  			device-width = <2>;
>  		};
> +
> +		/* Note: CAN support needs be enabled in U-Boot */
> +		can@3,0 {
> +			compatible = "intc,82527";
> +			reg = <3 0x0 0x80>;
> +			interrupts = <8 1>;
> +			interrupt-parent = <&PIC>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
> +			bosch,clock-out-frequency = <16000000>;
> +		};
> +
> +		can@3,100 {
> +			compatible = "intc,82527";
> +			reg = <3 0x100 0x80>;
> +			interrupts = <8 1>;
> +			interrupt-parent = <&PIC>;
> +			bosch,external-clock-frequency = <16000000>;
> +			bosch,disconnect-rx1-input;
> +			bosch,disconnect-tx1-output;
> +			bosch,iso-low-speed-mux;
> +		};
>  	};
>  
>  	soc@fff00000 {
