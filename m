Return-Path: <iseno@tomen-ele.co.jp>
Received: from tme-gw.tomen-ele.co.jp (tme-gw.tomen-ele.co.jp [202.230.206.90])
	by ozlabs.org (Postfix) with ESMTP id E437C679EF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 17:16:13 +1100 (EST)
Message-ID: <D7E527950707D611B2A20003474C612A0BD92821@tmemail0.tomen-ele.co.jp>
From: iseno@tomen-ele.co.jp
To: edjubenville@adelphia.net, linuxppc-embedded@ozlabs.org
Subject: RE: Where to define IO ports
Date: Tue, 14 Mar 2006 15:01:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ed,

I think you should change the "u-boot".
 - include/configs/IceCube.h
 - board/icecube/icecube.h

1st, put a constant like (CFG_CS1_START, CFG_CS1_STOP, CFG_CS1_CFG) to
IceCube.h.
And then, write some code to configure registers like (MPC5XXX_CS0_START,
MPC5XXX_CS0_STOP, MPC5XXX_CS0_CFG).

After that, you will be able to use ioremap() in your driver.

>We have added a peripheral to the LocalPlus bus, and I'm trying to figure
Is this address kernel space?
If this is so, you have to change "TEXT_BASE" in u-boot's Makefile and etc.

    Akihiro Iseno

=================================
 Akihiro Iseno <iseno@tomen-ele.co.jp>
   　TOMEN Electronics Corp.
      System Engineering Dept. II
=================================

-----Original Message-----
From: Edward Jubenville [mailto:edjubenville@adelphia.net] 
Sent: Tuesday, March 14, 2006 1:41 PM
To: linuxppc-embedded@ozlabs.org
Subject: Where to define IO ports

We are building a board similar to the Freescale Lite5200 (IceCube) board,
using ELDK 3.0 with Linux 2.4.25.

We have added a peripheral to the LocalPlus bus, and I'm trying to figure
out how to modify the kernel startup code to define a memory address range
and generate the proper chip select signal.

Can someone point me to where that sort of thing is done in the kernel
source?

Ed

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
