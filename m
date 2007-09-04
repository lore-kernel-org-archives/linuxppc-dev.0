Return-Path: <Alan.Bennett@miltope.com>
Received: from milsmtp01.Miltope.local (smtp.miltope.com [70.150.153.172])
	by ozlabs.org (Postfix) with ESMTP id 18588DDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 03:24:14 +1000 (EST)
Received: from milsmtp01.Miltope.local (127.0.0.1) by milsmtp01.Miltope.local
	(MlfMTA v3.2r9) id hrmac40171s5 for <linuxppc-embedded@ozlabs.org>;
	Tue, 4 Sep 2007 12:09:10 -0500 (envelope-from
	<Alan.Bennett@miltope.com>)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Flash on ep8248e standard motherboards
Date: Tue, 4 Sep 2007 11:09:42 -0600
Message-ID: <959DA007E34BCC4A8364734BAA08D7561B4472@BoulderEX01.Miltope.local>
In-Reply-To: <46DD65BF.5090304@kip.uni-heidelberg.de>
From: "Bennett, Alan" <Alan.Bennett@miltope.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello;
We have a custom board based on the ep8248e design from Embedded Planet
and I'm trying to use something other than codewarrior to flash u-boot
srec's=20

I'm not sure where the problem is, but I'm unable to flash the
u-boot.srec onto the Embedded Planet board (using the BDI2000), let
alone our custom board.
   1. Embedded Planet ep8248E
        64 MB SDRAM
        64 MB Flash (x2 Am29LV256M)
   2. Custom
       128 MB SDRAM
       128 MB Flash (X2 Spansion S29GL512N)

NOTE: CW successfully flashes both parts, but then again, it's CW.


BDI 2000 Config File:
  ;  initialize - FLASH BR0 & OR0 (64 Mbyte)
  ;*******************************************
  WM32	0xf0010100 	0xfc001801
  WM32 	0xf0010104 	0xfc0008c2
  [FLASH]
  CHIPTYPE    MIRRORX16
  CHIPSIZE    0x2000000
  BUSWIDTH    16

I then attempt to unlock/erase/program
Check for Sanity (NOTE: using BDI 2000 PROMPT)
  md 0xf0010100 2
  f0010100 : 0xf8001801  - 134211583  ....
  f0010104 : 0xf80008b2  - 134215502  ....
  md 0xfff00000 2
  fff00000 : 0x10101010    269488144  ....
  fff00004 : 0x10101010    269488144  ....
All looks good.  (10101010 is the existing planet core header)

TRY TO UNLOCK
  unlock 0xfff00000 1000
  Unlocking flash at 0xfff00000
  # Invalid parameter for flash programming

TRY TO ERASE
  erase 0xfff00000 UNLOCK 1000
  Erasing flash at 0xfff00000
  # Erasing flash memory failed
BUT
  erase 0xffff0000 UNLOCK 1000
  Erasing flash at 0xffff0000
  Erasing flash passed
HOWEVER
  mm 0xffff0000 0xdeadbeef
  md 0xffff0000 1
  ffff0000 : 0xffffffff
SO it doesn't seem to allow write access afterall...

Is there anyone that has a BDI 2000 config file for flashing the ep8248e
motherboard the 8MB Flash Version (64 MB flash version)=20

Thanks
-Alan

*****************************************************************
*************
CONFIDENTIAL NOTE: This e-mail and any attachments may be 
confidential and protected by legal privilege. If you are not 
the intended recipient, be aware that you are hereby notified 
that any unauthorized review, use, disclosure, dissemination, 
distribution, or copying of this communication, or any of its 
contents, is strictly prohibited. If you have received this 
email in error, please notify us immediately by replying to the 
sender and deleting this copy and the reply from your system. 
Thank you for your cooperation. 

EXPORT CONTROLLED DOCUMENT 
This document may contain information whose export is restricted 
by the Arms Export Control Act (Title 22, U.S.C., Sec 2751 Et 
Seq.) or the Export Administration Act of 1979, as amended, 
(Title 50, U.S.C., App. 2401, Et. Seq.) Violations to these 
export laws are subject to severe criminal penalties.  

All technical data forwarded by VT Miltope to its suppliers is 
EXPORT CONTROLLED. Supplier shall not disclose technical data in 
any form to a Foreign Person (including foreign person employees 
of Supplier), or export the technical data from the United 
States without U.S. Government authority and the written 
authorization of VT Miltope Contracts Department. 
*****************************************************************
*************
