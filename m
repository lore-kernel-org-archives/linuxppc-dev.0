Return-Path: <phil@ipal.net>
Received: from hadar.ipal.net (hadar.ipal.net [209.102.192.80])
	by ozlabs.org (Postfix) with ESMTP id C929DDDF0B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Jan 2008 07:00:37 +1100 (EST)
Date: Tue, 8 Jan 2008 13:54:42 -0600
From: Phil Howard <phil@ipal.net>
To: linuxppc-embedded@ozlabs.org
Subject: trying to boot linux on MVME5100
Message-ID: <20080108195442.GA31266@hadar.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kernel version is 2.6.23.12 compiled with gcc 4.2.1.

I have an MVME5100 board with PPC6-Bug firmware on it.  I'm trying to get a
Linux kernel loaded.  The first problem I see is that even though I configure
the load and execute addresses (at 00400000 or 00400004) via NIOT, doing NBO
or NBH still loads things at 00005000.  The time is set and the network is
working as I can see the kernel image there in memory at 00005000.  When I do
NIOT a 2nd time (actually have done it a few times) it shows by default what
I set it to, even though I have power cycled in between.  So it is definitely
saved to NVRAM.  But it just seems to not be using it.  Here are my latest
settings:

PPC6-Bug>niot
Controller LUN =00? 
Device LUN     =00? 
Node Control Memory Address =03F1D850? 
Client IP Address      =172.30.1.3? 
Server IP Address      =172.30.1.1? 
Subnet IP Address Mask =255.255.255.0? 
Broadcast IP Address   =172.30.1.255? 
Gateway IP Address     =172.30.1.2? 
Boot File Name ("NULL" for None)     =mvme5100/kernel.img? 
Argument File Name ("NULL" for None) =? 
Boot File Load Address         =003F0000? 
Boot File Execution Address    =00400004? 
Boot File Execution Delay      =00000000? 
Boot File Length               =00000000? 
Boot File Byte Offset          =00000000? 
BOOTP/RARP Request Retry       =00? 
TFTP/ARP Request Retry         =00? 
Trace Character Buffer Address =00000000? 
BOOTP/RARP Request Control: Always/When-Needed (A/W)=W? 
BOOTP/RARP Reply Update Control: Yes/No (Y/N)       =Y? 
PPC6-Bug>

The other issue I have is that this is a zImage kernel, and it does not
appear to be the right format for PPC6-Bug.  The first word of the text
section is not an executable instruction.  From the second word it looks
fine up to about 480 bytes into it, then at 512 bytes in there are more
valid CPU instructions.  Maybe some padding alignment?  So what is the
right entry point address?  And where should the kernel really be loaded
if zImage is right?

PPC6-Bug>nbh
Network Booting from: I82559, Controller 0, Device 0
Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
Loading: mvme5100/kernel.img

Client IP Address      = 172.30.1.3
Server IP Address      = 172.30.1.1
Gateway IP Address     = 172.30.1.2
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = mvme5100/kernel.img
Argument File Name     = 

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1678856, Bytes Loaded =&1678856
Bytes/Second   =&839428, Elapsed Time =2 Second(s)

