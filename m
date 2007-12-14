Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DEE3DDF2B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:07:59 +1100 (EST)
Message-Id: <4373ED4B-5EDD-4725-9D99-BE39B0656E19@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <1196716685975-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] ucc_geth: use rx-clock-name and tx-clock-name device
	tree properties
Date: Thu, 13 Dec 2007 23:07:43 -0600
References: <11967166791607-git-send-email-timur@freescale.com>
	<1196716680381-git-send-email-timur@freescale.com>
	<1196716685975-git-send-email-timur@freescale.com>
Cc: netdev@vger.kernel.org, Timur Tabi <timur@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 3, 2007, at 3:17 PM, Timur Tabi wrote:

> Updates the ucc_geth device driver to check the new rx-clock-name and
> tx-clock-name properties first.  If present, it uses the new function
> qe_clock_source() to obtain the clock source.  Otherwise, it checks  
> the
> deprecated rx-clock and tx-clock properties.
>
> Update the device trees for 832x, 836x, and 8568 to contain the new  
> property
> names only.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This patch applies to Kumar's for-2.6.25 branch.  ucc_geth will  
> compile but not
> run if my other patch, "qe: add function qe_clock_source" has not  
> also been
> applied.

Jeff, I'll take this patch via powerpc.git if you don't have any issue  
since its just touching probe/setup bits.

- k

