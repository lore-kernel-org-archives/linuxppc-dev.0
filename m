Date: Wed, 21 Jan 2004 10:08:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
Message-ID: <20040121170813.GT13454@stop.crashing.org>
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212231.45601.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200401212231.45601.amitkale@emsyssoft.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 21, 2004 at 10:31:45PM +0530, Amit S. Kale wrote:
> On Wednesday 21 Jan 2004 9:00 pm, Tom Rini wrote:
> > On Wed, Jan 21, 2004 at 07:46:17PM +0530, Amit S. Kale wrote:
> > > Hi Tom,
> > >
> > > Yes. Software breakpoints have been tested in the TimeSys ppc kernel
> > > source. They work quite well!! I'll be releasing that code soon.
> >
> > Any chance you can give me what they gave you?  I can try and merge
> > and test things.
>
> Done.
>
>
> > > The breakpoint 0xc0000000 placed by gdb is _evil_ It may clobber data.
> > > The gdb at kgdb.sourceforge.net places it correctly at module_event.
> >
> > I'm not quite sure what you're getting at.   The gdb binary I'm using is
> > a good one (It's happy w/ the current kgdb stub, working in tandem w/ a
> > BDI2000, etc).  If the breakpoints being set aren't right, I suspect
> > that it's related to the other problems I'm seeing.
>
> Stock gdb places a breakpoint to detect loading of shared libraries. Since
> kernel doesn't have the symbols that ld-linux-* has, it places that at
> begining of the kernel (or elsewhere I haven't been able to figure out
> exactly where it places it). This breakpoint corrupts kernel data many a
> times.
>
> The gdb I maintain at kgdb.sourceforge.net places a breakpoint correctly at
> module_event and detects loading of modules.

Ah, ok.

> > > Where is the other breakpoint placed? While you would have certainly done
> > > that, please confirm that kgdb actually inserts a breakpoint where you
> > > have asked it to: a simple printk at the address where the breakpoint is
> > > placed should be sufficient. printing from gdb will not work as gdb
> > > removes all breakpoints before giving control to a user.
> >
> > The thing is the kernel gets into an infinite loop of stopping, as far
> > as gdb can tell, at the initial breakpoint
>
> I thought you could place a breakpoint somewhere and the breakpoint was never
> hit.
>
> ok. Now I know where it went wrong: nip is instruction pointer, not
> instruction contents. The change you had done compared nip to breakpoint
> instruction contents.
>
> > > +       if (linux_regs->nip == 0x7d821008 )
> > > +               /* Skip over breakpoint trap insn */
> > > +               linux_regs->nip += 4;
>
>
> Checking for kgdb_setting_breakpoint is better. Following code from my patch
> is correct.
>
> > > +       extern atomic_t kgdb_setting_breakpoint;
> > > +       if (atomic_read(&kgdb_setting_breakpoint))
> > > +               regs->nip += 4;

I could have sworn I tried a number of combinations of things, including
that.  But I'm grabbing 2.1.0 now and will get back to you.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
