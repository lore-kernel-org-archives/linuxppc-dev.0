Return-Path: <bouncefilter+linuxppc-embedded=wd=denx.de@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem Programming Flash using BDI2000 on MPC8260ADS board
Date: Fri, 15 Aug 2003 09:59:30 +0100
Message-ID: <DEF39A0710293E489D45B10E06645CBD021EA386@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


My goal is to program u-boot.srec into the MPC8260ADS.
I have configured the BDI with the following file:

; bdiGDB configuration file for MPC8260-ADS board
; -----------------------------------------------
;
[INIT]
; init core register
WREG    MSR             0x00000000      ;clear MSR
WM32	0x0F0101A8	0x04700000	;IMMR : internal space @ 0x04700000
WM32	0x04710004	0xFFFFFFC3	;SYPCR: disable watchdog
WM32	0x04710C80	0x00000001	;SCCR : normal operation

; init memory controller
WM32	0x04710104	0xFF800836	;OR0: Flash 8MB, CS early negate, 6 w.s., Timing relax
WM32	0x04710100	0xFF801801	;BR0: Flash @0xFF800000, 32bit, no parity
WM32	0x0471010C	0xFFFF8010	;OR1: BCSR 32KB, all types accesse, 1 w.s.
WM32	0x04710108	0x04501801	;BR1: BCSR @0x04500000, 32bit, no parity
WM32	0x04500004	0x3D000000	;BCSR1: enable RS232-1

; init SDRAM Init (PPC bus)
WM16	0x04710184	0x1900	        ;MPTPR: Divide Bus clock by 26
WM8	0x0471019C	0x21	        ;PSRT : Divide MPTPR output by 34
;WM8	0x0471019C	0x14	        ;PSRT : Divide MPTPR output by 21
WM32	0x04710114	0xFF000C80	;OR2  : 16MB, 2 banks, row start at A9, 11 rows
WM32	0x04710110	0x00000041	;BR2  : SDRAM @0x00000000, 64bit, no parity
WM32	0x04710190	0x296EB452	;PSDMR: Precharge all banks
WM8	0x00000000	0xFF	        ;Access SDRAM
WM32	0x04710190	0x096EB452	;PSDMR: CBR Refresh
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM8	0x00000000	0xFF	        ;Access SDRAM
WM32	0x04710190	0x196EB452	;PSDMR: Mode Set
WM8	0x00000000	0xFF	        ;Access SDRAM
WM32	0x04710190	0x416EB452	;PSDMR: enable refresh, normal operation

[TARGET]
CPUTYPE     8260        ;the CPU type (603EV,750,8240,8260)
JTAGCLOCK   0           ;use 16 MHz JTAG clock
BOOTADDR    0xfff00100  ;boot address used for start-up break
WORKSPACE   0x00000000	;workspace in target RAM for fast download
BDIMODE     AGENT     	;the BDI working mode (LOADONLY | AGENT | GATEWAY)
BREAKMODE   SOFT      	;SOFT or HARD, HARD uses PPC hardware breakpoints
;STEPMODE    HWBP        ;TRACE or HWBP, HWPB uses a hardware breakpoint
VECTOR      CATCH       ;catch unhandled exceptions
DCACHE      NOFLUSH	;data cache flushing (FLUSH | NOFLUSH)
;MMU         XLAT        ;translate effective to physical address
POWERUP     5000        ;start delay after power-up detected in ms
;REGLIST     SPR         ;select register to transfer to GDB
;REGLIST     ALL         ;select register to transfer to GDB
;VIO         7 9600       ;TCP port for virtual IO, BCSR1: enable RS232-1 !!!
;SIO         7 9600       ;TCP port for serial IO, check BCSR1: enable RS232-1 !!!

[HOST]
IP          10.121.10.150
FILE        u-boot.srec
;FILE        E:\cygnus\root\usr\demo\mpc8260\vxworks (B4)
;FILE        E:\cygnus\root\usr\demo\mpc8260\fibo.exe
FORMAT      SREC
;FORMAT      ELF (B4)
LOAD        MANUAL      ;load code MANUAL or AUTO after reset
DEBUGPORT   2001
PROMPT      BDI>	;new prompt for Telnet
DUMP        dump.bin
;DUMP        dump.bin            ;Linux: dump.bin must already exist and public writable

