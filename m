Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F54E67A5E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 14:55:26 +1000 (EST)
In-Reply-To: <20060922024827.27185.39986.stgit@localhost.localdomain>
References: <20060922064610.0943f1fc@localhost.localdomain>
	<20060922024827.27185.39986.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DBDA0C60-A5F4-4F8A-BF98-FE232EAAA010@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] POWERPC: Added devicetree for mpc8272ads board
Date: Thu, 21 Sep 2006 23:55:36 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 21, 2006, at 9:48 PM, Vitaly Bordug wrote:

>
> This adds current dts file used with MPC8272ADS,
> introducing new mdio bitbang defines, as well as
> fully-CPM2-SoC board design.
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---
>
>  arch/powerpc/boot/dts/mpc8272ads.dts |  236 +++++++++++++++++++++++ 
> +++++++++++
>  1 files changed, 236 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/ 
> boot/dts/mpc8272ads.dts
> new file mode 100644
> index 0000000..6d72b7d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -0,0 +1,236 @@
> +/*
> + * MPC8272 ADS Device Tree Source
> + *
> + * Copyright 2005 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +
> +/*
> +/memreserve/   00000000 4000000;
> +*/

Is this needed?

> +
> +/ {
> +       model = "MPC8272ADS";
> +       compatible = "MPC8260ADS";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       linux,phandle = <100>;
> +
> +       cpus {
> +               #cpus = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               linux,phandle = <200>;
> +
> +               PowerPC,8272@0 {
> +                       device_type = "cpu";
> +                       reg = <0>;
> +                       d-cache-line-size = <20>;       // 32 bytes
> +                       i-cache-line-size = <20>;       // 32 bytes
> +                       d-cache-size = <4000>;          // L1, 16K
> +                       i-cache-size = <4000>;          // L1, 16K
> +                       timebase-frequency = <17d7840>;
> +                       bus-frequency = <5f5e100>;
> +                       clock-frequency = <17D78400>;

Are the freq's really fixed? if not having these values as 0, maybe  
be better.

> +                       32-bit;
> +                       linux,phandle = <201>;
> +                       linux,boot-cpu;
> +               };
> +       };
> +
> +       interrupt-controller@f8200000 {
> +               linux,phandle = <f8200000>;
> +               #address-cells = <0>;
> +               #interrupt-cells = <2>;
> +               interrupt-controller;
> +               reg = <f8200000 f8200004>;
> +               built-in;
> +               device_type = "pci-pic";
> +       };
> +       memory {
> +               device_type = "memory";
> +               linux,phandle = <300>;
> +               reg = <00000000 4000000 f4500000 00000020>;
> +       };
> +
> +       chosen {
> +               name = "chosen";
> +               bootargs = "root=/dev/nfs rw ip=on";

Seems bad form to put bootargs in the .dts directly like this.

> +               linux,stdout-path = "/dev/ttyCPM0";

I thought this was the 'of' path, not a dev path.

> +               linux,platform = <0>;
> +               interrupt-controller = <10c00>;
> +               linux,phandle = <400>;
> +       };
> +
> +       soc8272@f0000000 {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               #interrupt-cells = <2>;
> +               device_type = "soc";
> +               ranges = < 0 0 2 00000000 f0000000 00053000>;
> +               reg = <f0000000 0>;
> +
> +               mdio@0 {
> +                       device_type = "mdio";
> +                       compatible = "fs_enet";
> +                       reg = <0 0>;
> +                       linux,phandle = <24520>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       ethernet-phy@0 {
> +                               linux,phandle = <2452000>;
> +                               interrupt-parent = <10c00>;
> +                               interrupts = <19 1>;
> +                               reg = <0>;
> +                               bitbang = [ 12 12 13 02 02 01 ];
> +                               device_type = "ethernet-phy";
> +                       };
> +                       ethernet-phy@1 {
> +                               linux,phandle = <2452001>;
> +                               interrupt-parent = <10c00>;
> +                               interrupts = <19 1>;
> +                               bitbang = [ 12 12 13 02 02 01 ];
> +                               reg = <3>;
> +                               device_type = "ethernet-phy";
> +                       };
> +               };
> +
> +               ethernet@24000 {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       device_type = "network";
> +                       device-id = <2>;
> +                       compatible = "fs_enet";
> +                       model = "FCC";
> +                       reg = <11300 20 8400 100 11380 30>;
> +                       mac-address = [ 00 11 2F 99 43 54 ];
> +                       interrupts = <20 2>;
> +                       interrupt-parent = <10c00>;
> +                       phy-handle = <2452000>;
> +                       rx-clock = <13>;
> +                       tx-clock = <12>;
> +               };
> +
> +               ethernet@25000 {
> +                       device_type = "network";
> +                       device-id = <3>;
> +                       compatible = "fs_enet";
> +                       model = "FCC";
> +                       reg = <11320 20 8500 100 113b0 30>;
> +                       mac-address = [ 00 11 2F 99 44 54 ];
> +                       interrupts = <21 2>;
> +                       interrupt-parent = <10c00>;
> +                       phy-handle = <2452001>;
> +                       rx-clock = <17>;
> +                       tx-clock = <18>;
> +               };
> +
> +               cpm@f0000000 {
> +                       linux,phandle = <f0000000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       #interrupt-cells = <2>;
> +                       device_type = "cpm";
> +                       model = "CPM2";
> +                       ranges = <00000000 00000000 3ffff>;
> +                       reg = <10d80 3280>;
> +                       command-proc = <119c0>;
> +                       brg-frequency = <17D7840>;
> +                       cpm_clk = <BEBC200>;
> +
> +                       scc@11a00 {
> +                               device_type = "serial";
> +                               compatible = "cpm_uart";
> +                               model = "SCC";
> +                               device-id = <2>;
> +                               reg = <11a00 20 8000 100>;
> +                               current-speed = <1c200>;
> +                               interrupts = <28 2>;
> +                               interrupt-parent = <10c00>;
> +                               clock-setup = <0 00ffffff>;
> +                               rx-clock = <1>;
> +                               tx-clock = <1>;
> +                       };
> +
> +                       scc@11a60 {
> +                               device_type = "serial";
> +                               compatible = "cpm_uart";
> +                               model = "SCC";
> +                               device-id = <5>;
> +                               reg = <11a60 20 8300 100>;
> +                               current-speed = <1c200>;
> +                               interrupts = <2b 2>;
> +                               interrupt-parent = <10c00>;
> +                               clock-setup = <1b ffffff00>;
> +                               rx-clock = <4>;
> +                               tx-clock = <4>;
> +                       };
> +
> +               };
> +               interrupt-controller@10c00 {
> +                       linux,phandle = <10c00>;
> +                       #address-cells = <0>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       reg = <10c00 80>;
> +                       built-in;
> +                       device_type = "cpm-pic";
> +               };

Do we need to distinguish cpm2-pic from cpm-pic (8xx)?

> +               pci@0500 {
> +                       linux,phandle = <0500>;
> +                       #interrupt-cells = <1>;
> +                       #size-cells = <2>;
> +                       #address-cells = <3>;
> +                       compatible = "8272";
> +                       device_type = "pci";
> +                       reg = <10430 4dc>;
> +                       clock-frequency = <3f940aa>;
> +                       interrupt-map-mask = <f800 0 0 7>;
> +                       interrupt-map = <
> +
> +                                       /* IDSEL 0x16 */
> +                                        b000 0 0 1 f8200000 40 0
> +                                        b000 0 0 2 f8200000 41 0
> +                                        b000 0 0 3 f8200000 42 0
> +                                        b000 0 0 4 f8200000 43 0
> +
> +                                       /* IDSEL 0x17 */
> +                                        b800 0 0 1 f8200000 43 0
> +                                        b800 0 0 2 f8200000 40 0
> +                                        b800 0 0 3 f8200000 41 0
> +                                        b800 0 0 4 f8200000 42 0
> +
> +                                       /* IDSEL 0x18 */
> +                                        c000 0 0 1 f8200000 42 0
> +                                        c000 0 0 2 f8200000 43 0
> +                                        c000 0 0 3 f8200000 40 0
> +                                        c000 0 0 4 f8200000 41 0>;
> +                       interrupt-parent = <10c00>;
> +                       interrupts = <14 3>;
> +                       bus-range = <0 0>;
> +                       ranges = <02000000 0 80000000 80000000 0  
> 40000000
> +                                 01000000 0 00000000 f6000000 0  
> 02000000>;
> +               };
> +
> +/* May need to remove if on a part without crypto engine */
> +               crypto@30000 {
> +                       device_type = "crypto";
> +                       model = "SEC2";
> +                       compatible = "talitos";
> +                       reg = <30000 10000>;
> +                       interrupts = <b 0>;
> +                       interrupt-parent = <10c00>;
> +                       num-channels = <4>;
> +                       channel-fifo-len = <18>;
> +                       exec-units-mask = <0000007e>;
> +/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
> +                       descriptor-types-mask = <01010ebf>;
> +               };
> +
> +       };
> +};
