Date: Thu, 20 Feb 2003 14:48:12 -0500
From: Kent Borg <kentborg@borg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bringing up Motorola MGT5100
Message-ID: <20030220144812.D24949@borg.org>
References: <20030220142703.A24949@borg.org> <20030220193611.GB24845@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030220193611.GB24845@ip68-0-152-218.tc.ph.cox.net>; from trini@kernel.crashing.org on Thu, Feb 20, 2003 at 12:36:11PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 20, 2003 at 12:36:11PM -0700, Tom Rini wrote:
> Bad config.  Can you post it please?

If you could spot any obvious errors in here, I would love that.

Thanks,

-kb




; bdiGDB configuration file for the MGT5100 evaluation board
; ----------------------------------------------------------
;
[INIT]
; init core register
WREG    MSR             0x00001002      ;MSR  : ME,RI
WM32	0x80000000      0x0001e000      ;MBAR : internal registers at 0xf0000000
WSPR    279             0xf0000000      ;SPRG7: save internal register offset
;
; init memory controller
;WM32    0x80000004      0x0001ffe0      ;CS0STR: start = 0xfff00000
;WM32    0x80000008      0x0001ffef      ;CS0STP: stop  = 0xfff7ffff
;WM32    0x80000300      0x00047800      ;CS0CR: ctrl
;WM32    0x80000054      0x00410000      ;ADREN: enable CS0, disable CSBOOT
;
WM32    0xf000004c      0x0001ff00      ;BOOTSTR: start = 0xff800000
WM32    0xf0000050      0x0001ffff      ;BOOTSTP: stop  = 0xffffffff
WM32    0xf0000300      0x00043801      ;CS0CR:
;
WM32    0xf0000034      0x00000000      ;SDRAMSTR: Start = 0x00000000
WM32    0xf0000038      0x000007ff      ;SDRAMSTP: Stop  = 0x03ffffff
WM32    0xf0000054      0x02400000      ;ADREN: SDRAM enable
WM32    0xf0000108      0xc2222600      ;SDRAM Config 1
WM32    0xf000010c      0x88b70004      ;SDRAM Config 2
WM32    0xf0000110      0x03000000      ;SDRAM Adrsel
WM32    0xf0000104      0xd14f0000      ;SDRAM Control
WM32    0xf0000104      0xd14f0002      ;SDRAM Control
WM32    0xf0000104      0xd14f0004      ;SDRAM Control
WM32    0xf0000100      0x008d0000      ;SDRAM Mode
WM32    0xf0000104      0x514f0000      ;SDRAM Control

; define maximal transfer size
TSZ4    0xFF800000      0xFFFFFFFF      ;ROM space
TSZ4    0xF0000000      0xF0003FFF      ;internal registers

; define the valie memory map
MMAP    0x00000000      0x03FFFFFF      ;Memory range for SDRAM
MMAP    0xF0000000      0xF0003FFF      ;Memory map for Internal Register
MMAP    0xF0040000      0xF0005FFF      ;Memory map for On-chip SRAM

; Setup MMU info
WM32    0x000000f0  0x00000000  ;invalidate page table pointer pointer


[TARGET]
CPUTYPE     5100        ;the CPU type
JTAGCLOCK   0           ;use 16 MHz JTAG clock
WORKSPACE   0x02000000	;workspace for fast download and cache flush
BDIMODE     AGENT   	;the BDI working mode (LOADONLY | AGENT)
;STARTUP     STOP 5000
WAKEUP      1000        ;give reset time to complete
BREAKMODE   HARD      	;SOFT or HARD, HARD uses PPC hardware breakpoint
;MMU         XLAT	;translate effective to physical address
PTBASE      0x000000f0  ;here is the pointer to the page table pointers
DCACHE      NOFLUSH
;VECTOR      CATCH       ;catch unhandled exceptions
;MEMDELAY    2000        ;additional memory access delay
;PARITY      ON          ;enable data parity generation

[HOST]
; in the copy in your /tftpboot directory, uncomment the line that is yours
IP		199.10.246.44  ; rome
;IP		199.10.246.18  ; vienna
;FILE        E:\cygwin\home\bdidemo\mpc4200\fibo.exe
;FILE        E:\cygwin\home\bdidemo\mpc4200\eppc_c_isr.elf
;FILE        vmlinux
FILE        linux.bin
FORMAT       BIN
;FORMAT      ELF
;LOAD        MANUAL      ;load code MANUAL or AUTO after reset

[FLASH]

[REGS]
DMM1        0xF0000000  ;dBug remaps IPIB to 0xF0000000
FILE        reg5100.def

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
