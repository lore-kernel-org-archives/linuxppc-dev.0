Return-Path: <afleming@freescale.com>
In-Reply-To: <20050726060304.AF08EC372E@smtp.263.net>
References: <20050726060304.AF08EC372E@smtp.263.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8F2178E8-C29F-412E-9F07-F81F5E40153F@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 26 Jul 2005 13:26:19 -0500
To: KylongMu <mqy@263.net.cn>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: mpc8540 SK board FEC not work! (second message)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 26, 2005, at 01:02, KylongMu wrote:
>
> eth0 and eth1 not work, they are giga ethernet , but eth2 work  
> well , I know
> all of them are drived under same driver " drivers/net/gianfar* ",
> and I checked the 8540 datasheet , because the MAC is integrated ,  
> the only
> deferent is the PHY , the 2.4.18 kernel come with my board
> is work well at all eth port , so I'm sure the hardware is OK

The manual says the PHY addresses for TSEC 1 and TSEC 2 are:

TSEC1: 4
TSEC2: 5

The 8540 ADS has this configuration:

TSEC1: 0
TSEC2: 1

The correct solution would be to make a new board file for the SK  
board, and properly configure everything.  However, if you insist on  
using the 8540 ADS config for this, you will need to change arch/ppc/ 
platforms/85xx/mpc8540_ads.c so that TSEC1 and TSEC2 have their phyid  
platform data fields assigned to be:

TSEC1: 4
TSEC2: 5
