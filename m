Date: Thu, 31 Aug 2000 12:54:33 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <Pine.LNX.4.10.10008301334570.570-100000@cassiopeia.home>
Message-ID: <Pine.HPX.4.10.10008311107320.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Aug 2000, Geert Uytterhoeven wrote:

>
> On Sun, 30 Jul 2000, Geert Uytterhoeven wrote:
> >
> > Personally I'd more like a configuration where you can select whatever you
> > want of
> >
> >   - PowerMac (CONFIG_PMAC)
> >   - PReP (CONFIG_PREP)
> >   - MTX (CONFIG_MTX)
> >   - CHRP (CONFIG_CHRP)
> >   - Gemini (CONFIG_GEMINI)
> >   - EST8260 (CONFIG_EST8260)
> >   - APUS (CONFIG_APUS)
> >
> > with of course some extra logic to prevent illegal combinations.
>
> So what about this?
>
> --- linux-2.4.0-test8-pre1/arch/ppc/config.in.orig	Wed Aug 23 18:52:20 2000
> +++ linux-2.4.0-test8-pre1/arch/ppc/config.in	Wed Aug 30 14:23:38 2000
> @@ -82,6 +82,10 @@
>  fi
>
>  if [ "$CONFIG_ALL_PPC" != "y" ];then
> +  bool 'PowerMac support' CONFIG_PMAC
> +  bool 'PReP support' CONFIG_PREP
> +  bool 'MTX support' CONFIG_MTX
> +  bool 'CHRP support' CONFIG_CHRP
>    define_bool CONFIG_MACH_SPECIFIC y
>  fi
>
> and replace all tests for CONFIG_ALL_PPC by a suitable combination of tests
> for CONFIG_PMAC/CONFIG_PREP/CONFIG_MTX/CONFIG_CHRP? (BTW, there are still some
> relics of CONFIG_PREP around in config.in)
>
> This clearly indicates that you can
>  1. still compile one kernel that can run on all of PowerMac/PReP/MTX/CHRP,
>     while
>  2. it allows to fine tune the kernel to your specific machine and
>  3. protect against illegal combinations with other machine types.
> And if it ever will be possible to compile a generic kernel that runs on e.g.
> APUS as well, CONFIG_APUS can be included in CONFIG_ALL_PPC (or better, rename
> it to CONFIG_GENERIC_PPC) as well.
>
> I'm willing to work on a first patch, but I don't have a PPC cross-compiler at
> hand and am unable to use bitkeeper, so I have to base it on plain
> 2.4.0-test8-pre1 and leave it untested. Whoever owns whatever machine can
> smooth the rough edges for his/her platform afterwards.
>
> What do you think?

I strongly disagree. What I would like to see is the same kernel running
on all machines, without exception (well all 6xx/7xx/74xx and Power[34]
in 32 bit mode, obvioulsy 8xx and company are too different).

The only reasonable way to do this that I see is to have a self linking
kernel, the initial boot code would simply uncompress a partially linked
kernel and perform the final link step before passing control to it.

Yes this involves putting several versions of processor specific code
in the same kernel, but once compressed it's not that big. The _init
sections are ok, but adding apus/prep/openfirmware is pushing the method
past the breaking point.

Yes, this will make the bot iamge bigger, I just  don't care (embedded
systems are different) since it will make the running kernel smaller:

- only one PCI config method will be linked in for example,
- only the code for the specific interrupt controller(s) will be in (the
current code is a complete mess and so outstandingly inefficient that the
only sane solution is a complete rewrite)
- the various additional section are always rounded up to a page boundary,
another source of wasted space,
- a lot of conditional/machine dependant code will disappear as well as
ppc_md since it will be linked in,

And yes there are problems, like the fact that System.map will not be
constant, perhaps not even across reboots (imagine that you add modules
in the same image and the module becomes automagically linked in the
kernel image if the appropriate hardware happens to be plugged-in).

However this is solvable, and perhaps even better: keep a System.map
around inside the kernel and write it to /boot/System.map early in the
boot scripts and free the kernel memory at this time (a read-once self
destructing /proc entry for example). This even guarantees that System.map
is consistent with your kernel, which I see as a big plus.

Ok, I have a lot of other ideas (espcially about memory management, which
is currently braindead for desktops PPC) but that will be for other posts.

There actually are times where I think that the only viable solution is:
	rm -rf arch/ppc/*
	restart on a sane basis

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
