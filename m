Message-ID: <011401c00b48$c699e860$4607a8c0@LocalHost>
From: "Gong Zhuo" <gongzhuo@163.net>
To: "linuxppc dev" <linuxppc-dev@lists.linuxppc.org>
Subject: How to caculate the MIPS of my MVME2600?
Date: Mon, 21 Aug 2000 16:20:25 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi:
   I am developing program under MVME2600. But I found the program is not as
fast as I think. So I tested my computer board using the mothed like this
and get some impossible results:

  * fill the mem from 0x4000 to 0x8000 with instruction 'or r0,r0,r0'
  * DEC ==> r3, us counter value ==> r13 at 0x4000
  * DEC ==> r4, us counter value ==> r14 at 0x8000
  * breakpoint at 0x8008
  * go from 0x4000

The display of PPCbug like this:

Copyright Motorola Inc. 1988 - 1997, All Rights Reserved

PPC1 Debugger/Diagnostics Release Version 3.5 - 01/30/98 RM01
COLD Start

Local Memory Found =04000000 (&67108864)

MPU Clock Speed =200Mhz

BUS Clock Speed =67Mhz

WARNING: Keyboard Not Connected

Reset Vector Location  : ROM Bank A
Mezzanine Configuration: Single-MPU
Current 60X-Bus Master : MPUIdle MPU(s)            : NONE

System Memory: 64MB, ECC Enabled (ECC-Memory Detected)
L2Cache:       256KB

PPC1-Bug>

PPC1-Bug>bf 4000:4000 7c000378 ;w
Effective address: 00004000
Effective count  : &65536
PPC1-Bug>as 4000
00004000 3D80FEF8  ADDIS       R12,R0,$FEF8?
00004004 81AC0100  LWZ         R13,$100(R12) ($00000100)
00004008 7C7602A6  MFSPR       R3,22
0000400C 7C000378  OR          R0,R0,R0? .
PPC1-Bug>as 8000
00008000 7C9602A6  MFSPR       R4,22
00008004 81CC0100  LWZ         R14,$100(R12) ($00000100)
00008008 7C000378  OR          R0,R0,R0? .
PPC1-Bug>br 8008
BREAKPOINTS
00008008
PPC1-Bug>g 4000
Effective address: 00004000
At Breakpoint
IP     =00008008 MSR    =00003040 CR     =00000000 FPSCR  =00000000
R0     =00000000 R1     =03F78000 R2     =00000000 R3     =3F0A7D37
R4     =3F0A64CE R5     =00000000 R6     =00000000 R7     =00000000
R8     =00000000 R9     =00000000 R10    =00000000 R11    =00000000
R12    =FEF80000 R13    =0BF88E8D R14    =0BF89008 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000000 R30    =00000000 R31    =00000000
SPR0   =00000000 SPR1   =00000000 SPR8   =00000000 SPR9   =00000000
00008008 7C000378  OR          R0,R0,R0
PPC1-Bug>


The result:
r4 -r3 = 0x1869 , r14 - r13 = 0x17B (379us) . There are 0x1000 asm
instruction from 0x4000 to 0x8000 (4096), than the MIPS = 4096/379 = 10MIPS
. It's impossilbe because the MPU is 200Mhz and bus is 67Mhz. The MIPS
should be higher than 200MIPS.

  I have made some mistakes? What are they?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
