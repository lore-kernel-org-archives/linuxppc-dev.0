Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC3D3DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:49:03 +1100 (EST)
Message-Id: <C96CE59B-05FA-4728-930F-D4430EFB9B99@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 4/4] powerpc/83xx: Add PCI-E support for all MPC83xx
	boards with PCI-E
Date: Tue, 30 Dec 2008 11:46:50 -0600
References: <20081229164040.GD8215@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Tony Li <tony.li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 29, 2008, at 10:40 AM, Anton Vorontsov wrote:

> diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/ 
> boot/dts/mpc8315erdb.dts
> index d3d3097..5997325 100644
> --- a/arch/powerpc/boot/dts/mpc8315erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
> @@ -22,6 +22,8 @@
> 		serial0 = &serial0;
> 		serial1 = &serial1;
> 		pci0 = &pci0;
> +		pci1 = &pci1;
> +		pci2 = &pci2;
> 	};
>
> 	cpus {
> @@ -330,4 +332,44 @@
> 		compatible = "fsl,mpc8349-pci";
> 		device_type = "pci";
> 	};
> +
> +	pci1: pcie@e0009000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		device_type = "pcie";

should just be pci, not pcie

>
> +		compatible = "fsl,mpc8315-pcie", "fsl,mpc8314-pcie";
> +		reg = <0xe0009000 0x00001000 0xb0000000 0x01000000>;

the size on the 0xb0000000 seems wrong

>
> +		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
> +		bus-range = <0 0>;

normally we have this as <0 255> and assume FW updates it.

>
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0 0 0 1 &ipic 1 8
> +				 0 0 0 2 &ipic 1 8
> +				 0 0 0 3 &ipic 1 8
> +				 0 0 0 4 &ipic 1 8>;
> +		clock-frequency = <0>;
> +		/* cleared by u-boot */
> +		status = "not configured";

for pcie nodes we also include the virtual p2p bridge look at the 85xx  
or 86xx .dts w/pcie in them.

(I'm only commenting on this one, assuming the comments replicate to  
all other nodes)

- k
