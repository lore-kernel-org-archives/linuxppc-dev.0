Message-Id: <5.1.1.6.0.20030330184543.00a832e0@dns.struinfo.it>
Date: Sun, 30 Mar 2003 19:52:41 +0200
To: linuxppc-embedded@lists.linuxppc.org
From: llandre <r&d@wawnet.biz>
Subject: Script for BDI2000 for IBM 405EP Eval. Board
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all!

I've just start working with the IBM 405EP Evaluation Board. Currently I'm
trying to port the U-Boot boot loader. I use the Abatron BDI2000 as JTAG
interface with the GDB/DDD and I debug the code in the 512kB SRAM that can
be exchanged with the Flash.
Unfortunately the example script (evb405gp.cfg) BDI2000 comes with is
written for the 405GP ev. board (Walnut). I changed it to make it suitable
for the 405EP board that is quite similar to the Walnut. For convenience I
copied mine at the end of the message. I removed a lot of initailizations
in order to simulate the state of the CPU after a reboot.

Since I have some strange behaviours, I think the script could be somehow
wrong.
Here is what happens:
1) Sometimes the processor jumps to 0x700. This usually occurs during the
execution of a printf function or when the CPU executes a mtmsr
instruction. For example there is a mtmsr instruction at the end of
interrupt_init function. I noted that this instruction does not make the
CPU to jump to 0x700 during the first debug session, I mean just after
power up, but it does if I start a new debug session without turning off
and on the board (even the RESET command from telnet nor the reset button
on the board are useful).
2) From telnet I can erase the Flash without any problem, but I can't
complete its programming. The PROG command crashes at a random address.

So my questions are:
1) Anybody encountered similar problems with this board?
2) Anybody can send me a script that is certainly correct?
3) Any other suggestions?

Many thanks in advance.


*************************************************************************
;bdiGDB configuration file for IBM 405EP Reference Board for U-Boot
; -----------------------------------------------------------------
;
[INIT]
; init core register
;WSPR   954     0x00000000      ;DCWR: Disable data cache write-thru
;WSPR   1018    0x00000000      ;DCCR: Disable data cache
;WSPR   1019    0x00000000      ;ICCR: Disable instruction cache
;WSPR   982     0x00000000      ;EVPR: Exception Vector Table @0x00000000

; Setup Peripheral Bus
WDCR    18      0x00000010      ;Select PB0AP
WDCR    19      0x9B015480      ;PB0AP: Flash and SRAM
WDCR    18      0x00000000      ;Select PB0CR
WDCR    19      0xFFF18000      ;PB0CR: 1MB at 0xFFF00000, r/w, 8bit

;WDCR   18      0x00000011      ;Select PB1AP
;WDCR   19      0x02815480      ;PB1AP: NVRAM and RTC
;WDCR   18      0x00000001      ;Select PB1CR
;WDCR   19      0xF0018000      ;PB1CR: 1MB at 0xF0000000, r/w, 8bit
;WDCR   18      0x00000012      ;Select PB2AP
;WDCR   19      0x04815A80      ;PB2AP: Keyboard and Mouse
;WDCR   18      0x00000002      ;Select PB2CR
;WDCR   19      0xF0118000      ;PB2CR: 1MB at 0xF0100000, r/w, 8bit
;WDCR   18      0x00000013      ;Select PB3AP
;WDCR   19      0x01815280      ;PB3AP: IRDA
;WDCR   18      0x00000003      ;Select PB3CR
;WDCR   19      0xF0218000      ;PB3CR: 1MB at 0xF0200000, r/w, 8bit
;WDCR   18      0x00000017      ;Select PB7AP
;WDCR   19      0x01815280      ;PB7AP: FPGA
;WDCR   18      0x00000007      ;Select PB7CR
;WDCR   19      0xF0318000      ;PB7CR: 1MB at 0xF0300000, r/w, 8bit

