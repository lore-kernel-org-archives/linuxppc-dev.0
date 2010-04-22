Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C43F7B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 03:11:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3MHBepe026269 for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 10:11:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3MHKxfZ018773
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Apr 2010 12:20:59 -0500 (CDT)
Message-ID: <4BD0834A.3020508@freescale.com>
Date: Thu, 22 Apr 2010 12:11:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Peter Pan <pppeterpppan@gmail.com>
Subject: Re: How to support scc-enet on MPC8247 in Linux 2.6.32.6
References: <q2g48abf2c21004212341oe37ed471g63c646ae12914ab3@mail.gmail.com>
In-Reply-To: <q2g48abf2c21004212341oe37ed471g63c646ae12914ab3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Pan wrote:
> I'm porting Linux 2.6.32.6 to our MPC8247 based board. We use SCC3 and
> SCC4 as ethernet port. These two ports are connect with LXT905 PHY
> chip.
> I'm now using fs_enet driver, how should I config the scc port in dtc
> file. I copied from mgcoge.dts file, and my dtc file of scc enet is
> follows:
> 
>             eth2: ethernet@11a40 {
>                 device_type = "network";
>                 compatible = "fsl,mpc8247-scc-enet",
>                              "fsl,cpm2-scc-enet";
>                 reg = <0x11a40 0x20 0x8200 0x100 0x11390 0x1>;
>                 local-mac-address = [ 00 00 00 00 00 00 ]; /* filled
> by U-Boot */
>                 interrupts = <42 8>;
>                 interrupt-parent = <&PIC>;
>                 linux,network-index = <0x2>;
>                 fsl,cpm-command = <0x8c00000>;
>                 fixed-link = < 0 0 10 0 0 >;
>             };
> But i does not working. Linux says that PHY 0:00 is not found. I dive
> into the code, and that's according to the fixed-link property.
> I'm wondering how to support scc-enet in my situation.

Do you really want fixed-link, or does the board have a working MDIO 
interface?  If the latter, you need a phy-handle property instead, 
pointing to a PHY node under an MDIO bus node that represents how MDIO 
is wired on your board.

-Scott
