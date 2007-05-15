Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 7F420DDED0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 21:40:43 +1000 (EST)
Subject: Re: Fixed  PHY and MPC832x based boards don't work
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <1179095103.20638.56.camel@gentoo-jocke.transmode.se>
References: <1179067171.20638.48.camel@gentoo-jocke.transmode.se>
	<20070514003633.6710879e@localhost.localdomain>
	<1179095103.20638.56.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Tue, 15 May 2007 13:40:24 +0200
Message-Id: <1179229224.20638.122.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-14 at 00:25 +0200, Joakim Tjernlund wrote:
> On Mon, 2007-05-14 at 00:36 +0400, Vitaly Bordug wrote:
> > On Sun, 13 May 2007 16:39:30 +0200
> > Joakim Tjernlund wrote:
> > 
> > > Trying to make the Fixed PHY work under my 832x based board on current
> > > linus tree without success. Earlier kernels with custom PHY code for
> > > ucc_geth work without any special tricks.
> > > 
> > > If I enable the FIXED_MII_100_FDX option I get:
> > > ls bus/mdio_bus/devices/
> > > fixed@100:1@ 
> > > 
> > > but ucc_geth wants its PHYs under 
> > > ls -l bus/of_platform/devices/*phy*
> > > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > > bus/of_platform/devices/ethernet-p hy.1
> > > -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.1/
> > > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > > bus/of_platform/devices/ethernet-p hy.3
> > > -> ../../../devices/e0100000.qe/e0102320.mdio/ethernet-phy.3/
> > > lrwxrwxrwx    1 root     root            0 May 12 17:32
> > > bus/of_platform/devices/fixed-phy. 2
> > > -> ../../../devices/e0100000.qe/e0102320.mdio/fixed-phy.2/ These are
> > > 3 PHYs I just added in the DTS tree:
> > > 
> > > 		mdio@2320 {
> > > 			#address-cells = <1>;
> > > 			#size-cells = <0>;
> > > 			reg = <2320 18>;
> > > 			device_type = "mdio";
> > > 			compatible = "ucc_geth_phy";
> > > 
> > > 			phy1: ethernet-phy@18 {
> > > 				linux,phandle = <212000>;
> > > 				reg = <18>; // 24
> > > 				device_type = "ethernet-phy";
> > > 				interface = <3>; //ENET_100_MII
> > > 			};
> > > 			phy2: fixed-phy@64 {
> > > 				linux,phandle = <212001>;
> > > 				reg = <d#100>;
> > > 				device_type = "ethernet-phy";
> > > 			};
> > > 			phy3: ethernet-phy@19 {
> > > 				linux,phandle = <212002>;
> > > 				interrupt-parent = <700>;
> > > 				interrupts = <12 2>;
> > > 				reg = <19>; // 25
> > > 				device_type = "ethernet-phy";
> > > 				interface = <3>; //ENET_100_MII
> > > 			};
> > > 		};
> > > 
> > > How do I add a fixed PHY so that ucc_geth finds it?
> > > 
> > well I guess ucc stuff follows gianfar trend in mdio bus specification for the phy.
> > So, it would look like %d:%d or something like that.
> > 
> > Can you please dump the whole dts here?
> 
> Sure, it look pretty much like the 832x_mds
> phy2 is my experiment to get hold of the fixed phy, but the others should also be converted into a fixed phy. Here goes my DTS:

Ping, any ideas how to make fixed PHY work? 
This is a regression(sort of) compared with 2.6.20. The old PHY impl.
for ucc_geth did accept these PHYs, the Gen PHY driver would just report
a PHY id of ffffffff and move on.

 Jocke

[SNIP DTS]
