Date: Tue, 27 Jan 2004 11:34:54 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Pavel Machek <pavel@ucw.cz>, Hugang <hugang@soulinfo.com>,
	Patrick Mochel <mochel@digitalimplant.org>,
	Nigel Cunningham <ncunningham@users.sourceforge.net>,
	<ncunningham@clear.net.nz>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
In-Reply-To: <1075154452.6191.91.camel@gaston>
Message-ID: <Pine.LNX.4.44.0401271130010.23778-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Ah, also: The "Freeing memory" phase takes forever. That should
> > > really be fixed.
> >
> > Well, it does the trick for me, but it takes 50% or so of suspend
> > time. Some memory managment guru making "freeing memory" faster would
> > certainly be welcome.
> > 								Pavel
> > PS: But I'd like to keep it simple...
>
> Haven't looked at it yet. Several crash reports so far, mostly
> lockups right after printing the number of pages to save. I wonder
> if we have something broken in there. It dies for me once too at
> this point.

The PMU locking up with interrupts disabled, for me (Lombard, 400 MHz).
Seems to happen more often on slow machines.
Otherwise, it works (saving to the last swap partition if you try to
specify which one to use; patch sent to Ben FWIW).

> Also, at least on pmac laptops, the HD is usually so fast, that
> I suspect spending 10 seconds freeing things is less efficient than
> spending this 10 seconds writing 200Mb of data to disk :) Also, one
> wakup, it's quite painful to see everything be swapped in again. It
> may make sense to be less agressive on the memory freeing, though
> finding a good balance isn't easy.

I don't mind the wait for memory being freed. Copying more pages with
interrupts disabled would mean a higher chance for PMU lockup, won't it?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
