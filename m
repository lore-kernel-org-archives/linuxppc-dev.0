Message-Id: <v04003a00b3e8b6cc63fe@[216.81.20.86]>
In-Reply-To: <19990824110602.000653@mail.mipsys.com>
References: <v04003a04b3e7e12ecd82@[216.81.20.86]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 24 Aug 1999 16:21:15 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>,
        "David A. Gatwood" <dgatwood@mvista.com>,
        linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: Performa 5200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>On Tue, Aug 24, 1999, Tony Mantler <eek@escape.ca> wrote:
>
>>I recently obtained for myself up a Performa 5200, and I've been playing
>>with trying to hack linux into shape on it. (I'm usually a Mac68k guy)
>>
[...]

At 4:06 AM -0500 8/24/99, Benjamin Herrenschmidt wrote:
>is this a NuBus class machine or a PCI based one ? If it's a NuBus one,
>then you are out of luck, or if you have time to spend, you can begin
>porting linux/ppc to those beasts. (Basically, RAM is not contiguous and
>you cannot rely in the kernel beeing loaded at physical 0, since the
>frame buffer may be hard coded at physical 1Mb). Look at the various
>parameters BootX pass for a NuBus machine (using the latest 2.1.12 kernel
>from vger or Paul's rsync, you should have the latest bootx.h).

(2.1.12? I assume that's 2.3.12?)

It's a NuBus machine (though it doesn't actually have any NuBus slots). It
shares the same address maps as the 68k machines, which puts ram in a
contiguous block starting at 0x0, ROM at 0x40800000, IO at 0x50F00000 and
NuBus 'super' regions from 0x90000000 to 0xEFFFFFFF, and NuBus 'regular'
regions from 0xF9000000 to 0xFEFFFFFF (framebuffer is in slot $9 'regular'
space, starts at 0xF9001000).

I'm not sure which models have the f*ed up address maps, but I'm sure glad
I don't have one of them. :)


At 10:38:51 AM -0700 8/24/99, David A. Gatwood wrote:
>If I were you, I'd look at MkLinux, _not_ LinuxPPC.  I got about 2/3rds of
>the 52/53/62/6300 support already in there.  The interrupt handling code
>is written and should be close to correct, along with hard-coded addresses
>for serial hardware, video, IDE, SCSI... it's basically 90% finished.
>It's the 10% that I can't do anymore, since I no longer have access to the
>machines in question.

Yeah, I should probably work on MkLinux, but what would the fun in that be? :)

I think I'm mostly partial to LinuxPPC because I can actually pretend to be
familiar with how the Monolithic linux kernel works, and because I think
LinuxPPC should have the option of supporting all PPC models.


>Some models of machines in that family get a long way into the boot
>process, some freeze at the MkLinux Booter's splash screen, and I haven't
>have time to try to figure out the difference.  Could be anything from RAM
>size to whether it has a 603 vs. 603e.  I'm leaning towards the latter.
>That's probably what's wrong in LinuxPPC's head.S, too, since I don't
>think either one has ever supported a machine w/ an original 603.  Grab
>yourself a couple of microprocessor reference guides.  :-)

Time to learn PPC ASM I guess. :)


>LinuxPPC's interrupt handling code is not well suited to the design of the
>interrupt hardware in the NuBus 5x00 machines, since A. it has no master
>interrupt flag register or interrupt control register, and B. it has other
>interrupt hardware scattered in weird places throughout the hardware.
>It woudl be a _very_ massive hack to get it working under LinuxPPC,
>especially since even 6/7/8100 support isn't there (which is a necessary
>foundation for some of the MkLinux 5x00 changes).  It's also a heck of a
>lot easier to start with something that almost works than to start with
>somnething that's not remotely close.  ;-)

Yeah, I figure the two biggest hurdles I'm going to have to deal with is a:
getting it to boot, and b: getting the interrupts to work. After that, it's
just a matter of tweaking drivers, and luckily there's a whole lot of
shared code between Mac68k and LinuxPPC drivers. (CUDA ADB, Valkyrie video,
I think the serial driver too, and so forth)

(If anyone's interested, I wrote up a few docs on Mac68k interrupts, and
the functioning of the evil VIAs (and emulations thereof))


I'm starting to think that I should carve out a new machine class in the
config options (#ifdef CONFIG_WUSSY_68K_PMAC?) ;)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
