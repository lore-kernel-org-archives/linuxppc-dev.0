Message-ID: <20010926045943.4528.qmail@kunk.jriver.com>
Subject: Stock 2.4.10 kernel on RS6K 7248, pretty darn good....
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 25 Sep 2001 23:59:43 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


ALMOST everything works really well for me. The PCI fixes for the 7248
are in the stock kernel and it even works with a PCI tulip card.

I'm running SUSE 7.1 on this box. Only 2 problems. One very small...

1) When booting the 2.4.10 kernel as opposed to the 2.2.18 kernel, the
virtual consoles have the character and attribute REVERSED so there is
junk on the screen when one first switches. Subsequent characters
displayed work properly however. 2.4.10 is using the VGA console
driver in this case because the frame buffer driver wasn't
compiled in.

2) A little more problematic, I'd like to run X on this (it IS a
workstation). The carolina patches for 2.2.18 created a frame buffer
device for the S3-864 display called IBM_E15. It works nicely for
X 3.3.6 but there is no patch that I can find for this for 2.4 kernels.

I've been hacking the 2.2.18 patch into the 2.4.10 kernel source tree
and have it booting and using the frame buffer device for console
characters but it blows up when I run X. The screen blanks out
and the machine i/o appears dead.

I'm wondering if anyone is doing X on the prep boxes with 2.4.x and
if so, how? I was also curious about the possibility of skipping the
frame buffer stuff and running the accelerated S3 driver for X.


Here is the dmesg from 2.2.18 for the E15....

IBM_E15: initializing
IBM_E15: No PCI linear framebuffer base address  assigned to 864.
IBM_E15: This is normal. Using default of 0x20000000.
IBM_E15: detected S3 864, linear frame buffer at 0x20000000
Video ram virt base = d0000000
IBM_E15: Text console mode: 8 bit color depth
Console: switching to colour frame buffer device 80x30
fb0: IBM_E15 frame buffer device

Here it is from my hack into 2.4.10....

IBM_E15: initializing
IBM_E15: detected S3 864, linear frame buffer at 0x02800000
Video ram virt base = f2800000
IBM_E15: Text console mode: 8 bit color depth
Console: switching to colour frame buffer device 80x30
fb0: IBM_E15 frame buffer device


I noticed that the linear frame buffer address and the video ram virt base
are pretty different....

Hints are more than welcome!

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
