Message-ID: <B0CD235912AED411B69800D0B7C9F60F1DF878@mail>
From: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel not returning from M8xx_cpm_reset
Date: Wed, 20 Nov 2002 18:03:00 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I have ported the ppcboot 1.2.0 over to my hardware. I went into some
problem when I wanted to run the TQM_860L linux (version 2.4.4). The kernel
would not print anything after it was launched by the ppcboot. When I
stopped it, it shows that it is engaged in some kind of timer loop. When I
traced the function calls, I found that it never returns from the function
<va_to_pte>, and I have no idea how does it end up in the timer loop from
<va_to_pte>.
The followings are what I have found thus far. Could anybody please shed
some light into this. Thanks.
Francis Yu


=> bootm 400000
## Booting image at 00400000 ...
   Image Name:   Linux-2.4.4
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    605331 Bytes = 591.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00F9BC18 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF00
bd address  = 0x00F9BFC4
memstart    = 0x00000000
memsize     = 0x01000000
flashstart  = 0xFFE00000
flashsize   = 0x00200000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xFA000000
bootflags   = 0x00000001
intfreq     =     50 MHz
busfreq     =     50 MHz
ethaddr     = 00:10:EC:00:1D:0B
IP addr     = 192.168.1.65
baudrate    =   9600 bps
No initrd
## Transferring control to Linux (at address 00000000) ...

Nothing else was shown from this point on. I went in there to trace the
Kernel and found the followings:

Kernel started executing at 0x00000000, it went through some setups and then
jumped to the following sequences:
<start_kernel> ;
<setup_arch>;
<m8xx_setup_arch>;
<m8xx_cpm_reset>;
<va_to_pte>, passing 0x1b7000 as parameter;
Inside <va_to_pte>

 $0000AB24 mr.      R3,R3			(R3=0x1b7000)
 $0000AB28 blt      0xab34
 $0000AB2C lwz      R9,0x2c(R2)		(R2=0x156020, R9=0)
 $0000AB30 b        0xab3c
 $0000AB34 lis      R9,0x15
 $0000AB38 addi     R9,R9,0x5f9c
 $0000AB3C lwz      R11,0xc(R9)		(R11=0x7cdc3378 ???)
 $0000AB40 rlwinm   R3,R3,0x0,0x0,0x13	(R3=0x1b7000)
 $0000AB44 rlwinm   R9,R3,0xc,0x14,0x1d	(R9=0)
 $0000AB48 add      R0,R11,R9			(R0=0x7cdc3378)
 $0000AB4C cmpwi    R0,0x0......		(Starting accessing
non-existing memory here!!!)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
