Message-Id: <v03130301b2d040f84476@[192.168.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 24 Jan 1999 04:48:41 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Samuel Rydh <samuel@ibrium.se>
Subject: mac-on-linux project status
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Mac-on-linux project status, Jan 23, 1999
=================================


1. Overview

The goal of the mac-on-linux project is making linuxppc capable of
booting a second operating system. The target is in particular
to run MacOS, but also Be OS, Mac OS X Server and a "second linux".


2. Introduction

One common way of booting a second operating system involves
a software emulation library (Apple's MAE uses this technique).
One of the benefits with this approach is that it is fairly hardware
independent. However, only a single OS can be targeted.

The mac-on-linux project does not utilize an emulation library.
Instead it emulates the hardware of the machine. An approach that
has been commonly used to emulate such computers as C64, Atari,
Amiga, MSX etc.

In order to obtain reasonable speed, it is necessary that the second
OS runs natively on the processor. This has been achieved through
low-level support code in the kernel.


3. Supported Machines

For now, the code works on the 601 and the 604 processors. It probably
runs on G3 too.

The 603 have a slightly different MMU implementation (no PTE table).
Some modifications must be made to the MMU-code to support the 603
(this should be relatively simple).

Only linux-ppc is supported, not MkLinux. A port to MkLinux probably
requires a lot of effort since the micro-kernel architecture complicates
things.

For now, the Power Macintosh is in focus. It should be simple enough to
add support for other linuxppc machines though.


4. Status of Hardware Emulation

The processor emulation is fairly complete, with some  exceptions:

  - floating point instructions
  - 603 support
  - HIDx registers

Some things in the MMU code needs to be fixed and tuned,  but the MMU
emulaton is in principle complete.

Most of device drivers are unimplemented, or in very preliminar state.
Some of the things written so far:

   - nvram
   - via/cuda
   - adb (keyboard)
   - swim3 floppy controller
   - interrupt controller
   - 53c94 SCSI controller (emulates an empty SCSI bus)
   - AWACS sound controller
   - platinum (experimental)
   - DBDMA controller

The AWACS driver simply plays data sent through the DMA-channel
at constant speed. (This driver was written entirely to test the dma
interface.
It plays the startup-boing nicely though.)

The swim3 floppy driver does not support write operations. It can however
be used to load a kernel image.

The screen driver (platinum) is very experimental, but it is semi-working
(on the 7200/8200).

For now, it is necessary to communicate with Open Firmware through one of the
serial ports. Until a serial driver has been written, access of the serial
controller
is forwarded to the real hardware.


5. How Far Does It Boot?

The goal is booting MacOS, but it is far easier to boot a second linux
(since the
source  code is known). Thus, no effort has yet been put into booting MacOS.

It is possible though to boot and run the linux installer for a floppy
image. In
theory,  it should be possible to boot a complete linux system as soon as a
SCSI-driver
has been written.

The screen drivers have not been written yet, with the exception for a very
preliminary  platinum driver (which only works on the 7200/8200 for now).


6. Programmers Needed!

The source code has been published under the GNU license.  To help make this
project a success, take a look at the source and see if there is something you
can do to contribute!

The source code and further information is avabile at

	<http://www.ibrium.se/linux/mac_on_linux.html>.



/Samuel Rydh <samuel@ibrium.se>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
