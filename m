Return-Path: <pdfdoc15@yahoo.com>
Received: from web37109.mail.mud.yahoo.com (web37109.mail.mud.yahoo.com
	[209.191.85.111]) by ozlabs.org (Postfix) with SMTP id 77BF567B87
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 02:40:25 +1000 (EST)
Message-ID: <20060614164023.83004.qmail@web37109.mail.mud.yahoo.com>
Date: Wed, 14 Jun 2006 09:40:23 -0700 (PDT)
From: Om Vadlapatla <pdfdoc15@yahoo.com>
Subject: board initialization problem
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>,
	"U-Boot-Users@lists.sourceforge.net" <U-Boot-Users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1228222616-1150303223=:82247"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1228222616-1150303223=:82247
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

K0: Original Montavista kernel
K1: Kernel without D-cache Adapted for 4x60(SDH 2/6
ch)
K2: Kernel with D-cache enabled for 4160 (SDH 6 ch)

Difference between K1 & K2: 
1. D-cache (~/kernel2.4.17/arch/ppc/kernel/head.S)
here only one line difference.

2. Page table & cache buffer allocation
(~/kernel2.4.17/arch/ppc/8260_io/comproc.c)
I can send the difference only 4 lines only setting
the  buffer arrays.

Target: 4160 (compat SDH unit)
Abatron: Jtag Debugger 

fw4x60.cfg: old config file for Abatron
fw8270.cfg: new config file for Abatron

The tests tried using U-BOOT:

1. Loaded K1 onto target independent of Abatron

2. Loaded K2 onto target with Abatron fw8270.cfg 
   
     ran busy looptest for K1 & K2 result: K2 40 times
faster

3. Tried to load K2 to target without Abatron result:
Failed

Conclusions & comments:

There are significant differences between fw4x60.cfg &
fw8270.cfg.
These differences need to be incorporated in the new
Kernel (OR I am not sure about it but may be into the
Boot-loader).

Core Initialization file in kernel: 
~/kernel2.4.17/arch/ppc/kernel/head.S

Speculated changes:
~/kernel2.4.17/arch/ppc/8260_io/comproc.c
It was speculated that the cached buffers triggered
the exception. And commproc.c was modified to make
those buffers uncacheable. But that made things worse:
invalidate_dcache_range() and flush_tlb_page() cause
another exception to occur (not identified).

U-boot initialization files:
~/u-boot/cpu/mpc8260 
start.S, cpu_init.c

Both these files in u-boot are  meant to initialize
the core & MMU.

If the config changes need to go into the kernel I am
not sure if it is the head.S file.

If the config changes need to go into the boot loader
I am not sure while the kernel opperates if there will
be any unpredictable behaviour.

Irrespective of where the changes go, the main task is
to analize each difference between fw4x60.cfg &
fw8270.cfg and develope the initialization code. 

If any one has another plan of action please let me
know, I appreciate guidance. 

Attached are the two config files.

Sincerely,
Om Vadlapatla

PS:- All I need is to load the new kernel with out a
glitch coz I can do it with the Abatron pluged in.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-1228222616-1150303223=:82247
Content-Type: text/plain; name="fw4x60.cfg.txt"
Content-Description: 1384370366-fw4x60.cfg.txt
Content-Disposition: inline; filename="fw4x60.cfg.txt"

