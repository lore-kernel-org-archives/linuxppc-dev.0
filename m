Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 3209C685D8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Oct 2005 01:59:43 +1000 (EST)
To: "Peter Fercher" <peter.fercher@scs.ch>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1129910354_68740"
Date: Fri, 21 Oct 2005 17:59:27 +0200
Sender: wd@denx.de
Message-Id: <20051021155927.D6FAB35341A@atlas.denx.de>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: bdi2000 file for yosemite board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart MIME message.

--==_Exmh_1129910354_68740
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8bit
In-reply-to: Your message of "Fri, 21 Oct 2005 16:19:31 +0200."
	<008601c5d64a$743ebdc0$dbe5fed4@scsad.scs.ch>

In message <008601c5d64a$743ebdc0$dbe5fed4@scsad.scs.ch> you wrote:
> 
> does anybody have a clue where to get a yosemite (ppc440ep eval board from
> embedded planet) .cfg and .reg (configuration and register definition) file
> for the bdi2000 programmer to reprogramm the flash (write u-boot into flash)

Please see attachment.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Digital computers are themselves more complex than most things people
build: They have very large numbers of states. This makes conceiving,
describing, and testing them hard. Software systems  have  orders-of-
magnitude more states than computers do.           - Fred Brooks, Jr.


--==_Exmh_1129910354_68740
Content-Type: text/plain ; name="yosemite.cfg"; charset=us-ascii
Content-Description: yosemite.cfg
Content-Disposition: attachment; filename="yosemite.cfg"

;bdiGDB configuration file for IBM 440GX Reference Board
; ------------------------------------------------------
;
[INIT]
; Setup TLB
WTLB    0xF0000095  0x0F00003F  ;Boot Space 256MB
WTLB    0x00000094  0x0000003F  ;SDRAM 256MB @ 0x00000000
WTLB    0xd0000095  0x2000001B  ;PCI Page Entry
WTLB    0xe0000095  0x1400001B  ;Peripheral Page Entry
;
; Setup caches
WSPR    0x370   0x00000000      ;INV0
WSPR    0x371   0x00000000      ;INV1
WSPR    0x372   0x00000000      ;INV2
WSPR    0x373   0x00000000      ;INV3
WSPR    0x390   0x00000000      ;DNV0
WSPR    0x391   0x00000000      ;DNV1
WSPR    0x392   0x00000000      ;DNV2
WSPR    0x393   0x00000000      ;DNV3
WSPR    0x398   0x0001f800      ;DVLIM
WSPR    0x399   0x0001f800      ;IVLIM
;
; Setup Peripheral Bus
WDCR	0x12	0x00000010	;Select EBC0_B0AP
WDCR	0x13	0x04055200	;B0AP: Flash and SRAM
WDCR	0x12	0x00000000	;Select EBC0_B0CR
;WDCR	0x13	0xffc58000	;B0CR: 4MB at 0xFFC00000, r/w, 8bit
WDCR	0x13	0xffc5a000	;B0CR: 4MB at 0xFFC00000, r/w, 16bit
;WDCR	0x12	0x00000012	;Select EBC0_B2AP
;WDCR	0x13	0x05055200	;B2AP: 4 MB Flash
;WDCR	0x12	0x00000002	;Select EBC0_B2CR
;WDCR	0x13	0xff838000	;B2CR: 2MB at 0xFFE00000, r/w, 8bit
;
; Setup SDRAM Controller (DDR SDRAM)
WDCR	0x10	0x00000082	;Select SDRAM0_CLKTR
WDCR	0x11	0x40000000	;CLKTR: Advance 90 degrees
WDCR	0x10	0x00000080	;Select SDRAM0_TR0
WDCR	0x11	0x410a4012	;TR0:
WDCR	0x10	0x00000081	;Select SDRAM0_TR1
WDCR	0x11	0x8080080b	;TR1:
WDCR	0x10	0x00000040	;Select SDRAM0_B0CR
WDCR	0x11	0x000a4001	;B0CR:
WDCR	0x10	0x00000044	;Select SDRAM0_B1CR
WDCR	0x11	0x080a4001	;B1CR:
WDCR	0x10	0x00000030	;Select SDRAM0_RTR
WDCR	0x11	0x04080000	;RTR:
WDCR	0x10	0x00000020	;Select SDRAM0_CFG0
WDCR	0x11	0x34000000	;CFG0: enable SDRAM
WDCR	0x11	0x84000000	;CFG0: enable SDRAM
DELAY   100
;
; Setup default vector table
WSPR    0x03f   0x00000000      ;IVPR   vector base at 0x00000000
WSPR    0x190   0x00000100      ;IVOR0  Critical Input
WSPR    0x191   0x00000200      ;IVOR1  Machine Check
WSPR    0x192   0x00000300      ;IVOR2  Data Storage
WSPR    0x193   0x00000400      ;IVOR3  Instruction Storage
WSPR    0x194   0x00000500      ;IVOR4  External Input
WSPR    0x195   0x00000600      ;IVOR5  Alignment
WSPR    0x196   0x00000700      ;IVOR6  Program
WSPR    0x197   0x00000800      ;IVOR7  Reserved
WSPR    0x198   0x00000c00      ;IVOR8  System Call
WSPR    0x199   0x00000a00      ;IVOR9  Reserved
WSPR    0x19a   0x00001000      ;IVOR10 Decrementer
WSPR    0x19b   0x00001010      ;IVOR11 Fixed Interval Timer
WSPR    0x19c   0x00001020      ;IVOR12 Watchdog Timer
WSPR    0x19d   0x00001100      ;IVOR13 Data TLB Error
WSPR    0x19e   0x00001200      ;IVOR14 Instruction TLB Error
WSPR    0x19f   0x00000f00      ;IVOR15 Debug
;
; Clear DBCR1 and DBCR2
WSPR    0x135   0x00000000      ;DBCR1
WSPR    0x136   0x00000000      ;DBCR2


