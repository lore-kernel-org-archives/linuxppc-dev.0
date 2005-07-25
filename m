Return-Path: <ajz@cambridgebroadband.com>
Date: Mon, 25 Jul 2005 14:58:49 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: "KylongMu" <mqy@263.net.cn>
Message-Id: <20050725145849.5caef7a9.ajz@cambridgebroadband.com>
In-Reply-To: <20050725111654.6A5A1C34A8@smtp.263.net>
References: <20050725111654.6A5A1C34A8@smtp.263.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: mpc8540 SK board FEC not work!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I think there are two possibilities:

i)	You are probing the wrong phy address.  Since the MDIO line is pulled high you get a phyID of
0xffffffff.  Try changing the phy address probed.  From the source it looks like this is done in the
BIOS.  If this fails scope the MDIO/MDC bus.

ii)	The phy id has changed between the 88E1101 and the 88E1111.  If this is the case you may get
away with just modifying phy_info_marvell.name and phy_info_marvell.phy_id_mask.  But you may have
to add a new phy_info struct to deal with the new phy if there are any incompatibilities between
the new and old phys, or if the phy_ids differ in more than just their lower bits.


Or maybe both....

Alex


On Mon, 25 Jul 2005 19:16:50 +0800
"KylongMu" <mqy@263.net.cn> wrote:

> Hello, team
>         I'm testing the 2.6.13-rc3 kernel on my board, all is work well
> except
> the FEC.
> Board type:  PQ3SK REVB
> Kernel       :  2.6.13-rc3
> toolchain    : ELDK 3.1.1
> PHY type  : Marvell 88E1111S
> 
>         Compile with "make mpc8540ads_defconfig", change with nothing.
> download uImage file into my board and boot with it, all is ok ! But when
> I config the eth0 , it can't work , same with eth1, both of them are
> Giga-eth,
> but eth2 is work well, and eth2 is a 10/100-eth.
>         I checked the 8540ADS's hardware message , it's use 88E1011 PHY
> not 88E1111 PHY . And I checked the kernel code " driver/net/gianfar_phy.c"
> it takes 88E1011 and 88E1111 as same PHY , so I think this is not a hardware
> problem, and my board work well with a 2.4.18 DEMO kernel.
>         Here is the output message of  2.6.13-rc3 kernel:
> 
> PuffLinux:root$ifconfig eth0 192.168.1.77
> eth0: PHY is Generic MII (ffffffff)
> 
>         If the PHY config is correct it will recognize my PHY ID, but here
> is a
>  wrong ID number ffffffff .
> 
>         Please help me solve this problem!
> 
> Thanks a lot!
> 
>                         KylongMu
> 
> 
> 
> 
