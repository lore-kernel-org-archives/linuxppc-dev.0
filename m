Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <s123a722.007@EMAIL>
Date: Wed, 18 Aug 2004 18:59:21 +0530
From: "Raghav K" <raghavk@myw.ltindia.com>
To: "<LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Issues with raw write using MTD Char Driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings all,

Hi, I  have 8MB AMD29FXX flash organized as  16 chips of 0.5 MB each as DIMM package on a
MPC885 board. The same is accessed as a 4 x 2MB interleaved flash, of effective sector size
256k. I'm using the  MTD concatation option to interleave thes chips. I'm using Arabella Linux,
kernel 2.4.25.

When I attempt to write a 256k chunk of data to an erased sector the kerel crashes
with the followng dump

Waitin c03b2000[25] 'driv_mtd' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: 00040000 7FFFFDC0 00000000 0000000A 00000001 00000008 3006C2A4 00000001
GPR08: 7FFFFCD0 00000190 00000001 10010EAC 300052EC 00000000 30005140 30005000
GPR16: 00000002 000000CC riv_mtd' Last syscall: 4
last math 00000000 last altivec 00000000
GPR00: 00040000 7FFFFDC0 00000000 0000000A 00000001 00000008 3006C2A4 00000001
GPR08: 7FFFFCD0 00000190 00000001 10010EAC 300052EC 00000000 30005140 30005000
GPR16: 00000002 000000CC 300050A0 000000CC 30002D6C 30000C1C 00003915 30005154
GPR24: 30000130 30000000 10000000 10000000 00000003 10014000 00000000 00000000
Call backtrace:
100008A0 30026FE0 30026FFC 10000780 00000000 7FFFFF74
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

However when I try to write to the same sector in smaller chunks of 512 bytes,
with a sleep of a few microseconds, the write operation to entire sector is successful,
however a warning is raised.

Warning: DQ5 raised while program operation was in progress, however operation completed OK

I have the following is  my  kernel configuration :

CONFIG_MTD=y
CONFIG_MTD_PARTITIONS=y
CONFIG_MTD_CONCAT=y
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y

CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_CFI_B4=y
CONFIG_MTD_CFI_I4=y
CONFIG_MTD_CFI_AMDSTD=y

CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_START=2800000
CONFIG_MTD_PHYSMAP_LEN=800000
CONFIG_MTD_PHYSMAP_BUSWIDTH=4


Is there a maximum chunk that be written to a sector a one shot?
What am I doing wrong?

TIA,
-raghav-


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
