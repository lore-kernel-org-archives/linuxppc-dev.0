Message-Id: <5.1.0.14.2.20010806100745.0410e900@mail.lauterbach.com>
Date: Mon, 06 Aug 2001 10:09:09 +0200
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
From: Franz Sirl <Franz.Sirl-ppc@lauterbach.com>
Subject: Re: Modules and CONFIG_ALTIVEC
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010805233829.A27436@nevyn.them.org>
References: <01080518082100.00490@silence.internal>
 <20010805234945.A837@ibrium.se>
 <01080518082100.00490@silence.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 08:38 06.08.2001, Daniel Jacobowitz wrote:

>On Sun, Aug 05, 2001 at 06:08:21PM -0500, Hollis wrote:
> >
> > On Sunday 05 August 2001 04:49, Samuel Rydh wrote:
> > > On ppc, the size of thread_struct depends on the CONFIG_ALTIVEC setting.
> > > Thus, the offset of various task_struct fields are dependent upon this
> > > config option.
> > [snip]
> > >         unsigned long   fpscr;          /* Floating point status */
> > > -#ifdef CONFIG_ALTIVEC
> > > -       vector128       vr[32];         /* Complete AltiVec set */
> > > -       vector128       vscr;           /* AltiVec status */
> > > -       unsigned long   vrsave;
> > > -#endif /* CONFIG_ALTIVEC */
> > > +   altivec_t       *vregs;
> >
> > This also affects gdb. When gdb reads a core file, it gets upset if the
> size
> > of a regset isn't what it thinks it should be. Currently it's a bit too
> easy
> > to change that size...
>
>Yup.  Expect GDB patches to deal with that (and with altivec) from me
>in the next month, if no one beats me to it.  It's approaching the top
>of my TODO list.

Uhm, I sent a patch to Daniel Berlin a while ago for commenting, but
haven't heard back yet. I can send it to you if you want to take a look.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
