Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Praveen Madhavan <praveenb@intotoinc.com>
Reply-To: praveenb@intotoinc.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: MBX860 Exception: Memory check Failed
Date: Thu, 6 Dec 2001 12:45:08 +0530
Cc: wd@denx.de
MIME-Version: 1.0
Message-Id: <01120612450801.01296@praveen>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
   I am using Wolfang Denx linux kernel 2.4.4  for loading from Mbx860 board.

   Well, I am experiancing "Exception: Memory check "message reported by
EPPC-BUG  when it loads kernel.. I don't know whats is going wrong ?..
   But i can able to figure out, where the problem IS ! after disassembling
the kernel.. Well i think it happens at memcpy function invoked during
decompressing the kernel.

Here, I am enclosing my board details, EPPC-BUG dump, & asm dump of memcpy &
decompress_kernel ..

Please help me out from this !
Do reply me, since i am not member of the ppc embedded list.

Thanks..


Board details
----------
MBX860 - version 0050/00
On Board Ram - 4MB .
1 DIMM socket -  No DRAM installed.

Do i need to install optional DRAM in DIMM ?.. If yes how much ?
Is it possible to load linux kernel  using just on board 4MB ram ?..


EPPC-BUG dump
-------------
EPPC-Bug>PL 20 0
Network Booting from: MPC860, Controller 20, Device 0
Loading: 172.16.1.77/zImage

Client IP Address      = 172.16.1.77
Server IP Address      = 172.16.1.76
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = 172.16.1.77/zImage
Argument File Name     =

Bytes Received =&601958, Bytes Loaded =&601958
Bytes/Second   =&300979, Elapsed Time =2 Second(s)
Exception: Machine Check
[Data External Transfer Error Acknowledge]
[Data Transfer Monitor Timeout]
SRR0 =001002EC SRR1 =00001002 Vector-Offset =00200
IP     =001002EC MSR    =00001002 CR     =80000000
R0     =00000042 R1     =00109F70 R2     =0000000F R3     =FFFFDEFF
R4     =003F4228 R5     =00000034 R6     =003F4228 R7     =0000315C
R8     =00000000 R9     =00000000 R10    =FFFFDDFF R11    =00100000
R12    =FA100000 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =FA200000 R19    =00000000
R20    =00000000 R21    =00100000 R22    =00100000 R23    =00100000
R24    =9B3B2AF0 R25    =00000000 R26    =00100000 R27    =40000000
R28    =00000000 R29    =0000315C R30    =003F4228 R31    =0000DDFF
SPR1   =00000000 SPR8   =00100658 SPR9   =00000000
001002EC 7C0349AE  STBX        R0,R3,R9 ($FFFFDEFF)


asm code for decompress_kernel & memcpy
--------------------------------
001802dc <memcpy>:
  1802dc:       39 20 00 00     li      r9,0
  1802e0:       7c 09 28 00     cmpw    r9,r5
  1802e4:       4c 80 00 20     bgelr
  1802e8:       7c 04 48 ae    lbzx    r0,r4,r9
  1802ec:       7c 03 49 ae    stbx    r0,r3,r9  <-----Exception occured here
  1802f0:       39 29 00 01     addi    r9,r9,1
  1802f4:       7c 09 28 00     cmpw    r9,r5
  1802f8:       41 80 ff f0         blt     1r9,r5
 1802e4:       4c 80 00 20     bgelr802e8 <memcpy+0xc>
  1802fc:       4e 80 00 20     blr

001805a4 <decompress_kernel>:
  1805a4:       94 21 ff c0     stwu    r1,-64(r1)
  1805a8:       7c 08 02 a6     mflr    r0
  1805ac:       92 a1 00 14     stw     r21,20(r1)
  1805b0:       92 c1 00 18     stw     r22,24(r1)
  1805b4:       92 e1 00 1c     stw     r23,28(r1)
  1805b8:       93 01 00 20     stw     r24,32(r1)
  1805bc:       93 21 00 24     stw     r25,36(r1)
  1805c0:       93 41 00 28     stw     r26,40(r1)
  1805c4:       93 61 00 2c     stw     r27,44(r1)
  1805c8:       93 81 00 30     stw     r28,48(r1)
  1805cc:       93 a1 00 34     stw     r29,52(r1)
  1805d0:       93 c1 00 38     stw     r30,56(r1)
  1805d4:       93 e1 00 3c     stw     r31,60(r1)
  1805d8:       90 01 00 44     stw     r0,68(r1)
  1805dc:       7c 7f 1b 78     mr      r31,r3
  1805e0:       7c de 33 78     mr      r30,r6
  1805e4:       39 00 00 00     li      r8,0
  1805e8:       3d 5f ff ff     addis   r10,r31,-1
  1805ec:       3d 20 00 18     lis     r9,24
  1805f0:       3e e0 00 18     lis     r23,24
  1805f4:       3d 60 00 18     lis     r11,24
  1805f8:       2c 1e 00 00     cmpwi   r30,0
  1805fc:       91 09 70 08     stw     r8,28680(r9)
  180600:       91 4b 62 c8     stw     r10,25288(r11)
  180604:       91 17 70 04     stw     r8,28676(r23)
  180608:       38 00 25 80     li      r0,9600
  18060c:       38 6a 01 00     addi    r3,r10,256
  180610:       90 1e 00 30     stw     r0,48(r30)
  180614:       3d 20 00 18     lis     r9,24
  180618:       7f 60 00 26     mfcr    r27
  18061c:       7c 9d 23 78     mr      r29,r4
  180620:       90 69 62 e0     stw     r3,25312(r9)
  180624:       3e a0 00 18     lis     r21,24
  180628:       3e c0 00 18     lis     r22,24
  18062c:       3f 40 00 18     lis     r26,24
  180630:       41 82 00 10     beq     180640 <decompress_kernel+0x9c>
  180634:       7f c4 f3 78     mr      r4,r30
  180638:       38 a0 00 34     li      r5,52
  18063c:       4b ff fc a1     bl      1802dc <memcpy>001805a4

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
