Date: Fri, 4 Jan 2002 12:04:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: jaf <jaf@lcsaudio.com>,
	Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	linuxppc-dev@lists.linuxppc.org, jeffk@jdkoftinoff.com
Subject: Re: Having linking problems with atomic_inc(), atomic_dec_and_test() in user app, help!
Message-ID: <20020104190403.GL749@cpe-24-221-152-185.az.sprintbbd.net>
References: <60823947811-BeMail@sugoi> <Pine.LNX.4.10.10201041821170.19962-100000@zirkon.biophys.uni-duesseldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10201041821170.19962-100000@zirkon.biophys.uni-duesseldorf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 04, 2002 at 06:44:03PM +0100, Michael Schmitz wrote:
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

A userspace app using <asm/*.h> and <linux/*.h> is quite probably a bug.
If you need something from the kernel, make a local copy and never,
ever, ever, reference it directly, since it can change on you.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
