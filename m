From: "Bob Piatek" <bobtek@fishcamp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
Date: Tue, 19 Feb 2002 08:53:50 -0800
Message-ID: <002801c1b966$01a4b9e0$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <5.1.0.14.2.20020219061240.01e68de8@falcon.si.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A good book on the subject:

The Boundary-Scan Handbook by Kenneth P. Parker
Kluwer Academic Publishers
http://www.wkap.nl/

Bob

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Jerry
Van Baren
Sent: Tuesday, February 19, 2002 3:41 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: custom mpc8240 student project (long)


I agree, a socketed flash/EEPROM is your simplest method.

If you _really_ want to go JTAG, Mot has the 8240 BSDL available on
their
web site:
   http://e-www.motorola.com/collateral/MPC8240R1EBSDL.txt
This is the boundary scan description: it shows how the pins of the chip
can be scanned via JTAG.  You can write to flash by repeatedly (and I
mean
_repeatedly_!) scanning in the states of all the pins to wiggle the
address, data, and control signals (CS0*, write strobe, etc).  By
wiggling
the proper pins to simulate write cycles, you can write to flash.

Disclaimers:
* This is slow and painful.

* I've seen this done successfully with an Intel 386EX processor.  That
was
the only time someone I know was foolish enough to do this.

* Before it was done successfully with an Intel 386EX processor, I saw
at
least two of them burned up.  If you do the JTAG wrong, you can define
input pins to be output pins, causing a driver conflict which quickly
blows
the pin.

* The BSDL tends to change with processor revisions.  Make sure your
BSDL
matches the processor revision!

* Flash works because there is typically no cycle-to-cycle timing
requirements to set up the write and the write itself.

* EEPROM can be a problem because it typically has a 100uSec max timing
requirement for the write sequence and you will find that hard to do via
a
bit-bang parallel port.  In the 386EX case, we were able to write to
EEPROM
if software write protect was OFF.  If it was ON, it required a hardware
JTAG accelerator card to unlock it because we could not do the whole
unprotect sequence fast enough.

* It takes three scans per write cycle: scan in the three sequences
<address, data, not write>, <address, data, write>, <address, data, not
write>.  (It seems like it should be do-able in two, but my coworker was
unable to do it in two on the 386EX -- YMMV.)  When you count how many
bits
need to be shifted, you quickly realize how slow this is.

* Did I mention it is slow, painful, and fraught with hazards?

gvb
P.S. You are on your own if you go this route.  Enjoy learning BSDL :-).
P.P.S On the positive side, if you want to work for a JTAG tester
company,
you will have a _really_ impressive resume'.


At 03:32 PM 2/18/2002 -0700, Dustin Byford wrote:

>I understand what you're saying about the COP so I need to evaluate my
>options.  We are all students working on this so I don't think my
coleauges
>will spring for the BDI since we don't have one available to us at the
>University.  Is the BDI1000/2000 the least expensive way to use the
JTAG/COP?
>
>An alternate idea:  What if I jumper in a 32 pin PDIP 8-bit EEPROM
somewhere
>that I can boot from (RCS0/8-bit).  I can pull this part off of the
board and
>throw it in a programmer we have at the university.  Hopefully I'll be
able
>to program it with something that will "simply" program itself onto the
TSOP
>AMD flash (which would then be jumpered to (32-bit/RCS1).  Remove the
jumpers
>and reset the board and maybe I would have a ROM that can downlaod
stuff
>through the UART.  Not the quickest of development cycles but it is a
no-cost
>solution.
>
>Or: Leave the EEPROM on RCS0 all the time.  The AMD Flash on RCS1 all
the
>time and find another place to put the UART.  Suggestions?
>
>Thanks
>
>                         --Dustin
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
