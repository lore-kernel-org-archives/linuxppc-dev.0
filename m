Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0EDBADDE46
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 03:57:08 +1000 (EST)
Message-ID: <47067ADE.9060306@ru.mvista.com>
Date: Fri, 05 Oct 2007 21:56:46 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
In-Reply-To: <20071005174642.GB32145@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Anton Vorontsov wrote:

> Commit 5bece127f0666996ca90772229e00332a34e516c tried to fix
> PCI/PCIe nodes, but actually it broke them even harder. ;-)

    Of course. But shouldn't those be the subnoses of the "soc" type node?
I don't suppose the PCI controllers could hang off the root node... :-/

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
> index b4aa5e7..5439437 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -410,7 +410,7 @@
>  
>  	};
>  
> -	pci@8000 {
> +	pci@e0008000 {
>  		interrupt-map-mask = <f800 0 0 7>;
>  		interrupt-map = <
>  			/* IDSEL 0x12 AD18 */
> @@ -434,13 +434,13 @@
>  		#interrupt-cells = <1>;
>  		#size-cells = <2>;
>  		#address-cells = <3>;
> -		reg = <8000 1000>;
> +		reg = <e0008000 1000>;
>  		compatible = "fsl,mpc8540-pci";
>  		device_type = "pci";
>  	};
>  
>  	/* PCI Express */
> -	pcie@a000 {
> +	pcie@e000a000 {
>  		interrupt-map-mask = <f800 0 0 7>;
>  		interrupt-map = <
>  
> @@ -459,7 +459,7 @@
>  		#interrupt-cells = <1>;
>  		#size-cells = <2>;
>  		#address-cells = <3>;
> -		reg = <a000 1000>;
> +		reg = <e000a000 1000>;
>  		compatible = "fsl,mpc8548-pcie";
>  		device_type = "pci";
>  		pcie@0 {

WBR, Sergei