[TARGET]
JTAGCLOCK   0                   ;use 16 MHz JTAG clock
CPUTYPE     440 		;the used target CPU type
SCANMISC    8                   ;IR length is 8 bits for 440GX
WAKEUP      50                  ;wakeup time after reset
BREAKMODE   SOFT      	        ;SOFT or HARD, HARD uses PPC hardware breakpoint
STEPMODE    JTAG                ;JTAG or HWBP, HWBP uses one or two hardware breakpoints
;MMU         XLAT 0xC0000000     ;enable virtual address mode
;PTBASE      0x00000000          ;address where kernel/user stores pointer to page table
;SIO         7 9600              ;TCP port for serial IO
;REGLIST     ALL                 ;select register to transfer to GDB


[HOST]
IP          192.168.1.1
FILE        /tftpboot/yosemite/u-boot.bin
FORMAT      BIN
DUMP        /tftpboot/yosemite/dump.bin
PROMPT      440EP>


[FLASH]
; user flash at 0xff800000, AM29LV033C (4M x 8)
;WORKSPACE   0xFF800000  ;workspace in SRAM for fast programming algorithm
WORKSPACE   0x00100000  ;workspace in SDRAM for fast programming algorithm
CHIPTYPE    AM29BX16    ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x200000    ;The size of one flash chip in bytes
BUSWIDTH    16          ;The width of the flash memory bus in bits (8 | 16 | 32)
FILE        /tftpboot/yosemite/u-boot.bin
FORMAT      BIN 0xFFF80000
ERASE       0xFFF80000  ;erase sector 4
ERASE       0xFFF90000  ;erase sector 4
ERASE       0xFFFA0000  ;erase sector 4
ERASE       0xFFFB0000  ;erase sector 4
ERASE       0xFFFC0000  ;erase sector 4
ERASE       0xFFFD0000  ;erase sector 5
ERASE       0xFFFE0000  ;erase sector 6
ERASE       0xFFFF0000  ;erase sector 7

[REGS]
IDCR1	0x010	0x011	;SDRAM0_CFGADDR and SDRAM0_CFGDATA
IDCR2	0x012	0x013	;EBC0_CFGADDR   and EBC0_CFGDATA
IDCR3	0x014	0x015	;EBM0_CFGADDR   and EBM0_CFGDATA
IDCR4	0x016	0x017	;PPM0_CFGADDR   and PPM0_CFGDATA
IDCR5	0x00C	0x00D	;CPR0_CFGADDR   and CPR0_CFGDATA
IDCR6	0x00E	0x00F	;SDR0_CFGADDR   and SDR0_CFGDATA
DMM1    0xD0000000      ;PCI        (should map to 2_000_0000)
DMM2    0xE0000000      ;Peripheral (should map to 1_400_0000)
FILE    /tftpboot/BDI2000/reg440gx.def

--==_Exmh_1129910354_68740--
