Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Using BDI-2000 to debug kernel
Date: Thu, 13 Mar 2003 13:04:37 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNKEEBCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3E7051A8.A77EAF4C@tataelxsi.co.in>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I am having a strange problem trying to single step through the kernel.

I have a custom 405GPr board that runs u-boot like a trained pig.  Now
I'm on to the step of getting Linux up on the board.  I am using
a BDI-2000 to debug the kernel (I load it into memory, and enter the
go command, and I get an exception).

So I tried to find the problem as follows:

BDI>load

Loading /tftpboot/vmlinuz.bdi , please wait ....

Loading program file passed

BDI>info
    Target state      : debug mode
    Debug entry cause : JTAG stop request
    Current PC        : 0x00210000
    Current CR        : 0x00000000
    Current MSR       : 0x00000000
    Current LR        : 0x0021001c

BDI>md 0x00210000
00210000 : 7c7f1b78 7c9e2378 7cbd2b78 7cdc3378  |..x|.#x|.+x|.3x
00210010 : 7cfb3b78 3b000000 48002359 38001032  |.;x;...H.#Y8..2
00210020 : 7c1b03a6 3c00c000 600022d0 7c1a03a6  |...<...`.".|...
00210030 : 4c000064 00000000 00000000 00000000  L..d............
00210040 : 00000000 00000000 00000000 00000000  ................
00210050 : 00000000 00000000 00000000 00000000  ................
00210060 : 00000000 00000000 00000000 00000000  ................
00210070 : 00000000 00000000 00000000 00000000  ................
00210080 : 00000000 00000000 00000000 00000000  ................
00210090 : 00000000 00000000 00000000 00000000  ................
002100a0 : 00000000 00000000 00000000 00000000  ................
002100b0 : 00000000 00000000 00000000 00000000  ................
002100c0 : 00000000 00000000 00000000 00000000  ................
002100d0 : 00000000 00000000 00000000 00000000  ................
002100e0 : 00000000 00000000 00000000 00000000  ................
002100f0 : 00000000 00000000 00000000 00000000  ................


I disassembled head_4xx.o and so far this looks fine:
head_4xx.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <_start>:
       0:	7c 7f 1b 78 	mr	r31,r3
       4:	7c 9e 23 78 	mr	r30,r4
       8:	7c bd 2b 78 	mr	r29,r5
       c:	7c dc 33 78 	mr	r28,r6
      10:	7c fb 3b 78 	mr	r27,r7
      14:	3b 00 00 00 	li	r24,0
      18:	48 00 23 59 	bl	2370 <initial_mmu>

Now I set a breakpoint as recommended in "tool talk" white paper by Ultimate
Solutions.
In System.map:

c00022c4 T abort
c00022d0 t start_here
c0002370 t initial_mmu
c00023d4 T set_context
c00023e4 t rest_init

BDI>bi 0xc00022d0
Breakpoint identification is 0

BDI>go


- Target started with DBCR0 = 0x80800001

BDI>
- TARGET: target has entered debug mode

BDI>info
    Target state      : debug mode
    Debug entry cause : instruction breakpoint
    Current PC        : 0xc00022d0
    Current CR        : 0x00000000
    Current MSR       : 0x00001030
    Current LR        : 0x0021001c


So - I hit the breakpoint just fine - now I dump memory at start_here
and it is displayed below:

BDI>md 0xc00022d0

c00022d0 : 0223000d 00000a5f 2c019d00 003bd902  .#....._,....;..
c00022e0 : 23300b63 6d64002c 019e0000 00810223  #0.cmd.,.......#
c00022f0 : 3c0b6c65 6e002c01 9f000000 81022340  <.len.,.......#@
c0002300 : 0d000049 7d2c01a0 00000081 0223440d  ...I},.......#D.
c0002310 : 0001d231 2c01a100 001a2e02 23480022  ...1,.......#H."
c0002320 : 00004158 00006b91 142c01a4 0b6f6800  ..AX..k..,...oh.
c0002330 : 2c01a500 003ebc02 23000b6c 656e002c  ,....>..#..len.,
c0002340 : 01a60000 00810223 0c0d0001 d2312c01  .......#.....1,.
c0002350 : a7000041 58022310 000e0400 00011722  ...AX.#........"
c0002360 : 00004189 000015dc 3c2c01ac 0b696800  ..A.....<,...ih.
c0002370 : 2c01ad00 003e5402 23000d00 000a5f2c  ,....>T.#....._,
c0002380 : 01ae0000 3bd90223 30002200 0041b400  ....;..#0."..A..
c0002390 : 006d2d70 2c01b10b 6f68002c 01b20000  .m-p,...oh.,....
c00023a0 : 3ebc0223 000d0001 952e2c01 b300003c  >..#......,....<
c00023b0 : f3022310 00220000 41ee0000 6da3a02c  ..#.."..A...m..,
c00023c0 : 01b80b69 68002c01 b900003e 54022300  ...ih.,....>T.#.

Problem is if I look at the disassemble code at start_here I see:

000022d0 <start_here>:
    22d0:	3c 40 00 00 	lis	r2,0
    22d4:	60 42 00 00 	ori	r2,r2,0
    22d8:	3c 82 40 00 	addis	r4,r2,16384
    22dc:	38 84 02 70 	addi	r4,r4,624
    22e0:	7c 93 43 a6 	mtsprg	3,r4
    22e4:	38 60 00 00 	li	r3,0
    22e8:	7c 72 43 a6 	mtsprg	2,r3

Which does not match at all what I see above and hence when I use the
command
"go":

BDI>go


- Target started with DBCR0 = 0x80800001

# Step timeout detected
BDI>info
    Target state      : debug mode
    Debug entry cause : JTAG stop request
    Current PC        : 0x00000700
    Current CR        : 0x00000000
    Current MSR       : 0x00001000
    Current LR        : 0x0021001c

I get an exception indicating that an invalid opcode was fetched.
I can't figure out what to try next - Any ideas?

Thanks
Jerry Walden

Below is my cfg file for the BDI-2000:

;

[INIT]
; init core register
WSPR	954	0x00000000      ;DCWR: Disable data cache write-thru
WSPR	1018	0x00000000	;DCCR: Disable data cache
WSPR	1019	0x00000000	;ICCR: Disable instruction cache
WSPR	982	0x00000000	;EVPR: Exception Vector Table @0x0000000

; Setup Peripheral Bus
WDCR	18	0x00000010	;Select PB0AP
WDCR	19	0x9B015480	;PB0AP: Flash and SRAM
WDCR	18	0x00000000	;Select PB0CR
WDCR	19	0xFFF18000	;PB0CR: 1MB at 0xFFF00000, r/w, 8bit
WDCR	18	0x00000011	;Select PB1AP
WDCR	19	0x02815480	;PB1AP: NVRAM and RTC
WDCR	18	0x00000001	;Select PB1CR
WDCR	19	0xF0018000	;PB1CR: 1MB at 0xF0000000, r/w, 8bit
WDCR	18	0x00000012	;Select PB2AP
WDCR	19	0x04815A80	;PB2AP: Keyboard and Mouse
WDCR	18	0x00000002	;Select PB2CR
WDCR	19	0xF0118000	;PB2CR: 1MB at 0xF0100000, r/w, 8bit
WDCR	18	0x00000013	;Select PB3AP
WDCR	19	0x01815280	;PB3AP: IRDA
WDCR	18	0x00000003	;Select PB3CR
WDCR	19	0xF0218000	;PB3CR: 1MB at 0xF0200000, r/w, 8bit
WDCR	18	0x00000017	;Select PB7AP
WDCR	19	0x01815280	;PB7AP: FPGA
WDCR	18	0x00000007	;Select PB7CR
WDCR	19	0xF0318000	;PB7CR: 1MB at 0xF0300000, r/w, 8bit



; Setup SDRAM Controller

WDCR	16	0x00000080	;Select SDTR1
WDCR	17	0x0086400D	;SDTR1: SDRAM Timing Register
WDCR	16	0x00000040	;Select MB0CF
WDCR	17	0x00046001	;MB0CF: 16MB @ 0x00000000
WDCR	16	0x00000048	;Select MB2CF
WDCR	17	0x01046001	;MB2CF: 16MB @ 0x01000000
WDCR	16	0x00000030	;Select RTR
WDCR	17	0x05F00000	;RTR: Refresh Timing Register
WDCR	16	0x00000020	;Select MCOPT1
WDCR	17	0x80800000	;MCOPT1: Enable SDRAM Controller

; Setup MMU info
WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
WM32    0x000000f8  0x00000000  ;invalidate process page table base
WM32    0x000000f0  0xc00000f4  ;invalidate page table base


[TARGET]
;WAKEUP      3000                ;wakeup time after reset
;VECTOR      CATCH               ;catch unhandled exceptions
;SIO         7 9600              ;TCP port for serial IO
JTAGCLOCK   1                   ;use 16 MHz JTAG clock
CPUTYPE     405 		;the used target CPU type
BDIMODE     AGENT   	        ;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   HARD      	        ;SOFT or HARD, HARD uses PPC hardware
breakpoint
STEPMODE    HWBP                ;JTAG or HWBP, HWPB uses one or two hardware
breakpoints
MMU         XLAT 0xC0000000     ;enable virtual address mode
PTBASE      0x000000f0          ;address where kernel/user stores pointer to
page table


;REGLIST     SPR                 ;select register to transfer to GDB
;REGLIST     ALL                 ;select register to transfer to GDB
;SCANPRED    2 2                 ;JTAG devices connected before PPC400
;SCANSUCC    3 3                 ;JTAG devices connected after PPC400

[HOST]
IP          192.168.0.123
FILE        /tftpboot/vmlinuz.bdi
FORMAT      BIN 0x00200000
START       0x00210000
LOAD        MANUAL              ;load code MANUAL or AUTO after reset
DEBUGPORT   2001
DUMP        /tmp/dump.bin            ;Linux: dump.bin must already exist and
public writable

[FLASH]
WORKSPACE   0x00004000  ;workspace in target RAM for fast programming
algorithm
CHIPTYPE    AM29F       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 |
I28BX16)
CHIPSIZE    0x80000     ;The size of one flash chip in bytes (e.g. AM29F040
= 0x80000)
BUSWIDTH    8           ;The width of the flash memory bus in bits (8 | 16 |
32)
FILE        u-boot.srec
ERASE       0xFFF80000  ;erase sector 0 of flash in U7 (AM29F040)
ERASE       0xFFF90000  ;erase sector 1 of flash
ERASE       0xFFFA0000  ;erase sector 2 of flash
ERASE       0xFFFB0000  ;erase sector 3 of flash
ERASE       0xFFFC0000  ;erase sector 4 of flash
ERASE       0xFFFD0000  ;erase sector 5 of flash
ERASE       0xFFFE0000  ;erase sector 6 of flash
ERASE       0xFFFF0000  ;erase sector 7 of flash

[REGS]
IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA
IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA
IDCR3	0x014	0x015	;KIAR and KIDR
FILE    reg405gp.def


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
