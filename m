Message-ID: <383AF6FE.68C8CFA@netx4.com>
Date: Tue, 23 Nov 1999 15:20:14 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Christian Zankel <chris@mvista.com>
CC: cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com> <3839CF18.5D600DE@mvista.com> <19991122165535.A13360@hq.fsmlabs.com> <383A0AA4.1E4227DC@mvista.com> <19991122204001.A14117@hq.fsmlabs.com> <383A3610.BF976EDF@netx4.com> <383ADB77.C06460C4@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Christian Zankel wrote:


> I'm sorry, I didn't want to make fun or criticize any of you.


I was just kidding.  Some of that is pretty messy, and everytime
I am in there I think I should do something different....tomorrow.


> So, basically, what I wanted to ask you about, is, what you think about
> rearranging some small part of the sources


I have mixed feelings about it, and if you look at past messages
you will have seen me type this before.  I really want to separate
the dependent parts, but you have to consider there are still
"generic PPC" components that often get carried into these
dependent areas.  For people that are very focused on a
specific processor/board combination (and newbies) this is often
easier to understand.  However, for people that are making more
generic PPC changes, every time you update one machine type you
have to track down all of the others and make similar changes.
This not only increases the workload, but also the potential
for making mistakes and requires you test many more configurations
to ensure you haven't broken something on another platform.

The head.S is kind of bad, and we recently split off the 8xx
into its own.  I am not sure that was the right thing to do,
but we will live with it for a while.

There are already "machine" dependent files at the lowest
levels, just not in separate directories.  The complexity of
the "#ifdefs" at the PPC level is mostly to ensure we get to
the proper lower level dependent files.

Further, because of the integrated nature of some PPC processors,
the line between processor and machine is a little fuzzy.  For
example, the 8240 is a 603/MPC106/CHRP...but not exactly.  You
can leverage lots of existing code, but need to twist it just
a little in a couple of places.  It doesn't fit the processor
and machine model very well.

Someone just can't wake up some afternoon and declare major changes
for the "better".  This code has evolved over many years and there
are some subtle things that can't be upset or we take many steps
in the wrong direction.  We should try a few new things here and
there let the evolution continue.


> ........ Or, if you would suggest just to add another
> machine into the current code.

Well, since you asked :-).   I really like the machine
dependent structures with indirect function calls that was added
a little while back.  I would like to see that change into
something that really cleans up the current "setup.c" file.
So, yes, just add the new machine into the current code.

Second, because of my interest in the embedded software on any
of the PPC processors, I would like to see the assumptions about
OF, keyboards, video, or 8259s always present be broken.  These
assumptions aren't unique to the PPC port, they exist in other
generic Linux software.

Now, back to the subject line about bootloaders.  The "embedded"
Linux images seldom rely on any hardware initialization because
often there is nothing done.  This has grown a little out of
control, as each board has its own functions that run to set
up the hardware (including PCI mapping in some cases) before
the Linux kernel is started.  I am considering adopting the
machine descriptor for this as well to assist when adding new
board (machine) types.  Since the 8xx and 82xx environments
are quite programmable, another option I am considering is
programming all of the address spaces to a "Linux/8xx" space.
This would eliminate some code in mm/init.c and several
board specific include files.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
