Date: Sun, 5 Aug 2001 23:38:29 -0700
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Modules and CONFIG_ALTIVEC
Message-ID: <20010805233829.A27436@nevyn.them.org>
References: <20010805234945.A837@ibrium.se> <01080518082100.00490@silence.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01080518082100.00490@silence.internal>; from hollis-lists@austin.rr.com on Sun, Aug 05, 2001 at 06:08:21PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 05, 2001 at 06:08:21PM -0500, Hollis wrote:
>
> On Sunday 05 August 2001 04:49, Samuel Rydh wrote:
> > On ppc, the size of thread_struct depends on the CONFIG_ALTIVEC setting.
> > Thus, the offset of various task_struct fields are dependent upon this
> > config option.
> [snip]
> >         unsigned long   fpscr;          /* Floating point status */
> > -#ifdef CONFIG_ALTIVEC
> > -       vector128       vr[32];         /* Complete AltiVec set */
> > -       vector128       vscr;           /* AltiVec status */
> > -       unsigned long   vrsave;
> > -#endif /* CONFIG_ALTIVEC */
> > +	altivec_t	*vregs;
>
> This also affects gdb. When gdb reads a core file, it gets upset if the size
> of a regset isn't what it thinks it should be. Currently it's a bit too easy
> to change that size...

Yup.  Expect GDB patches to deal with that (and with altivec) from me
in the next month, if no one beats me to it.  It's approaching the top
of my TODO list.

--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
