Message-ID: <3937BBF4.344449FC@vas-gmbh.de>
Date: Fri, 02 Jun 2000 15:51:48 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: Erwin.Rol@q-soft-engineering.com
CC: fzfh@263.net, t.shantha.laxmi@exgate.tek.com,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: LTP BDM interface
References: <393799C1.2B264498@q-soft-engineering.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Erwin,

strange coincedences happen ;-)

Erwin Rol wrote:
>
> Hello Frank,
>
> I have found something "interesting" in your LPT BDM interface.
> The Freeze lines on the BDM port double as VFLS[0-1] lines (on the
> MPC860
> that is , dunno about other PowerPC cpu's). When the CPU goes into debug
> mode the VFLS[0-1] lines both go to '1' but 00 01 and 10 have a
> different
> meaning (See page 37-3 of the MPC860 PowerQUICC User's Manual) and in
> your hardware you only test one of the two lines which may cause a false
> positive recognition of the debug mode. A simple solution might be
> a AND port to "mix" the two lines in hardware, because this is always
> what we want and we aren't interested in the other functions of
> VFLS[0-1].
>
> Does anybody else use Frank's hardware interface and GDB patches and has
> strange problems like the debugger stopping the target at random places
> ?
>
> - Erwin
>
> --
>         Q - S O F T - E N G I N E E R I N G
>      Rodachtalweg 11, 81549 Muenchen, Germany
>
> Erwin Rol (Software Engineer)     phone: +49-89-68050051
> Erwin.Rol@Q-Soft-Engineering.com  fax  : +49-89-68050052

Thanks for your feedback!

Here is what I just have sent a couple of minutes before:

----------------------------------------
Subject: Re: about bdm?
Date: Fri, 02 Jun 2000 14:16:16 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
Organization: VAS Entwicklungsgesellschaft mbH
To:  fzfh@263.net
References: 1


Hi zheng.fh,

As IMHO motorola's documentation is poor regarding the debugging port,
is it hard for me to tell you if it things will work with option a.

I use option b, because I use a TQ-Module. They use FRZ on the BDM, because they
need the VFLS pins for PCMCIA. There is only one signal needed, to tell if the
processor is in debugging mode.
I hope you have motorola's 860 user manual. I haven't found detailed documention
about the history buffer signals at first glance.

As far as I understand, you need both signals from VFLS[0,1] to tell whether
processor is frozen or not.

So, have a try. Without show cycles, there is a chance that things will work.
The MPC signals VFLS0 and VFLS1 if frozen. So, if there are no history buffer
flush signals I think there is a chance that VFLS0 is enough to detect FRZ.

If not, add one AND gate to the adapter: FREEZE:= VFLS0 & VFLS1 :

FREEZE means the FRZ signal on the adapter board (do not connect it back to the
MPC ;-), so AND pin 1 and pin 6 from the MPC connector, and connect the output
to pin 1 at the parallel cable connector, replacing the old direct connection
from pin 1 to pin 1.

HTH
        Frank

---------------

Option a mentioned above is BDM with VFLS0 and 1, option b is BDM with FRZ on
pin 1 and 6 at the BDM connector.
So there are problems regarding different boards..., sorry for causing trouble.

I'm gonna do an update next week on
 http:www.vas-gmbh.de/software/mpcbdm
to mention this problems. I think two additional transistors with two resistors
will do the trick.

The update will fix some bugs (add add some new ;-) and add some additional
features, where I think the best is simple MMU table walk, simulating the linux
kernel table walk to allow kernel debugging. (it seems to work, but I have to
figure out, why it's working that simple... I think there are problems with
accessing data)

So, please give me a couple of days, and don't expect too much

	Frank

===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
