To: Jesper Skov <jskov@cygnus.co.uk>
Cc: Cort Dougan <cort@persephone.cs.nmt.edu>, linuxppc-dev@lists.linuxppc.org,
        alan@cymru.net, Linux/APUS mailing list <linux-apus@sunsite.auc.dk>
Subject: Re: Synchronization [was Re: The Magic Show: kernel_map() disappearing]
References: <13980.23937.676502.388522@lassi.cygnus.co.uk> <Pine.LNX.3.96.990113130000.3632F-100000@persephone.cs.nmt.edu> <13981.45420.95483.559227@lassi.cygnus.co.uk>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 14 Jan 1999 10:55:37 +0100
In-Reply-To: Jesper Skov's message of "Thu, 14 Jan 1999 08:57:16 +0000 (GMT)"
Message-ID: <d390f69o12.fsf@valhall.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Jesper" == Jesper Skov <jskov@cygnus.co.uk> writes:

>>>>> "Cort" == Cort Dougan <cort@persephone.cs.nmt.edu> writes:
Cort> You're right, that was an oversight on my part.  I'll fix the
Cort> mistake.  I'll commit that to vger now.  I'm going to leave the
Cort> sync in there as well, to make sure that things stall until the
Cort> writes are done.

Jesper> OK, core of the problem is that I don't know what mb() is
Jesper> supposed to do. Here's what we have on the PPC:

mb() is supposed to ensure that the CPU does not reschedule
instructions' memory access beyond the mb().

Jesper>  sync : stall CPU until all IO has completed.  eieio: prevent
Jesper> CPU from reordering/collapsing reads/writes to memory.  (but
Jesper> otherwise run at full steam!)

[snip]

Jesper> That's why I added the iobarrier() macros (adding _w/_r/_rw on
Jesper> Alan's request) that are only related to IO synchronization
Jesper> within the same CPU. Essentially it's just renaming the
Jesper> eieio() macro already used in many PPC drivers because it's a
Jesper> bad name; Linux/APUS will be sharing drivers with Linux/m68k
Jesper> where eieio isn't such a helpful name.

Jesper> Given that mb() was defined as sync, I assumed mb() to be the
Jesper> common Linux name for a thingie used for SMP synchronization.

I guess you would normally use a spinlock() for that, mb() is supposed
to ensure the ordering regarding access to memory which is really what
is happening in most of our drivers (at least all the Amiga ones) -
this is why I was moaning about the iobarrier() stuff as it was not
clear to me what it was supposed to do differently from mb() - except
if you want ordering when going out on an I/O bus like on the PC.

Jesper> I may have been wrong. iobarrier() may not be such a good name
Jesper> after all, but I think it's important for the names to reflect
Jesper> the semantics of the function. And there are two separate
Jesper> synchronization semantics required (at least on the PPC) - I
Jesper> don't want to merge them just because there's already a common
Jesper> Linux function that's named mb() (memory barrier, presumably).

When considering the name, memory barrier is the right name, after
all, all your driver registers are memory mapped and therefore `just'
another type of memory.

Jes

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
