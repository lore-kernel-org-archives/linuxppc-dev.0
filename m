Message-ID: <B25E2E5A003CD311B61E00902778AF2A0148B69D@server1.skystream.com>
From: Subodh Nijsure <SNijsure@SkyStream.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Cc: Subodh Nijsure <SNijsure@SkyStream.com>
Subject: Problems with turn_on_mmu
Date: Thu, 25 Jan 2001 23:28:28 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am trying to boot a linux image on a 860 board.

I am using ppcboot as the bootrom, I am using BDM4GDB as the debugger.

When using BDM4GDB I can set a break point at 0xC0000000 and single step
(stepi)
the code upto the point where instruction 'rfi' is executed in turn_on_mmu
at which point gdb just hangs.   Yes Wolfgang has warned me in the past
about
not setting breakpoint at this location, don't know the reasons, BDM4GDB
seems to
set breakpoints okay and allow me to step through the code...

Next I set breakpoint at start_here the gdb causes the break  but the
instruction being executed is fnmadd. f31,f31,f31,f31" -> 0xFFFFFFF....

So I have tried disabling the cache that was suggested in message below,
without any
success.

http://lists.linuxppc.org/listarcs/linuxppc-embedded/200006/msg00098.html

Also I have tried disabling the data cache and instruction cache using the
ppcboot
provided commands but without much success.

I have tried this with 2.4-12 from (ftp.denx.de site), 2.2.XX kernels,
just in case, although code in till turn_on_mmu is same in both version.

Also I have tested that I can read/write the RAM (64MB) on this board using
commands
provided by the ppcboot.


1. I am novice in PowerPC assembler code ( yes doing the RTFM) Why does gdb
hang when
   I do 'stepi' on instruction rfi ?

2. Of course the bigger question is when start_here is executed what could
be
   the reason instruction are all FFFF?

3. BDM4GDB seems like good tool, and I may not be using it correctly. Is
there other tool
   out there that might help me debug this thing better?

Attached below is the boot sequence, some board information, gdb debug
session, and
some PowerPC register values in case the "details" might help...

Any help/pointer will be much appreciated.

/Subodh Nijsure

ppcboot 0.8.1 (Jan 25 2001 - 15:46:02)

Initializing...
  CPU:   XPC860xxZPnnD3 at 48 MHz: 16 kB I-Cache 8 kB D-Cache FEC present
  Board:   SDRAM:  64  MB (67108864)
  Relocating to: 03fa0000, 393216 bytes for malloc()
  Board Info at: 03f3ffc0
  New Stack Pointer is: 03f3ff40
  Now running in RAM - dest_addr = 0x03fa0000
  FLASH:  4 MB
  Monitor relocated to 0x03fa0000
Install CPM interrupt for vector 0 ==> 03fafa48
  In:    serial
  Out:   serial
  Err:   serial

CXE-BOOTROM>tftpboot 300000 "/tftpboot/vmlinux"
ARP broadcast 1
Got good ARP - start TFTP
TFTP from server 192.168.4.43; our IP address is 192.168.4.41
Filename '/tftpboot/vmlinux'.
Load address: 0x300000
Loading: ##########################
done
CXE-BOOTROM=>copy_kernel
   Image Name:   2.4.0-test2 @ Thu Jan 25 22:31:4
   Image Type:   PowerPC Linux Kernel Image (uncompressed)
   Data Size:    1136088 Bytes = 1109 kB = 1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
