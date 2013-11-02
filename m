Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5D932C00F9
 for <linuxppc-dev@ozlabs.org>; Sun,  3 Nov 2013 15:04:40 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 2 Nov 2013 22:04:38 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C74D61FF0046
 for <linuxppc-dev@ozlabs.org>; Sat,  2 Nov 2013 22:04:21 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rA344aeC217076
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:04:36 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rA347QPx002144
 for <linuxppc-dev@ozlabs.org>; Sat, 2 Nov 2013 22:07:27 -0600
Date: Sat, 2 Nov 2013 09:36:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Victor Kaplansky <VICTORK@il.ibm.com>
Subject: Re: perf events ring buffer memory barrier on powerpc
Message-ID: <20131102163618.GK4067@linux.vnet.ibm.com>
References: <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <20131030112526.GI16117@laptop.programming.kicks-ass.net>
 <OFF6C78E48.E477DB1E-ON42257C14.0050F9B3-42257C14.0051AC6D@il.ibm.com>
 <20131031061602.GU4126@linux.vnet.ibm.com>
 <OF6655E55D.554B7448-ON42257C16.00442B8B-42257C16.0048995E@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF6655E55D.554B7448-ON42257C16.00442B8B-42257C16.0048995E@il.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 01, 2013 at 03:12:58PM +0200, Victor Kaplansky wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote on 10/31/2013
> 08:16:02 AM:
> 
> > > BTW, it is why you also don't need ACCESS_ONCE() around @tail, but only
> > > around
> > > @head read.
> 
> Just to be sure, that we are talking about the same code - I was
> considering
> ACCESS_ONCE() around @tail in point AAA in the following example from
> Documentation/circular-buffers.txt for CONSUMER:
> 
>         unsigned long head = ACCESS_ONCE(buffer->head);
>         unsigned long tail = buffer->tail;      /* AAA */
> 
>         if (CIRC_CNT(head, tail, buffer->size) >= 1) {
>                 /* read index before reading contents at that index */
>                 smp_read_barrier_depends();
> 
>                 /* extract one item from the buffer */
>                 struct item *item = buffer[tail];
> 
>                 consume_item(item);
> 
>                 smp_mb(); /* finish reading descriptor before incrementing
> tail */
> 
>                 buffer->tail = (tail + 1) & (buffer->size - 1); /* BBB */
>         }

Hmmm...  I believe that we need to go back to the original code in
Documentation/circular-buffers.txt.  I do so at the bottom of this email.

> > If you omit the ACCESS_ONCE() calls around @tail, the compiler is within
> > its rights to combine adjacent operations and also to invent loads and
> > stores, for example, in cases of register pressure.
> 
> Right. And I was completely aware about these possible transformations when
> said that ACCESS_ONCE() around @tail in point AAA is redundant. Moved, or
> even
> completely dismissed reads of @tail in consumer code, are not a problem at
> all,
> since @tail is written exclusively by CONSUMER side.

I believe that the lack of ACCESS_ONCE() around the consumer's store
to buffer->tail is at least a documentation problem.  In the original
consumer code, it is trapped between an smp_mb() and a spin_unlock(),
but it is updating something that is read without synchronization by
some other thread.

> > It is also within
> > its rights to do piece-at-a-time loads and stores, which might sound
> > unlikely, but which can actually has happened when the compiler figures
> > out exactly what is to be stored at compile time, especially on hardware
> > that only allows small immediate values.
> 
> As for writes to @tail, the ACCESS_ONCE around @tail at point AAA,
> doesn't prevent in any way an imaginary super-optimizing compiler
> from moving around the store to @tail (which appears in the code at point
> BBB).
> 
> It is why ACCESS_ONCE at point AAA is completely redundant.

Agreed, it is under the lock that guards modifications, so AAA does not
need ACCESS_ONCE().

OK, here is the producer from Documentation/circular-buffers.txt, with
some comments added:

	spin_lock(&producer_lock);

	unsigned long head = buffer->head;
	unsigned long tail = ACCESS_ONCE(buffer->tail); /* PT */

	if (CIRC_SPACE(head, tail, buffer->size) >= 1) {
		/* insert one item into the buffer */
		struct item *item = buffer[head];

		produce_item(item); /* PD */

		smp_wmb(); /* commit the item before incrementing the head */

		buffer->head = (head + 1) & (buffer->size - 1);  /* PH */

		/* wake_up() will make sure that the head is committed before
		 * waking anyone up */
		wake_up(consumer);
	}

	spin_unlock(&producer_lock);

And here is the consumer, also from Documentation/circular-buffers.txt:

	spin_lock(&consumer_lock);

	unsigned long head = ACCESS_ONCE(buffer->head); /* CH */
	unsigned long tail = buffer->tail;

	if (CIRC_CNT(head, tail, buffer->size) >= 1) {
		/* read index before reading contents at that index */
		smp_read_barrier_depends();

		/* extract one item from the buffer */
		struct item *item = buffer[tail]; /* CD */

		consume_item(item);

		smp_mb(); /* finish reading descriptor before incrementing tail */

		buffer->tail = (tail + 1) & (buffer->size - 1); /* CT */
	}

	spin_unlock(&consumer_lock);

Here are the ordering requirements as I see them:

1.	The producer is not allowed to clobber a location that the
	consumer is in the process of reading from.

2.	The consumer is not allowed to read from a location that the
	producer has not yet completed writing to.

#1 is helped out by the fact that there is always an empty element in
the array, so that the producer will need to produce twice in a row
to catch up to where the consumer is currently consuming.  #2 has no
such benefit: The consumer can consume an item that has just now been
produced.

#1 requires that CD is ordered before CT in a way that pairs with the
ordering of PT and PD.  There is of course no effective ordering between
PT and PD within a given call to the producer, but we only need the
ordering between the read from PT for one call to the producer and the
PD of the -next- call to the producer, courtesy of the fact that there
is always one empty cell in the array.  Therefore, the required ordering
between PT of one call and PD of the next is provided by the unlock-lock
pair.  The ordering of CD and CT is of course provided by the smp_mb().
(And yes, I was missing the unlock-lock pair earlier.  In my defense,
you did leave this unlock-lock pair out of your example.)

So ordering requirement #1 is handled by the original, but only if you
leave the locking in place.  The producer's smp_wmb() does not necessarily
order prior loads against subsequent stores, and the wake_up() only
guarantees ordering if something was actually awakened.  As noted earlier,
the "if" does not necessarily provide ordering.

On to ordering requirement #2.

This requires that CH and CD is ordered in a way that pairs with ordering
between PD and PH.  PD and PH are both writes, so the smp_wmb() does
the trick there.  The consumer side is a bit strange.  On DEC Alpha,
smp_read_barrier_dependes() turns into smp_mb(), so that case is covered
(though by accident).  On other architectures, smp_read_barrier_depends()
generates no code, and there is no data dependency between the CH and CD.
The dependency is instead between the read from ->tail and the write,
and as you noted, ->tail is written by the consumer, not the producer.

But my battery is dying, so more later, including ACCESS_ONCE().

							Thanx, Paul
