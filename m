Date: Mon, 1 Apr 2002 08:25:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Message-ID: <20020401152507.GB6360@opus.bloom.county>
References: <0203292359.AA12953@ivan.Harhan.ORG> <3CA4E98B.F7A7ECE0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CA4E98B.F7A7ECE0@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 29, 2002 at 05:24:11PM -0500, Mark A. Greer wrote:
>
> Michael Sokolov wrote:
>
> > Mark A. Greer <mgreer@mvista.com> wrote:
> >
> > > I have other things to do so I won't be able to finish today.  In case
> > > someone wants to work on this over the weekend, attached is a patch of
> > > what I have so far.  It implements the example bi_rec's emailed before
> > > for the ev64260 board.  Feel free to use it or do a better job.
> >
> > Looks OK except for 2 major problems:
> >
> > 1. You are using find_bootinfo() in EV-64260 platform_init to find the
> > bi_recs. This is bad, as the magic location where find_bootinfo looks for
> > the bi_recs is
> > unavailable to bootloaders outside the linux source tree. Instead I have
> > adopted the convention (which Tom Rini has accepted for the K2 port and
> > implemented in the wrapper) to pass the physical address of bi_recs to the
> > kernel in R3. You should use r3 + KERNELBASE in platform_init to find the
> > bi_recs. This works with the wrapper just as well as find_bootinfo(), but is
> > much nicer for external bootloaders.
>
> It *is* in the kernel source (and not the bootloader).   Also, 15 of
> the *_setup.c files in arch/ppc/platforms call find_bootinfo including
> ev64260_setup.c before I modified it.  I think the R3 way of doing things
> is out of date now but maybe Tom can elaborate.

OK.  The problem is that the original PPC location of the bi_recs was
kernel BSS + some.  This posed 2 problems.  First, a big enough kernel
could overwrite the bi_recs when they're here.  The second problem is
that anything out side of the kernel shouldn't have to know where the
bss is (in-kernel does because of linker magic).  So r3 is where the
bi_rec location can be.  This might be changed later (or we'll just pass
along the PReP residual data (not Motorola like I said in my last email,
whoops) location in a bi_rec. :)

So the always-correct call for platform_init() is:
parse_bootinfo((struct bi_record *) (r3 + KERNELBASE));

But, since Michael has only worked on a few boards, only a few boards do
that right now.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
