Message-ID: <E380A44D523BD5118EAE0002A52CE5C40B87C883@zcard0k8.ca.nortel.com>
From: "Andrew Williams" <awilliam@nortelnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: FEC support for 8260 in kernel 2.4.25
Date: Mon, 26 Apr 2004 14:48:59 -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-- Fourth Attempt.. hoping to have disabled HTML output in Outlook --

Not just the GPIO pins, be sure to note the different
clock sources. (Which in the code is clearly labeled as
"This is board specific", but then goes on to declare
constant values in the common fcc_enet.c file).

  This bothered me enough that I changed the fcc_enet
files from:

#define PC_F1RXCLK      ((uint)0x00000800)
#define PC_F1TXCLK      ((uint)0x00000400)
#define CMX1_CLK_ROUTE  ((uint)0x3e000000)

to

#ifndef PC_F1RXCLK
#define PC_F1RXCLK      ((uint)0x00000800)
#endif
#ifndef PC_F1TXCLK
#define PC_F1TXCLK      ((uint)0x00000400)
#endif
#ifndef CMX1_CLK_ROUTE
#define CMX1_CLK_ROUTE  ((uint)0x3e000000)
#endif

 (repeat for all 3 interfaces)

I know it looks a bit kludgy, but you can now declare board
specific values in your platform/<platform>.h file, and have these
override the current default hard coded values. Furthermore this
change won't break any existing platforms. :o)

One other potential 'gotcha' is if you have different FPSMR values
depending on the interface. The current code (2.4.22) limits you to
a single value that applies to all three interfaces. I worked around
this one, by adding a field to 'fcc_info' for the fpsmr. Then in the
declaration of 'fcc_ports' I once again used conditional
compiles to allow FPSMR values in the platforms file to override
the default FCC_PSMR_ENCRC value.


Andrew

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
