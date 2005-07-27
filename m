Return-Path: <mqy@263.net.cn>
From: "KylongMu" <mqy@263.net.cn>
To: "'Andy Fleming'" <afleming@freescale.com>
Date: Wed, 27 Jul 2005 12:10:33 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <8F2178E8-C29F-412E-9F07-F81F5E40153F@freescale.com>
Message-Id: <20050727041045.34D20C362A@smtp.263.net>
Cc: Linuxppc-embedded@ozlabs.org
Subject: mpc8540 SK board FEC work now! (Thanks for Andy Fleming)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 
Hi Andy:
	Thanks for your help , my board's all eth ports works now ,
according the file you give out:
" arch/ppc/ platforms/85xx/mpc8540_ads.c " , I modified the TSEC ID from 0,1
to 4,5 ,  and modified
the TFEC interrupt source from 5 to 7 , after these modification , my board
can work.

Thanks a lot!

KylongMu

On Jul 26, 2005, at 01:02, KylongMu wrote:
>
> eth0 and eth1 not work, they are giga ethernet , but eth2 work well , 
> I know all of them are drived under same driver " drivers/net/gianfar* 
> ", and I checked the 8540 datasheet , because the MAC is integrated , 
> the only deferent is the PHY , the 2.4.18 kernel come with my board is 
> work well at all eth port , so I'm sure the hardware is OK

On Jul 27, 2005, at 02:26, Andy Fleming wrote:

The manual says the PHY addresses for TSEC 1 and TSEC 2 are:

TSEC1: 4
TSEC2: 5

The 8540 ADS has this configuration:

TSEC1: 0
TSEC2: 1

The correct solution would be to make a new board file for the SK board, and
properly configure everything.  However, if you insist on using the 8540 ADS
config for this, you will need to change arch/ppc/
platforms/85xx/mpc8540_ads.c so that TSEC1 and TSEC2 have their phyid
platform data fields assigned to be:

TSEC1: 4
TSEC2: 5