Residual-Data Located at: $03FC26DC
IP     =00005000 MSR    =00003040 CR     =20000004 FPSCR  =00000000
R0     =00000000 R1     =03EFFE20 R2     =00000000 R3     =03FC26DC
R4     =00005000 R5     =00000000 R6     =00405030 R7     =00000000
R8     =03EFFE34 R9     =00000000 R10    =00000001 R11    =03EFFE7C
R12    =00000000 R13    =00000000 R14    =00000000 R15    =00000000
R16    =00000000 R17    =00000000 R18    =00000000 R19    =00000000
R20    =00000000 R21    =00000000 R22    =00000000 R23    =00000000
R24    =00000000 R25    =00000000 R26    =00000000 R27    =00000000
R28    =00000000 R29    =00000001 R30    =0040E228 R31    =00000001
SPR0   =00000000 SPR1   =00000000 SPR8   =00402AA0 SPR9   =00000000
00005000 7F454C46  WORD        $7F454C46
PPC6-Bug>md 5000 50ff
00005000  7F454C46 01020100 00000000 00000000  .ELF............
00005010  00020014 00000001 00400200 00000034  .........@.....4
00005020  00199CA0 00008000 00340020 00040028  .........4. ...(
00005030  00090008 00000001 00010000 00400000  .............@..
00005040  00400000 00189AB8 00195C64 00000007  .@........\d....
00005050  00010000 6474E551 00000000 00000000  ....dt.Q........
00005060  00000000 00000000 00000000 00000007  ................
00005070  00000004 00000004 00000000 00000000  ................
00005080  00000000 00000000 00000000 00000000  ................
00005090  00000000 00000004 00000000 00000000  ................
000050A0  00000000 00000000 00000000 00000000  ................
000050B0  00000000 00000000 00000000 00000000  ................
000050C0  00000000 00000000 00000000 00000000  ................
000050D0  00000000 00000000 00000000 00000000  ................
000050E0  00000000 00000000 00000000 00000000  ................
000050F0  00000000 00000000 00000000 00000000  ................
PPC6-Bug>ds 15000 :20
00015000 0000E0F4  WORD        $0000E0F4
00015004 9421FFF0  STWU        R1,$FFFFFFF0(R1) ($03EFFE10)
00015008 7C0802A6  MFSPR       R0,8
0001500C 429F0005  BCL         20,31,$00015010
00015010 BFC10008  STMW        R30,$8(R1) ($03EFFE28)
00015014 7FC802A6  MFSPR       R30,8
00015018 90010014  STW         R0,$14(R1) ($03EFFE34)
0001501C 801EFFF0  LWZ         R0,$FFFFFFF0(R30) ($0040E218)
00015020 7FC0F214  ADD         R30,R0,R30
00015024 88030004  LBZ         R0,$4(R3) ($03FC26E0)
00015028 2F800002  CMPI        CRF7,0,R0,$2
0001502C 409E0024  BC          4,30,$00015050
00015030 817E8000  LWZ         R11,$FFFF8000(R30) ($00406228)
00015034 3C00013F  ADDIS       R0,R0,$13F
00015038 6000FFFF  ORI         R0,R0,$FFFF
0001503C 812B0000  LWZ         R9,$0(R11) ($03EFFE7C)
00015040 7F890040  CMPL        CRF7,0,R9,R0
00015044 419D000C  BC          12,29,$00015050
00015048 3C000140  ADDIS       R0,R0,$140
0001504C 900B0000  STW         R0,$0(R11) ($03EFFE7C)
00015050 80010014  LWZ         R0,$14(R1) ($03EFFE34)
00015054 BBC10008  LMW         R30,$8(R1) ($03EFFE28)
00015058 38210010  ADDI        R1,R1,$10
0001505C 7C0803A6  MTSPR       8,R0
00015060 4E800020  BCLR        20,0
00015064 0000E090  WORD        $0000E090
00015068 9421FFE0  STWU        R1,$FFFFFFE0(R1) ($03EFFE00)
0001506C 7C0802A6  MFSPR       R0,8
00015070 429F0005  BCL         20,31,$00015074
00015074 BF810010  STMW        R28,$10(R1) ($03EFFE30)
00015078 7FC802A6  MFSPR       R30,8
0001507C 90010024  STW         R0,$24(R1) ($03EFFE44)
PPC6-Bug>

Executing at 00015004 hits a branch to 0 in just a few instructions.

Any ideas what are the proper steps with this board?

-- 
-----------------------------------------------------------------------------
| Phil Howard KA9WGN       | http://linuxhomepage.com/      http://ham.org/ |
| (first name) at ipal.net | http://phil.ipal.org/   http://ka9wgn.ham.org/ |
-----------------------------------------------------------------------------
