Message-ID: <393F3330.332FFA52@embeddededge.com>
Date: Thu, 08 Jun 2000 01:46:24 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
CC: Dan Malek <dan@netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: QUERY: Embedded PowerPC Linux?
References: <39243D0C.68406C9D@lucent.com> <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com> <392C039D.D0645FBD@embeddededge.com> <20000607225617.A11485@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> I think an embedded 6xx/7xx bootloader will remain separate since
> most of these systems fall into mapping something close to PReP or CHRP

OK.  I guess what I was really trying to say is the 8xx and 8260
directory is focused on the processors with the integrated peripherals.
The other directories have loaders that try to map (more or less)
standard UARTs and other I/O through some bridge.

> ......  Off
> topic: any chance we can change the "mbxboot" name?  It's kinda funny
> since MBX is EOLed or on it's way to being EOLed.

I guess.  It is probably easier now with BitKeeper that it was before
with CVS.  Should we start a poll on LinuxDevices :-)?

> Hmmm...prepboot has 165xx support as well...which is what I've adapted for
> my ports.

OK.  I just remember that when I did the 8240/Sandpoint, it fit one of the
other loader directories better than the 8xx.  I didn't really understand
what was where, but I did get a compressed zImage with little trouble.


> I'm curious, what do you see as the disadvantages to enumerating the bus
> late in the game?

You have to actually build the Linux kernel with knowledge of the
specific devices that are on the bus and how you want them configured.
If you keep this out of the kernel, it is more "generic" (along the
lines of a workstation kernel) and you can configure the kernel with
more driver support flexibility.

> ....  I like just hooking up my indirect config space method
> and using those calls rather than building something new the independent
> bootloader.

I understand.  It's not a big deal, as it appears the kernel is taking
on more of the functions that a properly working BIOS should perform.
This process has to happen someplace, and since embedded boards tend to
have a rather simplistic boot rom (if any) it has to be further up the
food chain.

> Sounds neat.

Like lots of other things on my list :-).

> Exactly.  I can easily see over 32 MACH_<board>'s in the next year.

OK.  I guess that's two votes :-).  I recently removed the detailed
8xx processor type (you don't need to specificy 823, 850, 860, etc.,
just 8xx now).

> Whoops.  I should have elaborated a bit more.  I've discussed this in
> detail with Cort a while back and he seemed receptive to my idea of a
> mostly cosmetic restructuring (it's at least a first phase).

OK.  The PowerPC is certainly unique among the architectures for the
number of different kinds of boards and processors it has to support,
so we have to do something.  It would be nice to keep as much common
as possible, and try to avoid the temptation to just blow stuff into
a new directory rather than merge it.

> Since I've only done 6xx/7xx work I'm not real sure where the 8xx stuff
> fits into my view but the 6xx/7xx can probably be changed independently
> for the first cut at this.

The 8xx shouldn't be much different.  It follows the same structure
as other platforms in the kernel directory.  The challenge is the
8260 and some of the upcoming processors.  It is a hybrid that fits
nicely in the 8xx structure, but it is also a 603.....

> It would now have something like:
>
> arch/ppc/kernel/
>                 chrp
>                 gemini
>                 pmac
>                 prep
>                 <port a>
>                 <port b>
>
> The generic stuff would either stay in kernel/ or move to kernel/common/
> Since all of this is board/arch specific code, there is no maintainence
> concern like when you split head.S for a different processor architecture.

Go for it.  Assume an 8xx directory for now.  This will have all of the
8xx and 8260 stuff in it.  The differences among the 8xx/8260 board
implementations are small enough they don't require separate directories.
I am assuming (hoping :-) things like head.S will remain in the common
area.  I use head.S for the 8260.


> Next it would be great to abstract the find_end_of_memory calls from
> setup.c so it's not necessary to add a new condition to call a board
> specific routine if the kernel.

How about we just "ppc_md" this stuff and make that structure
initialized by the linker?  I think the ppc_md abstraction has proven
quite useful, and this seems like a logical thing to put there.

> In between deadlines I'm experimenting with some different layouts so
> eventually I'll pass something more solid in front of folks.

Have fun :-).


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