> arch/powerpc/boot/dts/mpc832x_mds.dts |    8 ++--
> arch/powerpc/boot/dts/mpc832x_rdb.dts |    8 ++--
> arch/powerpc/boot/dts/mpc836x_mds.dts |    8 ++--
> arch/powerpc/boot/dts/mpc8568mds.dts  |    8 ++--
> drivers/net/ucc_geth.c                |   55 ++++++++++++++++++++++++ 
> ++++++--
> 5 files changed, 67 insertions(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/ 
> boot/dts/mpc832x_mds.dts
> index c64f303..fe54489 100644
> --- a/arch/powerpc/boot/dts/mpc832x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
> @@ -223,8 +223,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <19>;
> -			tx-clock = <1a>;
> +			rx-clock-name = "clk9";
> +			tx-clock-name = "clk10";
> 			phy-handle = < &phy3 >;
> 			pio-handle = < &pio3 >;
> 		};
> @@ -244,8 +244,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <17>;
> -			tx-clock = <18>;
> +			rx-clock-name = "clk7";
> +			tx-clock-name = "clk8";
> 			phy-handle = < &phy4 >;
> 			pio-handle = < &pio4 >;
> 		};
> diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/ 
> boot/dts/mpc832x_rdb.dts
> index 388c8a7..e68a08b 100644
> --- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
> @@ -202,8 +202,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <20>;
> -			tx-clock = <13>;
> +			rx-clock-name = "clk16";
> +			tx-clock-name = "clk3";
> 			phy-handle = <&phy00>;
> 			pio-handle = <&ucc2pio>;
> 		};
> @@ -223,8 +223,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <19>;
> -			tx-clock = <1a>;
> +			rx-clock-name = "clk9";
> +			tx-clock-name = "clk10";
> 			phy-handle = <&phy04>;
> 			pio-handle = <&ucc3pio>;
> 		};
> diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/ 
> boot/dts/mpc836x_mds.dts
> index 0b2d2b5..bfd48d0 100644
> --- a/arch/powerpc/boot/dts/mpc836x_mds.dts
> +++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
> @@ -254,8 +254,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <0>;
> -			tx-clock = <19>;
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk9";
> 			phy-handle = < &phy0 >;
> 			phy-connection-type = "rgmii-id";
> 			pio-handle = < &pio1 >;
> @@ -276,8 +276,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <0>;
> -			tx-clock = <14>;
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk4";
> 			phy-handle = < &phy1 >;
> 			phy-connection-type = "rgmii-id";
> 			pio-handle = < &pio2 >;
> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/ 
> boot/dts/mpc8568mds.dts
> index 5439437..cf45aab 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -333,8 +333,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <0>;
> -			tx-clock = <20>;
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> 			pio-handle = <&pio1>;
> 			phy-handle = <&phy0>;
> 			phy-connection-type = "rgmii-id";
> @@ -355,8 +355,8 @@
> 			 */
> 			mac-address = [ 00 00 00 00 00 00 ];
> 			local-mac-address = [ 00 00 00 00 00 00 ];
> -			rx-clock = <0>;
> -			tx-clock = <20>;
> +			rx-clock-name = "none";
> +			tx-clock-name = "clk16";
> 			pio-handle = <&pio2>;
> 			phy-handle = <&phy1>;
> 			phy-connection-type = "rgmii-id";
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
> index a3ff270..a93342e 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -3814,6 +3814,7 @@ static int ucc_geth_probe(struct of_device*  
> ofdev, const struct of_device_id *ma
> 	int err, ucc_num, max_speed = 0;
> 	const phandle *ph;
> 	const unsigned int *prop;
> +	const char *sprop;
> 	const void *mac_addr;
> 	phy_interface_t phy_interface;
> 	static const int enet_to_speed[] = {
> @@ -3846,10 +3847,56 @@ static int ucc_geth_probe(struct of_device*  
> ofdev, const struct of_device_id *ma
>
> 	ug_info->uf_info.ucc_num = ucc_num;
>
> -	prop = of_get_property(np, "rx-clock", NULL);
> -	ug_info->uf_info.rx_clock = *prop;
> -	prop = of_get_property(np, "tx-clock", NULL);
> -	ug_info->uf_info.tx_clock = *prop;
> +	sprop = of_get_property(np, "rx-clock-name", NULL);
> +	if (sprop) {
> +		ug_info->uf_info.rx_clock = qe_clock_source(sprop);
> +		if ((ug_info->uf_info.rx_clock < QE_CLK_NONE) ||
> +		    (ug_info->uf_info.rx_clock > QE_CLK24)) {
> +			printk(KERN_ERR
> +				"ucc_geth: invalid rx-clock-name property\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		prop = of_get_property(np, "rx-clock", NULL);
> +		if (!prop) {
> +			/* If both rx-clock-name and rx-clock are missing,
> +			   we want to tell people to use rx-clock-name. */
> +			printk(KERN_ERR
> +				"ucc_geth: missing rx-clock-name property\n");
> +			return -EINVAL;
> +		}
> +		if ((*prop < QE_CLK_NONE) || (*prop > QE_CLK24)) {
> +			printk(KERN_ERR
> +				"ucc_geth: invalid rx-clock propperty\n");
> +			return -EINVAL;
> +		}
> +		ug_info->uf_info.rx_clock = *prop;
> +	}
> +
> +	sprop = of_get_property(np, "tx-clock-name", NULL);
> +	if (sprop) {
> +		ug_info->uf_info.tx_clock = qe_clock_source(sprop);
> +		if ((ug_info->uf_info.tx_clock < QE_CLK_NONE) ||
> +		    (ug_info->uf_info.tx_clock > QE_CLK24)) {
> +			printk(KERN_ERR
> +				"ucc_geth: invalid tx-clock-name property\n");
> +			return -EINVAL;
> +		}
> +	} else {
> +		prop = of_get_property(np, "rx-clock", NULL);
> +		if (!prop) {
> +			printk(KERN_ERR
> +				"ucc_geth: mising tx-clock-name property\n");
> +			return -EINVAL;
> +		}
> +		if ((*prop < QE_CLK_NONE) || (*prop > QE_CLK24)) {
> +			printk(KERN_ERR
> +				"ucc_geth: invalid tx-clock property\n");
> +			return -EINVAL;
> +		}
> +		ug_info->uf_info.tx_clock = *prop;
> +	}
> +
> 	err = of_address_to_resource(np, 0, &res);
> 	if (err)
> 		return -EINVAL;
> -- 
> 1.5.2.4
