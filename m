Message-ID: <38DCCCF4.2868082E@iiic.ethz.ch>
Date: Sat, 25 Mar 2000 15:28:04 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
References: <Pine.LNX.4.10.10003241842211.22814-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

> > I spent some time discussion with Egbert. The result is basically that in
> > order to support all archs, bogus BIOS, legacy cards, softbooting, etc...
> > XF must take over the PCI the way it does it. There are lots of reasons
> > for that, I could try to summarize them if you really want the gory
> > details, I beleive Egbert is bored of repeating himself all the time ;)
>
> Nah, I take this to mean we better fix our PCI resource conflicts in the
> kernel if at all possible. But as I see everybody juggle with PCI resource
> and hot swap options only available in 2.3 the XFree people should plaster
> a big fat warning 'will not work with 2.2 kernels on some PPC hardware' on
> their release notes.

You are thinking Linux centric IMHO. XFree86 runs on a variety of OSs. AFAIK
the X PCI code we're talking about is OS independent.


> I sometimes wonder - the FBDev X server used to be a painless thing: the
> kernel frame buffer driver would handle the gory details and X would use a
> simplified, maybe slow but stable interface. X used to deal with that
> fine. Suddenly the kernel isn't to be trusted to correctly set up things
> anymore, and we're back to square one in terms of X stability. How did
> that happen?

The _big_ difference is that _the FBDev_ server was responsible for fbdev only
(I imagine it didn't have to care about PCI stuff at all), while there is only
one server for all drivers now, and it has to deal with several drivers
working on the same machine.


> I'd be glad if the X PCI code would recognize the same facts as reported
> via the kernel /proc/bus/pci interface, and 1) leave disabled regions
> alone and not bitch about them, 2) tolerate one region being fully
> contained inside another if it's on the same card. But it sure is easier
> to work around X.

It sure is easy to complain about something and not try to enhance it.


> X is free to disable whatever it likes on cards that aren't handled by
> framebuffer drivers. It should not disable anything otherwise and leave it
> to the kernel framebuffer drivers to sort things out. More communication
> between X and kernel is fine, but why not leave things as they were for
> framebuffer drivers? This is all that the framebuffer concept was about,
> why throw it out?

Because X can currently only determine what is controlled by an fbdev via
heuristics regarding the memory regions themselves. (With 32 bit busses on 64
bit machines it may even be impossible). Jeff Garzik has proposed a solution
for this with a new ioctl.


Michel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
