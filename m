Message-ID: <3C360794.E264BDFE@mvista.com>
Date: Fri, 04 Jan 2002 11:50:44 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: jaf <jaf@lcsaudio.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test()in
 user app, help!
References: <Pine.LNX.4.10.10201041821170.19962-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:
>
> > >> Also, what does "relocation truncated to fit: R_PPC_REL24
> > atomic_inc(atomic_t
> > >> *)" mean?
> > >
> > >About as much as 'unresolved external reference'. atomic_inc isn't
> > defined
> > >in the scope of your code. Look at the kernel headers; it might be
> > inside
> > >#ifdef __KRENEL__ (actually it is).
> >
> > I see... when I wrote the code using Red Hat, this was not the case.  I
> > assumed
> > things would be similar under all Linuxes... apparently a bad
> > assumption.
>
> It's a kernel or libc header issue - what kernel/libc version was that
> on? As far as I can see atomic operations are exported to user programs
> except on ppc (not ppc64), mips*, arm and sparc. At least in one case it's
> obvious why: MIPS needs to protect against interrupts to guarantee
> atomicity.
> Another corner case seems to be IBM 405 processors that use what I think
> is a privileged instruction as well in order to work around a hardware
> bug.

The dcbt instruction (the workaround) should not be privileged.

< stuff deleted >

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
