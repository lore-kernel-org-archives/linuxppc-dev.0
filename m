Date: Sat, 11 Mar 2000 15:50:16 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Michel Dänzer <michdaen@iiic.ethz.ch>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on
 ppcwithr128
In-Reply-To: <38C98B3D.AB06EE7E@iiic.ethz.ch>
Message-ID: <Pine.LNX.4.10.10003111521590.14494-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > One would sure hope so. The 4.0 X server dies horribly during device
> > configuration on my Lombard. After feeding it a hand-crafted XF86Config,
> > it just hangs the machine.
>
> Which driver?
>
> With the fbdev driver, you have to specify the bus ID of the graphics chip,
> e.g.
>
>     BusID	"0:1:0"

I'll try that. But the results I get with X -probeonly are more than
confusing. After I tosses out most of the driver modules, the probe runs
once or twice, and gets sporadic SIGILL the rest of the time. To the
extent of not succeeding at all for the rest of the day. Or succeeding
only from the console but not from a slogin session (signal 4 in the
slogin session consistently). The signal happens apparently at different
times during X startup - while loading the dbe module, after loading the
fbdevhw module.

The chip was detected on the PCI bus - what's the BusID supposed to do in
this situation? Keep X from probing the other PCI devices?

OK, tried to feed it the BusID (0:17:0 as reported by the probe). Results:
a beep, and the warnings 'invalid mem allocation' and 'invalid IO
allocation'. The IO range smells like a port address range, is that
remapped by the PCI bridge? lspci reports the IO range as disabled. I'll
look into Geerts description of the Mach64 memory layout to figure out
what aperture X tries to use here.

Trying a 'startx' with this config leaves me with the bell on and the
machine hung.

I haven't patched or configured anything in the X source.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
