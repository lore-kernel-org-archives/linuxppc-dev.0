From: "Prabhakar Kalasani" <kalasani@sena.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to set up KGDB
Date: Thu, 26 Feb 2004 17:36:54 +0900
Message-ID: <NCEHKHHDAHEBBGFMCFHCCEHCCBAA.kalasani@sena.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I have a customised target board with MPC855t Processor , ppcboot-1.1.3
bootloader , linux-2.4.2 kernel. I'm new to this environment, I got to set
up KGDB for this target.can anybody please help me how to go about .

what i did...
# make xconfig
CONFIG_KGDB y
CONFIG_KGDB_MORE y
CONFIG_KGDB_OPTIONS="-01 -ggdb"
CONFIG_KGDB_TTYS1 y

# vi Makefile

CFLAGS = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing
changed to:
CFLAGS = -Wall -Wstrict-prototypes -O2 -g -ggdb

#make

If i boot the Image from Teratem(Remote) , I'm getting log like....

Bootloader 1.1.3 (Dec 10 2003 - 17:02:39)

CPU      :  XPC855xxZPnnD4 (50 MHz)
DRAM     :  64 MB
FLASH    :   8 MB
PC CARD  :   5V CARD
EEPROM   :  A Type exist
Ethernet :  AUTO-NEGOTIATION
Autoboot Start:  0
----------------------------------------------------------------------------
---
 Welcome to Boot Loader Configuration page
----------------------------------------------------------------------------
---
 Select menu
 1. RTC configuration [ Jan 26 2004 - 17:21:55 ]
 2. Hardware test
 3. Firmware upgrade [S/W Version : v1.1.0]
 4. Exit and boot from flash
 5. Exit and reboot
  <ESC> Back, <ENTER> Refresh
 -----> =>
=>setenv bootargs
=>tftpboot
ARP broadcast 1
TFTP from server 192.168.222.208; our IP address is 192.168.161.5
Filename 'zImage.vts8nfs.v1.4.1'.
Load address: 0x100000
Loading: #################################################################
         ###############################################################
done
Bytes transferred = 651327 (9f03f hex)
=>bootm
[Kernel Image]
   Image Address  : 00100000
   Data Size      : 651263 Bytes
   Verifying Checksum ... OK

Then It's struck there , not even displaying any error messages ....How
to deal with it ?

Regards,
Prabhakar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
