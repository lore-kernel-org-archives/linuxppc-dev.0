Message-ID: <37BD6AA0.B5D4CA94@lip6.fr>
Date: Fri, 20 Aug 1999 16:48:00 +0200
From: Anthony Lester <Anthony.Lester@lip6.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: gnome-ppp and the mac serial ports
References: <199908180549.HAA00305@piglet.cpu.lu>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks for the reply, but it doesn't clear up the affair. The serial interface is
documented in Inside Macintosh which explicitly states that DCD is not used. I've even got
a copy of the old Inside Macintosh volume 4, which has a schematic of the serail hardware,
DCD simply does not exist.

As for the general purpose pins, I had a quick look at Zilogs data sheets for the 8530.
There are no pins dedicated to general purpose use but some of the control pins (e.g. DCD)
can be used as such. Therefore it is possible that the Mac uses the DCD pins for something
else but it is more likely that it is simply hardwired to the supply rails.

This would explain what I see on stepping through gnome-ppp when it interrogates the
serial port, simply that DCD stays off whatever the status of the modem. This brings me
back to the original question. Should applications relying on DCD be modified so that they
do not rely on the value of this control line, or should the kernel be modified so that it
sends something other than always off.

Anthony

P.S. I downloaded TattleTech. Quite a useful tool, but it tells me only a little more than
Apple System Profiler, I couldn't see anything near as detailed as hardware connections.

Michel Lanners a écrit:
> 
> IIRC, DCD is wired to the GPi pin (is that the right name?). That's
> some kind of multipurpose pin, that can be used for various things like
> sync clocking, remote power-on, etc.... Have a look at your hardware
> with a tool like TattleTech; the section about serial ports should show
> if/whether DCD of the SCC is wired to the GPi pin.
> 
> You might want to search the TIL (http://www.apple.com/til) about
> articles about the subject.
> 
> Michel
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
