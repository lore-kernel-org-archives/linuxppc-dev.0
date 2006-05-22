Return-Path: <evan@theunixman.com>
Received: from theunixman.com (valinor.theunixman.com [216.193.203.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.theunixman.com",
	Issuer "ca.theunixman.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B6014679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 May 2006 06:52:39 +1000 (EST)
Date: Mon, 22 May 2006 20:02:48 +0000
From: Evan Cofsky <evan@theunixman.com>
To: linuxppc-embedded@ozlabs.org
Subject: BDI 2000 and MPC 8250 Problem
Message-ID: <20060522200248.GG341278@valinor.arda.theunixman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm experiencing the following error with a BDI 2000 connected to the
JTAG port on a A&M Rattler 8250 board.  I was wondering if this is a
hardware problem, or if I have the wrong configuration set up.  The
following are a telnet session transcript, the BDI configuration file,
and the register configuration file.

Thanks

BDI Telnet Session Transcript (repeats endlessly):

- TARGET: processing user reset request
- BDI asserts HRESET
- Reset JTAG controller passed
- Bypass check: 0x00000001 => 0x00000001
- JTAG exists check passed
- COP status is 0x05
- Check running state failed
- TARGET: Target PVR is 0x80811014
*** TARGET: resetting target failed
# PPC: unexpected response from target
- TARGET: target will be restarted in 10 sec

rattler8250pci.cfg:

;bdiGDB configuration file for rattler
; ------------------------------------------------------
;
[INIT]
;WREG    MSR             0x00001002      ; set up MSR
;WSPR    1008            0               ; turn off caches
WM32    0x000101A8      0x00f00000      ; IMMR == 0xFF000000
WM32    0xff010004      0xFFFFFFC3      ; SYPCR == no watchdog
;WM32    0xFF010C80      0x00000001      ; SCCR == normal operations
;WM32    0xFF010000      0x0E240000      ; SIUMCR non PCI
;WM32    0xFF010000      0x0E640000      ; SIUMCR
;
;

; Memory controller
;
; These writes configure /CS0 to be the 2MB FLASH at 0xFFE0000
; and /CS6 to be the 2MB FLASH at 0xFFC0000
; These writes configure:
;   CHIP SELECT     BASE ADDRESS    SIZE   COMMENTS
;   -----------     ------------    ----   --------
;     /CS0           0WM16    0xFF010184      0x2000          ; MPTPR - PTP==0x20

;WM32    0xff010100      0x80001001      ; BR0
;WM32    0xFF010104      0xFF800E44      ; OR0
;WM32    0xff010104      0xFFC00E76      ; OR0
WM32    0xff010100      0xFE001001      ; BR0
WM32    0xff010104      0xFF800ED2      ; OR0

;
;
; Initialize the SDRAM on the 60x bus. /CS1
;FF
;
; operation
;
;
[TARGET]
CPUTYPE     8260        ;the CPU type (603EV,750,8240,8260)
JTAGCLOCK   0           ;use 16 MHz JTAG clock
WORKSPACE   0xff000000	;workspace in target RAM for fast download
BDIMODE     AGENT     	;the BDI working mode (LOADONLY | AGENT | GATEWAY)
BREAKMODE   SOFT      	;SOFT or HARD, HARD uses PPC hardware breakpoints
;VECTOR      CATCH    0   ;catch unhandled exceptions
DCACHE      NOFLUSH	;data cache flushing (FLUSH | NOFLUSH)
BOOTADDR    0x00000100  ;boot address
REGLIST     ALL             
STEPMODE    TRACE       ; use hardware breakpoints to single step
MEMDELAY    4000        ;
;quit

;
[FLASH]
CHIPTYPE    AM29BX16    ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
CHIPSIZE    0x800000     ;641 8 Meg The size of one flash chip in bytes (e.g. AM29F010 = 0x20000)
BUSWIDTH    16           ;The width of the flash memory bus in bits (8 | 16 | 32 | 64)

;
;
[HOST]
prompt 8250pci>
FORMAT  SREC
LOAD    MANUAL          ;load code MANUAL or AUTO after reset
;
;
[REGS]
DMM1    0xff000000
FILE    reg8260.def

reg8260.def:

;Register definition for MPC8260
;===============================
;
; name: user defined name of the register
; type: the type of the register
;	GPR	general purpose register
;	SPR	special purpose register
;	MM	memory mapped register
;	DMMx	direct memory mapped register with offset
;		x = 1..4
;		the base is defined in the configuration file
;		e.g. DMM1 0x02200000
; addr:	the number, adddress or offset of the register
; size	the size of the register (8,16 or 32)
;
;name		type	addr		size
;-------------------------------------------
;
sp		GPR	1
;
xer		SPR	1
lr		SPR	8
ctr		SPR	9
dsisr           SPR     18
dar             SPR     19
dec             SPR     22
sdr1            SPR     25
srr0            SPR     26
srr1            SPR     27
;
tbl             SPR     268
tbu             SPR     269
sprg0		SPR	272
sprg1		SPR	273
sprg2		SPR	274
sprg3		SPR	275
ear             SPR     282
pvr             SPR     287
;
ibat0u          SPR     528
ibat0l          SPR     529
ibat1u          SPR     530
ibat1l          SPR     531
ibat2u          SPR     532
ibat2l          SPR     533
ibat3u          SPR     534
ibat3l          SPR     535
;
dbat0u          SPR     536
dbat0l          SPR     537
dbat1u          SPR     538
dbat1l          SPR     539
dbat2u          SPR     540
dbat2l          SPR     541
dbat3u          SPR     542
dbat3l          SPR     543
;
dmiss           SPR     976
dcmp            SPR     977
imiss           SPR     980
icmp            SPR     981
rpa             SPR     982
;
hid0            SPR     1008
hid1            SPR     1009
hid2            SPR     1011
;
;
; DMM1 must be set to the internal memory base address
;
;	General SIU
siumcr		DMM1	0x10000		32
sypcr		DMM1	0x10004		32
swsr		DMM1	0x1000e		16
bcr		DMM1	0x10024		32
ppc_acr		DMM1	0x10028		8
ppc_alrh	DMM1	0x1002c		32
ppc_alrl	DMM1	0x10030		32
lcl_acr		DMM1	0x10034		8
lcl_alrh	DMM1	0x10038		32
lcl_alrl	DMM1	0x1003c		32
tescr1		DMM1	0x10040		32
l_tescr1	DMM1	0x10048		32
l_tescr2	DMM1	0x1004c		32
pdtea		DMM1	0x10050		32
pdtem		DMM1	0x10054		8
ldtea		DMM1	0x10058		32
ldtem		DMM1	0x1005c	        8
;
;	Memory Controller
br0		DMM1	0x10100         32
or0		DMM1	0x10104         32
br1		DMM1	0x10108         32
or1		DMM1	0x1010c         32
br2		DMM1	0x10110         32
or2		DMM1	0x10114         32
br3		DMM1	0x10118         32
or3		DMM1	0x1011c         32
br4		DMM1	0x10120         32
or4		DMM1	0x10124         32
br5		DMM1	0x10128         32
or5		DMM1	0x1012c         32
br6		DMM1	0x10130         32
or6		DMM1	0x10134         32
br7		DMM1	0x10138         32
or7		DMM1	0x1013c         32
br8		DMM1	0x10140         32
or8		DMM1	0x10144         32
br9     	DMM1	0x10148         32
or9		DMM1	0x1014c         32
br10    	DMM1	0x10150         32
or10    	DMM1	0x10154         32
br11    	DMM1	0x10158         32
or11    	DMM1	0x1015c         32
mar             DMM1    0x10168         32
mamr            DMM1    0x10170         32
mbmr            DMM1    0x10174         32
mcmr            DMM1    0x10178         32
mptpr           DMM1    0x10184         16
mdr             DMM1    0x10188         32
psdmr           DMM1    0x10190         32
lsdmr           DMM1    0x10194         32
purt            DMM1    0x10198         8
psrt            DMM1    0x1019c         8
lurt            DMM1    0x101a0         8
lsrt            DMM1    0x101a4         8
immr            DMM1    0x101a8         32
;
;       System Integration Timers
tmcntsc         DMM1    0x10220         16
tmcnt           DMM1    0x10224         32
tmcntal         DMM1    0x1022c         32
piscr           DMM1    0x10240         16
pitc            DMM1    0x10244         32
pitr            DMM1    0x10248         32
;
;       Interrupt Controller
sicr            DMM1    0x10c00         16
sivec           DMM1    0x10c04         32
sipnr_h         DMM1    0x10c08         32
sipnr_l         DMM1    0x10c0c         32
siprr           DMM1    0x10c10         32
scprr_h         DMM1    0x10c14         32
scprr_l         DMM1    0x10c18         32
simr_h          DMM1    0x10c1c         32
simr_l          DMM1    0x10c20         32
siexr           DMM1    0x10c24         32
;
;       Clocks and Reset
sccr            DMM1    0x10c80         32
scmr            DMM1    0x10c88         32
rsr             DMM1    0x10c90         32
rmr             DMM1    0x10c94         32
;
;       Input/Output Port
pdira           DMM1    0x10d00         32
ppara           DMM1    0x10d04         32
psora           DMM1    0x10d08         32
podra           DMM1    0x10d0c         32
pdata           DMM1    0x10d10         32
pdirb           DMM1    0x10d20         32
pparb           DMM1    0x10d24         32
psorb           DMM1    0x10d28         32
podrb           DMM1    0x10d2c         32
pdatb           DMM1    0x10d30         32
pdirc           DMM1    0x10d40         32
pparc           DMM1    0x10d44         32
psorc           DMM1    0x10d48         32
podrc           DMM1    0x10d4c         32
pdatc           DMM1    0x10d50         32
pdird           DMM1    0x10d60         32
ppard           DMM1    0x10d64         32
psord           DMM1    0x10d68         32
podrd           DMM1    0x10d6c         32
pdatd           DMM1    0x10d70         32
;
;       CPM Timers
tgcr1           DMM1    0x10d80         8
tgcr2           DMM1    0x10d84         8
tmr1            DMM1    0x10d90         16
tmr2            DMM1    0x10d92         16
trr1            DMM1    0x10d94         16
trr2            DMM1    0x10d96         16
tcr1            DMM1    0x10d98         16
tcr2            DMM1    0x10d9a         16
tcn1            DMM1    0x10d9c         16
tcn2            DMM1    0x10d9e         16
tmr3            DMM1    0x10da0         16
tmr4            DMM1    0x10da2         16
trr3            DMM1    0x10da4         16
trr4            DMM1    0x10da6         16
tcr3            DMM1    0x10da8         16
tcr4            DMM1    0x10daa         16
tcn3            DMM1    0x10dac         16
tcn4            DMM1    0x10dae         16
ter1            DMM1    0x10db0         16
ter2            DMM1    0x10db2         16
ter3            DMM1    0x10db4         16
ter4            DMM1    0x10db6         16
;
;       SDMA-General
sdsr            DMM1    0x11018         8
sdmr            DMM1    0x1101c         8
;
;       IDMA
idsr1           DMM1    0x11020         8
idmr1           DMM1    0x11024         8
idsr2           DMM1    0x11028         8
idmr2           DMM1    0x1102c         8
idsr3           DMM1    0x11030         8
idmr3           DMM1    0x11034         8
idsr4           DMM1    0x11038         8
idmr4           DMM1    0x1103c         8
;
;       FCC1
gfmr1           DMM1    0x11300         32
fpsmr1          DMM1    0x11304         32
ftodr1          DMM1    0x11308         16
fdsr1           DMM1    0x1130c         16
fcce1           DMM1    0x11310         32
fccm1           DMM1    0x11314         32
fccs1           DMM1    0x11318         8
ftirr1_phy0     DMM1    0x1131c         8
ftirr1_phy1     DMM1    0x1131d         8
ftirr1_phy2     DMM1    0x1131e         8
ftirr1_phy3     DMM1    0x1131f         8
;
;       FCC2
gfmr2           DMM1    0x11320         32
fpsmr2          DMM1    0x11324         32
ftodr2          DMM1    0x11328         16
fdsr2           DMM1    0x1132c         16
fcce2           DMM1    0x11330         32
fccm2           DMM1    0x11334         32
fccs2           DMM1    0x11338         8
ftirr2_phy0     DMM1    0x1133c         8
ftirr2_phy1     DMM1    0x1133d         8
ftirr2_phy2     DMM1    0x1133e         8
ftirr2_phy3     DMM1    0x1133f         8
;
;       FCC3
gfmr3           DMM1    0x11340         32
fpsmr3          DMM1    0x11344         32
ftodr3          DMM1    0x11348         16
fdsr3           DMM1    0x1134c         16
fcce3           DMM1    0x11350         32
fccm3           DMM1    0x11354         32
fccs3           DMM1    0x11358         8
;
;       BRGs 5-8
brgc5           DMM1    0x115f0         32
brgc6           DMM1    0x115f4         32
brgc7           DMM1    0x115f8         32
brgc8           DMM1    0x115fc         32
;
;       I2C
i2mod           DMM1    0x11860         8
i2add           DMM1    0x11864         8
i2brg           DMM1    0x11868         8
i2com           DMM1    0x1186c         8
i2cer           DMM1    0x11870         8
i2cmr           DMM1    0x11874         8
;
;       Communication Processor
cpcr            DMM1    0x119c0         32
rccr            DMM1    0x119c4         32
rter            DMM1    0x119d6         16
rtmr            DMM1    0x119da         16
rtscr           DMM1    0x119dc         16
rtsr            DMM1    0x119e0         32
;
;       BRGs 1-4
brgc1           DMM1    0x119f0         32
brgc2           DMM1    0x119f4         32
brgc3           DMM1    0x119f8         32
brgc4           DMM1    0x119fc         32
;
;       SCC1
gsmr_l1         DMM1    0x11a00         32
gsmr_h1         DMM1    0x11a04         32
psmr1           DMM1    0x11a08         16
todr1           DMM1    0x11a0c         16
dsr1            DMM1    0x11a0e         16
scce1           DMM1    0x11a10         16
sccm1           DMM1    0x11a14         16
sccs1           DMM1    0x11a17         8
;
;       SCC2
gsmr_l2         DMM1    0x11a20         32
gsmr_h2         DMM1    0x11a24         32
psmr2           DMM1    0x11a28         16
todr2           DMM1    0x11a2c         16
dsr2            DMM1    0x11a2e         16
scce2           DMM1    0x11a30         16
sccm2           DMM1    0x11a34         16
sccs2           DMM1    0x11a37         8
;
;       SCC3
gsmr_l3         DMM1    0x11a40         32
gsmr_h3         DMM1    0x11a44         32
psmr3           DMM1    0x11a48         16
todr3           DMM1    0x11a4c         16
dsr3            DMM1    0x11a4e         16
scce3           DMM1    0x11a50         16
sccm3           DMM1    0x11a54         16
sccs3           DMM1    0x11a57         8
;
;       SCC4
gsmr_l4         DMM1    0x11a60         32
gsmr_h4         DMM1    0x11a64         32
psmr4           DMM1    0x11a68         16
todr4           DMM1    0x11a6c         16
dsr4            DMM1    0x11a6e         16
scce4           DMM1    0x11a70         16
sccm4           DMM1    0x11a74         16
sccs4           DMM1    0x11a77         8
;
;       SMC1
smcmr1          DMM1    0x11a82         16
smce1           DMM1    0x11a86         8
smcm1           DMM1    0x11a8a         8
;
;       SMC2
smcmr2          DMM1    0x11a92         16
smce2           DMM1    0x11a96         8
smcm2           DMM1    0x11a9a         8
;
;       SPI
spmode          DMM1    0x11aa0         16
spie            DMM1    0x11aa6         8
spim            DMM1    0x11aaa         8
spcom           DMM1    0x11aad         8
;
;       CPM Mux
cmxsi1cr        DMM1    0x11b00         8
cmxsi2cr        DMM1    0x11b02         8
cmxfcr          DMM1    0x11b04         32
cmxscr          DMM1    0x11b08         32
cmxsmr          DMM1    0x11b0c         8
cmxuar          DMM1    0x11b0e         16
;
;       SI1 Registers
si1amr          DMM1    0x11b20         16
si1bmr          DMM1    0x11b22         16
si1cmr          DMM1    0x11b24         16
si1dmr          DMM1    0x11b26         16
si1gmr          DMM1    0x11b28         8
si1cmdr         DMM1    0x11b2a         8
si1str          DMM1    0x11b2c         8
si1rsr          DMM1    0x11b2e         16
;
;       MCC1 Registers
mcce1           DMM1    0x11b30         16
mccm1           DMM1    0x11b34         16
mccf1           DMM1    0x11b38         8
;
;       SI2 Registers
si2amr          DMM1    0x11b40         16
si2bmr          DMM1    0x11b42         16
si2cmr          DMM1    0x11b44         16
si2dmr          DMM1    0x11b46         16
si2gmr          DMM1    0x11b48         8
si2cmdr         DMM1    0x11b4a         8
si2str          DMM1    0x11b4c         8
si2rsr          DMM1    0x11b4e         16
;
;       MCC2 Registers
mcce2           DMM1    0x11b50         16
mccm2           DMM1    0x11b54         16
mccf2           DMM1    0x11b58         8
;

-- 
Evan Cofsky "The UNIX Man" <evan@theunixman.com>

See you space cowboy
