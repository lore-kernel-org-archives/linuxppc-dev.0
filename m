Message-ID: <38CBAF43.B9F7D50@iiic.ethz.ch>
Date: Sun, 12 Mar 2000 15:52:51 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work
 onppcwithr128
References: <Pine.LNX.4.10.10003111521590.14494-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> I'll try that. But the results I get with X -probeonly are more than
> confusing. After I tosses out most of the driver modules,

Which drivers? Only r128, fbdev and glint are known to be working on PPC
AFAIK.


> the probe runs once or twice, and gets sporadic SIGILL the rest of the time.
> To the extent of not succeeding at all for the rest of the day. Or
> succeeding only from the console but not from a slogin session (signal 4 in
> the slogin session consistently). The signal happens apparently at different
> times during X startup - while loading the dbe module, after loading the
> fbdevhw module.

This is a known bug in the server's cache flush code. There is a fix worked
out by Kostas Gewrgiou and Kevin Hendricks which unfortunately hasn't made it
into 4.0.


> The chip was detected on the PCI bus - what's the BusID supposed to do in
> this situation? Keep X from probing the other PCI devices?
> OK, tried to feed it the BusID (0:17:0 as reported by the probe). Results:
> a beep, and the warnings 'invalid mem allocation' and 'invalid IO
> allocation'. The IO range smells like a port address range, is that
> remapped by the PCI bridge? lspci reports the IO range as disabled. I'll
> look into Geerts description of the Mach64 memory layout to figure out
> what aperture X tries to use here.

Are you trying to use the driver for Mach64?

Try the fbdev driver with the BusID. (Mach is only minimally accelerated ATM
anyway)


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
