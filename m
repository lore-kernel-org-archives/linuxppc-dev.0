Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D408B3A.F1FA16B@occamnetworks.com>
Date: Thu, 25 Jul 2002 16:35:22 -0700
From: Kedar Madineni <kedar@occamnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPMC8260 - bdi2000.cnf
References: <3D37126C.921CE9C6@occamnetworks.com>
Content-Type: multipart/mixed;
 boundary="------------5035719D605B8B38A21EA70C"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------5035719D605B8B38A21EA70C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here is a bdi2000 config file, that works with PPMC8260.

Thanks,
Kedar

Kedar Madineni wrote:
>
> Hi:
>
> I am looking for a working configuration file for the PPMC8260 board for
> use
> with bdi2000. If you have one, would you please share it and post it
> here.
>
> Thanks,
> Kedar
>
--------------5035719D605B8B38A21EA70C
Content-Type: text/plain; charset=us-ascii;
 name="bdi2000-ppmc8260.cnf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bdi2000-ppmc8260.cnf"

; -----------------------------------------------------------------------------
; Abatron bdiGDB configuration file for the Wind River ppmc8260
;
; This file has been tested with the following hardware:
;       Abatron BDI2000 firmware revision 1.10
;       PPMC8260-0074 PCA-00205-005 4101-0434 REV 10
;       XPC8260ZU166A (Mask 0K26N) CPU
;       256MB Synchronous DRAM DIMM
;       16MB Flash SIMM - StrataFlash 28F640J3A - (4Mx16)
;		2 Devices (32 bit)
;
; The h/w reset configuration word for this board is at
; 0xFE000000. This will be programmed to 0x1E848205 when you load ppcboot
; (at 0xfe000000). The default onboard is 0x1C840502. You can have the ppcboot
; live at 0xfe000000 and have the vware at 0xfff000e0 (so that it skips
; the first 32 bytes) when executing it at 0xfff00100. If you don't want
; ppcboot, you don't need to do anything.
; All the switches are default from the factory
; ------------------------------------------------------
;
[INIT]
WREG    MSR             0x00000000      ; clear MSR
; Normal setting
WM32    0xF00101A8      0xF0000000      ; IMMR == 0xF0000000
; If you ever erase the whole flash, use this setting for IMMR
;WM32    0x000101A8      0xF0000000      ; IMMR == 0x00000000
;
WM32    0xF0010000      0x42200000      ; SIUMCR
WM32    0xF0010004      0xFFFFFFC3      ; SYPCR == no watchdog
WM16    0xF001000E      0x0000      	; SWSR
WM32    0xF0010024      0xB0000000      ; BCR
WM8    	0xF0010028      0x22      	; PPC_ACR
WM32    0xF001002C      0x71234560      ; PPC_ALRH
WM32    0xF0010030      0x89ABCDEF      ; PPC_ALRL
WM8    	0xF0010038      0x02      	; LCL_ACR
WM32    0xF0010040      0x80020000      ; TESCR1
WM32    0xF0010C80      0x00000000      ; SCCR == normal operations
;
;TSZ4    0x00000000      0x03000000
;
; Memory controller
;
; These writes configure /CS0 to be the 2MB FLASH at 0xFE00000
; and /CS6 to be the 4MB FLASH at 0xE000000
; These writes configure:
;   CHIP SELECT     BASE ADDRESS    SIZE   COMMENTS
;   -----------     ------------    ----   --------
;     /CS0           0xFE000000      8MB   8MB ON BOARD FLASH
;
WM32    0xF0010100      0xFE001801      ; BR0
WM32    0xF0010104      0xFE000856      ; OR0
;
WM32    0xF0010110      0x00000041      ; BR2
WM32    0xF0010114      0xF8002500      ; OR2
;
WM32    0xF0010118      0x08000041      ; BR3
WM32    0xF001011C      0xF8002500      ; OR3
;
WM32    0xF0010120      0x38001861      ; BR4
WM32    0xF0010124      0xFF0030C0      ; OR4
;
WM32    0xF0010128      0x32000801      ; BR5
WM32    0xF001012C      0x3FFF06F6      ; OR5
;
WM32    0xF0010130      0x00000000      ; BR6
WM32    0xF0010134      0x00000000      ; OR6
;
WM32    0xF0010138      0xF1000801      ; BR7
WM32    0xF001013C      0xFFFF06F6      ; OR7
;
WM32    0xF0010140      0x00000000      ; BR8
WM32    0xF0010144      0x00000000      ; OR8
;
WM32    0xF0010148      0x00000000      ; BR9
WM32    0xF001014C      0x00000000      ; OR9
;
WM32    0xF0010150      0x00000000      ; BR10
WM32    0xF0010154      0x00000000      ; OR10
;
WM32    0xF0010158      0x00000000      ; BR11
WM32    0xF001015C      0x00000000      ; OR11
;
;
; Initialize the SDRAM on the 60x bus.
;
;WM32    0xF0010190      0xC265A562      ; PSDMR: normal