; Setup SDRAM Controller
;WDCR   16      0x00000080      ;Select SDTR1
;WDCR   17      0x0086400D      ;SDTR1: SDRAM Timing Register
;WDCR   16      0x00000040      ;Select MB0CF
;WDCR   17      0x00046001      ;MB0CF: 16MB @ 0x00000000
;WDCR   16      0x00000048      ;Select MB2CF
;WDCR   17      0x01046001      ;MB2CF: 16MB @ 0x01000000
;WDCR   16      0x00000030      ;Select RTR
;WDCR   17      0x05F00000      ;RTR: Refresh Timing Register
;WDCR   16      0x00000020      ;Select MCOPT1
;WDCR   17      0x80800000      ;MCOPT1: Enable SDRAM Controller

; Setup MMU info
;WM32    0x000000f4  0x00000000  ;invalidate kernel  page table base
;WM32    0x000000f8  0x00000000  ;invalidate process page table base
;WM32    0x000000f0  0xc00000f4  ;invalidate page table base

[TARGET]
JTAGCLOCK   0                   ;use 16 MHz JTAG clock
CPUTYPE     405                 ;the used target CPU type
BDIMODE     AGENT               ;the BDI working mode (LOADONLY | AGENT)
;WAKEUP      3000                ;wakeup time after reset
BREAKMODE   HARD                ;SOFT or HARD, HARD uses PPC hardware
breakpoint
STEPMODE    HWBP                ;JTAG or HWBP, HWPB uses one or two
hardware breakpoints
;VECTOR      CATCH               ;catch unhandled exceptions
;MMU         XLAT 0xC0000000     ;enable virtual address mode
;PTBASE      0x000000f0          ;address where kernel/user stores pointer
to page table
;SIO         7 9600              ;TCP port for serial IO

;REGLIST     SPR                 ;select register to transfer to GDB
REGLIST     ALL                 ;select register to transfer to GDB
;SCANPRED    2 2                 ;JTAG devices connected before PPC400
;SCANSUCC    3 3                 ;JTAG devices connected after PPC400

[HOST]
IP           192.168.10.6      ;Linux host
;IP          151.120.25.119      ;Windows host
;FILE        E:\cygwin\home\bdidemo\evb405\vxworks
;FORMAT      ELF
FILE        /tftpboot/u-boot
FILE        u-boot
FORMAT      ELF
START       0xFFFFFFFC
LOAD        MANUAL        ;load code MANUAL or AUTO after reset
;LOAD        AUTO
DEBUGPORT   2001
;DUMP        E:\temp\dump.bin
DUMP        dump.bin            ;Linux: dump.bin must already exist and
public writable
PROMPT      PPC405EP>

[FLASH]
WORKSPACE   0x00004000  ;workspace in target RAM for fast programming algorithm
CHIPTYPE    AM29F       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 |
I28BX16)
CHIPSIZE    0x80000     ;The size of one flash chip in bytes (e.g. AM29F040
= 0x80000)
BUSWIDTH    8           ;The width of the flash memory bus in bits (8 | 16
| 32)
FILE        E:\cygwin\home\bdidemo\evb405\evb405gp.sss  ;The file to program
ERASE       0xFFF80000  ;erase sector 0 of flash in U7 (AM29F040)
ERASE       0xFFF90000  ;erase sector 1 of flash
ERASE       0xFFFA0000  ;erase sector 2 of flash
ERASE       0xFFFB0000  ;erase sector 3 of flash
ERASE       0xFFFC0000  ;erase sector 4 of flash
ERASE       0xFFFD0000  ;erase sector 5 of flash
ERASE       0xFFFE0000  ;erase sector 6 of flash
ERASE       0xFFFF0000  ;erase sector 7 of flash

[REGS]
IDCR1   0x010   0x011   ;MEMCFGADR and MEMCFGDATA
IDCR2   0x012   0x013   ;EBCCFGADR and EBCCFGDATA
;IDCR3  0x014   0x015   ;KIAR and KIDR
;FILE    E:\cygwin\home\bdidemo\evb405\reg405gp.def
FILE    reg405ep.def
*************************************************************************

llandre

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
