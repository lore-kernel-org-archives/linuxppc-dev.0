Date: Thu, 21 Sep 2000 13:12:35 -0700
From: Matt Porter <mmporter@home.com>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000921131235.E13197@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.10.10009172058340.715-100000@cassiopeia.home> <14790.58502.25252.825448@argo.linuxcare.com.au> <20000919150621.A9826@cx258813-a.chnd1.az.home.com> <14791.61311.118516.747495@argo.linuxcare.com.au> <20000919231220.A10511@cx258813-a.chnd1.az.home.com> <14793.17269.279179.950369@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14793.17269.279179.950369@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Thu, Sep 21, 2000 at 10:08:37AM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Sep 21, 2000 at 10:08:37AM +1100, Paul Mackerras wrote:
>
> Matt Porter writes:
>
> > Ick...agree here.  Of course, the serial driver could be changed to
> > do other than inb/outb's for other archs and be passed the memory
> > mapped address of the ports.
>
> And the parallel port driver, and the floppy driver, and the
> keyboard/mouse drivers, and the ...

I'm not trying to say it's easy... :)  It is a limited set of drivers
though.

> > This looks to be a good solution if we can't resolve to make the kernel
> > less legacy-oriented.  I changed the default K2 board memory map to
>
> If we only supported powermacs, and not preps or chrps, then we
> probably could make the kernel less "legacy-oriented". :-) :-)
>
> > do a similar thing by orienting the 2nd host bridge right after the
> > 1st in the physical map.  The virt->phys mapping was then 1:1 and things
> > work as you describe above.  Obviously, this approach won't work when
> > you have separate bridge ASICs since you can't get the memory map
> > granularity that I had in the dual host bridge package.
>
> So we set up the virtual -> physical mapping to suit ourselves.  Not a
> problem.

Agreed.  I think you've convinced me that the virtual contortions of
I/O space is the best way to go in we have to live with in*/out*.

> > Well, on drivers like the de4x5 you switch to use the mem bar instead
> > of the I/O bar and then it's generic.  There are lots of drivers that
> > given the choice, chose to use I/O calls.  These can easily be fixed.
>
> But what is wrong with using registers in I/O space and accessing them
> with in*/out*?  I don't understand the aversion some people have shown
> to using in*/out*.  They are the accessor functions for PCI I/O space,
> that's all.  Whatever happens, we need accessor functions for PCI I/O
> space.  We can call them something different or make them more
> complicated but that would just create extra work for ourselves and
> make it harder to port drivers between architectures.

We will need accessor functions, but the parameters of in*/out* are
limiting for other architectures.  That's been my point.  I'm trying
to be forward looking here so we don't do this all over again.

> > PCI I/O is memory mapped on everything but x86.  In most cases PCI
>
> So???  What we have is a level of abstraction that hides (from driver
> authors) exactly how PCI memory and I/O space are accessed.  We have
> readb/writeb etc. for PCI memory space and inb/outb etc. for PCI I/O
> space.  The fact that on PPC both are mapped into the processor's
> address space and accessed using loads and stores is something that
> drivers should not care in the slightest about.  And in fact these
> spaces are not accessed this way on some other non-intel platforms;
> e.g. sparc64 uses special ldasi/stasi instructions.

Ok.

> > devices provide bars that map the same set of registers into both
> > I/O space and mem space.  That leaves only the true legacy devices
> > which have no memory bars to be concerned with.  It's a smaller
> > set of drivers that need different low level access methods than
> > you're making it out to be.
>
> The fact remains that a lot of drivers will continue to use inb/outb
> etc., since they are developed primarily on the intel platform.  It
> makes sense for us to have an inb/outb that works similarly to intel,
> so that we can use as many drivers as possible with as little pain as
> possible.

I'm worn out.  I've been convinced that we'll have to live with it.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