[FLASH]
CHIPTYPE    I28BX8      ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
;CHIPTYPE    AM29BX8
CHIPSIZE    0x200000    ;The size of one flash chip in bytes (e.g. AM29F010 = 0x20000) (B4)
BUSWIDTH    32          ;The width of the flash memory bus in bits (8 | 16 | 32 | 64) (B4)
;WORKSPACE   0x04700000  ;workspace in dual port RAM
WORKSPACE   0x00000000  ;workspace in SDRAM
;FILE        E:\tornado\target\config\ads8260\test.hex  ;The file to program
;FORMAT      SREC 0x01000000
;FILE        E:\cygnus\root\usr\demo\mpc8260\init8260.S3
FILE         u-boot.srec
;FILE        E:\cygnus\root\usr\demo\mpc8260\ads8260.sss (B4)

;
ERASE       0xFF800000  ;erase sector  0 of flash SIMM (LH28F016SCT)
ERASE       0xFF840000  ;erase sector  1 of flash SIMM
ERASE       0xFF880000  ;erase sector  2 of flash SIMM
ERASE       0xFF8C0000  ;erase sector  3 of flash SIMM
ERASE       0xFF900000  ;erase sector  4 of flash SIMM
ERASE       0xFF940000  ;erase sector  5 of flash SIMM
ERASE       0xFF980000  ;erase sector  6 of flash SIMM
ERASE       0xFF9C0000  ;erase sector  7 of flash SIMM
ERASE       0xFFA00000  ;erase sector  8 of flash SIMM
ERASE       0xFFA40000  ;erase sector  9 of flash SIMM
ERASE       0xFFA80000  ;erase sector 10 of flash SIMM
ERASE       0xFFAC0000  ;erase sector 11 of flash SIMM
ERASE       0xFFB00000  ;erase sector 12 of flash SIMM
ERASE       0xFFB40000  ;erase sector 13 of flash SIMM
ERASE       0xFFB80000  ;erase sector 14 of flash SIMM
ERASE       0xFFBC0000  ;erase sector 15 of flash SIMM
ERASE       0xFFC00000  ;erase sector 16 of flash SIMM
ERASE       0xFFC40000  ;erase sector 17 of flash SIMM
ERASE       0xFFC80000  ;erase sector 18 of flash SIMM
ERASE       0xFFCC0000  ;erase sector 19 of flash SIMM
ERASE       0xFFD00000  ;erase sector 20 of flash SIMM
ERASE       0xFFD40000  ;erase sector 21 of flash SIMM
ERASE       0xFFD80000  ;erase sector 22 of flash SIMM
ERASE       0xFFDC0000  ;erase sector 23 of flash SIMM
ERASE       0xFFE00000  ;erase sector 24 of flash SIMM
ERASE       0xFFE40000  ;erase sector 25 of flash SIMM
ERASE       0xFFE80000  ;erase sector 26 of flash SIMM
ERASE       0xFFEC0000  ;erase sector 27 of flash SIMM
ERASE       0xFFF00000  ;erase sector 28 of flash SIMM
ERASE       0xFFF40000  ;erase sector 29 of flash SIMM
ERASE       0xFFF80000  ;erase sector 30 of flash SIMM
ERASE       0xFFFC0000  ;erase sector 31 of flash SIMM

[REGS]
DMM1        0x04700000
FILE        reg8260.def
;FILE        E:\cygnus\root\usr\demo\mpc8260\reg8260.def (B4)

After telnet'ing into the BDI, and calling 'erase' on the command line,
all sectors are erased. I have confirmed by calling 'md 0xff800000' for
which area displayed the result is all FF's

### Problem #1
Again after erasing the whole flash, the prog command (see below) shows
progress and returns a valid response

BDI>prog 0xff800000 u-boot.srec SREC
Programming u-boot.srec , please wait ....
Programming flash passed

however, when reading back the flash the contents of the flash still
display all FF's

### Problem #2
After erasing the whole flash, If I reset the target via the 'reset'
command, and call 'md 0xff800000' again, I get the result shown below

BDI>md 0xff800000
ff800000 : ffff00ff ffff00ff ffff00ff ffff00ff  ................
ff800010 : ffff00ff ffff00ff ffff00ff ffff00ff  ................
...

I obviously have a problem here, either under the configuration file, or
somewhere on the eval board.

I would appreciate if somebody can give me a hand with this.

Thanks in advance

Joao Vicente,
Software Engineer.
Spectel Ltd.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
