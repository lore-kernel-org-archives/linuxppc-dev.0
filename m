Date: Sat, 9 Jan 1999 18:19:15 +0100
To: Paul Mackerras <paulus@cs.anu.edu.au>, linuxppc-dev@lists.linuxppc.org,
        cort@persephone.cs.nmt.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Interesting stuffs & feature bits
Message-Id: <19990109181915.002685@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've done some hacking with MacsBug on MacOS today to understand
something related to the serial ports when I found those things:

 - The FCR bits in ohare.h for SCC channel A and B enable seems to be
wrong for the wallstreet (heathrow) and eventually other machines too.
They are currently defined this way:

#define OH_SCCA_IO		0x2000
#define OH_SCCB_IO		0x4000
#define OH_SCC_ENABLE		0x200

Apparently, on mt heathrow-based PowerBook, channel A is 0x4000 and
channel B is 0x8000 but MacOS always enable bit at 0x2000 when setting
one of those.
So, in the array of feature, the mask for channel A should be 0x00004200
and for channel B, it should be 0x00008200. So I guess this bit is wrong
too. The result for heathrow would be:

#define HEATHROW_SCCA_IO		0x4000
#define HEATHROW _SCCB_IO		0x8000
#define HEATHROW _SCC_ENABLE		0x2000

 - For port B (infra-red), MacOS sends a PMU command when opening and
closing the port. This is the 0x11 command, currently defined as
PMU_BACKLIGHT_CTRL. It looks like this command can be used to control the
power of some pieces of the motherboard. I think it's the IR LED power
which is controlled this way. The command sent by MacOS has one parameter
which is 0x84 when opening the port and 0x04 when closing it. This value
is not calculated from a previous value with a mask or anything like
that, so it's probably not a bitmask of things to enable/disable. I think
the top-most bit means enable/disable, the bottom bits mean what to
enable/disable: 0x4 for the IR port, and 0x1 for the backlight power (at
least on Paul's 3400, I didn't test it here).
We should rename the constant to PMU_POWER_CTRL.

I'm preparing some patches with some of those changes and more macserial
fixes (I found bugs in the way I turn the modem on/off). I would however
like someone with a OHard based machine to check the FCR bits. In my
patches, I will only change the heathrow ones until someone have tested
(both are separated in features.c)

If you want to test on your machine, use MacsBug, break on the traps
AOn(), AOff(), BOn() and BOff() (they control the enabling of the serial
port). I suggest using the TVB command for breaking in PPC code. Then,
open the serial ports, and trace.
For stepping, you have to step-into (Cmd-S in macsbug) until you reach
the code that plays with the SCC. On my machine running MacOS 8.5.1, it
looks like this:

 - First, you break into a PPC glue that calls CallOSTrapUniversalProc.
Step _into_ this function
 - You get in 68k code. Obviously, it looks like code that test the
function selector and jumps to appropriate code via an indexed JSR (the
JMP is easy to find, on my machine, it's indexed on A0 and D1). Step into
it and continue stepping until you reach a second indexed JSR. Step into
it again and that's it.

Once you have found the code for AOn(), the others (AOff(), BOn() and
BOff()) are just after (I don't remember in which order).


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
