Return-Path: <sr@denx.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Add AMCC Arches DTS
Date: Fri, 18 Jul 2008 16:24:10 +0200
References: <1216186476-28018-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1216186476-28018-1-git-send-email-fkan@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807181624.10338.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallard@amcc.com>, fkan@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 16 July 2008, fkan@amcc.com wrote:
> From: Victor Gallardo <vgallard@amcc.com>
>
> ppc4xx: Add AMCC Arches DTS
>
> Signed-off-by: Victor Gallardo <vgallard@amcc.com>
> ---
>  arch/powerpc/boot/dts/arches.dts |  522
> ++++++++++++++++++++++++++++++++++++++ 1 files changed, 522 insertions(+),
> 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/arches.dts
>
> diff --git a/arch/powerpc/boot/dts/arches.dts

<snip>

> +				nor_flash@0,0 {
> +					compatible = "amd,s29gl256n", "cfi-flash";

So its a S29GL256 with 32MBytes...

> +					bank-width = <2>;
> +					reg = <0 000000 4000000>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					partition@0 {
> +						label = "kernel";
> +						reg = <0 1e0000>;
> +					};
> +					partition@1e0000 {
> +						label = "dtb";
> +						reg = <1e0000 20000>;
> +					};
> +					partition@200000 {
> +						label = "ramdisk";
> +						reg = <200000 1400000>;
> +					};
> +					partition@1600000 {
> +						label = "jffs2";
> +						reg = <1600000 400000>;
> +					};
> +					partition@1a00000 {
> +						label = "user";
> +						reg = <1a00000 2560000>;
> +					};
> +					partition@3f60000 {
> +						label = "env";
> +						reg = <3f60000 40000>;
> +					};
> +					partition@3fa0000 {
> +						label = "u-boot";
> +						reg = <3fa0000 60000>;
> +					};

... and this partition scheme is for 64MByte.

<snip>

> +			EMAC0: ethernet@ef600e00 {
> +				device_type = "network";
> +				compatible = "ibm,emac-460gt", "ibm,emac4";

That's not correct anymore. A recent patch from Grant Erickson [ibm_newemac: 
Parameterize EMAC Multicast Match Handling] changed these compatible entries. 
You should use "ibm_emac4sync" here now.

> +				interrupt-parent = <&EMAC0>;
> +				interrupts = <0 1>;
> +				#interrupt-cells = <1>;
> +				#address-cells = <0>;
> +				#size-cells = <0>;
> +				interrupt-map = </*Status*/ 0 &UIC2 10 4
> +						 /*Wake*/   1 &UIC2 14 4>;
> +				reg = <ef600e00 70>;

The patch mentioned above also cfixed the incorrect size here. Please fix this 
too.

> +				local-mac-address = [000000000000]; /* Filled in by U-Boot */
> +				mal-device = <&MAL0>;
> +				mal-tx-channel = <0>;
> +				mal-rx-channel = <0>;
> +				cell-index = <0>;
> +				max-frame-size = <2328>;
> +				rx-fifo-size = <1000>;
> +				tx-fifo-size = <800>;
> +				phy-mode = "rgmii";

SGMII, right?

> +				phy-map = <00000000>;
> +				rgmii-device = <&RGMII0>;
> +				rgmii-channel = <0>;
> +				tah-device = <&TAH0>;
> +				tah-channel = <0>;
> +				has-inverted-stacr-oc;
> +				has-new-stacr-staopc;
> +			};

All EMAC related comment above are valid for all EMAC nodes of course.

Best regards,
Stefan
