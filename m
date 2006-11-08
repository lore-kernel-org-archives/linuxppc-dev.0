Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDA5967D4C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 17:28:35 +1100 (EST)
In-Reply-To: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0611071707520.6936@ld0175-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44B423FD-D411-4C80-A4BC-F74AFC942BFD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Changed gianfar device tree definition to make it more
	flexible
Date: Wed, 8 Nov 2006 00:28:30 -0600
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 27b457c..bb1a402 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1193,6 +1193,7 @@ platforms are moved over to use the flat
>
>      - device_type : Should be "network"
>      - model : Model of the device.  Can be "TSEC", "eTSEC", or "FEC"
> +      (This is deprecated in favor of the feature bits)
>      - compatible : Should be "gianfar"
>      - reg : Offset and length of the register set for the device
>      - mac-address : List of bytes representing the ethernet  
> address of
> @@ -1206,6 +1207,30 @@ platforms are moved over to use the flat
>        services interrupts for this device.
>      - phy-handle : The phandle for the PHY connected to this ethernet
>        controller.
> +    - interface : The interface this ethernet is using.  Current  
> options are:
> +        GMII, MII, RGMII, SGMII, TBI, RMII, and RTBI
> +
> +  Optional properties (features):
> +    - gigabit : Indicates support for 1000 Mbit operation
> +    - coalescing : Indicates support for interrupt coalescing
> +    - rmon : Indicates support for RMON-style counters
> +    - checksumming : Indicates support for hardware TCP/UDP  
> checksumming
> +    - vlan-insertion : Indicates support for hardware vlan header  
> insertion
> +    - extended-hash : Indicates support for using the Individual
> +        Address Hash registers to extend the Group Address Hash  
> registers
> +    - padding : Indicates support for padding between the FCB and
> +        the frame
> +    - filer : Indicates support for the Filer

What exactly does parseL2, L3, L4 actually mean? (what feature is this)

> +    - parseL2 : Indicates support for parsing L2 headers
> +    - parseL3 : Indicates support for parsing L3 headers
> +    - parseL4 : Indicates support for parsing L4 headers
> +    - multi-queue : Indicates support for sending and receiving
> +      into multiple queues
> +

Shouldn't we have a flag for L2 stashing as well? (83xx TSECs don't  
support it since no L2 on the parts :)

>
> +    The "eTSEC" model implements all these features, while the
> +    "TSEC" model implements only the first 3.  The "FEC" has none
> +    of these features.
> +
>
>    Example:
>
> @@ -1213,12 +1238,16 @@ platforms are moved over to use the flat
>  		#size-cells = <0>;
>  		device_type = "network";
>  		model = "TSEC";
> +		gigabit;
> +		coalescing;
> +		rmon;
>  		compatible = "gianfar";
>  		reg = <24000 1000>;
>  		mac-address = [ 00 E0 0C 00 73 00 ];
>  		interrupts = <d 3 e 3 12 3>;
>  		interrupt-parent = <40000>;
>  		phy-handle = <2452000>
> +		interface = "GMII";
>  	};
>
>
> @@ -1238,6 +1267,7 @@ platforms are moved over to use the flat
>      - reg : The ID number for the phy, usually a small integer
>      - linux,phandle :  phandle for this node; likely referenced by an
>        ethernet controller node.
> +    - flags : PHY-specific flags (defined by the device driver)
>
>
>     Example:
> @@ -1246,6 +1276,7 @@ platforms are moved over to use the flat
>  		linux,phandle = <2452000>
>  		interrupt-parent = <40000>;
>  		interrupts = <35 1>;
> +		flags = <0>;
>  		reg = <0>;
>  		device_type = "ethernet-phy";
>  	};
