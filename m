Date: Thu, 31 Aug 2000 18:04:16 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Dänzer <daenzerm@student.ethz.ch>,
        Tony Mantler <nicoya@apia.dhs.org>,
        Tom Rini <trini@kernel.crashing.org>, Dan Malek <dan@netx4.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <Pine.LNX.4.10.10008311714050.390-100000@cassiopeia.home>
Message-ID: <Pine.HPX.4.10.10008311753590.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Geert Uytterhoeven wrote:

> > The only reasonable way to do this that I see is to have a self linking
> > kernel, the initial boot code would simply uncompress a partially linked
> > kernel and perform the final link step before passing control to it.
> >
> > Yes this involves putting several versions of processor specific code
> > in the same kernel, but once compressed it's not that big. The _init
> > sections are ok, but adding apus/prep/openfirmware is pushing the method
> > past the breaking point.
>
> Cool!
>
> > Yes, this will make the bot iamge bigger, I just  don't care (embedded
> > systems are different) since it will make the running kernel smaller:
>
> My interest is in smaller kernel images. I don't want to compile every single
> piece of PPC code that's useless for my hardware, I want to compile only what
> I need. I think I'm already wasting too much of my time waiting for kernel
> compiles.

And you `make {x,menu,old,}config' to take longer than `make zimage' ?

First, kernel compile times are only fairly large after a big update, when
I do `make dep clean zImage'. Second, the proportion of time spend in the
specific PPC code (mostly arch/ppc and drivers/macintosh) is rather small.
Third, building a minimal kernel image for each machine would involve a
ton (and that's an undrestatement) of kernel options: CONFIG_INTC_8259,
CONFIG_INTC_POWERMAC, CONFIG_INTC_OPENPIC and others for the interrupt
controllers, half a dozen or so CONFIG_RTC types, same for CONFIG_NVRAM
and a few other things I surely forget. The only reasonable solution is to
aim for the smallest runtime kernel image.

> And since there are people who care about embedded PPC systems, it would be
> great to at least have _the choice_ to compile a small specific kernel or a
> large generic one.

Then build an utility which trims the kernel the same way as the smart
bootloader would do. People with embedded systems know what their target
systems is and could use it, but please don't add another couple of
hundred entries in the basic Linux kernel configuration.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
