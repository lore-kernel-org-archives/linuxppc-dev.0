Return-Path: <afleming@freescale.com>
In-Reply-To: <20050725111654.6A5A1C34A8@smtp.263.net>
References: <20050725111654.6A5A1C34A8@smtp.263.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE9E399A-D3DF-4875-AB59-A3D4633184CC@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 25 Jul 2005 15:40:24 -0500
To: KylongMu <mqy@263.net.cn>
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


On Jul 25, 2005, at 06:16, KylongMu wrote:

> Hello, team
>         I'm testing the 2.6.13-rc3 kernel on my board, all is work  
> well except
> the FEC.
> Board type:  PQ3SK REVB
> Kernel       :  2.6.13-rc3
> toolchain    : ELDK 3.1.1
> PHY type  : Marvell 88E1111S

I'm not familiar with the PQ3SK.  Who makes this board?

>
>         Compile with "make mpc8540ads_defconfig", change with nothing.
> download uImage file into my board and boot with it, all is ok !  
> But when
> I config the eth0 , it can't work , same with eth1, both of them  
> are Giga-eth,
> but eth2 is work well, and eth2 is a 10/100-eth.

Now I'm a little confused.  You are building the 8540 ADS config for  
your different board?  That sounds dangerous.  Also, I'm confused  
because your first paragraph implies that everything works except  
FEC, while this paragraph implies that nothing works except for the  
FEC (FEC is eth2).


>         I checked the 8540ADS's hardware message , it's use 88E1011  
> PHY
> not 88E1111 PHY . And I checked the kernel code " driver/net/ 
> gianfar_phy.c"
> it takes 88E1011 and 88E1111 as same PHY , so I think this is not a  
> hardware
> problem, and my board work well with a 2.4.18 DEMO kernel.
>         Here is the output message of  2.6.13-rc3 kernel:
>
> PuffLinux:root$ifconfig eth0 192.168.1.77
> eth0: PHY is Generic MII (ffffffff)

This message means that there was an error reading the PHY identifier  
from the PHY.  Either (as Alex said) you have the wrong PHY address  
(this is specified in board files), or there is a problem with your  
PHY bus.  The ADS boards required a jumper hat to be on the PHY  
configuration pins to configure the address of the Marvell PHYs.   
Perhaps your board is similar.  However, I suspect two things:

1) Your board sets the Marvell PHYs to different PHY addresses than  
the 8540 ADS board.  Check with your hardware engineers.

2) The Marvell 88E1111 probably requires the same workaround as the  
88E1011 after a reset, and a reset occurs.  This means that the PHY  
code needs to detect the 88E1111 as a Marvell PHY, so fixing #1  
should solve this problem.




Andy Fleming
Open Source Team
Freescale Semiconductor, Inc
