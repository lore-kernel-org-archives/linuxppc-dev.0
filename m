Message-ID: <3896E1BD.939CE189@ctam.com.au>
Date: Wed, 02 Feb 2000 00:38:05 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <200002010035.BAA26304@denx.local.net> <0001311713560A.00776@alan.corp.packetengines.com> <3896D868.BE2A5C@ctam.com.au> <0001311752470B.00776@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:

> > > We use a serial connection to debug our applications with GDB all the time
> > > using stubs that are part of our "OS".  It certainly is possible.  We put the
> > > devices on the end of a 24 port Livingston Portmaster terminal server and then
> > > setup the ports as raw data ports to which we connect with GDB running on our
> > > main build/debug box.  That way the user can debug something in another room or
> > > across the planet very easily through the network.
> >
> > Cool.  A little overkill never hurt anybody :)
> > I'll assume one build/debug box connected directly to the target via a serial cable
> > or ethernet for now.
>
> I see what you mean, but I still think it's a necessity.  It's not overkill if
> it means I don't have to wander across the hall every 5 minutes to dink with the
> platform or sit in a room full of LOUD fans to work and debug.

I was being a bit sarchy.  It is not overkill.  Infact I will probably setup some kind of
server for compile and debug too so some other engineers can work on linux from there
MS-Win machines (poor buggers).  I have cross-compiled Insight to work with the cygwin
environment so that might be an option with gdbserver.  I may even compile the entire
tool chain for cygwin and see if I can compile the kernel and apps from the MS-Win
machines (I'm just asking for trouble aren't I).  If it works I will ask Dan to put the
tools on the ftp server.


> > > I debugged my initial port of the linux kernel to our platform using just this
> > > kind of interface.  You have to commandeer the serial hardware away from the
> > > driver - I simply didn't tell the kernel there was a device there and
> > > configured it "manually" from the GDB nub initialization function which I
> > > called early in main.c.  This works fine for KERNEL debugging.
> >
> > When you say configured manually what exactly do you mean.
> > Is this in the kernel itself ?
> > When you say main.c do you mean init/main.c in the linux kernel source tree ?
> > Has this got anything to do with the kgdb option in the "make config" process ?
> > Can ethernet be used to debug the kernel or is a serial port the only or best way to
> > go ?
>
> I DO mean init/main.c.  I mean "manually" in the sense that the low level
> driver I used in my gdb nub has an "init" call made from init/main.c to
> setup the UART registers properly (baud rate, etc.).  The nub UART driver simply
> polls the UART and does simple one byte read/write operations to it.  The nub
> has the necessary (simple) hex/unhex conversion routines for the GDB serial
> protocol.  Doesn't use anything else so you can theoretically debug the
> kernel's version of printf with breakpoints and everything without screwing up
> the debugger by debugging code it depends upon.

What is "nub" ?
Have you have written the code to interpret the gdb serial protocol or are you using code
from gdb itself ?
Are your suggestions taken from the gdb howto or documentation ?

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
