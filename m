Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A43FFDDE43
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 06:37:11 +1000 (EST)
Date: Mon, 14 May 2007 00:36:33 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: joakim.tjernlund@transmode.se
Subject: Re: Fixed  PHY and MPC832x based boards don't work
Message-ID: <20070514003633.6710879e@localhost.localdomain>
In-Reply-To: <1179067171.20638.48.camel@gentoo-jocke.transmode.se>
References: <1179067171.20638.48.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 May 2007 16:39:30 +0200
Joakim Tjernlund wrote:

> Trying to make the Fixed PHY work under my 832x based board on current
> linus tree without success. Earlier kernels with custom PHY code for
> ucc_geth work without any special tricks.
> 
> If I enable the FIXED_MII_100_FDX option I get:
> ls bus/mdio_bus/devices/
> fixed@100:1@ 
> 
> but ucc_geth wants its PHYs under 
> ls -l bus/of_platform/devices/*phy*
> lrwxrwxrwx    1 root     root            0 May 12 17:32
> bus/of_platform/devices/ethernet-p hy.1
> -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.1/
> lrwxrwxrwx    1 root     root            0 May 12 17:32
> bus/of_platform/devices/ethernet-p hy.3
> -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.3/
> lrwxrwxrwx    1 root     root            0 May 12 17:32
> bus/of_platform/devices/fixed-phy. 2
> -> ../../../devices/e0100000.qe/e0102320.mdio/fixed-phy.2/ These are
> 3 PHYs I just added in the DTS tree:
> 
> 		mdio@2320 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <2320 18>;
> 			device_type = "mdio";
> 			compatible = "ucc_geth_phy";
> 
> 			phy1: ethernet-phy@18 {
> 				linux,phandle = <212000>;
> 				reg = <18>; // 24
> 				device_type = "ethernet-phy";
> 				interface = <3>; //ENET_100_MII
> 			};
> 			phy2: fixed-phy@64 {
> 				linux,phandle = <212001>;
> 				reg = <d#100>;
> 				device_type = "ethernet-phy";
> 			};
> 			phy3: ethernet-phy@19 {
> 				linux,phandle = <212002>;
> 				interrupt-parent = <700>;
> 				interrupts = <12 2>;
> 				reg = <19>; // 25
> 				device_type = "ethernet-phy";
> 				interface = <3>; //ENET_100_MII
> 			};
> 		};
> 
> How do I add a fixed PHY so that ucc_geth finds it?
> 
well I guess ucc stuff follows gianfar trend in mdio bus specification for the phy.
So, it would look like %d:%d or something like that.

Can you please dump the whole dts here?
>  Jocke
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
