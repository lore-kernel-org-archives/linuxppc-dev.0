Message-ID: <010b01bfc610$4a542c70$dc52df8d@oslo>
From: го╩Себ <stha@postech.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to load kernel on RPX Lite Board ?
Date: Thu, 25 May 2000 15:13:05 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have RPX Lite Board made by Embedded Planet Co.Ltd
CPU is MPC850.

Screen Dump is as follows

----
RPX Utility program, Copyright (C) 1998-1999, RPCg LLC, All Rights Reserved.
  Reset(0100): ExHard ExSoft ChkStop, TESR:0000 Core.Pv/Cp=2100.0050/0065
  BCSR : OK
  RTC  : OK, battery LOW or absent, tics/sec=1, time = 4 sec
  SPIp : OK, I2C: OK, STTM: OK, 37.5c, EEcfg: OK, 256b, cs:1FF1
  ENET : [zero], 0010EC001442, INET: 8DDF52DB
  FLASH: OK, 1*8 Mb(32x8), id=01:49, cs:F95D es:F95D OK (FFF00000:FFF46200)
  NVRAM: OK, 0 Kb, NVR battery GOOD
  DRAM : OK, 16 Mb, 10 columns
===> RPX Main
     RPX-Lite BW/CW 850SR 50Mhz/8Mhz Ic ~Dc RPXU v1.46
  1  test BCSR                    A  Add-on board tests
  2  test dip switches            B  rpxBug command line (ctrl-B)
  3  test LEDs                    C  Configure EEPROM
  4  test SPI I2C STTM EEPR,CFG   L  Load RAM
  5  test FLASH firmware chksum   O  On-board I/O tests
  6  test NVRAM/SRAM              P  Program FLASH
  7  test DRAM (destructive)      R  hard Reset
  8                               S  Scan FLASH for executables
  9  run all tests                T  display Time & Temperature
RPX Main menu: press 123456789 or ABCLOPRST key : <?> :
----


I want to load my kernel image into this board. To download kernel image, The flash utility given by company needs S-Record format. Actually, I do know about S-Record Format, But I don't know how to make it.  I used Montavista-2.2.13 kernel and patched it. To build the kernel, I typed "make zImage" and I got two files named "./vmlinux" and "./arch/ppc/mbxboot/zImage" in the kernel directory.
After that,
#>powerpc-linux-objcopy -O srec vmlinux vmlinux.srec

vmlinux.srec is created, "S-Record format"

To download via ethernet, I installed tftpserver on my PC, and working good.


----
===> RPX Load: (ESC - returns to Main menu)
  1  Copy one memory range to another range
  2  Verify one memory range against another range
  3  Fill memory range with generated data
  4
  5  load   using S-records received from serial monitor port
  6  verify using S-records received from serial monitor port
  7  load   using tftp via Ethernet interface
  8  set a start address
  9  transfer control to start address
  T  tftp & start using config info with retries
RPX Load menu: press 123456789T key : <?> : 7
Load using tftp via Ethernet
Enter server IP address <8DDF52DC> :
Enter server filename   <vmlinux.srec> :
Enter address offset  : <00000000 hex> :
----


C0000390 [does not exist]
C00003A0 [does not exist]
C00003B0 [does not exist]
C00003C0 [does not exist]
C00003D0 [does not exist]
load_tftp(): ** E_RPX_DST_NOT_EXIST
3072 data bytes, 62 S-records, 6 tftp blocks, 0 repeated blocks


Could you tell me about how to download the kernel and root file system onto my board. Maybe, Something wrong in my procedure.
I already read the instruction at ftp://ftp.ppc.kernel.org/pub/linuxppc/embedded/getting_started.rpx
But I couldn't.

I really thank you, in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
