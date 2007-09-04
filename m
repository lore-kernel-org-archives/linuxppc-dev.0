Return-Path: <alan@akb.net>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by ozlabs.org (Postfix) with ESMTP id A1F57DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 04:08:50 +1000 (EST)
Received: by el-out-1112.google.com with SMTP id s27so378112ele
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 04 Sep 2007 11:08:49 -0700 (PDT)
Message-ID: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
Date: Tue, 4 Sep 2007 12:08:47 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-embedded@ozlabs.org
Subject: Flash on ep8248e standard motherboards
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Please accept my apologies for sending the last email and accept this
email address and question.  without the disclaimer.
---------------------------------------------------

Hello;
We have a custom board based on the ep8248e design from Embedded
Planet and I'm trying to use something other than codewarrior to flash
u-boot srec's

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
  WM32    0xf0010100     0xfc001801
  WM32     0xf0010104     0xfc0008c2
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

Is there anyone that has a BDI 2000 config file for flashing the
ep8248e motherboard the 8MB Flash Version (64 MB flash version)

Thanks
-Alan
