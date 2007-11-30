Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E74BEDDE0C
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 11:44:31 +1100 (EST)
Message-Id: <3E2C1CAC-3BBE-404F-B678-FE4504C7B45D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1192793930-26039-10-git-send-email-leoli@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH v7 9/9] add MPC837x MDS board default device tree
Date: Thu, 29 Nov 2007 18:44:22 -0600
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
	<1192793930-26039-3-git-send-email-leoli@freescale.com>
	<1192793930-26039-4-git-send-email-leoli@freescale.com>
	<1192793930-26039-5-git-send-email-leoli@freescale.com>
	<1192793930-26039-6-git-send-email-leoli@freescale.com>
	<1192793930-26039-7-git-send-email-leoli@freescale.com>
	<1192793930-26039-8-git-send-email-leoli@freescale.com>
	<1192793930-26039-9-git-send-email-leoli@freescale.com>
	<1192793930-26039-10-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2007, at 6:38 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Updated pci node.
> arch/powerpc/boot/dts/mpc8377_mds.dts |  282 ++++++++++++++++++++++++ 
> +++++++
> arch/powerpc/boot/dts/mpc8378_mds.dts |  264 ++++++++++++++++++++++++ 
> +++++
> arch/powerpc/boot/dts/mpc8379_mds.dts |  300 ++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 846 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
> create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
> create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts

Can you make the following updates:

* Drop serdes and phy-handles
* Update sata nodes:

+	sata@19000 {
+		compatible = "fsl,mpc8315-sata", "fsl,sata-pq2pro;
+		reg = <19000 1000>;
+		interrupts = <2d 8>;
+		interrupt-parent = < &ipic >;
+        };

* Added labels for ethernet (enet), serial, pci

(some examples below):

- k

>
>
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/ 
> boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..4402e39
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -0,0 +1,282 @@
> +/*
> + * MPC8377E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
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
> +/ {
> +	model = "fsl,mpc8377emds";
> +	compatible = "fsl,mpc8377emds","fsl,mpc837xmds";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

[VERIFY THIS -- is copy/pasted from somewhere else]

+       aliases {
+               ethernet0 = "/soc8540@e0000000/ethernet@24000";
+               ethernet1 = "/soc@e0000000/ethernet@25000";
+               ethernet2 = "/soc@e0000000/ethernet@26000";
+               serial0 = "/soc@e0000000/serial@4500";
+               serial1 = "/soc@e0000000/serial@4600";
+               pci0 = "/pci@e0008000";
+       };


> +
> +		enet0: ethernet@24000 {

>
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <24000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <20 8 21 8 22 8>;
> +			phy-connection-type = "mii";
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &phy2 >;
> +		};
> +
> +		enet1: ethernet@25000 {

>
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <25000 1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <23 8 24 8 25 8>;
> +			phy-connection-type = "mii";
> +			interrupt-parent = < &ipic >;
> +			phy-handle = < &phy3 >;
> +		};
> +
> +		serial0: serial@4500 {

>
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <9 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		serial1: serial@4600 {

>
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +


> +	pci0: pci@e0008500 {
> +		interrupt-map-mask = <f800 0 0 7>;
> +		


> device_type = "pci";
> +	};
> +};