WM32	0xF0010168	0x00000200	; MAR
WM32	0xF0010170	0x00000000	; MAMR
WM32	0xF0010174	0x00000000	; MBMR
WM32	0xF0010178	0x00000000	; MCMR
WM16    0xF0010184      0x3200          ; MPTPR
WM32	0xF0010188	0x00000000	; MDR
WM32    0xF0010190      0x412EB45A      ; PSDMR
WM32    0xF0010194      0x4066A552      ; LSDMR:
;
WM8     0xF0010198      0x08            ; PURT
WM8     0xF001019C      0x0E            ; PSRT
;
WM8     0xF00101A0      0x08            ; LURT
WM8     0xF00101A4      0x0E            ; LSRT
;
WM32    0xF00101AC      0x00000000      ; PCIBR0
WM32    0xF00101B0      0x00000000      ; PCIBR1
WM32    0xF00101C4      0x00000000      ; PCIMSK0
WM32    0xF00101C8      0x00000000      ; PCIMSK1
WM16    0xF0010220      0x0000      	; TMCNTSC
WM32    0xF0010224      0x00000000     	; TMCNT
WM16    0xF0010240      0x0000     	; PISCR
WM32    0xF0010244      0x00000000     	; PITC
WM32    0xF0010248      0x00000000     	; PITR
;
WM16    0xF0010C00      0x0000     	; SICR
WM32    0xF0010C04      0x3C000000     	; SIVEC
WM32    0xF0010C08      0x00400000     	; SIPNR_H
WM32    0xF0010C10      0x05309770     	; SIPRR
WM32    0xF0010C14      0x05309770     	; SIPRR_H
WM32    0xF0010C18      0x05309770     	; SIPRR_L
WM32    0xF0010C1C      0x00000000     	; SIMR_H
WM32    0xF0010C20      0x00001800     	; SIMR_L
;
; IO Pin Configuration SETUP
WM32    0xF0010D00      0x00400000      ; PDIRA
WM32    0xF0010D04      0x00C00000      ; PPARA
WM32    0xF0010D08      0x00000000      ; PSORA
WM32    0xF0010D0C      0x00000000      ; PODRA
WM32    0xF0010D10      0x00C00000      ; PDATA
WM32    0xF0010D50      0x00403000      ; PDATC
WM32    0xF0010D60      0x00400000      ; PDIRD
WM32    0xF0010D64      0x00C00000      ; PPARD
WM32    0xF0010D70      0x00C30000      ; PDATD
WM16    0xF0010D94      0xFFFF      	; TRR1
WM16    0xF0010D96      0xFFFF      	; TRR2
WM16    0xF0010DA4      0xFFFF      	; TRR3
WM16    0xF0010DA6      0xFFFF      	; TRR4
;
WM32    0xF0010C80      0x00000001      ; SCCR
WM32    0xF0010C88      0x0831C001     	; SCMR
WM32    0xF0010C90      0x00000027     	; RSR
WM32    0xF0010C94      0x00000000     	; RMR
;
WM32    0xF00119F0      0x00011144     	; BRGC1
WM16    0xF0011A0E      0x7E7E     	; DSR1
WM16    0xF0011A2E      0x7E7E     	; DSR2
WM16    0xF0011A4E      0x7E7E     	; DSR3
WM16    0xF0011A6E      0x7E7E     	; DSR4
WM16    0xF0011A82      0x4823     	; SMCMR1
WM16    0xF0011A92      0x4823     	; SMCMR2
WM8    	0xF0011A98      0x03     	; SMCM2
WM16   	0xF0011AA0      0x0020     	; SPMODE
;
WM32    0xF0010190      0x212EB45A      ; PSDMR1:
WM8     0x00000000      0xFF            ; Access SDRAM:B0
WM8     0x08000000      0xFF            ; Access SDRAM:B0
WM32    0xF0010190      0x092EB45A      ; PSDMR2:
WM8     0x00000001      0xFF            ; Access SDRAM:B1
WM8     0x08000001      0xFF            ; Access SDRAM:B1
WM32    0xF0010190      0x192EB45A      ; PSDMR3
WM8     0x00000110      0xFF            ; Access SDRAM
WM8     0x08000110      0xFF            ; Access SDRAM
WM32    0xF0010190      0x412EB45A      ; PSDMR4
;
WM16    0xF001130C      0x7E7E     	; FDSR1
WM16    0xF001132C      0x7E7E     	; FDSR2
WM16    0xF001134C      0x7E7E     	; FDSR3
;
WM8    	0xF0011864      0xFF     	; I2ADD
WM8    	0xF0011868      0xFF     	; I2BRG
;
WM32    0xF00119F0      0x000100D6      ; BRGC1
WM32    0xF00119F4      0x000100D6      ; BRGC2
;
; To unprotect the flash for programming, enable the following
; lines - Thanks to Brad.Kemp@seranoa.com
;
;WM32	0xFE000000	0x60606060	; unprotect sequence
;WM32	0xFE000000	0xD0D0D0D0	; unprotect sequence

