Message-ID: <885489B3B89FB6449F93E525DF78777F064531@srvnt506.ALLOPTIC.COM>
From: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: BDI-2000
Date: Tue, 7 Jan 2003 16:40:52 -0800 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I finally got my BDI-2000 for PPC 860 this week, and tried to set it up to
debug my MMU problem.
This is my first time using the BDI-2000, and really hope someone here can
give me a hand.

Here is what I am trying to do:

I have a proven hardware platform with
	PPC860, IMMR is mapped to 0xf0000000.
	16 MB of SRAM in CS3 starts at physical locatio 0x0
	1 MB of BootROM in CS1 starts at physical location 0x28000000
	16 MB of code flash in CS5 starts at physical location 0x08000000
	some other IO mapped to miscellaneous addresses.

The hardware platform is running vxWorks with vxWorks bootrom.  I am trying
to
port the Linux to this custom hardware platform.  I was successful building
a zImage (no intrd yet)
with the compress vmLinux.gz.  The zImage.srec is then downloaded to the
target
platform using the vxWorks bootrom (I wrote a little program to take
srecords).  The following
information was dump out on the console

	boot device          : motfec
	unit number          : 0
	processor number     : 0
	host name            : linux
	file name            : linux\images\zImage.hex
	inet on ethernet (e) : 192.168.0.238
	host inet (h)        : 192.168.0.211
	user (u)             : me
	ftp password (pw)    : me
	flags (f)            : 0x8
	target name (tn)     : onu
	other (o)            : motfec

	Attached TCP/IP interface to motfec0.
	Attaching network interface lo0... done.
	Loading... S-Record:
        		Module Name: ../images/zImage.srec
        		Entry Location: 0x400000
		Starting at 0x400000...

	loaded at:     00400000 0040C30C
	board data at: 004001C0 004001E4
	relocated to:  0040C0E8 0040C10C
	zimage at:     0040C30C 004BC445
	avail ram:     004BD000 00800000

	Linux/PPC load: console=ttyS0,9600
nfsroot=192.168.0.211:/exports/rpx860/2.4.7-t
	imesys-3.1.254 ip=192.168.0.238
	Uncompressing Linux... done.
	Now booting the kernel

I was able to follow the execution from the power reset until the point
where the MMU is enabled
in the function kernel\arch\ppc\kernel\head_8xx.S:turn_on_mmu with visionICE
II (yes, I know there
is an update for the firmware to get visionICE to work with MMU, but I am
waiting for that also).

I don't think my MMU table is setup properly, therefore, I have aquired a
Abatron BDI-2000.  I have to
modified the .cfg files to use my UPM A table.  Furthermore, I modified the
registers defined in the
sample .cfg file to the values defined in my firmware.  I was successful in
powering up the BDI-2000,
connecting it to my target board, and telnet into the BDI.

I am able to check and modify the SRAM (at physical address location 0x0).
and view the bootROM memory
(at physical address of 0x28000000).  I enable the MMU XLAT and set the
PTBASE to 0xf0 as suggested in the
user manual.
Here is the output of the BDI

BDI>reset
- TARGET: processing user reset request
- TARGET: resetting target passed
- TARGET: processing target init list ....
- TARGET: processing target init list passed
BDI>bi 0x0c000000 0x0c00ffff
Breakpoint identification is 0
BDI>go 0x28000100
- TARGET: target has entered debug mode
BDI>ci
BDI>info
    Target state      : debug mode
    Debug entry cause : entering check stop state
    Current PC        : 0x00000220
BDI>

I never seem to get the break at the location of 0x0c000000.
The same problem if I set the break at location of start_here grep from
System.map

However I do get the break if I set at address location of 0 (start of the
head_8xx.S)
Can someone help me out here??

Thanks

Cecilia

P.S. here is a brief information of my .cfg file which I loaded to BDI

; bdiGDB configuration file for TQM855L/TQM860L Modules
; -----------------------------------------------------
;
[INIT]
; init core register
WREG	MSR		0x00001002	;MSR  : ME,RI
WSPR	27		0x00001002	;SRR1 : ME,RI
;;WSPR	149		0x2002000F	;DER  : set debug enable register
WSPR	149		0x2006000F	;DER  : enable SYSIE for BDI flash
progr.
WSPR	638		0xF0000000	;IMMR : internal memory at
0xF0000000
WSPR	158		0x00000007	;ICTRL:

; init SIU register
WM32	0xF0000000	0x70630200	;SIUMCR
WM32	0xF0000004	0x0000FF80	;SYPCR

;WM32	0xFFF00284	0x00000000	;PLPRCR no need to change (1:1 clock
mode)

; Init Memory Controller:
;
; BR0 and OR0 (BOOT FLASH)
WM32	0xF0000104	0xFFF00550	; 1 MB
WM32	0xF0000100	0x28000401	; @ 0x28000000 - 0x280FFFFF, 8Bit,
GPCM

; BR3 and OR 3 (SDRAM)
WM32	0xF000011C	0xFF000800	; 16 MB
WM32	0xF0000118	0x00000081	; @ 0x00000000 - 0x00FFFFFF, 32Bit,
UPMA

; BR5 and OR5 (MAIN FLASH & MDIO GLUE)
WM32 	0xF000012C	0xFD000550	; 16 MB FLASH / 16 MB GLUE
WM32	0xF0000128	0x08000001	; @ 0x08000000 - 0x08FFFFFF, 8Bit,
GPCM (FLASH)
					; @ 0x0A000000 - 0x0AFFFFFF, 8Bit,