Do memcopy 1136088 bytes from address 0x00300040 to load address of
0x00000000
Kernel is copied to location 0x00000000
CXE-BOOTROM=>md 0
00000000: 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378    |..x|.#x|.+x|.3x
00000010: 7cfb3b78 3b000000 7c0002e4 39000000    |.;x;...|...9...
00000020: 7d10c3a6 3d000400 65081000 7d18c3a6    }...=...e...}...
00000030: 3d00c000 61080200 7d13c3a6 7d1bc3a6    =...a...}...}...
00000040: 3900000c 61080001 7d15c3a6 7d1dc3a6    9...a...}...}..
00000050: 390001fd 7d16c3a6 7d1ec3a6 3d004000    9...}...}...=.@.
00000060: 7d12c3a6 7d1ac3a6 7d3e9aa6 7529ff80    }...}...}>..u)..
00000070: 7d284b78 61080200 7d1bc3a6 3900000c    }(Kxa...}...9...
00000080: 61080001 7d1dc3a6 7d284b78 610801ff    a...}...}(Kxa...
00000090: 7d1ec3a6 3d000c00 7d108ba6 7d188ba6    }...=...}...}...
000000a0: 3d000200 7d108ba6 3d000100 7d188ba6    =...}...=...}...
000000b0: 3d000200 7d188ba6 7c0000a6 60000030    =...}...|...`..0
000000c0: 7c1b03a6 3c00c000 60002190 7c1a03a6    |...<...`.!.|...
000000d0: 7c0004ac 4c00012c 4c000064 00000000    |...L..,L..d....
000000e0: 00000000 00000000 00000000 00000000    ................
000000f0: 00000000 00000000 00000000 00000000    ................
CXE-BOOTROM=>md 300040  ( Skip the 40 byte header -- actual code starts at
offset 0x40 )
00300040: 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378    |..x|.#x|.+x|.3x
00300050: 7cfb3b78 3b000000 7c0002e4 39000000    |.;x;...|...9...
00300060: 7d10c3a6 3d000400 65081000 7d18c3a6    }...=...e...}...
00300070: 3d00c000 61080200 7d13c3a6 7d1bc3a6    =...a...}...}...
00300080: 3900000c 61080001 7d15c3a6 7d1dc3a6    9...a...}...}...
00300090: 390001fd 7d16c3a6 7d1ec3a6 3d004000    9...}...}...=.@.
003000a0: 7d12c3a6 7d1ac3a6 7d3e9aa6 7529ff80    }...}...}>..u)..
003000b0: 7d284b78 61080200 7d1bc3a6 3900000c    }(Kxa...}...9...
003000c0: 61080001 7d1dc3a6 7d284b78 610801ff    a...}...}(Kxa...
003000d0: 7d1ec3a6 3d000c00 7d108ba6 7d188ba6    }...=...}...}...
003000e0: 3d000200 7d108ba6 3d000100 7d188ba6    =...}...=...}...
003000f0: 3d000200 7d188ba6 7c0000a6 60000030    =...}...|...`..0
CXE-BOOTROM=>reginfo

System Configuration registers
        IMMR    0XFF000501
        SIUMCR  0X1600400SYPCR  0XFFFFFF88
        SWT     0XFFFF0000      SWSR    0X0
        SIPEND  0X20000 SIMASK  0X4000000
        SIEL    0X0     SIVEC   0X3C000000
        TESR    0X0     SDCR    0X1
Memory Controller Registers
        BR0     0X28000001      OR0     0XFFC00742
        BR1     0XFF020001      OR1     0XFFFF07F2
        BR2     0XFF040001      OR2     0XFFFC07F2
        BR3     0X20000C1       OR3     0XFE000A00
        BR4     0X0     OR4     0X0
        BR5     0XC1    OR5     0XFE000A00
        BR6     0X0     OR6     0X0
        BR7     0XFF010801      OR7     0XFFFF8750

        mamr    0X67001000      mbmr    0X19964114
        mstat   0X0     mptpr   0X400
        mdr     0XFFFFFFFF

System Integration Timers
        TBSCR   0X1     RTCSC   0X11
        PISCR   0X2
CXE-BOOTROM=>bootm
## Booting Linux kernel at 00300000 ...
## Transferring control to Linux (at address 00000000) ...
about to invoke (*kernel) (kbd, initrd_start, initrd_end, cmd_start,
cmd_end)
kernel = 00000000 board_info (R3)= 007ffec0, initrd_start (r4)= 00000000,
initrd_end (r5) = 00000000, cmd_start (r6)= 007fff00 cmd_end (r7)= 007fff00

------gdb session----

[root@sn-smp linux-2.4-2000-12-04]# !pow
powerpc-linux-gdb -x ./mpc.init vmlinux
GNU gdb 5.0
Copyright 2000 Free Software Foundation, Inc.
....
This GDB was configured as "--host=i686-pc-linux-gnu
--target=powerpc-linux"...
MPCBDM version 1.2 / 2000.11.05
got access rights for printer port 0x378..0x37A
disabled power at port
adapter version 2 initialized
assert HRESET
assert SRESET sequence for immediate debug mode
*** init
Target cpu PVR=0x00500000 PARTNUM=0x05 MASKNUM=0x01 REV_NUM=0x0000
Target cpu is a 'XPC860 Rev. D.3'
BDM initialized
0x100 in ?? ()
SYPCR := (SWTC|16BMT|24BME||28SWF|SWE|SWRI|SWP)
IMMR + 4:System Protection Control Register, UM283
SYPCR = 0xffffff88 = (SWTC=0xffff|BMT=0xff|BME|SWF)
ICTRL :=
(CTA|3CTB|6CTC|9CTD|12IW0|14IW1|16IW2|18IW3|20SIW0EN|SIW1EN|SIW2EN|SIW3EN|DI
W0EN|DIW1EN|DIW2EN|DIW3EN|IFM|ISCT_SER)
SPR 158:Instruction Support Control Register, UM989
ICTRL = 0x00000007 =
(CTA=0x0|CTB=0x0|CTC=0x0|CTD=0x0|IW0=0x0|IW1=0x0|IW2=0x0|IW3=0x0|ISCT_SER=0x
7)
DER :=
(|RSTE|CHSTPE|MCIE||6EXTIE|ALIE|PRIE|FPUVIE|DECIE||13SYSIE|TRE||17SEIE|ITLBM
SE|DTLBMSE|ITLBERE|DTBLERE||28LBRKE|IBRKE|EBRKE|DPIE)
SPR 149:Debug Enable Register, UM996
DER = 0x2002000f = (CHSTPE|TRE|LBRKE|IBRKE|EBRKE|DPIE)
(gdb) break start_here
Breakpoint 1 at 0xc0002190
(gdb) myder
DER :=
(|RSTE|CHSTPE|MCIE||6EXTIE|ALIE|PRIE|FPUVIE|DECIE||13SYSIE|TRE||17SEIE|ITLBM
SE|DTLBMSE|ITLBERE|DTBLERE||28LBRKE|IBRKE|EBRKE|DPIE)
SPR 149:Debug Enable Register, UM996
DER = 0x7026400f =
(RSTE|CHSTPE|MCIE|DECIE|SYSIE|TRE|SEIE|LBRKE|IBRKE|EBRKE|DPIE)
(gdb) cont
Continuing.
*** run
*** Resume
*** wait freeze

Program received signal SIGTRAP, Trace/breakpoint trap.
CR := (CR0|4CR1|8CR2|12CR3|16CR4|20CR5|24CR6|28CR7)
SPR 2:Condition Register, UM140
CR = 0x59553555 =
(CR0=0x5|CR1=0x9|CR2=0x5|CR3=0x5|CR4=0x3|CR5=0x5|CR6=0x5|CR7=0x5)
ICR :=
(|RST|CHSTP|MCI||6EXTI|ALI|PRI|FPUVI|DECI||13SYSI|TR||17SEI|ITLBMS|DTBLMS|IT
LBER|DTLBER||28LBRK|IBRK|EBRK|DPI)
SPR 148:Interrupt Cause Register, UM994
ICR = 0x00200000 = (DECI)
0x3faf1a4:	eieio
0x3faf1a4 in ?? ()
(gdb) cont
Continuing.
*** run
*** Resume
*** wait freeze
CR = 0x95555554 =
(CR0=0x9|CR1=0x5|CR2=0x5|CR3=0x5|CR4=0x5|CR5=0x5|CR6=0x5|CR7=0x4)
ICR :=
(|RST|CHSTP|MCI||6EXTI|ALI|PRI|FPUVI|DECI||13SYSI|TR||17SEI|ITLBMS|DTBLMS|IT
LBER|DTLBER||28LBRK|IBRK|EBRK|DPI)
SPR 148:Interrupt Cause Register, UM994
ICR = 0x00000004 = (IBRK)
0xc0002190 <start_here>:	I!I!fnmadd.	f31,f31,f31,f31 <---------
Invalid fffff instruction here.

Breakpoint 1, 0xc0002190 in start_here ()
(gdb) quit

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
