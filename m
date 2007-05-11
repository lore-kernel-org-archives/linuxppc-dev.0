Return-Path: <vitb@kernel.crashing.org>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39486DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 00:04:18 +1000 (EST)
Date: Fri, 11 May 2007 18:04:12 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: joakim.tjernlund@transmode.se
Subject: Re: Fixed PHY problems
Message-ID: <20070511180412.025aa1ca@vitb.ru.mvista.com>
In-Reply-To: <1178890872.20638.21.camel@gentoo-jocke.transmode.se>
References: <1178818913.20638.5.camel@gentoo-jocke.transmode.se>
	<20070511120704.3e0377b7@localhost.localdomain>
	<1178874287.20638.8.camel@gentoo-jocke.transmode.se>
	<1178890872.20638.21.camel@gentoo-jocke.transmode.se>
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


> hmm, been trying to figure out all day how to make ucc_geth find my
> fixed PHY without success. OF experts, please give me some hints.
> My board is derived from the in tree mpc832x_mds bord and I am trying to
> convert this part:
> 	mdio@2320 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <2320 18>;
> 			device_type = "mdio";
> 			compatible = "ucc_geth_phy";
> 
> 			phy3: ethernet-phy@03 {
> 				interrupt-parent = < &ipic >;
> 				interrupts = <11 8>;
> 				reg = <3>;
> 				device_type = "ethernet-phy";
> 			};
> 			phy4: ethernet-phy@04 {
> 				interrupt-parent = < &ipic >;
> 				interrupts = <12 8>;
> 				reg = <4>;
> 				device_type = "ethernet-phy";
> 			};
> 		};
> into fixed PHYs, how do I do that?

Well, fixed phy didn't made it to have any representation in dts as of now, at least
what I am aware of, and it is just a platform device so far.

Speaking about it, I am recalling long-pending enhancement to unify fixed interface with
bus_id representation in gianfar (that is having numeric bus:device way).

About dts, the only options fixed phy can have, are speed and duplex, it does not trigger irq and
so on, and I see something like 

phy1: fixed-phy@01 {
	reg = <100 1>; /*100Mps, full duplex*/
	device_type = "ethernet-phy";
};

-- 
Sincerely, 
Vitaly
