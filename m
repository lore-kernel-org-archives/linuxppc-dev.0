Subject: Framebuffer problems
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF833FB15C.A4B24E5E-ON85256E9A.0066AC69-85256E9C.00054851@nanometrics.ca>
From: Christopher E Cordahi <chris@nanometrics.ca>
Date: Fri, 21 May 2004 20:57:41 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm having problems with a framebuffer on /dev/fb0 using the DENX 2.4.24
kernel

I have added the Linux Console Driver for the Epson S1D13806
http://www.erd.epson.com/vdc/RelSoft/generic/s1d13xxx_linux.zip
which prints the following to the console as it is initialized
Console: switching to frame buffer device
S1D13xxx: fb0: s1d13xxx frame buffer device
S1D13xxx: Display 240 x 320 8Bpp

Whenever the framebuffer is accessed a call is made to the
function PROC_CONSOLE in fbcon.c which always returns -1
because the info->display_fg pointer is NULL

None of the functions that call PROC_CONSOLE test for this error value.

Some commands seem to work because later functions test for con == -1.
(FBIOGET_FSCREENINFO works because fbgen_get_fix tests for it)
Ofher commands fail because later functions assume the con passed is
correct and use it as an index into the fb_display array.
(FBIOGETCMAP fails because fbgen_get_cmap doesn't test for it)
I guess I'm lucky the whole O/S is not crashing.

Is there a way to have PROC_CONSOLE always return a valid value?
Or should all the functions in fbgen.c be fixed to handle con == -1?

I would like to leave the serial port (/dev/ttyS0) as the console
and I don't actually want the framebuffer as the console.
I would prefer that only Konqueror/Embedded with Qt/Embedded
use the framebuffer.

Any assistance would be greatly appreciated.

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
