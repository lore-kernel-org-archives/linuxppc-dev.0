Date: Tue, 8 May 2001 13:59:00 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A02044644@SERVER1>
Message-ID: <Pine.HPX.4.10.10105081334180.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 May 2001, Brian Kuschak wrote:

> I've been running with Gabriel's suggested patch for about an hour now, and
> I still see the problem.  It hasn't generated an Oops in dcache.h yet, but I
> do still see the 'de_put: entry net already free!' messages.

I think that we agree that my patch fixes a real bug, but that, sadly, it
is _not_ the bug you are seeing. Given the "prevent interrups in atomic
operation" patch that apparently fixes the bug, I looked for possibilities
of stale reservations. Now your bug is even more puzzling...

BTW, I have finally found a scenario on UP which would fail even if stwcx.
checked for the address. It is somewhat contrived:

1) sem=-1, down(sem) interrrupted betwen lwarx and stwcx.,
   reservation set, would set sem to -2
2) interrupt 1 does up(sem), sem=0, another interrupt becomes pending,
   while this handler is executed
3) interrupt 2 does down_trylock(sem), fails and returns,
   dangling reservation.
4) continues with the stwcx. of step 1) stores -2, missing the up(sem),
   goes to sleep. Anybody trying down(sem) probably goes zombie...

I'm not sure that such a made-up example might actually happen in the
kernel. You need a heavily contended semaphore which interrupts or
bottom-halves also try to lock. But that's not the point, it just shows
that checking the address in stwcx. does not actually help much.

> I'll let it run overnight to see if the oops occurs.

Can we get an oops trace if you hit it ? For now I'm puzzled.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
