Date: Tue, 24 Aug 1999 10:38:51 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Tony Mantler <eek@escape.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <v04003a04b3e7e12ecd82@[216.81.20.86]>
Message-ID: <Pine.LNX.3.96.990824102919.26367A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 24 Aug 1999, Tony Mantler wrote:

> I recently obtained for myself up a Performa 5200, and I've been playing
> with trying to hack linux into shape on it. (I'm usually a Mac68k guy)
> 
> I compiled a kernel from a stock 2.2.10 tree that I have laying around
> (from ftp.kernel.org, most every config option turned off, booting with
> BootX) and, after sprinkling around a bit of debug code, found that it
> makes it past the prom.c code where it draws the "Welcome to linux
> [blahblah] booting...", but doesn't make it to start_kernel after that.
> 
> I'm not particularily fluent in PPC ASM, so head.S makes fairly opaque
> reading for me. I'm wondering if someone might have some pointers to where
> this would likely be dying, so I have good a place to start?

If I were you, I'd look at MkLinux, _not_ LinuxPPC.  I got about 2/3rds of
the 52/53/62/6300 support already in there.  The interrupt handling code
is written and should be close to correct, along with hard-coded addresses
for serial hardware, video, IDE, SCSI... it's basically 90% finished.
It's the 10% that I can't do anymore, since I no longer have access to the
machines in question.

Some models of machines in that family get a long way into the boot
process, some freeze at the MkLinux Booter's splash screen, and I haven't
have time to try to figure out the difference.  Could be anything from RAM
size to whether it has a 603 vs. 603e.  I'm leaning towards the latter. 
That's probably what's wrong in LinuxPPC's head.S, too, since I don't
think either one has ever supported a machine w/ an original 603.  Grab
yourself a couple of microprocessor reference guides.  :-)

LinuxPPC's interrupt handling code is not well suited to the design of the
interrupt hardware in the NuBus 5x00 machines, since A. it has no master
interrupt flag register or interrupt control register, and B. it has other
interrupt hardware scattered in weird places throughout the hardware.
It woudl be a _very_ massive hack to get it working under LinuxPPC,
especially since even 6/7/8100 support isn't there (which is a necessary
foundation for some of the MkLinux 5x00 changes).  It's also a heck of a
lot easier to start with something that almost works than to start with
somnething that's not remotely close.  ;-)


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
