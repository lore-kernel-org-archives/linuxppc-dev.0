Return-Path: <sr@denx.de>
Received: from natsluvver.rzone.de (natsluvver.rzone.de [81.169.145.176])
	by ozlabs.org (Postfix) with ESMTP id A79D9679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 00:19:18 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite board ala, PPC405EP
Date: Thu, 9 Mar 2006 14:18:46 +0100
References: <OF983EDDB6.1E8E12C2-ON8525712B.00750324@teal.com>
	<440F4DA2.3040706@ovro.caltech.edu>
In-Reply-To: <440F4DA2.3040706@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3sCEExypgsbsuZY"
Message-Id: <200603091418.47502.sr@denx.de>
Cc: Jeff.Fellin@rflelect.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_3sCEExypgsbsuZY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday, 8. March 2006 22:33, David Hawkins wrote:
> > Sorry, I was confused. I have a PPC405EP. not a Yosemite board.
>
> Ok, sorry then, I can't help.
>
> Take a look at the Denx web site, they have a bunch of
> BDI2000 configuration files, I'm not sure whether they
> have a 405EP, but take a look.

Yes, we have. Take a look at the attached bubinga config file (AMCC 405EP 
evaluation board).

The 405EP is quite different from the 405GP(r) regarding it initialization. 
The PLL is setup normally not via strapping pins as on the 405GP(r) but by 
reading values from a EEPROM. This can behavior can be configured by one 
strapping pin (don't know which one right now). Please take a look at the PLL 
setup in the BDI config file.

Best regards,
Stefan

--Boundary-00=_3sCEExypgsbsuZY
Content-Type: text/plain;
  charset="iso-8859-1";
  name="bubinga.cfg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="bubinga.cfg"

;bdiGDB configuration file for PPChameleonEVB for U-Boot
; ------------------------------------------------------
;
[INIT]
; init core register
WSPR	954	0x00000000      ;DCWR: Disable data cache write-thru
WSPR	1018	0x00000000	;DCCR: Disable data cache
WSPR	1019	0x00000000	;ICCR: Disable instruction cache
WSPR	982	0xFFF80000	;EVPR: Exception Vector Table @0x00000000

;
WDCR    0x0F9   0x08000000

; Setup PLL
; CPU=133MHz
; PLB=133MHz
; OPB=66MHz
; EBC=33MHz
WDCR    0x0F0    0x00001203
WDCR    0x0F4    0x8042223E


; Setup Peripheral Bus

; CS0 (default mode)
WDCR	18	0x00000010	;Select PB0AP
WDCR	19	0x92015480	;PB0AP: NOR Flash/SRAM
WDCR	18	0x00000000	;Select PB0CR
;WDCR	19	0xFFC5A000	;PB0CR: BAS=0xFFC,BS=4MB,BU=R/W,BW=16bit
WDCR	19	0xFFC58000	;PB0CR: BAS=0xFFC,BS=4MB,BU=R/W,BW=8bit
WDCR	18	0x00000011	;Select PB1AP
WDCR	19	0x92015480	;PB1AP: SRAM/NOR Flash
WDCR	18	0x00000001	;Select PB1CR
WDCR	19	0xFF85A000	;PB1CR: BAS=0xFF8,BS=4MB,BU=R/W,BW=16bit




;WDCR	18	0x00000011	;Select PB1AP
;WDCR	19	0x02815480	;PB1AP: NVRAM and RTC
;WDCR	18	0x00000001	;Select PB1CR
;WDCR	19	0xF0018000	;PB1CR: 1MB at 0xF0000000, r/w, 8bit
;WDCR	18	0x00000012	;Select PB2AP
;WDCR	19	0x04815A80	;PB2AP: Keyboard and Mouse
;WDCR	18	0x00000002	;Select PB2CR
;WDCR	19	0xF0118000	;PB2CR: 1MB at 0xF0100000, r/w, 8bit
;WDCR	18	0x00000013	;Select PB3AP
;WDCR	19	0x01815280	;PB3AP: IRDA
;WDCR	18	0x00000003	;Select PB3CR
;WDCR	19	0xF0218000	;PB3CR: 1MB at 0xF0200000, r/w, 8bit
;WDCR	18	0x00000017	;Select PB7AP
;WDCR	19	0x01815280	;PB7AP: FPGA
;WDCR	18	0x00000007	;Select PB7CR
;WDCR	19	0xF0318000	;PB7CR: 1MB at 0xF0300000, r/w, 8bit



; Setup SDRAM Controller
WDCR	16	0x00000080	;Select SDTR1
WDCR	17	0x01074015	;SDTR1: SDRAM Timing Register
WDCR	16	0x00000040	;Select MB0CF
WDCR	17	0x00084001	;MB0CF: 16MB @ 0x00000000
WDCR	16	0x00000030	;Select RTR
WDCR	17	0x07f00000	;RTR: Refresh Timing Register
WDCR	16	0x00000020	;Select MCOPT1
WDCR	17	0x80800000	;MCOPT1: Enable SDRAM Controller


; Setup MMU info - these lines must be uncommented to debug Linux kernel
;WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
;WM32    0x000000f8  0x00000000  ;invalidate process page table base
;WM32    0x000000f0  0xc00000f4  ;invalidate page table base

; Setup OCM
WDCR    0x01A   0xEC000000
WDCR    0x01B   0xC0000000

[TARGET]
JTAGCLOCK   0                   ;use 16 MHz JTAG clock
CPUTYPE     405 		;the used target CPU type
BDIMODE     AGENT   	        ;the BDI working mode (LOADONLY | AGENT)
WAKEUP      2000                ;wakeup time after reset
BREAKMODE   HARD      	        ;SOFT or HARD, HARD uses PPC hardware breakpoint
STEPMODE    HWBP                ;JTAG or HWBP, HWPB uses one or two hardware breakpoints
;VECTOR      CATCH               ;catch unhandled exceptions
;MMU         XLAT 0xC0000000     ;enable virtual address mode
;PTBASE      0x000000f0          ;address where kernel/user stores pointer to page table
;SIO         7 9600              ;TCP port for serial IO

;REGLIST     SPR                 ;select register to transfer to GDB
REGLIST      ALL                 ;select register to transfer to GDB
;SCANPRED    2 2                 ;JTAG devices connected before PPC400
;SCANSUCC    3 3                 ;JTAG devices connected after PPC400

[HOST]
IP           192.168.1.1
FORMAT       BIN
FILE         /tftpboot/bubinga/u-boot.bin
LOAD        MANUAL 	       ;load code MANUAL or AUTO after reset
DEBUGPORT   2001
PROMPT      PPC405EP>

[FLASH]
; ###FIXME### - workspace does not work with onchip memory
WORKSPACE   0x100000  ;workspace in on-chip SRAM for fast programming algorithm
; WORKSPACE   0  ;workspace in on-chip SRAM for fast programming algorithm
;CHIPTYPE    AM29BX16       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
;CHIPSIZE    0x400000    ;The size of one flash chip in bytes (e.g. AM29F040 = 0x80000)
;BUSWIDTH    16           ;The width of the flash memory bus in bits (8 | 16 | 32)
CHIPTYPE    AM29F       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x80000    ;The size of one flash chip in bytes (e.g. AM29F040 = 0x80000)
BUSWIDTH    8           ;The width of the flash memory bus in bits (8 | 16 | 32)
FILE        /tftpboot/bubinga/u-boot.bin
FORMAT      BIN   0xFFFC0000

; erase whole Flash
;ERASE       0xFFC00000 CHIP
; Erase just the last seven blocks for U-Boot
ERASE       0xFFFC0000
ERASE       0xFFFD0000
ERASE       0xFFFE0000
ERASE       0xFFFF0000

[REGS]
IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA
IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA
;IDCR3	0x014	0x015	;KIAR and KIDR
FILE    /tftpboot/BDI2000/reg405ep.def

--Boundary-00=_3sCEExypgsbsuZY--
