From: "Etienne van der Linde" <evdl@ananzi.co.za>
Subject: RE: Kernel oops, sig: 7 at last init / modules
To: linuxppc-embedded@lists.linuxppc.org
Cc: wd@denx.de
Date: Thu, 11 Mar 2004 14:22:37 +0200
Message-ID: <web-18331109@mail01.ananzi.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Wolfgang

Thanks for the reply...

> Decode the backtrace (see
ftp://ftp.denx.de/pub/tools/backtrace)

Which I did - but what does it tell me...and why so many
unknown addresses?:

###################################################################################
###################################################################################
.....
.....
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX,
10HDX.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.17.5.125
Looking up port of RPC 100005/2 on 172.17.5.125
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000D594 XER: 20000000 LR: C0040238 SP: C0EE1DB0 REGS:
c0ee1d00 TRAP: 0200
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c0ee0000[8] 'modprobe' Last syscall: 5
last math c0ee0000 last altivec 00000000
GPR00: 00000040 C0EE1DB0 C0EE0000 C0EDE000 0FFE0C58
00001000 C0EDDFFF 0FFDF304
GPR08: C01F25C0 00000000 C0EDE000 00000001 24888088
1003A1A8 00FFB000 007FFF79
GPR16: C013B478 C013B578 C0EE1F08 84888024 00009032
00EE1DF0 00000000 C0003DE4
GPR24: C0003B20 0FFEAA94 0FFED6A0 100389E8 00000008
C0EDE000 00001000 0FFE0C58
Call backtrace:
C00401C8 C0033434 C0003B7C 00000000 0FF1A05C 0FF4FBF8
0FF4EA04
0FF4F858 0FF4C4C8 0FF85B60 0FF85998 10015108 0FEE67B8
0FECFF74
00000000

***********************************************************************************
The backtrace:
***********************************************************************************
0xc00401c8 -- 0xc00401a0 + 0x0028   Letext
0xc0033434 -- 0xc0033418 + 0x001c   sys_open
0xc0003b7c -- 0xc0003b7c + 0x0000   ret_from_syscall_1
0x00000000 -- unknown address
0x0ff1a05c -- unknown address
0x0ff4fbf8 -- unknown address
0x0ff4ea04 -- unknown address
0x0ff4f858 -- unknown address
0x0ff4c4c8 -- unknown address
0x0ff85b60 -- unknown address
0x0ff85998 -- unknown address
0x10015108 -- unknown address
0x0fee67b8 -- unknown address
0x0fecff74 -- unknown address
***********************************************************************************

INIT: version 2.78 booting
Machine check in kernel mode.
Caused by (from SRR1=49030): Transfer error ack signal
Oops: machine check, sig: 7
NIP: C000D594 XER: 20000000 LR: C0040238 SP: C01F1DF0 REGS:
c01f1d40 TRAP: 0200
MSR: 00049030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01f0000[1] 'init' Last syscall: 33
last math 00000000 last altivec 00000000
GPR00: 00000040 C01F1DF0 C01F0000 C0E7E000 0FFE6DA8
00001000 C0E7DFFF FEFEFEFF
GPR08: C01F25E0 00000000 C0E7E000 00000001 4444408D
1001F5A8 00FFB000 007FFF79
GPR16: 00000001 00000000 007FFF00 10010000 00009032
001F1E70 00000000 C0003DE4
GPR24: C0003B20 10006BF0 7FFFFAD8 00000000 C01F1E38
C0E7E000 00001000 0FFE6DA8
Call backtrace:
C00401C8 C00417FC C0032784 C0003B7C 3000B178 0FFB5D08
0FFB5F6C
1000660C 10006690 10003384 10004328 10005C64 10006088
0FECFF70
00000000

***********************************************************************************
The backtrace:
***********************************************************************************
0xc00401c8 -- 0xc00401a0 + 0x0028   Letext
0xc00417fc -- 0xc00417e0 + 0x001c   __user_walk
0xc0032784 -- 0xc003271c + 0x0068   sys_access
0xc0003b7c -- 0xc0003b7c + 0x0000   ret_from_syscall_1
0x3000b178 -- unknown address
0x0ffb5d08 -- unknown address
0x0ffb5f6c -- unknown address
0x1000660c -- unknown address
0x10006690 -- unknown address
0x10003384 -- unknown address
0x10004328 -- unknown address
0x10005c64 -- unknown address
0x10006088 -- unknown address
0x0fecff70 -- unknown address
***********************************************************************************

Kernel panic: Attempted to kill init!
Rebooting in 1 seconds..


###################################################################################
###################################################################################


> To me it seems that you should check your memory  map.

Well I only map the internal dpram and the flash in init.c;

***********************************************************************************
	case _MACH_8260:
		setbat(0, IMAP_ADDR, IMAP_ADDR, 0x1000000, IO_PAGE);			/*
Internal regs */
		setbat(1, 0xf0000000, 0xf0000000, 0x10000000,
IO_PAGE);		/* FLASH */
		ioremap_base = IMAP_ADDR;
	break;
***********************************************************************************

> For  example, where  is  the  IMMR  mapped?

Here are excerpts from my BDI config file;
***********************************************************************************
WREG	MSR		0x00001002	; default MSR
WM32	0x000101A8	0x0F000000	; IMMR	== 0x0F000000, move
internal memspace to 0x0F000000
WM32	0x0F010004	0xFFFFFFC3	; SYPCR	== no watchdog
WM32	0x0F010C80	0x00000019	; SCCR	== normal operations
WM32	0x0F010024	0x100C0000	; BCR	== single mode

;	CHIP SELECT	BASE ADDRESS	SIZE	 BUS	PORT SIZE	COMMENTS
;	-----------	------------	----	-----	---------	--------
;	   #CS0		 0xFF000000	16MB	 60x	  64 bits	16MB FLASH
;	   #CS1		 0x00000000	16MB	 60x	  32bits	16MB SDRAM
;	   #CS2		 0xE2000000	16 B	Local	   8 bits	16 B RTC
;	   #CS3		 0xE3000000	 8 B	Local	  16 bits	 8 B USB
;	   #CS4		 0xE4000000	 1 B	Local	   8 bits	 1 B CAN
;	   #CS5		 0xE5000000	16 B	Local	   8 bits	16 B ARCNET
;	   #CS6		 0xE6000000	16MB	Local	  32 bits	16MB FPGA
;
WM32	0x0F010100	0xFF000001	; BR0 - FLASH
WM32	0x0F010104	0xFF001047	; OR0 - FLASH

WM16	0x0F010184	0x2000	; MPTPR: Divide bus clock by 32
WM8	0x0F01019C	0x20		; PSRT(Local bus SDRAM Refresh Timer):
Divide MPTPR output by 30

WM32	0x0F01010C	0xFF0030C0	; OR1 - SDRAM
WM32	0x0F010108	0x00001841	; BR1 - SDRAM 0x00001841

WM32	0x0F010190	0xAA66B552	; PSDMR: Precharge all banks E
WM32	0x00000000	0xFF		; Access SDRAM
WM32	0x0F010190	0x8A66B552	; PSDMR: CBR Refresh C
WM8	0x00000000	0xFF		; Access SDRAM
WM8	0x00000000	0xFF		; Access SDRAM
WM32	0x0F010190	0x9A66B552	; PSDMR: Mode Set D
WM8	0x00000000	0xFF		; Access SDRAM
WM32	0x0F010190	0xC266B552	; PSDMR: enable refresh, normal
C36AB552
WM8	0x00000000	0xFF		; Access SDRAM

WM32	0x0F010114	0xFF001CF6	; OR2 - RTC
WM32	0x0F010110	0xE2000821	; BR2 - RTC
WM32	0x0F01011C	0xFF001047	; OR3 - USB
WM32	0x0F010118	0xE3001021	; BR3 - USB
WM32	0x0F010124	0xFF001CF6	; OR4 - CAN
WM32	0x0F010120	0xE4000821	; BR4 - CAN
WM32	0x0F01012C	0xFF001047	; OR5 - ARCNET
WM32	0x0F010128	0xE5001021	; BR5 - ARCNET
***********************************************************************************

> Did you make sure to put it at a "high" address?

Is 0x0F000000 high enough? Do you have a better suggestion?

Furthermore, if I disable the 60x Busmonitor (i.e. write
0xFFFFFF34 to SYPCR at startup), I do not get the oops, but
the system only hangs after freeing init memory....does
this mean that the problem lies with my 60x bus
(SDRAM/FLASH)?

Thanks

Etienne

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
