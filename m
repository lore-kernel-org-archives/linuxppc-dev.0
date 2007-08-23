Return-Path: <SRS0=wcvd=NU=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 23DBADDF48
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 15:52:09 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Need the bdi cfg file for taihu PPCEP405 Eval board
Date: Thu, 23 Aug 2007 07:52:49 +0200
References: <OF4E3437FA.70738D18-ON8525733F.00715D10-8525733F.007168AC@rflelect.com>
In-Reply-To: <OF4E3437FA.70738D18-ON8525733F.00715D10-8525733F.007168AC@rflelect.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xCSzG9IwLELkMtV"
Message-Id: <200708230752.49526.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_xCSzG9IwLELkMtV
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 22 August 2007, ravi.rao@rflelect.com wrote:
>    Can one of you please email me the bdi config file for Taihu Eval
> board. I need to attach bdi200 and do some debugging on that..

I don't have a config file for the Taihu, but I attached one for a board 
that's quite similar to the AMCC Taihu. Needs some small changes perhaps. 
Just give it a try.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================

--Boundary-00=_xCSzG9IwLELkMtV
Content-Type: text/plain;
  charset="iso-8859-15";
  name="zeus.cfg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="zeus.cfg"

;bdiGDB configuration file for Zeus for U-Boot
; --------------------------------------------
;
[INIT]
; init core register
WSPR	954	0x00000000      ;DCWR: Disable data cache write-thru
WSPR	1018	0x00000000	;DCCR: Disable data cache
WSPR	1019	0x00000000	;ICCR: Disable instruction cache
WSPR	982	0xFFF80000	;EVPR: Exception Vector Table @0x00000000

;
WDCR    0x0F9   0x00000010	; enable WR# (PCI_INT/WR# multiplexing)

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
WDCR	19	0x05815600	;PB0AP: NOR Flash/SRAM
WDCR	18	0x00000000	;Select PB0CR
WDCR	19	0xff09a000	;PB0CR: BAS=0xFF0,BS=4MB,BU=R/W,BW=16bit

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
WAKEUP      1000                ;wakeup time after reset
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
IP          10.0.0.152
FORMAT      BIN
FILE        /tftpboot/zeus/u-boot.bin
LOAD        MANUAL 	       ;load code MANUAL or AUTO after reset
DEBUGPORT   2001
PROMPT      zeus>

[FLASH]
WORKSPACE   0x100000  ;workspace in on-chip SRAM for fast programming algorithm
CHIPTYPE    MIRRORX16    ;Flash type
CHIPSIZE    0x1000000    ;16MB The size of one flash chip in bytes
BUSWIDTH    16          ;The width of the flash memory bus in bits (8 | 16 | 32)
FILE        /tftpboot/zeus/u-boot.bin
FORMAT      BIN 0xFFFC0000

; Erase just the last seven blocks for U-Boot
ERASE       0xFFFC0000
ERASE       0xFFFE0000

[REGS]
IDCR1	0x010	0x011	;MEMCFGADR and MEMCFGDATA
IDCR2	0x012	0x013	;EBCCFGADR and EBCCFGDATA
;IDCR3	0x014	0x015	;KIAR and KIDR
FILE    /tftpboot/BDI2000/reg405ep.def

--Boundary-00=_xCSzG9IwLELkMtV--
