Return-Path: <ggvozden@pppoe.ca>
Message-ID: <002901c694d9$36c23870$6402a8c0@MASTER>
From: "GORAN GVOZDENOVIC" <ggvozden@pppoe.ca>
To: <grave@ipno.in2p3.fr>, <linuxppc-embedded@ozlabs.org>,
	"ppc dev" <linuxppc-dev@ozlabs.org>
References: <1150785936.17197.9.camel@ipnnarval>
Subject: Re: Gb Ethernet on xilinx gemac IP
Date: Tue, 20 Jun 2006 22:20:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Xavier,

Just wrapped up efforts to experiment with hard TEMAC support in 2.4 kernel 
( previev kit from Montavista ). DENX 2.4  distro should not be different.

Here are my experience with ML403 board:

Configure kernel for only eth driver offered for ML300 / ML403 ( soft EMAC - 
10/100Mb on-chip eth ). After updating kernel tree with the BSP using xilinx 
patch script for ML403, hard TEMAC driver will end up in 
/drivers/net/xilinx_gige ( supported soft MAC driver ends up in 
/drivers/net/xilinx_enet ).

>From here 2 options:
a) rename xilinx_gige folder to xilinx_enet and build kernel
b) modify config.in script for kernel network configuration and makefile for 
building net driver by addidng new GIGE option

>From my undersanding part of driver code for gige ( adapter.c ) is PHY 
specific and supports Marvel's PHY on ML403 board. Never looked more what it 
does ( phy interface should be common to all PHYs ? ) but if you use 
different PHY maybe you'll have to do some coding here ?!
( look for the comments in the driver )

Oh yes, my tree was missing gmii.h file ( found it throuh google - don't 
remember from where - first google hit :) !

Did some test measurement and comparison with soft EMAC against  hard TEMAC 
+ PLB TEMAC and defualt SG DMA mode (3):
Amazing performance increase: close to 100% on tcp ( netperf and netio shows 
over 11000KB/s for max packet size of 32K on 100Mb link )

Hope this helps !

Goran,
Waterloo,Canada


----- Original Message ----- 
From: "Xavier Grave" <grave@ipno.in2p3.fr>
To: <linuxppc-embedded@ozlabs.org>; "ppc dev" <linuxppc-dev@ozlabs.org>
Sent: Tuesday, June 20, 2006 2:45 AM
Subject: Gb Ethernet on xilinx gemac IP


> Hi,
>
> I'm currently running linux with 10/100 MBits xilinx ethernet driver. I
> have a memec 2VP20 evaluation board.
> We have bought a PCOM2 module in order to have a Gb PHY. I have
> implemented an hardware to handle it but whatever linux version I take
> (2.4 from denx web site, 2.6.17 from kernel.org), I can't configure a Gb
> ethernet driver. And the 10/100 driver don't configure my Gb PHY...
>
> I have compiled my linux kernel based on the ml300 configuration default
> config.
>
> Does anyone has an idea ?
>
> Thanks, xavier
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded 
