Message-ID: <399C128F.358D3503@vas-gmbh.de>
Date: Thu, 17 Aug 2000 18:27:59 +0200
From: 510072564774-0001@t-online.de (Frank Przybylski)
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Boot issues
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Navin,

>I am trying to work with a fads 823 board. I was a little confused as to how
>the boot process on the 823 actually works. I have been using 8xxrom code to
>boot up the system. I do not understand if the flash is accessed from the
>start when a reset occurs. Can someone explain the actual boot process.
>Nothing much about it is written in the mpc823 manual.

I've never ever had an MPC823 in my hands, but I hope it's very similar
to the MPC860.

see in MPC823UM/d (page 433 in the version I have):

"15.3.1.2 OPTION REGISTERS. The option registers (OR0-7) contain the address
mask
and address type mask bit for address bus comparison. It also includes the CS
general field and all the GPCM parameters. After reset, OR0 is referred to as
the Boot OR0 and it has a special functionality until the first write to OR0."

and page 15-38 (page 460 in the version I have) in chapter 15.4.1.3: BOOT
CHIP-SELECT OPERATION for greater detail.

After reset the processor is in a kind of boot mode. This means:
only memory bank0 is valid (see spr OR0 and BR0), and this is mapped for the
whole memory starting at address 0x0. So the ROM content seems to repeat as
addresses increases. You only have access to the boot ROM connected to CS0#
after reset.

The processor starts execution at address 0x100 (see 'hard reset configuration'
for a different behavior, size of Boot ROM etc.), so code from the ROM will be
executed.

The ROM code is then responsible for setting OR1-7 and BR1-7 to the board
specific mapping, setting up UPMs and a lot of system registers, and finally to
init BR0 and OR0. This might remap the ROM addresses (e.g. to 0x40000000) and
normally the boot code jumps to an absolute address inside the new ROM address
space (so the old reset entry point is then located at e.g. 0x40000100). With
this initializing the 'boot
mode' is finished.

Have a look at the 8xxrom source code, and maybe inside the mpc860 manual.

hth
	Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
