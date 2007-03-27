Return-Path: <powerpc440@googlemail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by ozlabs.org (Postfix) with ESMTP id 92DF2DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 00:39:36 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w9so3030819mue
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Mar 2007 07:39:34 -0700 (PDT)
Message-ID: <46092D3A.7000903@googlemail.com>
Date: Tue, 27 Mar 2007 16:42:02 +0200
From: powerpc440 <powerpc440@googlemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Custom board based on PPC405 and PCI Graphic controler problem.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I have a custom board, based on ppc405ep CPU. On the board are 3 PCI devices: sATA, USB and PCI Slot. sATA and PCI working already gut, but still I have some troubles with a Graphic Controler put on PCI slot. The graphic card is standard 3.3V PCI Radeon 7000. I have compile xorg 7.2, and try to start the X server with radeon driver. The X server starts, the monitor is found with the correct model, but no picture is appears. After several seconds the whole board freeze. After system check no Xorg.0.log file is stored, but while X server starts, I see follow messages in serial console:

root@localhost:~$ X
_XSERVTransSocketOpenCOTSServer: Unable to open socket for inet6
_XSERVTransOpen: transport open failed for inet6/localhost:0
_XSERVTransMakeAllCOTSServerListeners: failed to open listener for inet6

X Window System Version 7.2.0
Release Date: 22 January 2007
X Protocol Version 11, Revision 0, Release 7.2
Build Operating System: Linux 2.6.16.27 ppc
Current Operating System: Linux localhost 2.6.16.27 #13 Fri Mar 23 10:33:46 CET 2007 ppc
Build Date: 27 March 2007
        Before reporting problems, check http://wiki.x.org
        to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
        (++) from command line, (!!) notice, (II) informational,
        (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/usr/xorg/var/log/Xorg.0.log", Time: Tue Mar 27 15:02:51 2007
(==) Using config file: "/etc/X11/xorg.conf"
(WW) RADEON: No matching Device section for instance (BusID PCI:0:1:1) found
(WW) ****INVALID IO ALLOCATION**** b: 0xe800ff00 e: 0xe800ffff correcting
(EE) end of block range 0xe7ffffff < begin 0xe8000000
(**) RADEON(0): RADEONPreInit
(**) RADEON(0): RADEONScreenInit b8000000 0
(**) RADEON(0): Map: 0xb8000000, 0x00800000
(**) RADEON(0): RADEONSave
(**) RADEON(0): RADEONSaveMode(0x101e1408)
(**) RADEON(0): Read: 0x0000003f 0x000001bb 0x00000000
(**) RADEON(0): Read: rd=63, fd=443, pd=0
(**) RADEON(0): RADEONSaveMode returns 0x101e1408
(**) RADEON(0): RADEONInitMemoryMap() :
(**) RADEON(0):   mem_size         : 0x08000000
(**) RADEON(0):   MC_FB_LOCATION   : 0xbfffb800
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0): RADEONModeInit()
1400x1050     122.00  1400 1488 1640 1880  1050 1052 1064 1082 (24,32) +H +V
1400x1050     122.00  1400 1488 1640 1880  1050 1052 1064 1082 (24,32) +H +V
(**) RADEON(0): Pitch = 11534512 bytes (virtualX = 1400, displayWidth = 1408)
(**) RADEON(0): dc=12200, of=24400, fd=108, pd=2
(**) RADEON(0): RADEONInit returns 0x101e1db8
(**) RADEON(0): RADEONRestoreMode()
(**) RADEON(0): RADEONRestoreMode(0x101e1db8)
(**) RADEON(0): RADEONRestoreMemMapRegisters() :
(**) RADEON(0):   MC_FB_LOCATION   : 0xbfffb800
(**) RADEON(0):   MC_AGP_LOCATION  : 0xffffffc0
(**) RADEON(0):   Map Changed ! Applying ...
(**) RADEON(0):   Map applied, resetting engine ...
(**) RADEON(0): Updating display base addresses...
(**) RADEON(0): Memory map updated.
(**) RADEON(0): Programming CRTC1, offset: 0x00000000
(**) RADEON(0): Wrote: 0x0000000c 0x0001006c 0x00000000 (0x0000a400)
(**) RADEON(0): Wrote: rd=12, fd=108, pd=1
(**) RADEON(0): GRPH_BUFFER_CNTL from 20205c5c to 200e5c5c
(**) RADEON(0): RADEONSaveScreen(0)
(**) RADEON(0): Setting up initial surfaces
(**) RADEON(0): Initializing fb layer
(**) RADEON(0): Setting up accel memmap
(**) RADEON(0): Initializing backing store
(**) RADEON(0): Setting up final surfaces
(**) RADEON(0): Initializing Acceleration
(**) RADEON(0): EngineInit (32/32)
(**) RADEON(0): Pitch for acceleration = 176
(**) RADEON(0): EngineRestore (32/32)
(**) RADEON(0): Initializing DPMS
(**) RADEON(0): Initializing Cursor
(**) RADEON(0): Initializing color mapnevertheless;
(**) RADEON(0): Initializing DGA
(**) RADEON(0): Initializing Xv
(**) RADEON(0): RADEONScreenInit finished
expected keysym, got dead_diaresis: line 143 of pc/de
The XKEYBOARD keymap compiler (xkbcomp) reports:
> Warning:          Type "ONE_LEVEL" has 1 levels, but <RALT> has 2 symbols
>                   Ignoring extra symbols
Errors from xkbcomp are not fatal to the X server
(**) RADEON(0): Idle timed out: 64 entries, stat=0x80060140
(EE) RADEON(0): Idle timed out, resetting engine...
(**) RADEON(0): EngineRestore (32/32)


I know that the monitor is found, because at first I was try with xorg 7.0, and the system stores log file. Nevertheless the error message was the same:

(EE) RADEON(0): Idle timed out, resetting engine...


My question is, what I have to do in u-boot or Linux kernel, to run a standard PCI graphic card on PPC405 system?

PS:I was try also the Kernel's framebuffer modules: RADEON and REDEON_OLD but also without any success.

Thank you in advance!

Best regards,
Zhivko Yordanov