[TARGET]
CPUTYPE     8260        ;the CPU type (603EV,750,8240,8260)
JTAGCLOCK   0           ;use 16 MHz JTAG clock
BDIMODE     AGENT	;the BDI working mode (LOADONLY | AGENT | GATEWAY)
BREAKMODE   SOFT      	;SOFT or HARD, HARD uses PPC hardware breakpoints
DCACHE      FLUSH
VECTOR      CATCH       ;catch unhandled exceptions
;MMU         XLAT
PTBASE      0xF0	; try to put this is after I boot:
REGLIST     ALL
POWERUP     5000
;BOOTADDR    0xFFF00000
;SIO 2002 9600 ; TCP port for console
;
;STARTUP	RUN
;
;
[FLASH]
; 28F640J3A in 16 bit mode, sector size is 256 = 0x40000, Start address is 0xFE000000
CHIPTYPE    STRATAX16	;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x1000000    ;The size of one flash chip in bytes (e.g. AM29F010 = 0x20000)
BUSWIDTH    32           ;The width of the flash memory bus in bits (8 | 16 | 32 | 64)
;
;
FILE /bdi2000/ppcboot-ppmc8260.bin
WORKSPACE   	0xF0000000
FORMAT BIN 	0xfe000000
ERASE       	0xfe000000
;ERASE       	0xfe040000
;
;
[HOST]
;FORMAT   ROM
IP      10.0.0.1
;LOAD    MANUAL          ;load code MANUAL or AUTO after reset
;
;
[REGS]
DMM1    0xF0000000
FILE    /bdi2000/REG8260.DEF
;
; kmadineni@occamnetworks.com

--------------5035719D605B8B38A21EA70C--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
