Message-Id: <6.0.1.1.0.20040213165723.01f573a8@dns.struinfo.it>
Date: Fri, 13 Feb 2004 17:50:21 +0100
To: jgallant@vanteon.com
From: llandre <r&d@wawnet.biz>
Subject: RE: Assistance with using /dev/fb0 and No X windows
Cc: linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi John,

three months ago I started a thread in the linuxppc-embedded ml about the
Silicon Motion
VGA controllers. Today I realized that you are working with the same chip
by reading
you message on the linuxppc-embedded ml.
Last week I started working with the SM712 chip on an embedded PPC system (a
PPC405EP-based custom board).
So far I successfully enabled the driver under U-Boot. The chip (I'm
working with its PCI evaluation board called Purin) is initialized
correctly and the U-Boot shell is prompted on the monitor (even the famous
penguin
logo appears on the screen).
To do that it is necessary to:

1) define the following symbols to add the SM712 support:
#define CONFIG_VIDEO
#define CONFIG_CFB_CONSOLE
#define CONFIG_VIDEO_SMI_LYNXEM
#define CONFIG_VIDEO_LOGO
#define CONFIG_CONSOLE_EXTRA_INFO
#define CONFIG_VGA_AS_SINGLE_DEVICE
/* This is the base address (on 405EP-side) used to generate I/O accesses
on PCI bus */
#define CFG_ISA_IO 0xE8000000

2) define the symbol CONFIG_PCI_PNP in order to make U-Boot to initialize
the PCI registers (for example, in this case, the BAR0 register is
set to 0x80000000).


Then I tried to enable it under the Linux kernel 2.4.20, too.
First of all I enabled the VGA drivers (s you can see I used a different
configuration from yours):

#
# Character devices
#
CONFIG_VT=y
# CONFIG_VT_CONSOLE is not set
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

...

#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_S3TRIO is not set
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=y
CONFIG_FB_LYNX=y
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FBCON_ADVANCED is not set
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
# CONFIG_FBCON_FONTWIDTH8_ONLY is not set
# CONFIG_FBCON_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y




but, when the kernel loaded them, it crashed:



i2c-core.o: i2c core module
vga16fb: mapped to 0xc3070000
Oops: Exception in kernel mode, sig: 4
NIP: C00A4348 XER: 00000000 LR: C00A466C SP: C1F9DCE0 REGS: c1f9dc30 TRAP:
0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1f9c000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0x00000800 acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000

GPR00: C00A4664 C1F9DCE0 C1F9C000 00000000 00000000 E80003CE 00000000 00000050
GPR08: C3079150 00000500 00000010 C0177A18 C01BFEBC 30000000 C01B0000 C1F9DE08
GPR16: 00000050 00000000 C01B0000 C1F9DD08 000012C0 0000001E 000000A0 C02752C0
GPR24: 00000000 C01B0C90 000000A0 00000001 C01B0B94 00000001 00000000 00000000
Call backtrace:
C00A4664 C00A4D14 C00D138C C00D0AB4 C00A4794 C00A8834 C00CF980
C0192B98 C0190D94 C018B498 C01825B4 C0182600 C0002448 C0006D54
Kernel panic: Attempted to kill init!
Oops: Exception in kernel mode, sig: 4
NIP: C00A8CC0 XER: 00000000 LR: C0135380 SP: C1F9DB00 REGS: c1f9da50 TRAP:
0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1f9c000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
PLB0: bear= 0x00000800 acr=   0x00000000 besr=  0x00000000
PLB0 to OPB: bear= 0x00000000 besr0= 0x00000000 besr1= 0x00000000



Today I tried to use the same configuration you posted to the ml, but it
crashed anyway
when executing vga16fb. I'll do further investigations. I suspect the
VGA_FB_PHYS in
vga16fb.c must be changed to take into account how U-Boot initialized the
BAR0 register.
In my understanding, the default 0xA0000 value is ok for PCs.


Did you experience similar problems? Did you need to hack the VGA drivers?


I'll keep you informed about what it is going on.


Thanks in advance and best regards,

llandre


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