GPCM (GLUE)
; init UPM A
;
SUPM	0xF0000168	0xF000017c	;set address for MCR and MDR

;  single read. (offset 0 in upm RAM)
WUPM	0x00000000 	0xFF0FC024
WUPM	0x00000001 	0x0F03C024
WUPM	0x00000002 	0x7F0FC004
WUPM	0x00000003 	0x00ACC004
WUPM	0x00000004 	0x0FF30000
WUPM	0x00000005 	0x7FFFC004
WUPM	0x00000006 	0xFFFFC005
WUPM	0x00000007 	0xFFFFFFFF

;  burst read. (Offset 8 in upm RAM)
WUPM	0x00000008 	0xFF0FC024
WUPM	0x00000009 	0x0F03C024
WUPM	0x0000000A 	0x7FFFC004
WUPM	0x0000000B 	0x00FCC004
WUPM	0x0000000C 	0x70FFC000
WUPM	0x0000000D 	0xF0FFC000
WUPM	0x0000000E 	0xF0FFC000
WUPM	0x0000000F 	0xFFFFC000
WUPM	0x00000010 	0xFFFFC004
WUPM	0x00000011 	0xFFFFC005
WUPM	0x00000012 	0xFFFFFFFF
WUPM	0x00000013 	0xFFFFFFFF
WUPM	0x00000014 	0xFFFFFFFF
WUPM	0x00000015 	0xFFFFC034
WUPM	0x00000016 	0x0FA00034
WUPM	0x00000017 	0x7FAFC035

;  single write. (Offset 0x18 in upm RAM)
WUPM	0x00000018 	0xFF0FC024
WUPM	0x00000019 	0x0F03C024
WUPM	0x0000001A 	0x7F0FC000
WUPM	0x0000001B 	0x00AC0004
WUPM	0x0000001C 	0x0FF30004
WUPM	0x0000001D 	0x7FFFC005
WUPM	0x0000001E 	0xFFFFFFFF
WUPM	0x0000001F 	0xFFFFFFFF

;  burst write. (Offset 0x20 in upm RAM)
WUPM	0x00000020 	0xFF0FC024
WUPM	0x00000021 	0x0F03C024
WUPM	0x00000022 	0x7F0FC000
WUPM	0x00000023 	0x00FC0000
WUPM	0x00000024 	0x70FFC000
WUPM	0x00000025 	0xF0FFC000
WUPM	0x00000026 	0xF0FFC004
WUPM	0x00000027 	0xFFFFC005
WUPM	0x00000028 	0xFFFFFFFF
WUPM	0x00000029 	0xFFFFFFFF
WUPM	0x0000002A 	0xFFFFFFFF
WUPM	0x0000002B 	0xFFFFFFFF
WUPM	0x0000002C 	0xFFFFFFFF
WUPM	0x0000002D 	0x0FF30004
WUPM	0x0000002E 	0x7FFFC005
WUPM	0x0000002F 	0xFFFFFFFF

;  Refresh cycle, offset 0x30
;  One refresh cycle
WUPM	0x00000030 	0x0FF0C004
WUPM	0x00000031 	0x7FFFC004
WUPM	0x00000032 	0xFFFFC004
WUPM	0x00000033 	0xFFFFC004
WUPM	0x00000034 	0xFFFFC005
WUPM	0x00000035 	0xFFFFFFFF
;  Two refresh cycles
WUPM	0x00000036 	0x0FF0C004
WUPM	0x00000037 	0x7FFFC004
WUPM	0x00000038 	0xFFFFC004
WUPM	0x00000039 	0xFFFFC004
WUPM	0x0000003A 	0x0FF0C004
WUPM	0x0000003B 	0x7FFFC004
;  Exception, 0ffset 0x3C
WUPM	0x0000003C 	0xFFFFC004
WUPM	0x0000003D 	0xFFFFC005
WUPM	0x0000003E 	0xFFFFFFFF
WUPM	0x0000003F 	0xFFFFFFFF

WM32	0xF0000170	0x18043111	; MAMR = machine A mode register

; Execute precharge-all command using Memory Command Register, Patch-Offset
0x2D
; Immediately following initialize SDRAM
;
; SRAM
WM32	0xF0000168	0x8000612D
WM32	0xF0000168	0x80006136	; 2 cycle autorefresh command

WM32	0xF0000164	0x00000088	; MAR = Memory Address Register
WM32	0xF0000168	0x80006115	; rUN INDEX AT 0x15

; Initialize memory periodic timer prescaler (MPTPR). divide by 32
; enable timer
WM16	0xF000017A	0x0200
WM32	0xF0000170	0x18843111	; MAMR = machine A mode register

WSPR	796		0x00000000	;invalidate M_TWM in any case
WM32	0x000000f0	0x00000000	;invalidate page table base

[TARGET]
CPUCLOCK    5000000	;50MHz CPU clock rate after processing the init list
BDIMODE	    AGENT	;the BDI working mode (LOADONLY | AGENT)
BREAKMODE   HARD	;SOFT or HARD, HARD uses PPC hardware breakpoints
MMU 	    XLAT	;enable address translation
PTBASE	    0x000000f0	;here is the pointer to the page table pointer

[HOST]
IP          192.168.0.211
;FILE        E:\cygnus\root\usr\demo\mbx860\vmlinux
;FORMAT      BIN
FILE        t:\cmuaddi\tftp\linux\images\zImage
FORMAT      IMAGE
;FILE        E:\cygnus\root\usr\demo\mbx860\vxWorks
;FORMAT      ELF
LOAD        MANUAL      ;load code MANUAL or AUTO after reset

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