; -----------------------------------------------------------------------------
; Abatron bdiGDB configuration file for the FW4X60 platform
; single board computer running MontaVista Linux.
;
; The physical memory map is as follows:
;       0x00000000 - 0x0FFFFFFF         256MB 60x SDRAM on CS1 and CS2
;       0x30000000 - 0x33FFFFFF         64MB local SDRAM on CS5
;       0x40000000 - 0x41FFFFFF         32MB FPGA on CS6
;       0x50000000 - 0x50FFFFFF         16MB RTC on CS7
;       0x80000000 - 0x80007FFF         32KB IDE on CS9
;       0xF0000000 - 0xF001FFFF         128KB MPC8260 internal memory
;       0xFFE00000 - 0xFFFFFFFF         2MB Flash on CS0
; -----------------------------------------------------------------------------
;
[INIT]
WM32    0x000101A8      0xF0000000      ; IMMR (relocate internal memory)
WREG    MSR             0x00000000      ; clear MSR
;WM32   0xF0010000      0x0A200000      ; SIUMCR
WM32    0xF0010004      0xFFFFFFC3      ; SYPCR (no watchdog)
WM32    0xF0010C80      0x00000001      ; SCCR
WM32    0xF0010024      0x80808000      ; BCR
WM8     0xF0010028      0x26            ; PPC_ACR:
WM32    0xF0010040      0x00004000      ; TESCR1:
WM32    0xF0010048      0x00004000      ; L_TESCR1:
;
;
; Memory controller
WM32    0xF0010104      0xFF000C54      ; OR0
WM32    0xF0010100      0xFF001001      ; BR0
;WM32   0xF0010100      0xFFE01001      ; BR0
;WM32   0xF0010104      0xFFE00844      ; OR0
WM32    0xF0010134      0xFE000008      ; OR6 FPGA
WM32    0xF0010130      0x40001001      ; BR6
WM32    0xF001013C      0xFF000C0C      ; OR7 RTC
WM32    0xF0010138      0x50001001      ; BR7
WM32    0xF001014C      0xFFFF8008      ; OR9 IDE
WM32    0xF0010148      0x80001001      ; BR9
;
;
; Initialize the SDRAM on the 60x bus.
;
WM32    0xF001010C      0xF8002B00      ; OR1
WM32    0xF0010108      0x00000049      ; BR1
WM32    0xF0010114      0xF8002B00      ; OR2
WM32    0xF0010110      0x08000049      ; BR2
WM16    0xF0010184      0x4000          ; MPTPR
WM8     0xF001019C      0x7             ; PSRT
WM32    0xF0010190      0xAAAE245E      ; PSDMR: Precharge all banks
WM8     0x00000000      0xFF            ; Access SDRAM
WM32    0xF0010190      0x8AAE245E      ; PSDMR: CBR Refresh
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM8     0x00000000      0xFF            ; Access SDRAM
WM32    0xF0010190      0x9AAE245E      ; PSDMR: Mode Register Write
WM8     0x00000000      0xFF            ; Access SDRAM
WM32    0xF0010190      0xC2AE245E      ; PSDMR: Normal operation and refresh enable
;
; Initialize the SDRAM on the local bus.
;
WM32    0xF001012C      0xFC002D00      ; OR5
WM32    0xF0010128      0x30001861      ; BR5
WM8     0xF00101A4      0x7             ; LSRT
WM32    0xF0010194      0xAA6A2556      ; LSDMR: Precharge all banks
WM8     0x30000000      0xFF            ; Access SDRAM
WM32    0xF0010194      0x8A6A2556      ; LSDMR: CBR Refresh
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM8     0x30000000      0xFF            ; Access SDRAM
WM32    0xF0010194      0x9A6A2556      ; LSDMR: Mode Register Write
WM8     0x30000000      0xFF            ; Access SDRAM
WM32    0xF0010194      0xC26A2556      ; LSDMR: Normal operation and refresh enable
;
WM16    0x50800206      0x2000          ; Disable flash write protection
;
;
[TARGET]
CPUTYPE         8270                    ; 603EV, 750, 8240, 8260, 750CX, or 7400
BDIMODE         AGENT                   ; LOADONLY or AGENT
STARTUP         RESET                   ; RESET, STOP, or RUN
JTAGCLOCK       3                       ; 0=16.6MHz, 1=8.3MHz, 2=5.5MHz, 3=4.1MHz
BOOTADDR        0xFFF00100              ; 0xFFF00100 or 0x00000100
WORKSPACE       0x00000000              ; use SDRAM for 256 byte workspace
BREAKMODE       HARD                    ; SOFT or HARD
VECTOR          CATCH                   ; catch unhandled exceptions
DCACHE          NOFLUSH                 ; FLUSH or NOFLUSH
POWERUP         3000
WAKEUP          3000
MMU             XLAT 0xC0000000         ; kernel virtual base address
PTBASE          0x000000F0              ; address of page table pointer array
SIO             7 9600
;
;
;
[FLASH]
CHIPTYPE        AM29BX16                ; AM29F, AM29BX8, AM29BX16, I28BX8, I28BX16,
                                        ; AT49, AT49X8, AT49X16, STRATAX8, STRATAX16
