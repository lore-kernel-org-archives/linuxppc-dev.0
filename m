Message-ID: <21A8AE56EBB6D411A4520060973D360101A9F739@PEPINTERCOM>
From: Claus Gindhart <Claus.Gindhart@kontron.com>
To: "'Gallant, John'" <jgallant@vanteon.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Assistance with using /dev/fb0 and No X windows
Date: Tue, 14 Jan 2003 08:46:56 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello John,

i assume you want to see console output on the framebuffer
device.
To achieve this, you need
the framebuffer driver
  from your mail i conclude, that You have a framebuffer driver
a keyboard driver
  the dummy keyboard driver is o.k., if you dont have a physical kbd
Additionally you have to enable CONFIG_VT and CONFIG_VT_CONSOLE
on your system.
Please remove console=ttyS0 from the kernel command line. Put a console=xxx
command, which is appropriate for your framebuffer driver (see sourcecode
of framebuffer driver)

-----Original Message-----
From: Gallant, John [mailto:jgallant@vanteon.com]
Sent: Montag, 13. Januar 2003 17:23
To: linuxppc-embedded@lists.linuxppc.org
Subject: Assistance with using /dev/fb0 and No X windows

    I have managed to get the "default" VGA/FB support to access my graphics
device on the onboard PCI bus.  We a SMI LynxEM chip on the board.  I have
the vga init() code properly accessing the device and the on chip frame
buffer.  I have used fbset to determine if /dev/fb0 can be accessed, and the
driver is called.  I also tried "ls -l > /dev/fb0" this also gets into the
vga16fb_get_fix() code.

    What I need to do, and here is my lack of understanding, is to have some
program access the /dev/fb0 device and display on the CRT.  I do not have
any X support, only whatever came with the MVL distribution.  I am wondering
what is necessary to use mingetty, or some other display method.

    Added wrinkles:  No keyboard yet, but I do have the console=ttyS0
working.

    So any advice on what I could use or what I may have missed in my
Xconfig settings?
[...]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