CHIPSIZE        0x200000                ; size of one flash chip in bytes
BUSWIDTH        16                      ; flash bus width (8, 16, 32, or 64)
WORKSPACE       0xF0000000              ; use MPC8270 internal RAM for 2KB workspace
ERASE           0xFFE00000 CHIP         ; erase entire Flash SIMM
;
;
;
[HOST]
IP              172.30.10.7             ; IP address of tftp server
FILE            vmlinuz-est-sbc8260
FORMAT          IMAGE 0x0               ; SREC, BIN, AOUT, ELF, IMAGE, or ROM
LOAD            MANUAL                  ; MANUAL or AUTO
DEBUGPORT       2001                    ; TCP port number for GDB
PROMPT          FW4X60>                 ; Telnet prompt string
DUMP            dump.bin                ; default filename for DUMP command
;
;
;
[REGS]
DMM1            0xF0000000
FILE            abatron/reg8260.def

--0-1228222616-1150303223=:82247
Content-Type: application/octet-stream; name="FW8270.CFG"
Content-Transfer-Encoding: base64
Content-Description: 1432833698-FW8270.CFG
Content-Disposition: attachment; filename="FW8270.CFG"

OyBiZGlHREIgY29uZmlndXJhdGlvbiBmaWxlIGZvciBNUEM4MjcwDQo7IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo7DQpbSU5JVF0NCjsgaW5pdCBjb3JlIHJlZ2lzdGVyKE1BU1RFUikNCldS
RUcgICAgTVNSICAgICAgICAgICAgIDB4MDAwMDAwMDAgICAgICA7Y2xlYXIg
TVNSDQo7V00zMgkweEYwMDEwMUE4CTB4RjAwMDAwMDAJO0lNTVIgOiBpbnRl
cm5hbCBzcGFjZSBAIDB4RjAwMDAwMDANCldNMzIJMHhGMDAxMDAwNAkweEZG
RkZGRkMzCTtTWVBDUjogZGlzYWJsZSB3YXRjaGRvZw0KV00zMgkweEYwMDEw
MDI0CTB4ODA4MDAwMDAJO0JDUjoNCldNOAkweEYwMDEwMDI4CTB4MjYJO1BQ
Q19BQ1I6DQpXTTMyCTB4RjAwMTAwNDAJMHgwMDAwNDAwMAk7VEVTQ1IxOg0K
V00zMgkweEYwMDEwMDQ4CTB4MDAwMDQwMDAJO0xfVEVTQ1IxOg0KO1dNMzIJ
MHhGMDAxMEM4MAkweDAwMDAwMDAxCTtTQ0NSIDogbm9ybWFsIG9wZXJhdGlv
bg0KDQo7IGluaXQgbWVtb3J5IGNvbnRyb2xsZXIobWFzdGVyKQ0KV00zMgkw
eEYwMDEwMTA0CTB4RkZFMDBDNTQJO09SMDogRmxhc2ggMk1CLCBDUyBlYXJs
eSBuZWdhdGUsIDUgdy5zLiwgVGltaW5nIHJlbGF4DQpXTTMyCTB4RjAwMTAx
MDAJMHhGRkUwMTAwMQk7QlIwOiBGbGFzaCBAMHhGRjAwMDAwMCwgMTZiaXQs
IG5vIHBhcml0eQ0KV00zMgkweEYwMDEwMTBDCTB4RjgwMDJCMDAJO09SMTog
MTI4TUJZVEUNCldNMzIJMHhGMDAxMDEwOAkweDAwMDAwMDQxCTtCUjE6IDYw
eC1CVVMNCldNMzIJMHhGMDAxMDExNAkweEY4MDAyQjAwCTtPUjI6IDEyOE1C
WVRFIHJpa2kgY2hnIGZjLT5mOA0KV00zMgkweEYwMDEwMTEwCTB4MDgwMDAw
NDEJO0JSMjogNjB4LUJVUw0KO1dNMzIJMHhGMDAxMDExQwkweDAwMDAwMDAw
CTtPUjM6IDY0TUJZVEUNCjtXTTMyCTB4RjAwMTAxMTgJMHgwMDAwMDAwMAk7
QlIzOiA2MHgtQlVTDQpXTTMyCTB4RjAwMTAxMkMJMHhGQzAwMkYwMAk7T1I1
OiA2NE1CWVRFDQpXTTMyCTB4RjAwMTAxMjgJMHgzMDAwMTg2MQk7QlI1OiBM
T0NBTC1CVVMNCldNMzIJMHhGMDAxMDEzNAkweEZDMDAwMDA4CTtPUjY6IE1B
SU5JLU8NCldNMzIJMHhGMDAxMDEzMAkweDQwMDAxMDAxCTtCUjY6IDYweC1C
VVMNCldNMzIJMHhGMDAxMDEzQwkweEZGMDAwQzBDCTtPUjc6IEZQR0EtSU8N
CldNMzIJMHhGMDAxMDEzOAkweDUwMDAxMDAxCTtCUjc6IDRNQllURQ0KO1dN
MzIJMHhGMDAxMDE0NAkweEZGRkMwMTAwCTtPUjg6IEZVTUVJLW5hcGENCjtX
TTMyCTB4RjAwMTAxNDAJMHg1ODAwMTA4MQk7QlI4OiBGVU1FSS1uYXBhDQpX
TTMyCTB4RjAwMTAxNEMJMHhGRkZGMDAwOAk7T1I5OiBDLUZMQVNIDQpXTTMy
CTB4RjAwMTAxNDgJMHg4MDAwMTAwMQk7QlI5OiA2MHgtQlVTDQoNCjsgaW5p
dCBjb3JlIHJlZ2lzdGVyKFNMQVZFKQ0KO1dSRUcgICAgTVNSICAgICAgICAg
ICAgIDB4MDAwMDAwMDAgICAgICA7Y2xlYXIgTVNSDQo7V00zMgkweEZGMDEw
MUE4CTB4RkYwMDAwMDAJO0lNTVIgOiBpbnRlcm5hbCBzcGFjZSBAIDB4RjAw
MDAwMDANCldNMzIJMHhGRjAxMDAwNAkweEZGRkZGRkMzCTtTWVBDUjogZGlz
YWJsZSB3YXRjaGRvZw0KV00zMgkweEZGMDEwMDI0CTB4ODA4MDAwMDAJO0JD
UjoNCldNOAkweEZGMDEwMDI4CTB4MjcJO1BQQ19BQ1I6DQpXTTMyCTB4RkYw
MTAwNDAJMHgwMDAwNDAwMAk7VEVTQ1IxOg0KV00zMgkweEZGMDEwMDQ4CTB4
MDAwMDQwMDAJO0xfVEVTQ1IxOg0KO1dNMzIJMHhGRjAxMEM4MAkweDAwMDAw
MDAxCTtTQ0NSIDogbm9ybWFsIG9wZXJhdGlvbg0KDQoNCjsgaW5pdCBTRFJB
TSBJbml0IChQUEMgYnVzKSBmb3IgQ1MxJjINCldNMTYJMHhGMDAxMDE4NAkw
eEYwMDAJICAgICAgICA7TVBUUFINCldNOAkweEYwMDEwMTlDCTB4RjAJICAg
ICAgICA7UFNSVA0KV00zMgkweEYwMDEwMTkwCTB4QUIyREI0QUUJO1BTRE1S
OiBQcmVjaGFyZ2UgYWxsIGJhbmtzDQpXTTgJMHgwMDAwMDAwMAkweEZGCSAg
ICAgICAgO0FjY2VzcyBTRFJBTQ0KV004CTB4MDgwMDAwMDAJMHhGRgkgICAg
ICAgIDtBY2Nlc3MgU0RSQU0NCldNMzIJMHhGMDAxMDE5MAkweDhCMkRCNEFF
CTtQU0RNUjogQ0JSIFJlZnJlc2gNCldNOAkweDAwMDAwMDAwCTB4RkYJICAg
ICAgICA7QWNjZXNzIFNEUkFNDQpXTTgJMHgwMDAwMDAwMAkweEZGCSAgICAg
ICAgO0FjY2VzcyBTRFJBTQ0KV004CTB4MDAwMDAwMDAJMHhGRgkgICAgICAg
IDtBY2Nlc3MgU0RSQU0NCldNOAkweDAwMDAwMDAwCTB4RkYJICAgICAgICA7
QWNjZXNzIFNEUkFNDQpXTTgJMHgwMDAwMDAwMAkweEZGCSAgICAgICAgO0Fj
Y2VzcyBTRFJBTQ0KV004CTB4MDAwMDAwMDAJMHhGRgkgICAgICAgIDtBY2Nl
c3MgU0RSQU0NCldNOAkweDAwMDAwMDAwCTB4RkYJICAgICAgICA7QWNjZXNz
IFNEUkFNDQpXTTgJMHgwMDAwMDAwMAkweEZGCSAgICAgICAgO0FjY2VzcyBT
RFJBTQ0KV004CTB4MDgwMDAwMDAJMHhGRgkgICAgICAgIDtBY2Nlc3MgU0RS
QU0NCldNOAkweDA4MDAwMDAwCTB4RkYJICAgICAgICA7QWNjZXNzIFNEUkFN
DQpXTTgJMHgwODAwMDAwMAkweEZGCSAgICAgICAgO0FjY2VzcyBTRFJBTQ0K
V004CTB4MDgwMDAwMDAJMHhGRgkgICAgICAgIDtBY2Nlc3MgU0RSQU0NCldN
OAkweDA4MDAwMDAwCTB4RkYJICAgICAgICA7QWNjZXNzIFNEUkFNDQpXTTgJ
MHgwODAwMDAwMAkweEZGCSAgICAgICAgO0FjY2VzcyBTRFJBTQ0KV004CTB4
MDgwMDAwMDAJMHhGRgkgICAgICAgIDtBY2Nlc3MgU0RSQU0NCldNOAkweDA4
MDAwMDAwCTB4RkYJICAgICAgICA7QWNjZXNzIFNEUkFNDQpXTTMyCTB4RjAw
MTAxOTAJMHg5QjJEQjRBRQk7UFNETVI6IE1vZGUgU2V0DQpXTTgJMHgwMDA4
ODExMAkweEZGCSAgICAgICAgO0FjY2VzcyBTRFJBTQ0KV004CTB4MDgwODgx
MTAJMHhGRgkgICAgICAgIDtBY2Nlc3MgU0RSQU0NCldNMzIJMHhGMDAxMDE5
MAkweGMzMkRCNEFFCTtQU0RNUjogZW5hYmxlIHJlZnJlc2gsIG5vcm1hbCBv
cGVyYXRpb24NCg0KDQpXTTE2CTB4NTA4MDAyMDYJMHgyMDAwCSAgICAgICAg
O2ZsYXNoLXByb3RlY3QtZGlzYWJsZQ0KDQo7IGluaXQgU0RSQU0gSW5pdCAo
TE9DQUwgYnVzKSBmb3IgQ1M1DQpXTTgJMHhGMDAxMDFBNAkweEYwCSAgICAg
ICAgO0xTUlQNCldNMzIJMHhGMDAxMDE5NAkweEFCNDFCNEFFCTtMU0RNUjog
UHJlY2hhcmdlIGFsbCBiYW5rcw0KV004CTB4MzAwMDAwMDAJMHhGRgkgICAg
ICAgIDtBY2Nlc3MgU0RSQU0NCldNMzIJMHhGMDAxMDE5NAkweDhCNDFCNEFF
CTtMU0RNUjogQ0JSIFJlZnJlc2gNCldNOAkweDMwMDAwMDAwCTB4RkYJICAg
ICAgICA7QWNjZXNzIFNEUkFNDQpXTTgJMHgzMDAwMDAwMAkweEZGCSAgICAg
ICAgO0FjY2VzcyBTRFJBTQ0KV004CTB4MzAwMDAwMDAJMHhGRgkgICAgICAg
IDtBY2Nlc3MgU0RSQU0NCldNOAkweDMwMDAwMDAwCTB4RkYJICAgICAgICA7
QWNjZXNzIFNEUkFNDQpXTTgJMHgzMDAwMDAwMAkweEZGCSAgICAgICAgO0Fj
Y2VzcyBTRFJBTQ0KV004CTB4MzAwMDAwMDAJMHhGRgkgICAgICAgIDtBY2Nl
c3MgU0RSQU0NCldNOAkweDMwMDAwMDAwCTB4RkYJICAgICAgICA7QWNjZXNz
IFNEUkFNDQpXTTgJMHgzMDAwMDAwMAkweEZGCSAgICAgICAgO0FjY2VzcyBT
RFJBTQ0KV00zMgkweEYwMDEwMTk0CTB4OUI0MUI0QUUJO0xTRE1SOiBNb2Rl
IFNldA0KV004CTB4MzAwNDQwODgJMHhGRgkgICAgICAgIDtBY2Nlc3MgU0RS
QU0NCldNMzIJMHhGMDAxMDE5NAkweEMzNDFCNEFFCTtMU0RNUjogZW5hYmxl
IHJlZnJlc2gsIG5vcm1hbCBvcGVyYXRpb24NCg0KOyBpbml0IG1lbW9yeSBj
b250cm9sbGVyKHNsYXZlKQ0KO1dNMzIJMHhGRjAxMDEwNAkweEZGRTAwQzU0
CTtPUjA6IEZsYXNoIDJNQiwgQ1MgZWFybHkgbmVnYXRlLCA1IHcucy4sIFRp
bWluZyByZWxheA0KV00zMgkweEZGMDEwMTAwCTB4MDAwMDAwMDAJO0JSMDog
Rmxhc2ggQDB4RkYwMDAwMDAsIDE2Yml0LCBubyBwYXJpdHkNCjtXTTMyCTB4
RkYwMTAxMEMJMHhGODAwMkIwMAk7T1IxOiAxMjhNQllURQ0KO1dNMzIJMHhG
RjAxMDEwOAkweDAwMDAwMDQxCTtCUjE6IDYweC1CVVMNCjtXTTMyCTB4RkYw
MTAxMTQJMHhGODAwMkIwMAk7T1IyOiAxMjhNQllURSByaWtpIGNoZyBmYy0+
ZjgNCjtXTTMyCTB4RkYwMTAxMTAJMHgwODAwMDA0MQk7QlIyOiA2MHgtQlVT
DQo7V00zMgkweEZGMDEwMTFDCTB4MDAwMDAwMDAJO09SMzogNjRNQllURQ0K
O1dNMzIJMHhGRjAxMDExOAkweDAwMDAwMDAwCTtCUjM6IDYweC1CVVMNCjtX
TTMyCTB4RkYwMTAxMkMJMHhGQzAwMkYwMAk7T1I1OiA2NE1CWVRFDQo7V00z
MgkweEZGMDEwMTI4CTB4MzAwMDE4NjEJO0JSNTogTE9DQUwtQlVTDQo7V00z
MgkweEZGMDEwMTM0CTB4RkMwMDAwMDgJO09SNjogTUFJTkktTw0KO1dNMzIJ
MHhGRjAxMDEzMAkweDQwMDAxMDAxCTtCUjY6IDYweC1CVVMNCjtXTTMyCTB4
RkYwMTAxM0MJMHhGRjAwMEMwQwk7T1I3OiBGUEdBLUlPDQo7V00zMgkweEZG
MDEwMTM4CTB4NTAwMDEwMDEJO0JSNzogNE1CWVRFDQo7V00zMgkweEZGMDEw
MTQ0CTB4RkZGQzAxMDAJO09SODogRlVNRUktbmFwYQ0KO1dNMzIJMHhGRjAx
MDE0MAkweDU4MDAxMDgxCTtCUjg6IEZVTUVJLW5hcGENCjtXTTMyCTB4RkYw
MTAxNEMJMHhGRkZGMDAwOAk7T1I5OiBDLUZMQVNIDQo7V00zMgkweEZGMDEw
MTQ4CTB4ODAwMDEwMDEJO0JSOTogNjB4LUJVUw0KDQoNCg0KDQpbVEFSR0VU
XQ0KQ1BVVFlQRSAgICAgODI3MCAgICAgICAgO3RoZSBDUFUgdHlwZSAoNjAz
RVYsNzUwLDgyNDAsODI2MCkNCkpUQUdDTE9DSyAgIDAgICAgICAgICAgIDt1
c2UgMTYgTUh6IEpUQUcgY2xvY2sNCkJPT1RBRERSICAgIDB4ZmZmMDAxMDAg
IDtib290IGFkZHJlc3MgdXNlZCBmb3Igc3RhcnQtdXAgYnJlYWsNCldPUktT
UEFDRSAgIDB4MGUwMDAwMDAJO3dvcmtzcGFjZSBpbiB0YXJnZXQgUkFNIGZv
ciBmYXN0IGRvd25sb2FkDQpCRElNT0RFICAgICBBR0VOVCAgICAgCTt0aGUg
QkRJIHdvcmtpbmcgbW9kZSAoTE9BRE9OTFkgfCBBR0VOVCB8IEdBVEVXQVkp
DQpCUkVBS01PREUgICBTT0ZUICAgICAgCTtTT0ZUIG9yIEhBUkQsIEhBUkQg
dXNlcyBQUEMgaGFyZHdhcmUgYnJlYWtwb2ludHMNCjtTVEVQTU9ERSAgICBI
V0JQICAgICAgICA7VFJBQ0Ugb3IgSFdCUCwgSFdQQiB1c2VzIGEgaGFyZHdh
cmUgYnJlYWtwb2ludA0KVkVDVE9SICAgICAgQ0FUQ0ggICAgICAgO2NhdGNo
IHVuaGFuZGxlZCBleGNlcHRpb25zDQpEQ0FDSEUgICAgICBOT0ZMVVNICTtk
YXRhIGNhY2hlIGZsdXNoaW5nIChGTFVTSCB8IE5PRkxVU0gpDQo7TU1VICAg
ICAgICAgWExBVCAgICAgICAgO3RyYW5zbGF0ZSBlZmZlY3RpdmUgdG8gcGh5
c2ljYWwgYWRkcmVzcw0KUE9XRVJVUCAgICAgMTAwMCAgICAgICAgO3N0YXJ0
IGRlbGF5IGFmdGVyIHBvd2VyLXVwIGRldGVjdGVkIGluIG1zDQo7UkVHTElT
VCAgICAgU1BSICAgICAgICAgO3NlbGVjdCByZWdpc3RlciB0byB0cmFuc2Zl
ciB0byBHREINCjtSRUdMSVNUICAgICBBTEwgICAgICAgICA7c2VsZWN0IHJl
Z2lzdGVyIHRvIHRyYW5zZmVyIHRvIEdEQg0KO1ZJTyAgICAgICAgIDcgOTYw
MCAgICAgICA7VENQIHBvcnQgZm9yIHZpcnR1YWwgSU8sIEJDU1IxOiBlbmFi
bGUgUlMyMzItMSAhISENCjtTSU8gICAgICAgICA3IDk2MDAgICAgICAgO1RD
UCBwb3J0IGZvciBzZXJpYWwgSU8sIGNoZWNrIEJDU1IxOiBlbmFibGUgUlMy
MzItMSAhISENCg0KW0hPU1RdDQpJUCAgICAgICAgICAxOTIuMTY4LjAuMw0K
RklMRSAgICAgICAgRDpcY3lnd2luXGhvbWVccmlraVxyYW0tdGVzdC1kYXRh
XG1ha2VfYmluX2luY18yNTZNLmJpbg0KRk9STUFUICAgICAgQklOIDB4MDAw
MDAwMDANCkxPQUQgICAgICAgIE1BTlVBTCAgICAgIDtsb2FkIGNvZGUgTUFO
VUFMIG9yIEFVVE8gYWZ0ZXIgcmVzZXQNCkRFQlVHUE9SVCAgIDIwMDENClBS
T01QVCAgICAgIE1QQzgyNzA+CTtuZXcgcHJvbXB0IGZvciBUZWxuZXQNCkRV
TVAgICAgICAgIEQ6XGN5Z3dpblxob21lXHJpa2lcdGVtcFxkdW1wLmJpbg0K
DQpbRkxBU0hdDQpDSElQVFlQRSAgICBBTTI5QlgxNiAgICAgIDtGbGFzaCB0
eXBlIChBTTI5RiB8IEFNMjlCWDggfCBBTTI5QlgxNiB8IEkyOEJYOCB8IEky
OEJYMTYpDQo7Q0hJUFRZUEUgICAgQU0yOUJYOA0KQ0hJUFNJWkUgICAgMHgy
MDAwMDAgICAgO1RoZSBzaXplIG9mIG9uZSBmbGFzaCBjaGlwIGluIGJ5dGVz
IChlLmcuIEFNMjlGMDEwID0gMHgyMDAwMCkNCkJVU1dJRFRIICAgIDE2ICAg
ICAgICAgIDtUaGUgd2lkdGggb2YgdGhlIGZsYXNoIG1lbW9yeSBidXMgaW4g
Yml0cyAoOCB8IDE2IHwgMzIgfCA2NCkNCjtXT1JLU1BBQ0UgICAweDA0NzAw
MDAwICA7d29ya3NwYWNlIGluIGR1YWwgcG9ydCBSQU0NCldPUktTUEFDRSAg
IDB4MDAwMDAwMDAgIDt3b3Jrc3BhY2UgaW4gU0RSQU0NCjtGSUxFICAgICAg
ICBFOlx0b3JuYWRvXHRhcmdldFxjb25maWdcYWRzODI2MFx0ZXN0LmhleCAg
O1RoZSBmaWxlIHRvIHByb2dyYW0NCkZPUk1BVCAgICAgIEJJTg0KRklMRSAg
ICAgICAgRDpcdGZ0cGJvb3RcdS1ib290LmJpbg0KOw0KRVJBU0UgICAgICAg
MHhGRkUwMDAwMCBDSElQIDtFUkFTRSBXSE9MRSBDSElQDQoNCltSRUdTXQ0K
RE1NMSAgICAgICAgMHhGMDAwMDAwMA0KRklMRSAgICAgICAgQzpcQkRJXENP
TkZJR1xyZWc4MjcwLmRlZg0KDQo=

--0-1228222616-1150303223=:82247--
